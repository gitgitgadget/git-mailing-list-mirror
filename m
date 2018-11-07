Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2311F453
	for <e@80x24.org>; Wed,  7 Nov 2018 11:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726388AbeKGUxS (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 15:53:18 -0500
Received: from mout.gmx.net ([212.227.15.19]:49983 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbeKGUxS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 15:53:18 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MgL1q-1g7edP2daI-00Nihw; Wed, 07
 Nov 2018 12:23:17 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MgL1q-1g7edP2daI-00Nihw; Wed, 07
 Nov 2018 12:23:17 +0100
Date:   Wed, 7 Nov 2018 12:23:16 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
In-Reply-To: <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1811071222200.39@tvgsbejvaqbjf.bet>
References: <pull.66.git.gitgitgadget@gmail.com> <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com> <a374e4bb-1970-9ec7-fe94-a273f1206d6b@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:de97xc1H0pbvK0ZoyvxgsDhEdhuHmQ0O6m17gtZEVLeayP4t0to
 xAaJnsZ2gaotytfCgi3+vHlMpScTtG/l0gxkL4LtLk0ckPboU6xVN0FxpIUbitaTXCOsei5
 ogkWjgDu7+huEE/0AtXmspapolAB7SiSd2khQexR4tnW0byhRx5QJuqPbErRL4LJ0ORuFLa
 60iPb6HbhUX2rvrCKqTmQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Uai0CrxwLqI=:bE73j2c62oER423lEB7LvY
 1Prt6H9QJWvrDc8LN6IgkdjtFBdzJLO9t2dvc37IY9vcL5DYGdGC/eti7ahocnVbH7OmcbhQ+
 WW6ga37uDBytW7W2sd3LKP6KdVoASUOYKKmZ+C7hoe+dvcryPC1nwfwjS+L5VqdqVqnJPKQJg
 3mwD5OEz4Xp4wNeHXOFHUvbMsMiUCV2nUBcypptOGc25NvklWfbh09u9SOP7GwWR1czme8Zuy
 lP/pwfOmXDcrWkdaE6llUBx/ORtX8vfXdILc0xCJvGVGUN1i7tpE0lnjEBqA9kXjn2yjI9x64
 //Nzak2oUx/9NC0waxxexFagWuU8d6k9DH++qSqeGoChCfN9cu7zqwnHfNguHmTiQ6lIwIOzK
 FqvwlqYengVuGaHFn8eVIRgCh+cBEMDz3cQRfXqJjJoZs3QAS3DJXOrZOZpnaEL2uLlUXTyeP
 AbALYA9BQWd3nPgqyq75R9QIbX0vh3Rn0tQz+Dg8/YduJuXgETUcCsbstVxTgSnKV60girUVT
 WoUt4zRhZkdpHBZpwvGH5iGWkb02j8UXIe9s9fdSd1ygpZ6g0iorMI4mGrXkacfCJA2SsL8Qn
 w7dQak3f2mcl58nGxjdycTNZOIml8Wfw0mdR/Wa/2TMMHcKcTpbcypK8VTV6dF4OTAZgLJKxq
 Gw5U/JlhD/HSJiLyxPdCYTzpkZ7vExv9UF2QB0IZ/0dbs1mH1d+wEHJin7nNKULl6cJzWKrqS
 yhhYHXLKf27UvyS/sYb6/P3YvMgIsj4s5qm1NWDnw+L+r5g8fYMBIIQ3y7waKF+W+BfwEnacP
 vxOFrb0oJDH+BgDO4mowVRBxIFDQhS7xqiMykN21NikNPiGpG4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Tue, 6 Nov 2018, Johannes Sixt wrote:

> Am 06.11.18 um 15:53 schrieb Johannes Schindelin via GitGitGadget:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > 
> > On Windows, an absolute POSIX path needs to be turned into a Windows
> > one.
> 
> If I were picky, I would say that in a pure Windows application there cannot
> be POSIX paths to begin with.
> 
> Even if a path looks like a POSIX paths, i.e. it starts with a directory
> separator, but not with drive-letter-colon, it still has a particular meaning,
> namely (as far as I know) that the path is anchored at the root of the drive
> of the current working directory.
> 
> If a user specifies such a path on Windows, and it must undergo
> expand_user_path(), then that is a user error, or the user knows what they are
> doing.
> 
> I think it is wrong to interpret such a path as relative to some random other
> directory, like this patch seems to do.

Okay, now we know everything you find wrong with the current patch. Do you
have any suggestion how to make it right? I.e. what would you suggest as a
way to specify in a gitconfig in a portable Git where the certificate
bundle is?

Thanks,
Dscho

> 
> > 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >   path.c | 5 +++++
> >   1 file changed, 5 insertions(+)
> > 
> > diff --git a/path.c b/path.c
> > index 34f0f98349..a72abf0e1f 100644
> > --- a/path.c
> > +++ b/path.c
> > @@ -11,6 +11,7 @@
> >   #include "path.h"
> >   #include "packfile.h"
> >   #include "object-store.h"
> > +#include "exec-cmd.h"
> >   
> >   static int get_st_mode_bits(const char *path, int *mode)
> >   {
> > @@ -709,6 +710,10 @@ char *expand_user_path(const char *path, int real_home)
> >   
> >    if (path == NULL)
> >   		goto return_null;
> > +#ifdef __MINGW32__
> > +	if (path[0] == '/')
> > +		return system_path(path + 1);
> > +#endif
> >    if (path[0] == '~') {
> >     const char *first_slash = strchrnul(path, '/');
> >     const char *username = path + 1;
> > 
> 
> 
> 
