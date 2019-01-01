Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A542B1F770
	for <e@80x24.org>; Tue,  1 Jan 2019 13:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfAANTz (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Jan 2019 08:19:55 -0500
Received: from mail-pl1-f181.google.com ([209.85.214.181]:37432 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728493AbfAANTz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jan 2019 08:19:55 -0500
Received: by mail-pl1-f181.google.com with SMTP id b5so13510712plr.4
        for <git@vger.kernel.org>; Tue, 01 Jan 2019 05:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KoWExHdhr5qSw9oKf8S9V/+uA1bsxvMLu3nTt/fvAFM=;
        b=LrbymuWVsHZ8uaO31N+meVmJxFJPvBEubWLqCqPTkiz7OTNsI+qie/n9SOPF6daa3q
         itbWiaM8o9wA+mt97XfdWxuSJOyrXf01kscSWlqAF8oe/T9obDu8EF8KlhqE770XEHL9
         /gmnwTLLpWJDB8+6KCDqe9UnJAEC15AQcun+cwKRgeO9g76DONHGMGFYkLIsk6XH7oxb
         z0MIsGy2qHY37Swvj8t6XdmBJc6iwg4ShQVnKkXkelSjpFL3a5LKmAXtQDjLZLhNpwhe
         TgxiFS9Lsve3lr8vnyfgJKMAjPvEwNTOWX8JUfaadujf3XpiF0qiXR71r48ANM3DWkyh
         6KBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KoWExHdhr5qSw9oKf8S9V/+uA1bsxvMLu3nTt/fvAFM=;
        b=cgbCACgoz+/3Hy3Rz61+vVvBP6qX3kDZJ5ty44xPlbyLgiljJU2VmLJfzpM7ZoMYKH
         Clah41Kg/Kal+apC/rO3u41xhZI+ASnCYojK25cY4dG4ni7/PIEuKHQy529O7DMcASJa
         E1nD+ZIIKoDmIOCuX5F/oYEy5rI1EDgJcnS/q7H3/RsaFezQJhwOp2Y8Cuul5mhmKxeg
         BRwMYWNb4mNbgxmVz1jMupS9cntm12fI8hPrAv2FwXxOO1iaZX2FDED3ELmbUo3m1f/x
         fonugI1im1KLnN4Hy0L2hjs7lfcgN/VFoquU0oMyDbMJ4ixLS/bhcW1Lvlq+JNKNCbBk
         tkeg==
X-Gm-Message-State: AJcUukd83IfSVNpJ5Ajt3WA2auaGrDBvY8ktT3OJRjWaZ7V6pTH10kZv
        PubluN5zlmEppsPTeGXFVkg=
X-Google-Smtp-Source: ALg8bN69fK5sglyf8Lbeushs1gf69HjBDWRM102l53lQ5IOL6BQJ+g0FIBpb7PGnitSAZH65KKUzhw==
X-Received: by 2002:a17:902:24e7:: with SMTP id l36mr40401775plg.61.1546348793119;
        Tue, 01 Jan 2019 05:19:53 -0800 (PST)
Received: from ash ([171.232.90.54])
        by smtp.gmail.com with ESMTPSA id g3sm109199234pfe.37.2019.01.01.05.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 05:19:51 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 01 Jan 2019 20:19:47 +0700
Date:   Tue, 1 Jan 2019 20:19:47 +0700
From:   Duy Nguyen <pclouds@gmail.com>
To:     Marc Balmer <marc@msys.ch>
Cc:     Git Mailing List <git@vger.kernel.org>, roger.strain@swri.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Regression in git-subtree.sh, introduced in 2.20.1, after
 315a84f9aa0e2e629b0680068646b0032518ebed
Message-ID: <20190101131947.GA18907@ash>
References: <B81E8278-965A-4860-95E1-20ADCAB29BC9@msys.ch>
 <CACsJy8B7=xNBeyYYgMqh-aU_1-Rb8g5t5SwK5jvfbMw4ch-ZLQ@mail.gmail.com>
 <11AC6C27-4C74-43B1-89F6-98ABBFE74E0E@msys.ch>
 <CACsJy8AQ1raB+2wjEBtDrAvJm0v-3exJ-FVB2ZyL6VpRFQkspQ@mail.gmail.com>
 <0F754615-C852-49D8-8E0C-DD2A00A15ED1@msys.ch>
 <CACsJy8C8DVz7u7z01Q3T_vY+DY-StwCQLhkhDJ6XK5C2z0agLA@mail.gmail.com>
 <DE854533-FC7C-4DD4-8F42-C02C4D4524CB@msys.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DE854533-FC7C-4DD4-8F42-C02C4D4524CB@msys.ch>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 31, 2018 at 01:31:21PM +0100, Marc Balmer wrote:
> 
> 
> > Am 31.12.2018 um 12:36 schrieb Duy Nguyen <pclouds@gmail.com>:
> > 
> > On Mon, Dec 31, 2018 at 6:24 PM Marc Balmer <marc@msys.ch> wrote:
> >> In a (private) Email to me, he indicated that had no time for a fix.  Maybe he can speak up here?
> > 
> > Well, I guess Junio will revert when he's back after the holidays
> > then. Meanwhile..
> > 
> >> In any case, if I can help testing, I am in.  I just don't know the inner workings of git-subtree.sh (I am a mere user of it...)
> > 
> > If the repo you're facing the problem is publicly available, that
> > would be great so some of us could try reproduce.
> 
> Unfortunately it is not.
> 
> > 
> > Otherwise we'll need your help to track this problem down. in
> > git-subtree script line 640 (or somewhere close)
> > 
> >    progress "$revcount/$revmax ($createcount) [$extracount]"
> > 
> > could you update it to show $parents and $rev as well, e.g.
> > 
> >    progress "$revcount/$revmax ($createcount) [$extracount] ($parents) ($rev)"
> 
> I did add this, plus changed progress to output a linefeed, and now just before the crash, the output looks like this:
> 
> 436/627 (2013) [1649] (6e54a90a29e4e01fa2d6a42c232e02e08e912b2d) (2ca7b24e731ff91c94c9abf214686cb29cdc367e)
> 436/627 (2014) [1650] (1ef866e5a18012e80eed36315deb932c2b66d34a) (6e54a90a29e4e01fa2d6a42c232e02e08e912b2d)
> 436/627 (2015) [1651] (c8585f441548dd43f113a96ba48f6fa70363d388) (1ef866e5a18012e80eed36315deb932c2b66d34a)
> 436/627 (2016) [1652] (663bb110a58decfe889cf7c6b766f1d0c032ba39) (c8585f441548dd43f113a96ba48f6fa70363d388)
> 436/627 (2017) [1653] (edbdd28e009e52c8001bb54e53a56b059167e07d) (663bb110a58decfe889cf7c6b766f1d0c032ba39)
> 436/627 (2018) [1654] (c47739713912ae6e94714b9a1a6732407b236932) (edbdd28e009e52c8001bb54e53a56b059167e07d)
> 436/627 (2019) [1655] (d444823b97d9a8e53c4e721a44e4c49619d0b372) (c47739713912ae6e94714b9a1a6732407b236932)
> 436/627 (2020) [1656] (15a7ccecb2ca8bc47c77a997f8c74e7ac3b13325) (d444823b97d9a8e53c4e721a44e4c49619d0b372)
> 436/627 (2021) [1657] (b9bc5c9b33b100b57e23626ff422dac73f94384e) (15a7ccecb2ca8bc47c77a997f8c74e7ac3b13325)
> 436/627 (2022) [1658] (eec0f28c6fe5f7d664c41a913883d64cdf53c111) (b9bc5c9b33b100b57e23626ff422dac73f94384e)
> 436/627 (2023) [1659] (e0ddd9c60f71283996cfb169f1dbb77e8f7c4b94) (eec0f28c6fe5f7d664c41a913883d64cdf53c111)
> 436/627 (2024) [1660] (27b96988847caf3bfd71df2d7f58cbe6ba78208a) (e0ddd9c60f71283996cfb169f1dbb77e8f7c4b94)
> 436/627 (2025) [1661] (11e5861e50f88237ce362b6c7531e4e90bac86ac) (27b96988847caf3bfd71df2d7f58cbe6ba78208a)
> /usr/libexec/git-core/git-subtree: line 751: 122202 Done                    eval "$grl"
>      122203 Segmentation fault      (core dumped) | while read rev parents; do
>     process_split_commit "$rev" "$parents" 0;
> done
> 
> 
> > 
> > Then please run these commands and post the output here
> > 
> >    git rev-parse <that-rev>^@
> 
> Did that with the last three lines:
> 
> $ git rev-parse 27b96988847caf3bfd71df2d7f58cbe6ba78208a^@
> 11e5861e50f88237ce362b6c7531e4e90bac86ac
> $ git rev-parse e0ddd9c60f71283996cfb169f1dbb77e8f7c4b94^@
> 27b96988847caf3bfd71df2d7f58cbe6ba78208a
> $ git rev-parse eec0f28c6fe5f7d664c41a913883d64cdf53c111^@
> e0ddd9c60f71283996cfb169f1dbb77e8f7c4b94
> 
> > 
> > and
> > 
> >    git show -s --pretty=%P <that-rev>
> 
> $ git show -s --pretty=%P 27b96988847caf3bfd71df2d7f58cbe6ba78208a
> 11e5861e50f88237ce362b6c7531e4e90bac86ac
> $ git show -s --pretty=%P e0ddd9c60f71283996cfb169f1dbb77e8f7c4b94
> 27b96988847caf3bfd71df2d7f58cbe6ba78208a
> $ git show -s --pretty=%P eec0f28c6fe5f7d664c41a913883d64cdf53c111
> e0ddd9c60f71283996cfb169f1dbb77e8f7c4b94
> 

Hmm.. I'm not that familiar with git-subtree.sh, so here's one last
blind shot.

There's a format change between git-show and git-rev-parse. The former
separates commits by spaces while the latter by newlines. Will this
help?

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 147201dc6c..23f570beee 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -633,7 +633,7 @@ process_split_commit () {
 	else
 		# processing commit without normal parent information;
 		# fetch from repo
-		parents=$(git rev-parse "$rev^@")
+		parents=$(git rev-parse "$rev^@" | tr '\n' ' ')
 		extracount=$(($extracount + 1))
 	fi
 
--
Duy
