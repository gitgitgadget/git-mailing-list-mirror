Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D2B31FAF4
	for <e@80x24.org>; Wed,  8 Feb 2017 22:08:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbdBHWHo (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Feb 2017 17:07:44 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:35593 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751011AbdBHWHn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Feb 2017 17:07:43 -0500
Received: by mail-io0-f193.google.com with SMTP id m98so366414iod.2
        for <git@vger.kernel.org>; Wed, 08 Feb 2017 14:06:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lvRFDNjdEXILQa6WiTehikof7+vgWvITKq8NCAcjUHM=;
        b=olyiabZiGimO2XVf2yvFNaY9Uoeke/N8NK2BMfeRCTZTR8Y7IbSBx08zJeLVlNRyAs
         KlbPR5t9fGUc0m4N3kAeR47KjxX5lTDC02vkHP9upGQ1Tu+sk8NhhY9a0AVbsqaOCbhQ
         BnL/2W/2yQMuH5PBgYkXt3xy3I+dSOESFYNlgZYtspmZjrL8trh86LfVyjUqUCjjgJ01
         gTPkdeef55rrFNuFw4yV2COPd6fjTvfBPnqmda6noFmnYqn1+Tw6dBFrXzNFQ9AldARw
         1QsPPtupP+dYtBXNAHvU3MJ14ZZNdX3N6pB4seCT0qK0SfSurzBwmD+RkyiCTVF1L8FV
         Z7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lvRFDNjdEXILQa6WiTehikof7+vgWvITKq8NCAcjUHM=;
        b=QwhIzgFGinB75OSRxsd1Ap556ZrMYrWL6zJ2+WGgV07h2N2fkunvWdYTI82mAo2YAz
         E5c5s5chf93wXDm/zdnXEn12dmN0+DedrCxveuMxNWXzGCtt+zmO/m/GYI+6swzoZOX/
         M3rcrcVXK1E/HP7uQemsBnYkidJKfBj7whbjkq4s0f6H/8berPV0x1D0aQ0VGlpW11N+
         kZ4Tzgn8oJ8y33D6roGBsT7hVPPc9jkd1SUsVFTQDzdrhOjGCcDnglgKYhI7d1gwgfsO
         Mwp8jII5NbyRvcn0n/I+NaxU91ATMTxCfTyihNTqf5ZUrIYUpFxDbRE+EMJK3VMNI9hs
         BQBA==
X-Gm-Message-State: AIkVDXKMOjdYiRqfn/sK5xaxicPCCCG37tsmsZMUJslKSMv2AR1taRkXM3JZYxoqXHC2iA==
X-Received: by 10.98.166.131 with SMTP id r3mr28572022pfl.143.1486591585628;
        Wed, 08 Feb 2017 14:06:25 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:7c20:fa7c:46cb:2209])
        by smtp.gmail.com with ESMTPSA id d69sm22824709pfd.11.2017.02.08.14.06.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 08 Feb 2017 14:06:24 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, David Turner <dturner@twosigma.com>
Subject: Re: [PATCH] refs-internal.c: make files_log_ref_write() static
References: <20170208094558.23712-1-pclouds@gmail.com>
Date:   Wed, 08 Feb 2017 14:06:24 -0800
In-Reply-To: <20170208094558.23712-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Wed, 8 Feb 2017 16:45:58 +0700")
Message-ID: <xmqqfujouylb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> Created in 5f3c3a4e6f (files_log_ref_write: new function - 2015-11-10)
> but probably never used outside refs-internal.c
>
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---

It's been more than a year, so let's declare that when somebody
needs it it can easily be turned into extern again and take this
patch.

Thanks.

>  refs/files-backend.c | 3 +++
>  refs/refs-internal.h | 4 ----
>  2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index c041d4ba21..6a0bf94bf1 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -165,6 +165,9 @@ static struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
>  					  const char *dirname, size_t len,
>  					  int incomplete);
>  static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
> +static int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
> +			       const unsigned char *new_sha1, const char *msg,
> +			       int flags, struct strbuf *err);
>  
>  static struct ref_dir *get_ref_dir(struct ref_entry *entry)
>  {
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 25444cf5b0..4c9215d33f 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -220,10 +220,6 @@ struct ref_transaction {
>  	enum ref_transaction_state state;
>  };
>  
> -int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
> -			const unsigned char *new_sha1, const char *msg,
> -			int flags, struct strbuf *err);
> -
>  /*
>   * Check for entries in extras that are within the specified
>   * directory, where dirname is a reference directory name including
