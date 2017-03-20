Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C54112095B
	for <e@80x24.org>; Mon, 20 Mar 2017 12:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754077AbdCTM6k (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Mar 2017 08:58:40 -0400
Received: from mail-oi0-f44.google.com ([209.85.218.44]:32925 "EHLO
        mail-oi0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753301AbdCTM6A (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Mar 2017 08:58:00 -0400
Received: by mail-oi0-f44.google.com with SMTP id q19so21535327oic.0
        for <git@vger.kernel.org>; Mon, 20 Mar 2017 05:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SNBuhGIPOqCzGc6ySWdTfqKKVTqGyK7q4XdxTJXe4c0=;
        b=VjqcjIvYoDHrDOv/OHEuxWiBxG8TrjL2GeTgN5ioefCaWzNEP99/LvIGbmXt4I+TFn
         /uKV3O+c9/QebQ+cH/Rg2Uj8UBgPHfMqMq5FsxeNZnNV74jtzJWUQh3E58XiybzicNWX
         /8k1ZHPxxhVb8R9RFlojaUOvEBIy/beOoudB3G4nWJzyUXMLT3P6F/MXgG7HYDm+dwk9
         qqM5SrDFsT7VjCe4LRyzaRZxrieOIpj25sOk9Kc0w6HwTlSyqUl7ykAYGrNh7RmC0wxp
         Zd/+6m4pXJ9vxHQiFII16Xnzx1WAEOLAC35FvL471YiORxxZR+mmIppyGEcpiITnmv6S
         GyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SNBuhGIPOqCzGc6ySWdTfqKKVTqGyK7q4XdxTJXe4c0=;
        b=f8EAffP/Iw+AcLqCiuHoBvH/7GA8JbtPEugy8P6hjfKq1sEYpbXEX+m6bwhTUwAqoQ
         73bKuLS02iByWm8T52jepI3Rp+51cxHNVBhSgha7lwWWVhPmePEInfogty1nNAHJcRjI
         HVyUZ8JmI3QplZNpraRgT907G8FYmPVXzv2iATIu5r8X/hSKrMyHoU6ab5QbdBYwfjPd
         iydJcfJGueUReojPrU9ZQAyrGfBy+Qx5hZMGHAUfYvRPGMQixai0+RM6aBjsfaQw+MSC
         iCcPqi3AT+SVgkqwAcSK9pDY5u5FkuHVujB1EjpThXY0VpwGKE2afCIlAS5i81k74CEf
         qxiw==
X-Gm-Message-State: AFeK/H3zmPsbFk44zoS5UJ/Cm3tDo6HkRTcNlsoTcRjmDISaxWc0+TRN7xpYTSuOSBypbLuNxOYB9Sth89g26Q==
X-Received: by 10.202.237.9 with SMTP id l9mr13368106oih.186.1490014607559;
 Mon, 20 Mar 2017 05:56:47 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Mon, 20 Mar 2017 05:56:17 -0700 (PDT)
In-Reply-To: <20170318211954.564030-7-sandals@crustytoothpaste.net>
References: <20170318211954.564030-1-sandals@crustytoothpaste.net> <20170318211954.564030-7-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 20 Mar 2017 19:56:17 +0700
Message-ID: <CACsJy8Ch0=ovmmfHikQG04K249TEpA3HONWpknUn_kWbQa=8Fw@mail.gmail.com>
Subject: Re: [PATCH 06/20] builtin/receive-pack: convert portions to struct object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Mar 19, 2017 at 4:19 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> @@ -1489,23 +1489,24 @@ static struct command **queue_command(struct command **tail,
>                                       const char *line,
>                                       int linelen)
>  {
> -       unsigned char old_sha1[20], new_sha1[20];
> +       struct object_id old_oid, new_oid;
>         struct command *cmd;
>         const char *refname;
>         int reflen;
> +       const char *p;
>
> -       if (linelen < 83 ||
> -           line[40] != ' ' ||
> -           line[81] != ' ' ||
> -           get_sha1_hex(line, old_sha1) ||
> -           get_sha1_hex(line + 41, new_sha1))
> +       if (!linelen ||

I think you can skip this. The old code needed "< 83" because of the
random accesses to [40] and [81] but you don't do that anymore.
parse_oid_hex() can handle empty hex strings fine.

> +           parse_oid_hex(line, &old_oid, &p) ||
> +           *p++ != ' ' ||
> +           parse_oid_hex(p, &new_oid, &p) ||
> +           *p++ != ' ')

maybe "|| *p)" as well? I think the old code, with "linelen < 83",
makes sure reflen is at least one. Not sure what FLEX_ALLOC_MEM would
do if reflen is zero.

>                 die("protocol error: expected old/new/ref, got '%s'", line);
>
> -       refname = line + 82;
> -       reflen = linelen - 82;
> +       refname = p;
> +       reflen = linelen - (p - line);
>         FLEX_ALLOC_MEM(cmd, ref_name, refname, reflen);
> -       hashcpy(cmd->old_sha1, old_sha1);
> -       hashcpy(cmd->new_sha1, new_sha1);
> +       oidcpy(&cmd->old_oid, &old_oid);
> +       oidcpy(&cmd->new_oid, &new_oid);
>         *tail = cmd;
>         return &cmd->next;
>  }
-- 
Duy
