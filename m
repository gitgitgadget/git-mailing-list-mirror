Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 488961F453
	for <e@80x24.org>; Thu, 31 Jan 2019 20:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbfAaUiv (ORCPT <rfc822;e@80x24.org>);
        Thu, 31 Jan 2019 15:38:51 -0500
Received: from mout.web.de ([212.227.15.14]:58651 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727200AbfAaUiv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Jan 2019 15:38:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1548967123;
        bh=n1rMjyEhZcuO+vDYz1+0Z2JSN1wZmZZ3sxju9rgCgtk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=CD8v06GKnhOPTWmgjLcgv2xs0Bgn9/oZQy4sMPl+p6ObUBxAFI2q54dkiFA1h8TPT
         MgmxirIhPdzUT4NND+Jg3y35ig6z3vO+8T88JB1qLZI/S/hWGybTNzRdSPP//3aiAk
         cMjX3VhPM+0c+MewPGHQtsnXmbd2MVdirweeGWro=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([195.198.252.176]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M09uu-1hAGEx0UQ8-00uHCd; Thu, 31
 Jan 2019 21:38:43 +0100
Date:   Thu, 31 Jan 2019 20:38:42 +0000
From:   Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Martin Koegler <martin.koegler@chello.at>
Subject: Re: mk/use-size-t-in-zlib [was: Re: What's cooking in git.git (Jan
 2019, #05; Tue, 29)]
Message-ID: <20190131203842.633ztr4yckn7kl2d@tb-raspi4>
References: <xmqqa7jj6rg7.fsf@gitster-ct.c.googlers.com>
 <994568940.109648.1548957557643@ox.hosteurope.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <994568940.109648.1548957557643@ox.hosteurope.de>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Provags-ID: V03:K1:RoQkEmzHIQIC4ZTcsnuQQAZr2WFJK519mBEHYllcHh1RuAHG5mH
 RReevwgXuLtpGzGo3O2PjspYQvjcfo84FTh2UGpXhcOWD3am0Gl+Mw3ITsdFGKPmOtaJ+xC
 nZfwnmg+hyby5wbKjPNFUasfqJQlqBqCPvHQyLnKQkCUgrg3eGz7fu+USD6izDJ0WUptz4U
 SUTphNJb+5bEr5rgRIw7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ydWSdgP/0hg=:ZxQUNG5o9V7Qpc29OoAXhs
 nDwdkiYtLI4v2vb5svqFoD1s7+pP+osKpiJcw/ZTOXIJzlOjaFpxDzFSDhoEncFp8ApEc+ojs
 giaO0Wv9NcMjAf+iBMdpfvNqN8d63T5myffoFRTuFxnABc7C3FfLokWj3gWJLXvBH4I7DGYDn
 UbIPy6at6I2FMUghYSGPZFbtoVNQHwtlG33Wjm2uHR/MoCcsKRaWILWZfhqVd+gFVBQa8JDzT
 VUHYJ9y4ZSNTNC2dEVad2jD7MjBJECymrwC2Q/rUb2wvYknElo1I4I90DJ9C48ieG3VSlvQgf
 oj7dgWj/ygFHTgosplZpy1vVkjyyQzvSuaE+31GAkYwNfEdqyBi9G/PmMayeCISizpuBg/01Y
 KcKTSdEBxWqF1x3BZrQS7YUT1EgHDNt8bsnEnvGvnJk4s6M6vop9ZxiUuIXBfUuph6RwoTZUW
 50p9J6+fB0XfHd5P81RiiliUGtGlAiC92R6imBskwBFbVfTi4ZD4nZf9pNvmzcCkjsbn8oToV
 HX5px6li0qzJoVzBCncpEufMhsbBJSIICA7EIShbCS9GTjeXQFXvIFlFGCUKEu7L3swDu9s4Z
 AtSAmo4GveQTi6j/Q/E64h+ZXCuhOe/rBEkO9NfybvkGP4hwKAkbcwBtx/EJ4skiCas811O8t
 N/LXjr8ewwhw4ndW8bkXTCJOLp8G+1YzXs/4/hY3IVO82QX9Mm7qLs8EzcvhVGP+MpHWKMlYu
 u6/eawfOgOKL1V9+qOGXH3Tem4bKSldKPIyngNwPiqIDbKCGOTR6oyazCRf+P0IOvfOnqWTOt
 33ohay2r7zCc2gyi5ishS9c21r/M0Wc82FTNan+ZUE/1fYNFh73G7k4PL/YsVm9KhOfXlhArU
 TF7C1NjkhZOvP7UcyLJwUfromKXJJuL+meh9AoifuC3UJDZ3WbqLXHg/zLopuf
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 31, 2019 at 06:59:17PM +0100, Thomas Braun wrote:
> > Junio C Hamano <gitster@pobox.com> hat am 29. Januar 2019 um 23:15 ges=
chrieben:
>
> [...]
>
> > * mk/use-size-t-in-zlib (2018-10-15) 1 commit
> >  - zlib.c: use size_t for size
> >
> >  The wrapper to call into zlib followed our long tradition to use
> >  "unsigned long" for sizes of regions in memory, which have been
> >  updated to use "size_t".
> >
>
> I've started playing around with the patch from Thorsten [1] for getting=
 unsigned long replaced in more places so that you can commit large files =
on platforms like Windows there unsigned long is 32-bit even on 64-bit OSe=
s.
>
> And the first thing which bugs out when I do a quick test with committin=
g a large file and fsck the repo is in zlib.c:
>
> 	if (s->z.total_out !=3D s->total_out + bytes_produced)
> 		BUG("total_out mismatch");
>
> here s->z.total_out is an unsigned long and s->total_out is size_t and t=
his triggers the BUG message once the unsigned long wraps. There is even a=
n FAQ entry for zlib at [2] which warns about that potential issue.
>
> So I would think that something like
>
> ----------->8
>
> diff --git a/zlib.c b/zlib.c
> index 197a1acc7b..9cc6421eba 100644
> --- a/zlib.c
> +++ b/zlib.c
> @@ -51,13 +51,9 @@ static void zlib_post_call(git_zstream *s)
>
>         bytes_consumed =3D s->z.next_in - s->next_in;
>         bytes_produced =3D s->z.next_out - s->next_out;
> -       if (s->z.total_out !=3D s->total_out + bytes_produced)
> -               BUG("total_out mismatch");
> -       if (s->z.total_in !=3D s->total_in + bytes_consumed)
> -               BUG("total_in mismatch");
>
> -       s->total_out =3D s->z.total_out;
> -       s->total_in =3D s->z.total_in;
> +       s->total_out +=3D bytes_produced;
> +       s->total_in +=3D bytes_consumed;
>         s->next_in =3D s->z.next_in;
>         s->next_out =3D s->z.next_out;
>         s->avail_in -=3D bytes_consumed;
>
> -----------8<
>
> would make the patch [3] more complete IMHO.
>
> Another potential issue in that patch is that the signature change in gi=
t_deflate_bound forces size to unsigned long on the call to deflateBound (=
for newer zlib versions) and if that conversion is not faithful this will =
certainly not work.
>
> Just my 2cents I'm not vetoing anything here,
> Thomas

Thanks for digging.

Do you think that you can provide a new version of the patch ?
Or, may be better,  a patch on top of that ?


>
> [1]: http://public-inbox.org/git/20181120050456.16715-1-tboegi@web.de/
> [2]: http://www.zlib.net/zlib_faq.html#faq32
> [3]: http://public-inbox.org/git/20181012204229.11890-1-tboegi@web.de/
