Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89A8C4332F
	for <git@archiver.kernel.org>; Fri, 14 Oct 2022 04:51:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJNEv4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Oct 2022 00:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJNEvz (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Oct 2022 00:51:55 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1256167274
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 21:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665723101; bh=wIGqCIhvdD1yWdl7BgbC2gNncC52pc9sclYQZtcZ6ss=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=Ru/Mm+1rmwA0EfzaPERrOXfi46mkR5ftkDbNDI4AzoOEUuX/TRYRl+lECKhDMMCLx
         oSkxwC1DJyz9hB083rcWU6yexAxVXmf19LsMqJQErUv87FweLixcO5rMGPow4YIsCx
         nkXkEYOVlothJjqX7MYqLYzaehKBZa41Yi1eFo1ul4k9jmtLC5uxU0PSsAwEri8c1P
         G8VgBdcxKKRkChfGl9cymrlQL0V/1dv5yRoFZP05irTzYeSVg0wXzkDUIHZinghXsb
         jbTztQftfc5waUm6GrFycz3VrE/QAzPMx2L/Sf7q0PBCH17HYDXBuMfnn4rty1yvxZ
         nWORnb14O3qqw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from localhost ([62.20.115.19]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MD5o3-1osFEC1AX3-008wMk; Fri, 14
 Oct 2022 06:51:41 +0200
Date:   Fri, 14 Oct 2022 06:51:40 +0200
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Tao Klerks <tao@klerks.biz>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: icase pathspec magic support in ls-tree
Message-ID: <20221014045140.7ibix3632w4uset5@tb-raspi4>
References: <CAPMMpogcnwJDUazw82OB0DvdgvNS6hpUN9Qs69ppTFb1QFbLSg@mail.gmail.com>
 <220930.86r0ztufwd.gmgdl@evledraar.gmail.com>
 <YznhYzWztkPc9pJk@tapette.crustytoothpaste.net>
 <CAPMMpojy8OMxYT0WuZCOZjwvufmVucvoHPtvLHatopXvuk9K5Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAPMMpojy8OMxYT0WuZCOZjwvufmVucvoHPtvLHatopXvuk9K5Q@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:RlaOPo+Cn7cWycHkamRjFH7Dd8W7fmsXPDvHzTL/oTcoT1Z1CPV
 BhWcSRrVpTSHkx4yT4dXGaTSgJKjsI8t1vCX2oNSg1uyB9TfBY8zuTmZYT2QAMywC/NDzB7
 AD1BAz+60nbDobWJc2uGPExFV6ULw2k2SZTs9WB8VcMXiUDRWtSAv+s1kqsC9+Mna8BLVSW
 Qgv7pOEbrSFuBjnaaySMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ck3g2uOwBX0=:KRUpPRezsX+rMrx0GcE4Go
 IBWIjdnIV43QypFvR+PT6mWnMfYWECklcy7SMIjyWQsDVGbyD/40F1UieYeVVbL/ZLsQJ4Cy2
 PJAtkq7JsbOB2zkjMA5MRwQ9OOCa6q6zf9NT3MGjIk1m9pLC0FKrPntkcNIawEQblEw3Fv4+l
 PCe6+Wvzyj04ikUV5C01xaN4TXrONQbesvlcK+0nn0pEVOWE24YZsPgOxIvz2AsGSkbHTwpyT
 Scw3ByzeKwFUzdZb0bawLbF0YNGXQIUlXIefh1XUjsKsztnGw1Jhbt+0wFmzEl5bR0r6i/OrB
 99Y5eYyvuhXR2/JwO3nwViIAlrvMacftq47o3pvRkGUAcLsZgVlw6pxZc3p80lumfGhrbhSzD
 wpr4dmovV86KpfTZH7wzC5MBvDNQZXobzdEJMkCnSD484Qq1oKlKtDTDsVTmaaQgSPH+WMVCq
 cWCrjMdSo7QeZH9Ed6WW87KqEhTZHs1hI7QC+QwS2MIIJ+A1FkC1X453qy2fAOklo8TNo970a
 TBQ9eVCG2hxCwirTkLldkY9161Ru5lIF4pURK5O4C38+Z0EXcYKIs0n1jlvicxfMHmUxTfYNm
 OkKIkn9b1CN+5q6h/c+ttVpwcB31/vtoLanzicZreCY2QfmcBoGch/tOBngPvssCHt0laxcQp
 nNgCEJA8AQWEqayzpppQIcbwUEq8ze8avGAMgPSvO0hBaLhSdaeVYrBGCQdIxdUGrZec4wYfJ
 tnYgKs1PgmAgMElpoZ0cy2O5x3gp9yc64pZIYUvq9qub4Wfxe7lD1Y3MpYW/0rhR/bqY9vw73
 Jb+2SRJO7pw8nb6hzSl01lSrSnxs4cVYTDRGYCcvDQjJlWmcBZDxb6Sy2z2RHsbJqAv9JVOCp
 aNGw/TnInYCmb29sma6i7SP4q0506qlKu25jKHQv6ne0N33KirDaL9W6MV+Sniv9CI5qG2Ywv
 3nCF/t1bWacxR6J0rxP0hylMvGV1YAeI3NzjIxLBPSLgbBdzb3wjsrhI7h8LBY2/SuR+jTxJO
 arCVPIGhl/q0l6R9tm+je9zDPJrkdOQuMtVjgF+kZO7G5d8iLzRt5AQ8LTJCqjYq04BaLOk+U
 xtgPCNzMFsXWTSquLlInUxnuTannAssSA9iaab70FeQUKV+camYI30KB58vfsirqxarHHxjeI
 tY/2Ey2N2HpL1aemtJhX84FhIdzGptjX0u2fdfEBZdcEWzcvEIl7DyPzMZIDEIchX5/TE4CUQ
 Xo9iwpkyqePOxphZUcTNRFfWBRSniYdOHpe1fhN6bpcYv/oHxgxJDbCBvBO+ZMJwxizlSOQW3
 70vBGauHbE9dN/YSwtxaIy47gNfRdqdHCHA3fYmvTJL6Hf3akFRhSi0Zi2PX+8x14lxtRIbnr
 w8S3DlWw6KlymBrprB4uo4vMNPkvQFVXrTwAE1myCIXIu87tP5b9Mtzj5h2+SYhd5gLNeySg+
 /2Ao5fK4Ds9iGAi0oHAPF6GDH3ICXLWsVwi7K7Q8H0TcPKEXuVQLcLe3ISCjwKt0qcdz6zU/o
 TWZ4aNv8/7y1gOfvZ7A/3urmBc9hydPUWs00m75BCR8/O
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 13, 2022 at 08:35:11AM +0200, Tao Klerks wrote:
> On Sun, Oct 2, 2022 at 9:07 PM brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> >
> > On 2022-09-30 at 13:53:16, =C6var Arnfj=F6r=F0 Bjarmason wrote:
> > > You might find ASCII-only sufficient, but note that even if you get =
this
> > > working you won't catch the more complex Unicode normalization rules
> > > various filesystems perform, see the fsck code we carefully crafted =
to
> > > make sure we don't get something those FS's will mistake for a ".git=
"
> > > directory in-tree.
> >
> > What's even worse is that different OSes case-fold differently and the
> > behaviour differs based on the version of the OS that formatted the fi=
le
> > system (which is of course not exposed to userspace), so in general it=
's
> > impossible to know exactly how case folding works on a particular
> > system.
> >
> > It might be possible to implement some general rules that are
> > overzealous (in that they will catch patterns that will case-fold on
> > _some_ system), but in general this is very difficult.  The rules will
> > also almost certainly change with newer versions of Unicode.
> >
> > I'll also point out that there is no locale-independent way to correct=
ly
> > case-fold Unicode text.  Correct case-folding is sensitive to the
> > language, script, and region.
>
> Thanks for the feedback!
>
> If I'm understanding correctly, both of these responses were targeted
> specifically at my motivation/usecase (preventing the submission of
> case-insensitively duplicate files into a repository) rather than the
> question of whether anyone has worked or is working on anything
> relevant to adding icase pathspec magic support to ls-tree.
>
> I understand that case-folding is a complex topic, and doing it
> correctly in some universal sense is undoubtedly beyond me - but "my"
> context certainly does not require a high standard of correctness:
> There's a repo shared by some 1000 engineers, 200k files, lots of
> activity, three different OSes of which two default to
> case-insensitive filesystems, and every once in a while a user on
> linux creates a case-insensitive-duplicate file with differing
> content, which causes git on case-insensitive filesystems to lose the
> plot (you end up with one file's content looking like changes to the
> other file's content - "ghost changes" that appear as soon as you
> check out, that prevent you from doing a simple "pull", and that you
> just can't reset).
>
> I don't imagine I can make a perfectly correct and universal fix to
> this, but with case-insensitive matching on ls-tree in an update hook
> I believe I could reduce the frequency of this already-infrequent
> issue by at least 1000X, which would suit my purposes just fine. In my
> case filenames are mostly ansi-based, and I don't expect we've ever
> had Turkish filenames (turkish "i" being the most famous case-folding
> gotcha I think?).
>
> Coming at this from another angle, I guess we could teach git on
> case-insensitive filesystems to detect this situation (where two files
> in the index, with different contents, are pointing to the exact same
> filesystem file) and more explicitly warn the user of what's wrong,
> giving them clear help on how to fix it? And temporarily exclude those
> two files from its change reconciliation processes altogether to avoid
> ghost changes interfering with recovery actions like "pull"? Certainly
> that would be better than the current "ghost changes" behavior... but
> it would still be far less convenient than preventing (the vast
> majority of) these issues altogether, be that with a custom hook or a
> core option prohibiting clearly case-insensitive-duplicate files from
> being pushed.
>
> By the time a case-insensitive-FS-user encounters this issue in their
> repo as they checkout or clone, it's likely that the problem is in
> master/main and others are already affected, and both the cycle time
> to fixing the issue, and the communication impact in the current state
> ("please wait, the issue is being addressed, once the remote branch is
> fixed here's what you'll do to 'pull' successfully in spite of the
> local repo thinking there are filesystem changes that really don't
> exist and can't be reset") are... suboptimal.
>
> It feels like adding case-insensitivity pathspec magic support to
> ls-tree (however reliable or universal the subsequent
> duplicate-detection is or isn't) *should* be much simpler than what it
> would have taken to support it in ls-files in the first place - but at
> a glance, I see the official pathspec-supporting function
> "match_pathspec()" is deep in index-land, with an "index_state"
> structure being passed around all over the place. If it really was
> easy, someone would already have done it I guess? :)
>
> I don't see this being something I can take on in my spare time, so
> for now I suspect I'll have to do a full-tree duplicate-file-search on
> every ref update, and simply accept the 1-second update hook
> processing time/delay per pushed ref :(
>
> I'm assuming the "ghost changes" behavior I allude to here (where two
> different files in the index, with different contents, point to the
> same single file in the case-insensitive filesystem, and one or the
> other index file appears modified / the working tree looks "dirty") is
> a known issue, but if there's any value in my opening a thread more
> clearly/explicitly about this behavior, please let me know.
>
> Thanks,
> Tao


Thanks for sharing your experience in detail.

Did you ever consider to write a shell script,
that can detect icase-collisions ?

For example, we can use Linux:
 git ls-files | tr 'A-Z' 'a-z' | sort | uniq -d ; echo $?
 include/uapi/linux/netfilter_ipv4/ipt_ecn.h
 include/uapi/linux/netfilter_ipv4/ipt_ttl.h
 [snip the other files]

The GNU versions of uniq allow an even shorter command,
(But the POSIX versions don't)

git ls-files  | sort | uniq -i -d

I think that a script like this could do the trick:

#!/bin/sh
ret=3D1
>/tmp/$$-exp
git ls-files  | sort | uniq -i -d >/tmp/$$-act &&
  cmp /tmp/$$-exp /tmp/$$-act &&
    ret=3D0
    rm -f /tmp/$$-exp /tmp/$$-act
    exit $ret


####################
The usage of files in /tmp is probably debatable,
I want just illustrate how a combination of shell
scripts in combination with existing commands can be used.

The biggest step may be to introduce a server-side hook
that does a check.
But once that is done and working, you probably do
not want to miss it.
