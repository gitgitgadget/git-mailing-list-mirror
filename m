Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8DC520706
	for <e@80x24.org>; Tue,  5 Jul 2016 18:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753295AbcGESLh (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 14:11:37 -0400
Received: from mail-wm0-f46.google.com ([74.125.82.46]:38474 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751622AbcGESLh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 14:11:37 -0400
Received: by mail-wm0-f46.google.com with SMTP id r201so163456445wme.1
        for <git@vger.kernel.org>; Tue, 05 Jul 2016 11:11:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0suaZpZOTraGgBjF/xLD9lDsADFBO2BmGo3tmzGzcc=;
        b=x4r6uKk4K+QH+6jYob2fmULlqZCCQhJRJ0Fvs9okq68cs2uaIakVPSQHVL/E6xwza2
         ehveK8cg1pFHyTmzPkbpsviGP1kkhE2bXr9CUN89YUIUOwnnqKgOyzV7IZbavRCeP95J
         KO2a42ossmWBwu3+gaZO4EfmUJorOfSreN6a+cLo2k/oPY51+NnoTzBtScdSD0oZ8CSq
         wwh1hK0c8vMOudfiyHNLx4lTxQmsgEeyrVaEQi50q9BLen3WP3rHmL0I/Buz0Fsw8p0O
         uiDodwRi6XBiI9kp0NvuCjxLFhUV1aywoqURyGibV9Nw8hLBi3gxBbQJdCPBvWeAZ3+y
         aSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0suaZpZOTraGgBjF/xLD9lDsADFBO2BmGo3tmzGzcc=;
        b=gF8f5fiN7vadoTQy7Zo/vM19WJ19cwdQiV5ujSM+8j84GVdj3/kWgtrRTvm40e7e+9
         255AY0wxRjZ4sjOln6YnMC4yZGfML59aKyIoQVUhCu3Gwc+dnT5HPfFyCJUcXobg1scF
         IMuVG5Ey8CsAP/3xIUqjgTq6WTEz1Du7Ap+VowNkdhSZDjTcV5C/qJe8YGPFJlm8QHBM
         gyXyDj+6RzCIUJQBTIA2aZMBAoz7JWkORofuAT+7oEqum1mE999zK7SYBgJh+iz8X/LH
         H98HeuHc1PO3UIUuDYsm+Lr3CyY3qKZ2XluCo+OC+tLVZO2urmoogfNelvGvfsq4/5b7
         UArQ==
X-Gm-Message-State: ALyK8tIHwJmyqfT4Y6o5ImKvoe7srGEoH6OqAtKODzo/Y2ofNgU+Q2ca2V3u4oVTYQvIDw==
X-Received: by 10.194.87.42 with SMTP id u10mr18730653wjz.152.1467742295491;
        Tue, 05 Jul 2016 11:11:35 -0700 (PDT)
Received: from christoph-laptop-16-04 (ip-103-010-005-185.cpe.my-wire.de. [185.5.10.103])
        by smtp.googlemail.com with ESMTPSA id f73sm6456644wmg.1.2016.07.05.11.11.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jul 2016 11:11:34 -0700 (PDT)
Message-ID: <1467742293.3047.3.camel@gmail.com>
Subject: Re: [PATCH 0/5] Number truncation with 4+ GB files on 32-bit systems
From:	Christoph Michelbach <michelbach94@gmail.com>
To:	=?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc?= Duy 
	<pclouds@gmail.com>, git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>
Date:	Tue, 05 Jul 2016 20:11:33 +0200
In-Reply-To: <20160705170558.10906-1-pclouds@gmail.com>
References: <1466807902.28869.8.camel@gmail.com>
	 <20160705170558.10906-1-pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Thank you very much!

-- 
With kind regards
Christoph Michelbach

On Tue, 2016-07-05 at 19:05 +0200, Nguyễn Thái Ngọc Duy wrote:
> Since I now could reproduce the problem that Christoph showed, I
> decided to send the good patches out. To sum up, we use "unsigned
> long" in some places related to file size. On 32-bit systems, it's
> limited to 32 bits even though the system can handle files larger
> than
> that (off_t is 64-bit). This fixes it.
> 
> clang -Wshorten-64-to-32 is very helpful to spot these problems. I
> have a couple more patches to clean all these warnings, but some need
> more code study to see what is the right way to do.
> 
> Most of the rest seems harmless, except for the local variable "size"
> in builtin/pack-objects.c:write_one(). I might send 6/5 for that one.
> 
> Nguyễn Thái Ngọc Duy (5):
>   pack-objects: pass length to check_pack_crc() without truncation
>   sha1_file.c: use type off_t* for object_info->disk_sizep
>   index-pack: correct "len" type in unpack_data()
>   index-pack: report correct bad object offsets even if they are
> large
>   index-pack: correct "offset" type in unpack_entry_data()
> 
>  builtin/cat-file.c     |  4 ++--
>  builtin/index-pack.c   | 23 ++++++++++++-----------
>  builtin/pack-objects.c |  2 +-
>  cache.h                |  2 +-
>  sha1_file.c            |  2 +-
>  5 files changed, 17 insertions(+), 16 deletions(-)
> 
