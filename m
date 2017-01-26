Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C91011F6DC
	for <e@80x24.org>; Thu, 26 Jan 2017 00:50:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752270AbdAZAuN (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 19:50:13 -0500
Received: from mail-it0-f43.google.com ([209.85.214.43]:35604 "EHLO
        mail-it0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752203AbdAZAuN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 19:50:13 -0500
Received: by mail-it0-f43.google.com with SMTP id 203so121332779ith.0
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 16:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=05hBkJC/chxfQ77yI5WWSrA7i2W4iQTclZsyuwp97VY=;
        b=DP4UMYI+sqSSDKXF4xn3WahHgWrROfDY5/1CxlVS9VqBSSjlOqTLa1xiz7o36vyYao
         EkG2/YY4HHO+JUodDzXGI/SN77LPHKXNdvXRGKh37bbdlhdp19Mc7Gn8VmytenMSyM38
         3mbYLN0tQg+Ama2FnJp8UZi1pg5xErS9lc0SDP9bZEOPlgBwAC6LCVyziM+vYj1pxhKS
         p4P4StSit5lmf447o9oqsQArVvaTIUsQadsAl1v/8Rdk1Jn0QvkxEppqYdsuyzPGNsIA
         QiBFdUURPhwRzrT/3Rrg9zFyIBaayot5a5DP7bC2huPGtM9G3v/MNAKo9J3nhBnFK0dO
         3Nug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=05hBkJC/chxfQ77yI5WWSrA7i2W4iQTclZsyuwp97VY=;
        b=G7Gh9pdBSD2/j2mOY2rOyzV3IRTTCVmhjnsyf/v+8VkdxC0epRk9fT1iesNWTDERKW
         amoSSKW79hcn3Tlo0SJLjNUHMn6vh1W7yTbLiVQ0KKo9qeojYKc6Ne7cEFrokyPptdpX
         cULYZZUEb05gSIULaUdtSQ5mibcj+9mdMjlHZ0lUXWA5NKRj2OlowCen8vm4vZIW+H/P
         GtGdnewX98PEeR8jqoC9XUYd1SCsHTbjZSoY1ayuB0BVKDKHf9bD8TobAD1Txq1T7IiZ
         OTkhwwS9mp9dyKv0540ANjTuXKmXMnVav0zhFHflqvyKBJJDshW7rqcXUcDzxeDWeJUy
         NVOw==
X-Gm-Message-State: AIkVDXIwLZ4QoKrtTq57LrhkHu0Wt4hvBEdx1lX+j8NEDjHr4bgX0I2I39m2yTZz0gueeYD7K6NDJxY4pPBXxGn+
X-Received: by 10.36.40.198 with SMTP id h189mr3745743ith.114.1485391812029;
 Wed, 25 Jan 2017 16:50:12 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Wed, 25 Jan 2017 16:50:11 -0800 (PST)
In-Reply-To: <db1db5d0e5563464c09d1678234c9c5e8ae5b2f4.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com> <db1db5d0e5563464c09d1678234c9c5e8ae5b2f4.1485381677.git.jonathantanmy@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 25 Jan 2017 16:50:11 -0800
Message-ID: <CAGZ79kb+VVQoimCDCxk1JPtVdDcS0vgi3NgVfo_aZ_=feed8Cw@mail.gmail.com>
Subject: Re: [RFC 12/14] fetch-pack: do not printf after closing stdout
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 25, 2017 at 2:03 PM, Jonathan Tan <jonathantanmy@google.com> wrote:
> In fetch-pack, during a stateless RPC, printf is invoked after stdout is
> closed. Update the code to not do this, preserving the existing
> behavior.

This seems to me as if it could go as an independent
bugfix(?) or refactoring as this seems to be unclear from the code?

>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
>  builtin/fetch-pack.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
>
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index ae073ab24..24af3b7c5 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -191,10 +191,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>                 printf("connectivity-ok\n");
>                 fflush(stdout);
>         }
> -       close(fd[0]);
> -       close(fd[1]);
> -       if (finish_connect(conn))
> -               return 1;
> +       if (finish_connect(conn)) {
> +               ret = 1;
> +               goto cleanup;
> +       }
>
>         ret = !ref;
>
> @@ -218,11 +218,17 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
>                 ret = 1;
>         }
>
> +       if (args.stateless_rpc)
> +               goto cleanup;
> +
>         while (ref) {
>                 printf("%s %s\n",
>                        oid_to_hex(&ref->old_oid), ref->name);
>                 ref = ref->next;
>         }
>
> +cleanup:
> +       close(fd[0]);
> +       close(fd[1]);
>         return ret;
>  }
> --
> 2.11.0.483.g087da7b7c-goog
>
