Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD64C433EF
	for <git@archiver.kernel.org>; Sat,  8 Jan 2022 17:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234822AbiAHRYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Jan 2022 12:24:25 -0500
Received: from mout.web.de ([212.227.17.11]:51275 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234814AbiAHRYY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jan 2022 12:24:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641662646;
        bh=++DbNsDTWMphoZBG06IgczQWUVY83nnIw8CjGcBOwxo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=riexIcjvv9XIlU1DBusRmCEb6WwChGo3lr2Zimtn/7d53yix+PaC9CfD8//4WY+nX
         oDliXK5cQWtIGhz3rYIsk88L27Qdo/vn0IdeWJKdd5NfQfO+Q9tnqO/IOSUfraRtEh
         KmSEMgL85WuzG22zu0qgJB8ygS4OO5sn6iTT1stY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M2gkf-1n5QEb0t4x-003uIO; Sat, 08
 Jan 2022 18:24:06 +0100
Message-ID: <6d63d5d2-48db-40e9-8e5c-5b72c3d84414@web.de>
Date:   Sat, 8 Jan 2022 18:24:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v8 3/6] object-file.c: remove the slash for
 directory_size()
Content-Language: en-US
To:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
 <20220108085419.79682-4-chiyutianyi@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20220108085419.79682-4-chiyutianyi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cob5iHzSxaXkdSxojGC8fYI7TUhTaeSfd2VSqoFWYeDEfPZD0Z8
 gx5u11LkzMDQxHh851Mn9wOa84gac+n7z8OekX0eBhQjKq+EzSRy/74QqiN+mFnz4Vxvpsa
 ISYbhV86OBUS767OWboFktBk8V0kl988/DRvjXKtU9RzSssWFPcAx8XbE+flSbOtlG8VglR
 Fu4YLK6/qC0LaBXfeAQBw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:EvRp22TgYmQ=:+qB0yGu4EyekzHJBuYpILR
 2BEtU7E3lLYuCLHUg2CsOpzxgDLPtQ2xspQVlJ8EHDVnUseaGgrdWQ6dToadS+mrvTS6B9J65
 1XYdFx0GRrqhKpx/y5+eEmh/BhRFObIvp97BFEFtmwAlfJIiWdmp/LigM4Ox8zI6icHfjqDz/
 flSizESljIkZZRh6KibVESpEvpfBg4cGbz5hGCbhKlTQmKtHdwU5UJbQqxcrR/ZaYXgKTpH8W
 P4ey1CdM9pDOQ1PHybOSeO50vRfMaYtunQLN36/MMjYmkYT5gB1Kl78GUIsFVizTJe9ap5eZq
 YsHM+NPxYkpw4NgehJA2225n4m/DeOgra+hY1Bnqxi6deilj9MaSGLZRQIP9wGvVr07xykyod
 sIvbOGOI6Ve/Moga+JoHTG3O+LeVZWMA2U1AcxtsT8IvFDCtw9u6smoWeBf+o1TO5mB4/2NMQ
 yJloVH0n+4V0b0ep8MIVcb7epg8knFcs/AC39nKPU9jeLNTVJ0+5Iqy6ejUVD6aJ35+nlFdvN
 TFx7ppnJVXRKsUNzAf+04r2qX37o3v2FSAoJf+MoVeXnwqJQXmlIJF9ibrhlXa2fIXvOYVCh8
 zwt/Hd6dipp2Ctw3UU393KfW1HitlBByPKJ5Rui4Zngm53hNpX6B0vCU8qtDyTfj6WnrHTZqH
 2KH8RhjQ1ijaTksHM162+nBdHo1wiBtuls7JHbWvJTn+ZJ3K6CsVGbNFghrxKTINPemse/l5m
 YUYuNUnTrV78+o4euizBa7h7v/3Wv1CBkFEJIEP7Q263FHqBlYbuP4xdfLf6//cW8w8hDBC4n
 K4Aga2soWRmrR8m9uQW5ojPIP2BmbODyvBzdq4Oe3VeoECKILRho0aS0ag+mTEsN4A/8y38v6
 MYUcMGU3tcgxXU60aPwQcr+kEhOZcE80YiFKeWvXAw8/LL7uW9XWIDUiaZEtfj9UeFms87SZh
 38sduLH4Yy5+quN8bVryy+r3ZmuVjVi0V4O9USvusQjlpwNKPDRLVEUawkjUgeRWB7+ZhdTzl
 XIjsY7W0S5hjAWivOmWBeSWuM3IYL+fYJeyKLjMqCs5ByG6L0jOL7DG7+enPIKJIBOkm9nm+4
 gDuEu22BaXlU3I=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.01.22 um 09:54 schrieb Han Xin:
> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> Since "mkdir foo/" works as well as "mkdir foo", let's remove the end
> slash as many users of it want.
>
> Suggested-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  object-file.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 5d163081b1..4f0127e823 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1831,13 +1831,13 @@ static void close_loose_object(int fd)
>  		die_errno(_("error when closing loose object file"));
>  }
>
> -/* Size of directory component, including the ending '/' */
> +/* Size of directory component, excluding the ending '/' */
>  static inline int directory_size(const char *filename)
>  {
>  	const char *s =3D strrchr(filename, '/');
>  	if (!s)
>  		return 0;
> -	return s - filename + 1;
> +	return s - filename;

This will return zero both for "filename" and "/filename".  Hmm.  Since
it's only used for loose object files we can assume that at least one
slash is present, so this removal of functionality is not actually a
problem.  But I don't understand its benefit.

>  }
>
>  /*
> @@ -1854,7 +1854,7 @@ static int create_tmpfile(struct strbuf *tmp, cons=
t char *filename,
>
>  	strbuf_reset(tmp);
>  	strbuf_add(tmp, filename, dirlen);
> -	strbuf_addstr(tmp, "tmp_obj_XXXXXX");
> +	strbuf_addstr(tmp, "/tmp_obj_XXXXXX");
>  	fd =3D git_mkstemp_mode(tmp->buf, 0444);
>  	do {
>  		if (fd >=3D 0 || !dirlen || errno !=3D ENOENT)
> @@ -1866,7 +1866,7 @@ static int create_tmpfile(struct strbuf *tmp, cons=
t char *filename,
>  		 * scratch.
>  		 */
>  		strbuf_reset(tmp);
> -		strbuf_add(tmp, filename, dirlen - 1);
> +		strbuf_add(tmp, filename, dirlen);
>  		if (mkdir(tmp->buf, 0777) && errno !=3D EEXIST)

This code makes sure that mkdir(2) is called without the trailing slash,
both with or without this patch.  From the commit message above I
somehow expected a change in this regard -- but again I wouldn't
understand its benefit.

Is this change really needed?  Is streaming unpack not possible with the
original directory_size() function?

>  			break;
>  		if (adjust_shared_perm(tmp->buf))
