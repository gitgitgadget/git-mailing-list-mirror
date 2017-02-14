Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A68651FAF4
	for <e@80x24.org>; Tue, 14 Feb 2017 18:53:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752398AbdBNSxz (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 13:53:55 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:34252 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752233AbdBNSxx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 13:53:53 -0500
Received: by mail-it0-f68.google.com with SMTP id r141so6526833ita.1
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 10:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=q4JxqVz2y4LRWkdeCYNMQE9JrVkS8KqVx+pteUlPHTw=;
        b=sVB9ngwpoBrM6CzXHdLbNu43M86coAIvnjh780b+DfoZ+I/8PapkXJ4yJc15hcChV/
         8BtVOsQWnGGChVze8bwrPwok1u1mWxAjijrd+K4HVjTuIglgO1izdg/pgbFQfiR+gzKq
         QBQopeOD0cCVCY3w8LiCQYPW7IB9mSLaIFkUofGARug+B8tArX1IYVKKDdL6PAnWDisY
         X+dSQDaqsVbJ0dnVBrRe6/ippLYoi3o4wgJP88qkDpdlC2nRgcbSVW+j5tsgCRLv1d8E
         uHoPLYnOnkJKewNwTH2x8Mnx/rrLin0KXJBVxucoR9ejR53Wijh3z7akwHR6XBkBHRlT
         ibGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=q4JxqVz2y4LRWkdeCYNMQE9JrVkS8KqVx+pteUlPHTw=;
        b=iQ7iVno2RkICTaF8jBG1MD7If/oopczers73H+J2bRCtf9PXXtmoEtHi+0nOSsyqSu
         wvji7BidSQ1urEgLxwo+5U7xY9YHoeHguKe3CrIE/uMi/MuYa/o3FfzOsrpMKC2A8crp
         tjZj1TLJYNGYPFx/E8e7mBD5NjxjYaDJ850A+jOHLDojQvKsvevXGrNvR48wa6/qNRTZ
         Ec5xsg35PFthoJ6Nl7bswUSXyl9cfBYiYvFckxVqQv62dGREawKLLTR8bF3TlecQzLSV
         WcTkvIdclEvEeqQlhEw3AIo0TmDelcikllvWK73RakegsBdViWyVOjUSvdlP4N5pFlLd
         abFg==
X-Gm-Message-State: AMke39m27+N+TI2JHctByUWeiEi/CybwfGQ4nQ3abqC6MFDaU3F01mawUes5cEc8mzTmXyJmTjoTRvfAF7PzCw==
X-Received: by 10.107.182.214 with SMTP id g205mr31456972iof.120.1487098432671;
 Tue, 14 Feb 2017 10:53:52 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.142.147 with HTTP; Tue, 14 Feb 2017 10:53:52 -0800 (PST)
In-Reply-To: <20170214172829.6w3cnnqy6ozxl424@sigill.intra.peff.net>
References: <20170214172526.hzpm3d3ubd3vjnzr@sigill.intra.peff.net> <20170214172829.6w3cnnqy6ozxl424@sigill.intra.peff.net>
From:   Pranit Bauva <pranit.bauva@gmail.com>
Date:   Wed, 15 Feb 2017 00:23:52 +0530
Message-ID: <CAFZEwPOYGRGd5PWSfLRd6vMs35TT1ZzUSfr79fwRA4VzVjAWXA@mail.gmail.com>
Subject: Re: [PATCH 3/3] show-branch: use skip_prefix to drop magic numbers
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary=001a114a4cf2d45e8e0548821564
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--001a114a4cf2d45e8e0548821564
Content-Type: text/plain; charset=UTF-8

Hey Peff,

On Tue, Feb 14, 2017 at 10:58 PM, Jeff King <peff@peff.net> wrote:
> We make several starts_with() calls, only to advance
> pointers. This is exactly what skip_prefix() is for, which
> lets us avoid manually-counted magic numbers.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/show-branch.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/show-branch.c b/builtin/show-branch.c
> index 404c4d09a..c03d3ec7c 100644
> --- a/builtin/show-branch.c
> +++ b/builtin/show-branch.c
> @@ -470,17 +470,14 @@ static void snarf_refs(int head, int remotes)
>         }
>  }
>
> -static int rev_is_head(char *head, char *name,
> +static int rev_is_head(const char *head, const char *name,
>                        unsigned char *head_sha1, unsigned char *sha1)
>  {
>         if (!head || (head_sha1 && sha1 && hashcmp(head_sha1, sha1)))
>                 return 0;
> -       if (starts_with(head, "refs/heads/"))
> -               head += 11;
> -       if (starts_with(name, "refs/heads/"))
> -               name += 11;
> -       else if (starts_with(name, "heads/"))
> -               name += 6;
> +       skip_prefix(head, "refs/heads/", &head);
> +       if (!skip_prefix(name, "refs/heads/", &name))
> +               skip_prefix(name, "heads/", &name);
>         return !strcmp(head, name);
>  }
>
> @@ -799,8 +796,9 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
>                                 has_head++;
>                 }
>                 if (!has_head) {
> -                       int offset = starts_with(head, "refs/heads/") ? 11 : 0;
> -                       append_one_rev(head + offset);
> +                       const char *name = head;
> +                       skip_prefix(name, "refs/heads/", &name);
> +                       append_one_rev(name);
>                 }
>         }
>


Did you purposely miss the one in line number 278 of
builtin/show-branch.c because I think you only touched up the parts
which were related to "refs/" but didn't explicitly mention it in the
commit message?

    if (starts_with(pretty_str, "[PATCH] "))
        pretty_str += 8;

If not, you can squash this patch attached. Sorry, couldn't send it in
mail because of proxy issues.

Regards,
Pranit Bauva

--001a114a4cf2d45e8e0548821564
Content-Type: text/x-patch; charset=US-ASCII; 
	name="0001-squash-show-branch-use-skip_prefix-to-drop-magic-num.patch"
Content-Disposition: attachment; 
	filename="0001-squash-show-branch-use-skip_prefix-to-drop-magic-num.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iz5vwzjw0

RnJvbSAyZTgwZDQ0NThkZjY1OTc2NTAxMTQ1MDYyMWVlMzQ0NTlkYzc0OWY5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQcmFuaXQgQmF1dmEgPHByYW5pdC5iYXV2YUBnbWFpbC5jb20+
CkRhdGU6IFR1ZSwgMTQgRmViIDIwMTcgMjM6NTM6MzYgKzA1MzAKU3ViamVjdDogW1BBVENIXSAh
c3F1YXNoOiBzaG93LWJyYW5jaDogdXNlIHNraXBfcHJlZml4IHRvIGRyb3AgbWFnaWMgbnVtYmVy
cwoKU2lnbmVkLW9mZi1ieTogUHJhbml0IEJhdXZhIDxwcmFuaXQuYmF1dmFAZ21haWwuY29tPgot
LS0KIGJ1aWx0aW4vc2hvdy1icmFuY2guYyB8IDMgKy0tCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYnVpbHRpbi9zaG93LWJyYW5j
aC5jIGIvYnVpbHRpbi9zaG93LWJyYW5jaC5jCmluZGV4IGMwM2QzZWM3Yy4uMTk3NTY1OTVkIDEw
MDY0NAotLS0gYS9idWlsdGluL3Nob3ctYnJhbmNoLmMKKysrIGIvYnVpbHRpbi9zaG93LWJyYW5j
aC5jCkBAIC0yNzUsOCArMjc1LDcgQEAgc3RhdGljIHZvaWQgc2hvd19vbmVfY29tbWl0KHN0cnVj
dCBjb21taXQgKmNvbW1pdCwgaW50IG5vX25hbWUpCiAJCXBwX2NvbW1pdF9lYXN5KENNSVRfRk1U
X09ORUxJTkUsIGNvbW1pdCwgJnByZXR0eSk7CiAJCXByZXR0eV9zdHIgPSBwcmV0dHkuYnVmOwog
CX0KLQlpZiAoc3RhcnRzX3dpdGgocHJldHR5X3N0ciwgIltQQVRDSF0gIikpCi0JCXByZXR0eV9z
dHIgKz0gODsKKwlza2lwX3ByZWZpeChwcmV0dHlfc3RyLCAiW1BBVENIXSAiLCAmcHJldHR5X3N0
cik7CiAKIAlpZiAoIW5vX25hbWUpIHsKIAkJaWYgKG5hbWUgJiYgbmFtZS0+aGVhZF9uYW1lKSB7
Ci0tIAoyLjExLjAKCg==
--001a114a4cf2d45e8e0548821564--
