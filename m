Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A38EE1FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 15:54:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932483AbcK1Pyb (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 10:54:31 -0500
Received: from mout.web.de ([212.227.15.3]:55759 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932334AbcK1Py3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 10:54:29 -0500
Received: from localhost ([195.252.60.88]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M7scS-1cxq7F3yb2-00vP7W; Mon, 28
 Nov 2016 16:54:18 +0100
Date:   Mon, 28 Nov 2016 15:54:15 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     eevee.reply@veekun.com
Cc:     git@vger.kernel.org
Subject: Re: cherry-pick -Xrenormalize fails with formerly CRLF files
Message-ID: <20161128155415.GA9966@tb-raspi>
References: <777ee899-4cfb-e3b4-da0d-793fde35e412@veekun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <777ee899-4cfb-e3b4-da0d-793fde35e412@veekun.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Provags-ID: V03:K0:2yyGmHViuFXbrsNrgkqQQORpLDcvGuUcJNxAVd9i0/Ddc/C9iuy
 0GWwXZo2AnEGMJcwabrewQ9Co38Eb9o/G57gPoSDKHPraHknTqnHYYW7/j/XvEx59VaPpRa
 3ukiJw/hFGPk9MHL5lHYy2kUHT0iA9VXMhYqyoFffhH2sKOIsn3TudGXB2sAQ/JHvaw3Jjf
 dgC1lIaZ8+0sahLSBs1lg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:UwQj1Sl0954=:KEzpxiib21VkBLYqaIs52u
 C3a4r++q/FC1cErl6I//2b6g4ew9kWavNMeE+IxZufYjkyFsHiEQjsOo5F2tnfekuXt041DcI
 gzzZnyZ/Kj31lLzDs3gbpqY3ZeA0kLEQA3ocqcdQq/oeXN7SnE2ITlUB19MwHLqX6/2PF4ASO
 SGRvpz0M2igZDpFiXotSsFVI5R2+rwFH1s9r01pGakyBm6I34Uz7awGt8GRuieCaEy92Y1Ncu
 Gs9s5QBEiJJ46sRpX1AUdnHnN+sVE8ZbAz9fRmm5Jycf5Fh1NwjwLco7lTFjv5/BnqU7XUKzd
 1YsmK105wdRqu1jUAK0gedyWPKRoIRdzrhj+nf37XRTn0i7BE7EPv/x7WvFWh5uTTaEdUu7y0
 tUB2T12HyoURQCSJ81J6nVMg6AxcfSpQVDOUOPrZlWqA1DQyP9t+Hk43hnXAjD2DjVaGaaLJF
 R5sjvQGQDbX+qMry7NhCaIftUxgFpiGgXSkhW5cHhTfv9/+LKVPJuZPKZzBejfZkoEqV4D1lu
 KsRwchxstsAuinMihh/ZXUgaewnxapJvGOpQB8J1Sy/EjURiw+IcE4Ksrak9GHi2PUGMfXt9u
 0TJ9QTjhW0gXXG9gRiAe074vBsji4n+QMrQv4DTQuO4BgN4T4zxv5h3UKyIzbjw45VWP8yidG
 HxWMorTqRrKW4LqvpC12nJvmSZJOR8eV69ZN1UfKt6tmICFd6YQ6Neo0N+FD6Q2OdMW/JvLmO
 BKE2Gu+00/+ZG/i6X0eIRs0AhRWVbwuzSXMdB+2olu31ySHgxg0RJQ5XyLA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 27, 2016 at 10:19:35PM -0800, Eevee (Lexy Munroe) wrote:
> I'm working with a repo that used to be all CRLF.  At some point it
> was changed to all LF, with `text=auto` in .gitattributes for the
> sake of Windows devs.  I'm on Linux and have never touched any
> twiddles relating to line endings.  I'm trying to cherry-pick some
> commits from before the switchover.
> 
> Straightforward cherry-picking causes entire files at a time to
> conflict, which I've seen before when switching from tabs to spaces.
> So I tried -Xrenormalize and got:
> 
>     fatal: CRLF would be replaced by LF in [path]
> 

Which version of Git are you using, what does
git --version
say?


> The error comes from check_safe_crlf, which warns if checksafe is
> CRLF_SAFE_WARN and dies if it's (presumably) CRLF_SAFE_FAIL.  The
> funny thing is that it's CRLF_SAFE_RENORMALIZE.
> 
> I don't know what the semantics of this value are, but the caller
> (crlf_to_git) explicitly checks for CRLF_SAFE_RENORMALIZE and
> changes it to CRLF_SAFE_FALSE instead.  But that check only happens
> if crlf_action is CRLF_AUTO*, and for me it's CRLF_TEXT_INPUT.
> 
> I moved the check to happen regardless of the value of crlf_action,
> and at least in this case, git appears to happily do the right
> thing.  So I think this is a bug, but line endings are such a tangle
> that I'm really not sure.  :)
>
I am not sure either.
Could you send me the diff you made ?
git diff

I am happy to look into it, (in the amount of time I have).

> The repository in question is ZDoom: https://github.com/rheit/zdoom
> I'm trying to cherry-pick commits from the 3dfloors3 branch (e.g.,
> 9fb2daf58e9d512170859302a1ac0ea9c2ec5993) onto a slightly outdated
> master, 6384e81d0f135a2c292ac3e874f6fe26093f45b1.

This is what I tried:

user@pc:~/NoBackup> cd zdoom/          9fb2daf58e9d512170859302a1ac0ea9c2ec5993                                      t9fb2daf5Note: checking out '9fb2daf58e9d512170859302a1ac0ea9c2ec5993'.02a1ac0ea9c2ec5993 

You are in 'detached HEAD' state. You can look around, make experimental
changes and commit them, and you can discard any commits you make in this
state without impacting any branches by performing another checkout.

If you want to create a new branch to retain commits you create, you may
do so (now or later) by using -b with the checkout command again. Example:

  git checkout -b <new-branch-name>

HEAD is now at 9fb2daf... - Force use of GL nodes when 3D floors are present. - Move MAPINFO line modification flags into P_AdjustLine().
user@pc:~/NoBackup/zdoom> git format-patch HEAD^..HEAD --stdout >9fb2daf.patch
user@pc:~/NoBackup/zdoom> git format-patch HEAD^..HEAD --stdout | tr -d "\r" >9fb2daf-noCRLF.patch
user@pc:~/NoBackup/zdoom> git checkout 6384e81d0f135a2c292ac3e874f6fe26093f45b1
Previous HEAD position was 9fb2daf... - Force use of GL nodes when 3D floors are present. - Move MAPINFO line modification flags into P_AdjustLine().
HEAD is now at 6384e81... - Add support for Skulltag ACS IsNetworkGame.
user@pc:~/NoBackup/zdoom> git cherry-pick 9fb2daf58e9d512170859302a1ac0ea9c2ec5993'.02a1ac0ea9c2ec5993
> 
user@pc:~/NoBackup/zdoom> git cherry-pick 9fb2daf58e9d512170859302a1ac0ea9c2ec5993
error: could not apply 9fb2daf... - Force use of GL nodes when 3D floors are present.
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'
user@pc:~/NoBackup/zdoom> git status
HEAD detached at 6384e81
You are currently cherry-picking commit 9fb2daf.
  (fix conflicts and run "git cherry-pick --continue")
  (use "git cherry-pick --abort" to cancel the cherry-pick operation)

Unmerged paths:
  (use "git add <file>..." to mark resolution)

        both modified:   src/p_setup.cpp

Untracked files:
  (use "git add <file>..." to include in what will be committed)

        9fb2daf-noCRLF.patch
        9fb2daf.patch

no changes added to commit (use "git add" and/or "git commit -a")
user@pc:~/NoBackup/zdoom> git cherry-pick --abort
user@pc:~/NoBackup/zdoom> git am < 9fb2daf-noCRLF.patch 
Applying: - Force use of GL nodes when 3D floors are present. - Move MAPINFO line modification flags into P_AdjustLine().
error: patch failed: src/p_setup.cpp:1798
error: src/p_setup.cpp: patch does not apply
Patch failed at 0001 - Force use of GL nodes when 3D floors are present. - Move MAPINFO line modification flags into P_AdjustLine().
The copy of the patch that failed is found in: .git/rebase-apply/patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".



The patch did not apply, but for different reasons.

Could you send us, what exactly you did, to help me out ?

 



