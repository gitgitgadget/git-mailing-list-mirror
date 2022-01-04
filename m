Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6852C433F5
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 15:17:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234802AbiADPRw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 10:17:52 -0500
Received: from mout.gmx.net ([212.227.17.22]:36151 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229658AbiADPRv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 10:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641309451;
        bh=6CC090Xfb0hYHSqzDRNH981vZsn3Za9ynVMLpHhjvuk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=VHeASNq7f11JOfh8o8IiVNrz/72+sr9GBpmESOo20aftVQ729fIzsLbP7yGbFu3Mw
         XoKEP495TccnPQiimyqz4J4CP02tpcjrqfqDLmGNg62dbKNVBpe9bZEDZpMJD3zd0b
         /2WXLMd/Eleyv7qx/X2klaVxyUobdcr4imWPQAfw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.212.167]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MN5if-1mmGi63BHJ-00J04b; Tue, 04
 Jan 2022 16:17:31 +0100
Date:   Tue, 4 Jan 2022 16:17:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Teng Long <dyroneteng@gmail.com>
cc:     avarab@gmail.com, congdanhqx@gmail.com, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v8 8/8] ls-tree.c: introduce "--format" option
In-Reply-To: <nycvar.QRO.7.76.6.2201041533540.7076@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2201041615560.7076@tvgsbejvaqbjf.bet>
References: <cover.1641043500.git.dyroneteng@gmail.com> <e0add802fbbabde7e7b3743127b2d4047f1ce760.1641043500.git.dyroneteng@gmail.com> <nycvar.QRO.7.76.6.2201041533540.7076@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bvaOq6NnDi1rOIm2Tug+YIuD54JOSD7EQlUvJXAX4yCPkzpssbC
 NxD+mBEpwytJtUs7bDQIgxmbDbm0JfF1zFfpTo0VM2MHSZ82WlylSXWQJJ6Bf2IP71DwauW
 /0Fv1IZzpI9UNHKWFAqf5DXPdWr0vIxpHBd4Kmygcz+Q/xiBYsgwWsun4P5LMYBSLoJiU0C
 +BjONpV3wDx9UHrxdejSg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YYyO8bwEIAA=:YXNnci1RpgNcnrCtaXFx+w
 r9PMZtqWPxqoA0OseCR5QSIjgYTZb2dTfhoq0c/SV1cE07sWGluZxP3434cE2Z0PF1+M1SImw
 x42uKHpEKnM0nLFc95NM0ZcZSgxcJwZYjQe2zRk3JdkTZHda8f+e3i8M4bomuy0yYgWoCj3Fa
 cOP2pB1YlBtonbRCVW6/cRAou3zzLmuI1JwcMh5Kti/3y2WTCRus33F5r0FSB10aCfUEve7Tg
 oKgK4k7Ne1/3cb72ai0k1yJY//NIIapm171OxnrtSqIHCEc3oZBkSLt7zfr/UildJ1fKMOvCM
 pLQWEfs/I5c594WTfO671586awnRSrHNjgvfPxzuxFB7kUHIj3RxEm4sRAaeic21rve1FFHsb
 KDjmVs97kGXN2WC3v8s1dQkgZecPOZxiqeMkb2Gb0hLiB/m6R/N1Vpl/j3RPcP9av+FlgnlJM
 WW2eom9QsFu1VZc8ij5uJZkTd875nhbHM4LST/hByusuwO4d62dr1u1MlkwRFLLfqH23BNe/f
 KhVTsnx4ZgQTcY4li34UIYvvguSFbbVk1XnP8/EP6PYaNVbhRxo8y9sc794JAwF9W5MKOaj5q
 hhf8TxPoIH8KXXn8nU2j38qUmCqNbr9je51ScgpmYZSXyuU6xkkMZllpbiR6GYcu2DtI1V77e
 G7CgZmFUFDpyJeGsEOes92tjjeTn5jhcuJMsEvcEOqmDJTezQotWIVZS27OH7VVi996ftBNmi
 H0c69rNouns2QONLLIjqaJZat8tJe2ziUc8nsqOg3Gmp8nWx/Joji1UGnWTOz0qhjWKzWxfpm
 v/75+s600CKpfFXpmqEA6MTuCR+uG9yo/uPWRQ2AvFpxjdjSkENeyCWHCr7HEBpZ7JFd2JkzX
 tGVjIBQkvnZkdhch7QL3uLs6dWTibsVUywiLfEMjXq2FFkSBORDRgRs7oNjLobh/yjon1U/4E
 GjVe0cVahxdOCwrw8Os+HWKfwnlyc8mF9ZYa4ffcfYUawY2PhnUKVVCBlw1OHxV2uLnZDQOYR
 IJlNQby0HpTyBQ0qfex2v7up1/myb9KEkn9xAMoi8pSLL7kPz4grfGkXknZln7t1v+xY8f/Ly
 krVwZ9nD23T3uI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Teng,

On Tue, 4 Jan 2022, Johannes Schindelin wrote:

> -- snip --
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 6e3e5a4d0634..8301d1a15f9a 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -75,7 +75,7 @@ static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
>  		else
>  			strbuf_addf(line, "%" PRIuMAX, (uintmax_t)size);
>  	} else if (padded) {
> -		strbuf_addf(line, "%7s", "-");
> +		strbuf_addstr(line, "-");
>  	} else {
>  		strbuf_addstr(line, "-");
>  	}
> @@ -110,7 +110,7 @@ static size_t expand_show_tree(struct strbuf *line, const char *start,
>  	} else if (skip_prefix(start, "(size)", &p)) {
>  		expand_objectsize(line, data->oid, data->type, 0);
>  	} else if (skip_prefix(start, "(object)", &p)) {
> -		strbuf_addstr(line, find_unique_abbrev(data->oid, abbrev));
> +		strbuf_add_unique_abbrev(line, data->oid, abbrev);
>  	} else if (skip_prefix(start, "(file)", &p)) {
>  		const char *name = data->base->buf;
>  		const char *prefix = chomp_prefix ? ls_tree_prefix : NULL;
> @@ -119,7 +119,7 @@ static size_t expand_show_tree(struct strbuf *line, const char *start,
>  		strbuf_addstr(data->base, data->pathname);
>  		name = relative_path(data->base->buf, prefix, &sb);
>  		quote_c_style(name, &quoted, NULL, 0);
> -		strbuf_addstr(line, quoted.buf);
> +		strbuf_addbuf(line, &quoted);
>  	} else {
>  		errlen = (unsigned long)len;
>  		die(_("bad ls-tree format: %%%.*s"), errlen, start);
> -- snap --

In addition to that, you need these to quiet down the `linux-leaks` job of
our CI build, which is also failing with your patches:

-- snipsnap --
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 8301d1a15f9a..0dc0327e4785 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -120,6 +120,8 @@ static size_t expand_show_tree(struct strbuf *line, const char *start,
 		name = relative_path(data->base->buf, prefix, &sb);
 		quote_c_style(name, &quoted, NULL, 0);
 		strbuf_addbuf(line, &quoted);
+		strbuf_release(&sb);
+		strbuf_release(&quoted);
 	} else {
 		errlen = (unsigned long)len;
 		die(_("bad ls-tree format: %%%.*s"), errlen, start);
@@ -197,6 +199,7 @@ static int show_tree_fmt(const struct object_id *oid, struct strbuf *base,
 	strbuf_expand(&line, format, expand_show_tree, &data);
 	strbuf_addch(&line, line_termination);
 	fwrite(line.buf, line.len, 1, stdout);
+	strbuf_release(&line);
 	strbuf_setlen(base, baselen);
 	return retval;
 }
