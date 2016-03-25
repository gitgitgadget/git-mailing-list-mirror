From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv3 5/5] submodule--helper clone: lose the extra prefix option
Date: Fri, 25 Mar 2016 16:02:11 -0700
Message-ID: <CAGZ79kbbVN4kQyQoTk+3o5yPZPAdGULtOhKisOLUf9-u7ssh7A@mail.gmail.com>
References: <1458931156-29125-1-git-send-email-sbeller@google.com>
	<1458931156-29125-6-git-send-email-sbeller@google.com>
	<xmqqfuve2vln.fsf@gitster.mtv.corp.google.com>
	<xmqq60wa2s7w.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZotAZeKJxRsHczMp5BG7edu=GLj6mox08M6afkMu1UDg@mail.gmail.com>
	<xmqqmvpm18sw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 00:02:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajakD-0005xv-Go
	for gcvg-git-2@plane.gmane.org; Sat, 26 Mar 2016 00:02:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754591AbcCYXCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2016 19:02:13 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:34495 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753534AbcCYXCM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2016 19:02:12 -0400
Received: by mail-io0-f179.google.com with SMTP id e3so12714399ioa.1
        for <git@vger.kernel.org>; Fri, 25 Mar 2016 16:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=PdWjURRrEunrC/09Kz+6sEWfaA3z0S9Ll/Gv+B1P90c=;
        b=WBt1kLz3QFKCDlHU+kAlmMYZylSF3cGbIQRe86fD+3V5iFRGqJCIYA7dEuEDzG5Hbw
         reB3uE6ZtMAMDP/Z3Aev1Q9Ny1wauj2FWhq40aDqPv9A5YtcyOSezWVolYxhAZbnqvW8
         kSz46FK6aW/aewGWPYI3VEt/UGXiZRpd6rr6LsWRfgEHLp8CK+toggBngqdveApNARch
         UoCmoS8VKxXn4G7uD64J4YvpoUxDCINhXpRxGco0cVhtCDiCjBezVFZ860S6d2cew0Tc
         gNZuANcr2lk9Qy7xmbjknOj142xeeoDXvTFfFj6Hr2nFED+2IdJo/QSY0obTTRn3gZRv
         Q7qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=PdWjURRrEunrC/09Kz+6sEWfaA3z0S9Ll/Gv+B1P90c=;
        b=O1X0oxpkjmSp+ZMhye+BvNMbKSF/X1uZ52fLTWouKiM2Z6zMNXmFh0x/O9NSY3pXxH
         mguHssiPNQzbADN9IT8TI3TXDSVioTxHCv+17/IP9tP2BgRU6QEU09nhfV5hmHdKLa1z
         RZZKsuFTRlZUFpwowJ3ZxKHBuo5d1bMz6Cmub4BZjndPdA4xFBVHgmW4uUW7v6X9mEiB
         EDQteefN24uHHUoJmq72BjoAaMdNjOOdD+2m6qRIzvkSLnKwMnmwNLYb5iMdnvknXgvx
         PPVFK2t8AgoH793uErxyMobm5Xocv897gdtCI60bcKWWQ9W1MSMkIawoatvR1kD4CoE2
         h/kQ==
X-Gm-Message-State: AD7BkJKOF3c02522MhWqBcL7SPBLx056cl/99hJ0b8wayOXTeYl7k1mihwDCuRFwDxU0gCey+uuVjD23dGWkTzB/
X-Received: by 10.107.158.138 with SMTP id h132mr15641393ioe.174.1458946931151;
 Fri, 25 Mar 2016 16:02:11 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Fri, 25 Mar 2016 16:02:11 -0700 (PDT)
In-Reply-To: <xmqqmvpm18sw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289964>

On Fri, Mar 25, 2016 at 3:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The replacement works fine in all tests except for the recursive
>> tests as then the chdir is an important detail. In the submodule
>> there is no $wt_prefix (as it is the parents' wt_prefix we passed in),
>
> So the real reason is that we may tweak $wt_prefix to refer to a
> non-existing directory, that submodule--helper is buggy and does not
> notice it, and that using "-C $wt_prefix" would catch it because it
> first tries to chdir to it.

I agree that we tweak wt_prefix to refer to an existing path.
However I would claim that it's git-submodule.sh which is buggy, not
the submodule--helper, because the shell script gives the non-extistent
path to submodule--helper in the first place.

 "-C $wt_prefix" would catch it indeed, so we need to fix that before we
switch to -C (if at all)

>
> The calling script "git submodule" first sets $wt_prefix to the
> original directory, so there is no way chdir'ing back there would
> not work,

right,

> but if we update it (e.g. by appending a path to a
> submodule we want to work in), it may very well end up referring to
> a directory that does not exist (e.g. it may not have been
> "init"ed).  Is that what is going on?

Or by changing dirs in the shell script, i.e.

wt_prefix=$(git rev-parse --show-toplevel)
# wt_prefix is correct until we do:
cd sm_path

# If we now would "chdir'ing back there", we try to
(in $sm_path) >  cd ./$wt_prefix
# which would be  $sm_path/$wt_prefix and that may not exists.

>
> If that is the case, it makes a lot more sense as an explanation.
> The justification for the main change 4/5 in the log message,
> i.e. "-C $wt_prefix" is more familiar, was an irrelevant subjective
> statement that only said "we could change it to use -C" without
> explaining why "--prefix $wt_prefix" was wrong, and that was why I
> was unhappy about it.
>
>> So here is the example from before:
>>         repo/ # a superproject repository
>>         repo/untracked/ # an untracked dir in repo/
>>         repo/sub/ # a submodule
>>         repo/sub/subsub # a submodule of a submodule
>>
>> When calling "git submodule <cmd> --recursive" from within
>> repo/untracked/, the recursed instance will end up in
>> repo/sub/ with the parents prefix ("untracked/")
>>
>> In case of git -C $wt_prefix we would try to chdir into
>> repo/sub/untracked/ which doesn't exist and our journey ends here.
>
> That sounds like an unrelated bug, though.

It is the thing described above.

>  Whether -C or --prefix
> is used, we shouldn't be using "repo/sub/untracked" after going to
> "repo/sub".  If the <cmd> somehow wanted to refer to a relative path
> (e.g. "file") in the original directory, it should be using
> ../untracked as the base (e.g. it would use "../untracked/file").

In case of --prefix we do not chdir into "repo/sub/untracked"; however
we have cwd="repo/sub/" and wt_prefix=untracked (as it's stale from
the parent). We have no way of knowing where "untracked/" applies to.
As the root of the repository is now "repo/sub/" (It is a different repo,
the submodule), we may assume there is a "repo/sub/untracked/",
but we never compute that value or chdir there. It's just cwd and wt_prefix
being from different repositories. (superproject&submodule)

>
> Of course by using -C, you might notice that repo/sub/untracked does
> not exist, but that is not a proper error checking---what if the
> submodule at repo/sub does have a directory with that name?  IOW,
> the computation that gave repo/sub/untracked instead of ../untracked
> is wrong and using -C would not make it right.

There is no explicit computation of repo/sub/untracked, but it would happen
implicitely in the -C case as we'd be in the repo/sub and try to chdir
to 'untracked'
(interpreted as a relative path)

>
> And if you clear the prefix you originally obtained in calling
> script "git submodule", which is "untracked/", even if <cmd> somehow
> wanted to refer to the "file" in that directory, the only clue to do
> so is forever lost.  Again, this is unrelated to -C/--prefix, but
> that is what the patch 2 in the original series (which was rolled
> into patch 1 in the update) was about.

As of now this file would also be lost I would assume, as it is unclear
which repository you refer to.

If you are in the "subsub" submodule and know that the $wt_prefix=untracked,
you still don't know if the original command was invoked from the root super
project or the intermediate submodule.

In the current situation you /may/ be able to reconstruct that by going back
"prefix" as that seems to be the path we traveled so far.


>
> So I am not sure what the value of using -C is.  At least that
> "example from before" does not serve as a good justification.
>
