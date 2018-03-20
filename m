Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F21EB1FAE2
	for <e@80x24.org>; Tue, 20 Mar 2018 18:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751640AbeCTSIP (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 14:08:15 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33585 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751578AbeCTSIL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 14:08:11 -0400
Received: by mail-lf0-f67.google.com with SMTP id x205-v6so4001183lfa.0
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 11:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LHIEvEg8FnQ9PxJX7IPDHE9+V+hysN5fVqXcienPcDo=;
        b=EQ8i4R5+k489LsNFVUzaJLo9+SOG9FgnHI888hC5UvIdqsB/6O/yivENBvkg+//i5W
         kyxM4iWibUOaBF3hsk+5LyBUjHeR/KJnuq30L0NO2UxAuMEh/taa14nEdHoCrchSvxNV
         /w1NWWCHDOm8TqzQ6yUipCvGr4Ys0CJxiSqBkg1W2x2sKSKTI5WqbKOC8ZbFK5DeiMXq
         L0YTvrzypHCb3ggLjddBsVSugIwp4fVDtBkFu6kbg5LHhYvtcuz2aiJ48WU2H7Ojxfz0
         /yWaenHmca9yNN5HR+HxXscoC0UXjBzlfF9ysbPgwpcehbyVSMTZh6x49TEqKdR8pvaL
         xg0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LHIEvEg8FnQ9PxJX7IPDHE9+V+hysN5fVqXcienPcDo=;
        b=gmdahMsjiSE8aBnx7Jk9S6tk21Y+VP8jWFJuNVcjor928CoE46AMhzg1wgevykVbCL
         sjiHQb5Iw4kNAYhQma1KeYSHtWt7ODRJSs3KSflpftJY9hQ8iWYI3MsTsNNUeqmxhCOH
         gnRs84lm9I5mnVB4BnF25Cdi6Ez/npx8zKTTtRha+ltyGbWijLm8YsyPLmiCaBFB6zzN
         /DJ6YQyT9gEGFQ0z2FK+aZvHEj5TuvmWRQUqNlSumqGZceM8ifYQdLNRlMg/yPFU+t/B
         ejOcbcfQll+TVlqzPpXaAhGq755Ei8/z6jk7ojBPmU/MMONqHZpCYJe2+TVP+90weTFx
         7dLQ==
X-Gm-Message-State: AElRT7H4t4w61iA5piBTKq4ERFxdEZrTZkOIutMjIVo5Y4diyRekySYI
        FuwF79OuQU52t2tMAVS1pn8=
X-Google-Smtp-Source: AG47ELvI+DmZTTTiPvUJIfJ+XWvCsiJbRMgDEqzgIyVYr+K1TRMsL7UI1YG3xC2r+HJacir2OWOV0g==
X-Received: by 2002:a19:b516:: with SMTP id e22-v6mr12285514lff.47.1521569290124;
        Tue, 20 Mar 2018 11:08:10 -0700 (PDT)
Received: from duynguyen.home (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g74sm496919lji.24.2018.03.20.11.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Mar 2018 11:08:09 -0700 (PDT)
Date:   Tue, 20 Mar 2018 19:08:07 +0100
From:   Duy Nguyen <pclouds@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Wong <e@80x24.org>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 09/11] pack-objects: shrink size field in struct
 object_entry
Message-ID: <20180320180806.GA16521@duynguyen.home>
References: <20180317141033.21545-1-pclouds@gmail.com>
 <20180318142526.9378-1-pclouds@gmail.com>
 <20180318142526.9378-10-pclouds@gmail.com>
 <xmqqsh8wvwwn.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AkJJQ4XNszxBsESN_WGOSZ+ExWdcCtn6NA+gW9+-mAqQ@mail.gmail.com>
 <xmqqlgenvs07.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AbkaSLBYqtFiCwFoqRXguy1hTs=XriefZ3WQJjo_sy8Q@mail.gmail.com>
 <xmqqy3inu8qe.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy3inu8qe.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 19, 2018 at 01:10:49PM -0700, Junio C Hamano wrote:
> > ... I was trying to exercise this
> > code the other day by reducing size_ field down to 4 bits, and a
> > couple tests broke but I still don't understand how.
> 
> Off by one?  Two or more copies of the same objects available whose
> oe_size() are different?
> 

No. I did indeed not understand pack-objects enough :)

This "size" field contains the delta size if the in-pack object is a
delta. So blindly falling back to object_sha1_info() which returns the
canonical object size is definitely wrong. Please eject the series
from 'pu' until I fix this. The bug won't likely affect anyone (since
they must have 4GB+ objects to trigger it) but better safe than sorry.

BTW can you apply this patch? This broken && chain made me think the
problem was in the next test. It would have saved me lots of time if I
saw this "BUG" line coming from the previous test.

-- 8< --
Subject: [PATCH] t9300: fix broken && chain

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 t/t9300-fast-import.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index e4d06accc4..e2a0ae4075 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -348,7 +348,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
 	INPUT_END
 
 	test_when_finished "rm -f .git/TEMP_TAG
-		git gc
+		git gc &&
 		git prune" &&
 	git fast-import <input &&
 	test -f .git/TEMP_TAG &&
@@ -365,7 +365,7 @@ test_expect_success 'B: accept empty committer' '
 	INPUT_END
 
 	test_when_finished "git update-ref -d refs/heads/empty-committer-1
-		git gc
+		git gc &&
 		git prune" &&
 	git fast-import <input &&
 	out=$(git fsck) &&
-- 
2.17.0.rc0.348.gd5a49e0b6f

-- 8< --
