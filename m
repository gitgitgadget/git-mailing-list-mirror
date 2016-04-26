From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 03/15] submodule add: label submodules if asked to
Date: Tue, 26 Apr 2016 16:19:04 -0700
Message-ID: <CAGZ79kZfGVhMweP_Sqx1dSAif6L46dneXgKYtEozNuxxay5TOg@mail.gmail.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-4-git-send-email-sbeller@google.com>
	<CA+P7+xrPYHEoLPNbGaSDSniHUCLeqj+d85ei3T_uwnBmz68G1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Jacob Keller <jacob.keller@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 01:19:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avCGL-0002HV-Oc
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 01:19:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754142AbcDZXTL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 19:19:11 -0400
Received: from mail-ig0-f172.google.com ([209.85.213.172]:36529 "EHLO
	mail-ig0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752768AbcDZXTF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 19:19:05 -0400
Received: by mail-ig0-f172.google.com with SMTP id u10so57254083igr.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 16:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=60MXETSjP7JxrozXhyXnc4/F0W1IKNZR/urucLM1MSQ=;
        b=R9EjecG3dyjIuNaM8LeCPkk+AJAOnOUHX+lganpvGR47pRPNoOf3S63KYei0fbh325
         P2iaG1mcW4l8IMleCy6c6zCiTfJK2g+A5v8AuFejfJhTpzsTOKZyrzJAuuVTuMUqrFsz
         ZXvqknsmz64eRNWcLcO7dSAABWbplBXA33T40FFRl4vsHjs+kax+jLyxc4XWYHk8miLk
         YbCYKVgr/rrm7wfFUBF5HgCXzPkAzLqVnK8MntJ9+OQMyZgEJ8IRyx1aXPPqx3eHZgJ8
         UuolCaGziQqzBm08ZrfKyOc2sDa4ztIO9Tw7KREmeVf0XYM1qpXyTYLlys4RVz3xnBe2
         EL8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=60MXETSjP7JxrozXhyXnc4/F0W1IKNZR/urucLM1MSQ=;
        b=agNvlmpUABbUIomQuQ4XLU2AqSf6AxQDRj4YFuHzEj+NL95rV6RkqMkNQNv0U0cDlT
         uid+WMR8G/UNXSXsNj8kv0FCU6tu46Gwypa4/a/Ug/G09d82GxFx6sNbLu24hq+c9JqS
         yUZKFVYUFOWFlwERy5L0H/0orpecqLTHrXHremf9vb3Pd0l7gRArJNdcpW5qXgTDI7Ng
         HKHK0dso2tQZbVEMVg5P4YWryAUByuAqc8eKjJULmOeMYREFJlKcgZXYbdAZW14kzTii
         31pApoMCZMZAwOuJaMXotMtKr89n1nbrheGFvvwAgDWQoqUQ7OnBRWWLBYYzNBRx86GQ
         u3eg==
X-Gm-Message-State: AOPr4FUyywwpNfu2ZHbCiKHY0Uob3uWfuFJh6jfiqerBfOSe0SNZFLznhOFQpO4pEvPX8Wl0dr921LlEi6Lt1fGt
X-Received: by 10.50.111.15 with SMTP id ie15mr7102531igb.94.1461712744094;
 Tue, 26 Apr 2016 16:19:04 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Tue, 26 Apr 2016 16:19:04 -0700 (PDT)
In-Reply-To: <CA+P7+xrPYHEoLPNbGaSDSniHUCLeqj+d85ei3T_uwnBmz68G1g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292698>

On Tue, Apr 26, 2016 at 3:50 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Tue, Apr 26, 2016 at 1:50 PM, Stefan Beller <sbeller@google.com> wrote:
>> When adding new submodules, you can specify the
>> label(s) the submodule belongs to by giving one or more
>> --label arguments. This will record each label in the
>> .gitmodules file as a value of the key
>> "submodule.$NAME.label".
>>
>
> Ok so labels will be in the .gitmodules file. This means that if we go
> back in history using git bisect or something similar, we'll
> potentially change what the default submodules are for example?

Good point! Yes that's exactly what we want.

Consider this:
We have:
    libA
    libB

Now libB grows a lot and someone decides to split it up into
2 libraries, so we'll have:
    libA
    libB-small
    libC-was-part-of-B

As libB (the big one repo containing all the code) was no open source,
we can deprecate it fast and just keep developing in libB-small and
libC-was-part-of-B. As we do only small changes at a time, we'll keep
those 2 in the same label set, so the users can pick up the changes via

    git submodule update
    #  libB-small and  libC-was-part-of-B are in both the same group,
e.g. default
    # so they will be checked out.

When a bug is found in the future, you'd use `git bisect` to find it.
In a repository with no
submodules (analogy: think of splitting a file in two. Checking out
older revisions
will give the one old file, checking out newer revisions will give 2 new files.)
that works great. With submodules we want to have the same properties.

    git checkout tag-before-libB-split
    git submodule update
    # get libB checked out

    git checkout tag-after-libB-split
    git submodule update
    # get libB-small and libC-was-part-of-B checked out

Ideally (read: in a later patch series), checkout will automatically
checkout submodules for you if you have configured `submodule.updateOnCheckout`,
such that switching old and new revisions will add or delete
submodules automatically.

>
> This is sort of why having some submodule data appear in the
> .git/config file is useful since it helps keep things like the remote
> url safe from being updated when doing this sort of thing.

(Unrelated, but my thoughts on this)
The remote url mechanism is broken with the .gitmodules file in some use cases:
Consider there is an upstream "kernel.org" which hosts a repository with
submodules. Now you want to mirror that superproject to "kernel.mymirror.org"
and you start with

    git clone --mirror git://kernel.org/superproject

When the superproject uses relative URLs for the submodules, this will
break your mirror,
if you did not mirror them exactly with the same relative path. Then
cloning from
your mirror will result in broken submodule URLs.

So you would want an additional mechanism for URLs. Jonathan came up
with the idea of having another configuration file in a refs/submodules/config
branch which essentially allows to annotate/enhance the .gitmodules file.

So in such a configuration you could say:

    defaultRelativeURLBase = kernel.org
    [submodule."foo"]
        relativeURLBase = kernel.mymirror.org
        protocol = ssh
        # ssh as opposed to git:// which was inherited from the superproject

which allows finer controls of submodule/repository mirroring.
As the refs/submodule/configuration is not part of the history of the
superproject,
mirroring can be done without changing history, but still having URLs changed to
the internal mirror.

>
> I am not sure if labels will be that important in this case?

I am not sure. If it turns out to be a problem, maybe we can
introduce a hook, that will be called on adding new submodules via lables?

Thanks,
Stefan

>
> Thanks,
> Jake
