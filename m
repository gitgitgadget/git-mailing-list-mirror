Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C9D1F404
	for <e@80x24.org>; Mon, 27 Aug 2018 12:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbeH0QgE (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Aug 2018 12:36:04 -0400
Received: from mout.gmx.net ([212.227.15.18]:59727 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbeH0QgE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Aug 2018 12:36:04 -0400
Received: from [192.168.0.129] ([37.201.193.173]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LiDnn-1fXG0z2iCh-00nPqW; Mon, 27
 Aug 2018 14:49:26 +0200
Date:   Mon, 27 Aug 2018 14:49:25 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood@talktalk.net>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] rebase -i: fix SIGSEGV when 'merge <branch>' fails
In-Reply-To: <xmqqzhxmfgbb.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1808271442010.73@tvgsbejvaqbjf.bet>
References: <20180815093935.10222-1-phillip.wood@talktalk.net> <20180815093935.10222-3-phillip.wood@talktalk.net> <xmqqzhxmfgbb.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hyQ2sdzmY1H4ji5uIgzwwJP7tEK3hU8cid1tMc05FNsw2Y8Cgiv
 MzJ3VxvI/p2SvncVhtEPV+xG3RAUWNuaCd+ftmF9yyIWiQktUQUbDILLo7PgJSlmFnxrgdR
 hjfthM7d1gMa3zn1sEZ2fjVbn7hsLRx3IKq7+4RM74ysnx8Bh1V3i5JHKQKJ9CMI7mwcZ9O
 LU1bHUXok46tNmBjdPOeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:RA3O+ZdGv9w=:RMcfbbJQC6xvmiUtTQ3Uly
 h1LI1wxguC6qVV16OZj+u8qovbiHfJJyqNGwNzfgvDduhmG3QZ2KAYPerfM/GkNwurQfptFbb
 ZMycSQqw2BKR0Afyr/2Uypa+ALar0L7xqF4m/9Njw6W+1mk7utgFqlZhTvzcC0x9O24fq4jnF
 OyxHrFrh6z+ucSej4rHDuJODIdxagipptsLB3a0otMMs0wy74YLG0v3IyOUCDzIdUO+6Vcp3k
 hakvcAwk/5zNKF5TbJ2uibkmDJjeqplEi45FDi9WrCozMyd1nFAI7CVfMym97YZ9/WwZKqseF
 rEcxG57dZpHEcVspcyYa1gRNQVgFtPMszORDhuXkoL+H+C60hWD4MCHywCOtBgtvb/ms+O2Yb
 fLmNYtEoNqvUfqJjH+n6CPSkBtMLC0jBgiwznbgUlyrC4MwemTK+NzSA+C5FEDfE8vWFUTrmU
 no636tk7pz0wvax9/c5rMX0xOGD6wN6mWow/KCHInFugjVwiwqlHnkUncQWBde06LO4ek7TkV
 Bqu5CIAcHpQ1S1pBygkCRinGBvpTCrp/jm0G5wWMOVRMMBEylvh2mtXvxVhwSUmLtHoiWkpCD
 NT0B0XR4lX6W72LEGE8b/Cg7T0F0jV13VlHKVwKHwUUQT1kRwO4b2BG3dg8HP8tcI6+dQxTza
 Jw1i5lHPrPo/+pHCJ8DuqxGmUhKjj7d1TntK8KgjfCTgzxin5PBX2BhVJ7fAt+1U+FSZyTwsr
 oo5RmGsfU0LyPNmOFByD44uUsFv5Da/bHsvBjoDkcof8oM/e7AJe9AXKbE/fYDrqnp/FNJrft
 k0Aosh6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 16 Aug 2018, Junio C Hamano wrote:

> Phillip Wood <phillip.wood@talktalk.net> writes:
> 
> > This commit implements a minimal fix which fixes the crash and allows
> > the user to successfully commit a conflict resolution with 'git rebase
> > --continue'. It does not write .git/rebase-merge/patch,
> > .git/rebase-merge/stopped-sha or update REBASE_HEAD.
> 
> I think that should be OK.  When merging, a patch that shows the
> diff from the merge base to the tip indeed is an interesting and
> useful reference material to help the conflict resolution, but it is
> not even clear what the latter two should mean while merging.

Late reply, I know.

It is indeed ambiguous what the REBASE_HEAD should be... While a natural
choice would be the commit to be merged, that would be inconsistent with
the `-c`/`-C` version of `merge`.

But yes, the `patch` should not be written, and the `stopped-sha` does not
make sense with a `merge` that has neither `-c <commit>` nor `-C <commit>`
(although, please note, that this breaks a subsequent `fixup` if there is
one directly after the `merge`).

> > diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> > index 31fe4268d5..2e767d4f1e 100755
> > --- a/t/t3430-rebase-merges.sh
> > +++ b/t/t3430-rebase-merges.sh
> > @@ -129,7 +129,7 @@ test_expect_success '`reset` refuses to overwrite untracked files' '
> >  	git rebase --abort
> >  '
> >  
> > -test_expect_success 'failed `merge` writes patch (may be rescheduled, too)' '
> > +test_expect_success 'failed `merge -C` writes patch (may be rescheduled, too)' '
> >  	test_when_finished "test_might_fail git rebase --abort" &&
> >  	git checkout -b conflicting-merge A &&
> >  
> > @@ -151,6 +151,19 @@ test_expect_success 'failed `merge` writes patch (may be rescheduled, too)' '
> >  	test_path_is_file .git/rebase-merge/patch
> >  '
> >  
> > +SQ="'"
> 
> A low-hanging fruit tangent, but somebody may want to go through the
> output from
> 
>     $ git grep '[Ss][Qq]_*=' t
> 
> and come up with a shared "convenience" definition of this, which
> perhaps sits next to the definition of $_x40 etc.

If only we had a nice bug tracker with labels. I guess
https://github.com/git/git would be a good place, but it *is* discouraged
by us, which is a pity.

Ciao,
Dscho
