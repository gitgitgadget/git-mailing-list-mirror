From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: tests failing on Cygwin
Date: Sat, 7 Aug 2010 23:02:27 +0000
Message-ID: <AANLkTikvGAwW0XbaSXOw6iWETwe_bpVC4cj1J8UP++66@mail.gmail.com>
References: <AANLkTimeE-dJrSrjJSuP9Zm93tF9woNakO+HwspJg6CZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Amir E. Aharoni" <amir.aharoni@mail.huji.ac.il>
X-From: git-owner@vger.kernel.org Sun Aug 08 01:02:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OhsPd-0002yp-Jk
	for gcvg-git-2@lo.gmane.org; Sun, 08 Aug 2010 01:02:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754010Ab0HGXC3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 7 Aug 2010 19:02:29 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:59890 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605Ab0HGXC2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Aug 2010 19:02:28 -0400
Received: by iwn33 with SMTP id 33so2529240iwn.19
        for <git@vger.kernel.org>; Sat, 07 Aug 2010 16:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1j5LOcjIXqnI3+LgjSsOSkwy6tembxeOn7jZtODG1ok=;
        b=GkRK+/INz6S/MqxyNdKuM6t4ig+xdHeohbkTs/vuxX98g0ytr+XihQjaEO4X4z5Jyh
         PBwt1kq3z6V6MEWrFbqbjp65N+V6VTyclPXBuoyvbaeLH4/uw6HGv58FtbMsSoWBJbM1
         7Wj4uHnVUq0bcFSdYAzAvyW/EVZXdSnlU7A9c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=a7vGJ2otciZZY4nZqWqJVqvn5I5duKMSArG/2OmZzLe9IUDu46JubmgvDdW/B63Jrt
         LKSWUJSBLW0BPmnD1lRyXEgOOH/ZOe8QbAhD9y9HsKl504ob75kULMCBFjROupTMZg6H
         WVzdi89SDYIx00OPGYEQKaONck5DkdxFUiyp4=
Received: by 10.231.39.134 with SMTP id g6mr16326561ibe.8.1281222147152; Sat, 
	07 Aug 2010 16:02:27 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sat, 7 Aug 2010 16:02:27 -0700 (PDT)
In-Reply-To: <AANLkTimeE-dJrSrjJSuP9Zm93tF9woNakO+HwspJg6CZ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152870>

On Sat, Aug 7, 2010 at 21:37, Amir E. Aharoni
<amir.aharoni@mail.huji.ac.il> wrote:
> Hallo,
>
> I couldn't find a better place to report this and i don't know whethe=
r
> anyone really cares about this, but i'll try anyway.
>
> I want to make a few corrections to the core documentation. I cloned
> git.git and before starting the actual i built it and ran `make test'=
,
> just in case, and some tests failed.
>
> I am doing this on XP/Cygwin. Some of them may be irrelevant for
> Cygwin; if so, they probably should be skipped. And maybe i am just
> misunderstanding something.
>
> Here's the list of files and names of failed tests:
>
> t0001-init.sh:
> * init notices EPERM
>
> t1004-read-tree-m-u-wf.sh:
> * funny symlink in work tree, un-unlink-able
>
> t3300-funny-names.sh:
> * git diff-tree delete with-funny
> * ... and all the test from here until the end of that file
>
> t3301-notes.sh:
> * test_expect_success 'git notes copy --for-rewrite (disabled)' '
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git config notes.rewrite.bar false &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0echo $(git rev-parse HEAD~3) $(git rev-par=
se HEAD) |
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git notes copy --for-rewrite=3Dbar &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0git log -2 > output &&
> =C2=A0 =C2=A0 =C2=A0 =C2=A0test_cmp expect output
> =C2=A0 =C2=A0'
>
> t556x_common:
> * direct refs/heads/master not found
> * no export by default
> * static file if http.getanyfile true is ok
> * http.uploadpack false
> * http.receivepack default disabled
> * http.receivepack false
>
> t7300-clean.sh:
> * removal failure
>
> t7606-merge-custom.sh:
> * merge c2 with a custom strategy

Did you run these tests as root? The 'init notices EPERM' test at
least seems to have failed due to that.

I have a pending patch series (on list) to make the test suite not
fail when you run it as the root user.

It looks like you running them as the superuser might not explain all
of them though, but I didn't go through them all in detail, and I
don't have a cygwin system.

It also helps you run the failing tests like this:

    ./failing-test.sh --verbose --debug

And provide the full output from that. The output from "uname -a"
would also be helpful.
