Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFC621F454
	for <e@80x24.org>; Sun,  3 Nov 2019 15:46:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbfKCPqN (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Nov 2019 10:46:13 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33347 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbfKCPqN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Nov 2019 10:46:13 -0500
Received: by mail-lf1-f67.google.com with SMTP id y127so10414096lfc.0
        for <git@vger.kernel.org>; Sun, 03 Nov 2019 07:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=uvuxEgQahx4INbUbUUaoJPnQU3euyIQePk36Y3kETHQ=;
        b=uYfw6GWvkR0k8LrItiBEwdo3JlaPqYBNANAptHjxIbZDHLiUBZ33e/uOJOFBXn1FDa
         UIFDocJeQcUQjPiIZJJHddCOz21QjnmaPzpK9821M1kAV/akXkUaw4d+EqPL8zeTC4mg
         AkG51Mxtb0/q5f0FpcV0lUWru0ZgK5hxp7klPGmAHJmXr0humBn0ayHB0JZdnOaVxRrd
         C2CglZUH5chZhOOaKZlvdlWQZwCEIu+oBoWnQPZfxxdoigizVMPMrEc7MCwKdlqMWohc
         1mng8z40+LabBYtMqe089a2iOVRUgHUvNqaVxyVEu7Uez+S2XXjvDOBxjnyn9dIF0IiA
         RbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=uvuxEgQahx4INbUbUUaoJPnQU3euyIQePk36Y3kETHQ=;
        b=FCx//Qt3hlpjzy/quBRc7BF1oFP/IAxvCoKda/dEPFLDsoK3fGLLz4/o6Aq33+XdCb
         xePXgqKDS2w9Okw+4DOsp8XtIbB0XfF461WcJBno8JCe+jDMIkWwtMcV7HqClM+Vsu2A
         mz0STonQsa/73lsCv9becKrQ4zvVXg6s8+hu2yquV/I/OjDZ6N3WvYvDxPVwAK2Bx8ss
         7Lelv+67y/ZcUt45/efiomVOHHa8KWyygSH2kSWjz/Y/h4gECjrv2ebBoED0fMZqBlW9
         95n3rYP+5mqbthhl1pNxQGjTxWjNK3nNVchAm33rg4sggBKRKJwENHKGEIklxaYrV5gc
         0lXw==
X-Gm-Message-State: APjAAAWAjR2z/Hk0tTAEB+jHtCKohxOlh1XlqBPKQEhjrGsa7XCiLQIw
        P7dXTz+Dm1TnSJsSsGMcygI=
X-Google-Smtp-Source: APXvYqyNVyVbuNOAgiTvkmLjux7bJ4FwlSx8xuK9GwyWs7ceFxIbaoPh5g2OHglHfbDBowGwySmc7g==
X-Received: by 2002:ac2:4d17:: with SMTP id r23mr14372037lfi.56.1572795971477;
        Sun, 03 Nov 2019 07:46:11 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id x12sm5328650lfq.52.2019.11.03.07.46.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 03 Nov 2019 07:46:10 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     <rsbecker@nexbridge.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 3/4] doc: dissuade users from trying to ignore tracked files
References: <20191102192615.10013-1-sandals@crustytoothpaste.net>
        <20191102192615.10013-4-sandals@crustytoothpaste.net>
        <001501d591ba$1d190060$574b0120$@nexbridge.com>
Date:   Sun, 03 Nov 2019 16:46:08 +0100
In-Reply-To: <001501d591ba$1d190060$574b0120$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Sat, 2 Nov 2019 16:14:14 -0400")
Message-ID: <86bltthsjj.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

> On November 2, 2019 3:26 PM, brian m. carlson wrote:
>> It is quite common for users to want to ignore the changes to a file tha=
t Git
>> tracks.  Common scenarios for this case are IDE settings and configurati=
on
>> files, which should generally not be tracked and possibly generated from
>> tracked files using a templating mechanism.
>>=20
>> However, users learn about the assume-unchanged and skip-worktree bits
>> and try to use them to do this anyway.  This is problematic, because when
>> these bits are set, many operations behave as the user expects, but they
>> usually do not help when git checkout needs to replace a file.
[...]
> Just noodling about a potential solution. If we assume the use case that
> files are modified by an IDE that have no real relevance, but should not
> interfere with other git operations including checkout...
>
> What if we introduce something like .gitignore.changes, with the same syn=
tax
> as .gitignore. The difference is files listed in this file will not show =
in
> `git status` (or could show as "changes ignored" with an option to enable
> that. The only way to have the changes considered would be `git add -f`, =
so
> `git add .` and `git commit -a` would not pick up the changes.
[...]

I think it would be better and easier to add new attribute and use
.gitattributes instead of a new .gitignore.changes (and its
per-repository, per-user and system-wide version).

> If this idea seems reasonable, it might make a nice small project for
> someone, possibly me, if I could unentangle from my current hellish $DAYJ=
OB
> project.

I wish you luck.

The fact that it was nod done yet may mean that there are some annoying
corner-cases in the concept, or that it is not commonly useful... or
maybe that is the problem that needs reframing.

Best,
--=20
Jakub Nar=C4=99bski
