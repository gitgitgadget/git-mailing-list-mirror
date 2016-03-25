From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 5/5] submodule--helper clone: lose the extra prefix option
Date: Fri, 25 Mar 2016 16:51:40 -0700
Message-ID: <CAGZ79kYgORCf2n5UtjRqmbFic62fSZkN4gOaGPzh7Herk8Otig@mail.gmail.com>
References: <1458931156-29125-1-git-send-email-sbeller@google.com>
	<1458931156-29125-6-git-send-email-sbeller@google.com>
	<xmqqfuve2vln.fsf@gitster.mtv.corp.google.com>
	<xmqq60wa2s7w.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZotAZeKJxRsHczMp5BG7edu=GLj6mox08M6afkMu1UDg@mail.gmail.com>
	<xmqqmvpm18sw.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbbVN4kQyQoTk+3o5yPZPAdGULtOhKisOLUf9-u7ssh7A@mail.gmail.com>
	<xmqqegay175q.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 00:51:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajbWB-0007QG-LJ
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 00:51:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041AbcCYXvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 19:51:42 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:35589 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751763AbcCYXvl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 19:51:41 -0400
Received: by mail-io0-f169.google.com with SMTP id v187so96456004ioe.2
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 16:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=v/ZKxwxd5vxon8UksY5wjQro88TYiqGK1JoL4v2yucE=;
        b=m1bLixY/j5e0QgWob4UfpNmxM6PFqx8KeGycnFrl3q5dkVyF2SRCozvbYrXOheS6id
         mTcK6ZZwPlTCE0v3ubiZqvHIjbiM9fLkoWsl6vAncKW8TKFzik/IZtnvvZtCxZ0fjxAX
         QmtxCnDMa7uQWeoJCHv+MnnT97vq99ycUlIWg7KGEODwKLTuzCDJgkM8rfNl5sMt7iBn
         85if1UOIgAawv9Sz6MwYkyIP9SsR/PA0y7wP+zqCiYvw3qPrg9aQfIEKnnVnHbooxJOk
         MDrqGk+GH6hhT99lfFREzUjSNcrlCy3c7f05S9tqY7uh1dDVNNrqaP074Qc4oqza9Kak
         uzVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=v/ZKxwxd5vxon8UksY5wjQro88TYiqGK1JoL4v2yucE=;
        b=lsMJYdDbSOzmQMFKbyq0W+z5FVHlBNnXsq/m/TiOQboDVi5mT546d7ioaM5rmrA9I8
         Hei4UIwNopoucxeP3ndfaUDZmaoHnyEkglnVaphZI5lF6re6CprSe4dvOw81JMqcCb5c
         TP1lzZVGZXqiR9j9ZmdYRXqaqDgSC4Tot8wwolXT5y2VIPxUk9OjsWHOFfy6jhLBdOkg
         bK1KB7CikaBv3HiMPPqspsCdHWATGgapCrHwX07wIaBNIUkrFOH5aa3vkIFjozovJb2V
         IStn/2gCMKZ4k+I5a8BM7a6FO/yJDpKpwEg9iJJocCdNjz4cLMutcuTaApoBTPIGiM/7
         loPg==
X-Gm-Message-State: AD7BkJI0/XXGo9IhoNa++kiKoZFsXl49Eum7OW90MoN5lI/8FHJKyT1If5noNFSVJ6tyVcV3Lu+7GrZcFWCtXJ9o
X-Received: by 10.107.135.96 with SMTP id j93mr16341027iod.96.1458949900346;
 Fri, 25 Mar 2016 16:51:40 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Fri, 25 Mar 2016 16:51:40 -0700 (PDT)
In-Reply-To: <xmqqegay175q.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289973>

On Fri, Mar 25, 2016 at 4:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> Of course by using -C, you might notice that repo/sub/untracked does
>>> not exist, but that is not a proper error checking---what if the
>>> submodule at repo/sub does have a directory with that name?  IOW,
>>> the computation that gave repo/sub/untracked instead of ../untracked
>>> is wrong and using -C would not make it right.
>>
>> There is no explicit computation of repo/sub/untracked, but it would happen
>> implicitely in the -C case as we'd be in the repo/sub and try to chdir
>> to 'untracked'
>> (interpreted as a relative path)
>
> You are looking at repo/sub/untracked that does not have anything to
> do with the reality, and it does not matter if you have an explicit
> code to construct "char *" that points at such a pathname, or it
> happens implicitly.  Looking for 'untracked' directory after going
> inside 'repo/sub/untracked' is simply wrong, just like looking for
> 'sub/untracked' diretory while staying at 'repo/' is wrong.

Right. But we don't do it. We just keep around stale information, such
that it is easily tempted to do such a thing. But we don't currently.

If we were to switch to -C we would do it, if that bug is not fixed.

>
> If anything, ../tracked might have some relevance to the reality but
> nobody is computing it, which may be a bug in "git submodule" if
> <cmd> wants to have an access to the original place.
>
> In either case, that is true with either -C/--prefix, no?

We don't compute  ../tracked in either case.

We don't have to compute that because there is no --read-from=file
switch.

>
>>> And if you clear the prefix you originally obtained in calling
>>> script "git submodule", which is "untracked/", even if <cmd> somehow
>>> wanted to refer to the "file" in that directory, the only clue to do
>>> so is forever lost.  Again, this is unrelated to -C/--prefix, but
>>> that is what the patch 2 in the original series (which was rolled
>>> into patch 1 in the update) was about.
>>
>> As of now this file would also be lost I would assume, as it is unclear
>> which repository you refer to.
>>
>> If you are in the "subsub" submodule and know that the $wt_prefix=untracked,
>> you still don't know if the original command was invoked from the root super
>> project or the intermediate submodule.
>
> I am talking about a case where
>
>         cd repo
>         cd untracked
>         git submodule <cmd> --recurse-submodules --read-from=file
>
> wants to run <cmd>, using information stored in repo/untracked/file,
> and work on submodules repo/sub and repo/sub/subsub.  The reference
> to the original location somehow needs to be carried through if we
> wanted to allow this kind of thing.

I fully agree.

1)
To carry that trough, we need:
* filepath, "the path of the file" (i.e. file)
* wt_prefix, "the path where the user typed the command relative to
repo root" ("untracked")
* prefix, "where we traveled already from repo root" (e.g. sub/)

Then the construction is easy as
    reverse(prefix) + / +  wt_prefix + / + filepath
    ..     /    untracked    /   file

That path is a relative path to the current working directory of the
command, such that we can access file.


2)
Another way to get the same:
* "filepath" , i.e. file
[* wt_prefix "relative path to the repo root", (null) as relative to repo/sub]
* prefix, "path traveled so far from where the user typed the
command", "../untracked"

Then the construction is easy as
    prefix + / + filepath
    ../untracked   /   file

We need to decide to stick with one of both interpretations. Don't mix them!


Notes on 1)
* easy model, because everything is relative to
  the superprojects repo root.
* It may be more work though as we need to resolve
  everything to that superprojects root.
* --prefix $wt_prefix works with that, as we don't try to cd $wt_prefix

Notes on 2)
* we loose the superproject as the reference, which sounds scary!
* it doesn't matter, as we have everything in the prefix
* This model works with both git -C as well as --prefix as has the right
  properties for wt_prefix.

And patch 1/5 switches from model 1) to 2).

I think model 2 is better in this context
* because it works with either git -C or --prefix
  (because of wt_prefix = (null) in all submdirectories
* only need 'prefix' to reference to 'file' (less work!)
* is easier to get right [1]


[1] Looking closer at patch1/5, cmd_status already has
  prefix="$displaypath/" with displaypath="$(relative_path $prefix$sm_path)/"
  as is done for cmd_sync and cmd_update. So before patch 1/5
  we have a bug in cmd_status as it mixes the two models
  (wt_prefix from 1) and prefix from 2)
  After patch 1/5 every command uses model 2)



>
>>> So I am not sure what the value of using -C is.  At least that
>>> "example from before" does not serve as a good justification.
>
> And I do not think your reply does not change anything with respect
> to this statement.
