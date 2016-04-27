From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH 03/15] submodule add: label submodules if asked to
Date: Tue, 26 Apr 2016 20:24:32 -0700
Message-ID: <CA+P7+xpMhH+dU3y6ueGZ+1oRWdwE+9yt1u6CqJSSpq4f-0ta5Q@mail.gmail.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
 <1461703833-10350-4-git-send-email-sbeller@google.com> <CA+P7+xrPYHEoLPNbGaSDSniHUCLeqj+d85ei3T_uwnBmz68G1g@mail.gmail.com>
 <CAGZ79kZfGVhMweP_Sqx1dSAif6L46dneXgKYtEozNuxxay5TOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 05:27:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avG8g-00049L-Vv
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 05:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752798AbcD0DYz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 23:24:55 -0400
Received: from mail-oi0-f48.google.com ([209.85.218.48]:33906 "EHLO
	mail-oi0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbcD0DYx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 23:24:53 -0400
Received: by mail-oi0-f48.google.com with SMTP id k142so36315499oib.1
        for <git@vger.kernel.org>; Tue, 26 Apr 2016 20:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8LzZ8hl7UhTnGqGU7LlB34DPkw5tPjHS9nD815A+w48=;
        b=PCZaz1oLiUJAR45Hmnyakjbw0Aj91YX6W+FnW71P8G1XWtmj6fxuvOBC7pltyGzKak
         4UACdvRENDeSkz2IN4wc0A6QBRYIcTTTOrLGQlZBIf/R8RSF2pWF2pp7bR7MRrmNUciC
         0Izp/lzFVYu5AwZ8Kx5Mk3BJUrTDma+aFma3KZL8+dZDMtW5+6PeZIniGFihxg4rOp2n
         RIDV8JNcGWxmYbAcmeiz0aaQaHDlJzwEh/OqTFAlXk8WwKuxpnUADtdDmW9fjZjM4KXy
         laQErPdg7AIeM36ZocYzmdkgeoZ8kWRd71QTBH0DvO673lRjr672iADTbYSwdj6djFLv
         +BmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8LzZ8hl7UhTnGqGU7LlB34DPkw5tPjHS9nD815A+w48=;
        b=Uwhe6CJNS4OYpG5JnGx3J6JaU6GwzOF9qB4RtzXgIPfcfos2xYQ0P/MwHTscI3dohy
         Gtv2gviTRrWfk/FEP0boPIUWW+WsED+qslXiuApNiwXw6e6+VGKkhLS1AtoPsgcjE9jp
         dl+LmWJh8c9bshm67z/GQ0OUcbkbl+xV6YSoFCE/GHwBgM48U1Hs3KkXe1Cv0B/g+0Tk
         4MVO3vwZgYEWllzfGOC1NllfAf/DYihNhMrDMTb4wr4WGAyvmsA3oTYUNnlX+bNLNJ93
         939EE2uMVUs1ZxCr5WiH/T5Y/gaGastLgRzQeuz6N+jqcLWb02YZisMRb4dDeT16bFik
         LiAQ==
X-Gm-Message-State: AOPr4FXSH3MiMYysZ7UiFOTPWZjuUm8UIyCLJJygnjJh3ztiViiknZOQCvqL3r3X+2mCSXfIh2gi17ABLRRFpA==
X-Received: by 10.157.49.1 with SMTP id e1mr2642801otc.148.1461727491664; Tue,
 26 Apr 2016 20:24:51 -0700 (PDT)
Received: by 10.182.117.132 with HTTP; Tue, 26 Apr 2016 20:24:32 -0700 (PDT)
In-Reply-To: <CAGZ79kZfGVhMweP_Sqx1dSAif6L46dneXgKYtEozNuxxay5TOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292701>

On Tue, Apr 26, 2016 at 4:19 PM, Stefan Beller <sbeller@google.com> wrote:
> On Tue, Apr 26, 2016 at 3:50 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
>> On Tue, Apr 26, 2016 at 1:50 PM, Stefan Beller <sbeller@google.com> wrote:
>>> When adding new submodules, you can specify the
>>> label(s) the submodule belongs to by giving one or more
>>> --label arguments. This will record each label in the
>>> .gitmodules file as a value of the key
>>> "submodule.$NAME.label".
>>>
>>
>> Ok so labels will be in the .gitmodules file. This means that if we go
>> back in history using git bisect or something similar, we'll
>> potentially change what the default submodules are for example?
>
> Good point! Yes that's exactly what we want.
>

Ok. That makes sense.

> Ideally (read: in a later patch series), checkout will automatically
> checkout submodules for you if you have configured `submodule.updateOnCheckout`,
> such that switching old and new revisions will add or delete
> submodules automatically.
>

This is something I definitely would like to be able to tell people.

>>
>> This is sort of why having some submodule data appear in the
>> .git/config file is useful since it helps keep things like the remote
>> url safe from being updated when doing this sort of thing.
>
> (Unrelated, but my thoughts on this)
> The remote url mechanism is broken with the .gitmodules file in some use cases:
> Consider there is an upstream "kernel.org" which hosts a repository with
> submodules. Now you want to mirror that superproject to "kernel.mymirror.org"
> and you start with
>
>     git clone --mirror git://kernel.org/superproject
>
> When the superproject uses relative URLs for the submodules, this will
> break your mirror,
> if you did not mirror them exactly with the same relative path. Then
> cloning from
> your mirror will result in broken submodule URLs.
>
> So you would want an additional mechanism for URLs. Jonathan came up
> with the idea of having another configuration file in a refs/submodules/config
> branch which essentially allows to annotate/enhance the .gitmodules file.
>

I like the idea of refs/submodules/config.

> So in such a configuration you could say:
>
>     defaultRelativeURLBase = kernel.org
>     [submodule."foo"]
>         relativeURLBase = kernel.mymirror.org
>         protocol = ssh
>         # ssh as opposed to git:// which was inherited from the superproject
>
> which allows finer controls of submodule/repository mirroring.
> As the refs/submodule/configuration is not part of the history of the
> superproject,
> mirroring can be done without changing history, but still having URLs changed to
> the internal mirror.
>
>>
>> I am not sure if labels will be that important in this case?
>
> I am not sure. If it turns out to be a problem, maybe we can
> introduce a hook, that will be called on adding new submodules via lables?
>
> Thanks,
> Stefan
>
>>
>> Thanks,
>> Jake
