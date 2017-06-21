Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EAA020401
	for <e@80x24.org>; Wed, 21 Jun 2017 17:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbdFURWn (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 13:22:43 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33269 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751974AbdFURWm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 13:22:42 -0400
Received: by mail-pf0-f193.google.com with SMTP id w12so31943242pfk.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2017 10:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=SXp8oX6gNE2j6hFz/R97+kLxbB2jaSTGzlb+dfhk3Dc=;
        b=AdsGvpGjNojMRC9lngDGtuq1M8FYqpLAB7tShwJ3n1HdRZ0ZuXmX32vOCcfFyThNei
         BulgtqxGh4/QnHTIppvKbRfgSfnb+pqfqk6JQ5eF5HFHUorRSmVnK5jsvRYHg9gnZkgu
         pVUeHiZ36RYgjh2NSlP2Tz7pvCCATNOJYNIEHcbrUSaWtwwlZ9C5I60HDAOhLAYQK836
         Adnxe+04gTcb4EOAfW/Q46pnhLtfI+sPtHeagAhRrHMId8MpBNxAmusaEAXa7JdMT3fq
         gJPdNSOJq5yEp7NO0wwBEA0kzG/o8J38ubZ0p0M/kpMKn0Q6kx5sZUxWCf3895i8lHYv
         acvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=SXp8oX6gNE2j6hFz/R97+kLxbB2jaSTGzlb+dfhk3Dc=;
        b=Q7t7EOs04vtT2aMJB/kGMqSPJV/gsvTd/kJ0Y4z4dwrNvlL5/MTsnaZ3asnAbxTB0J
         waAHqPNAnAzPw5/m+75H4C33fv+tryVQLYYHObNkjqOJ8/bwzJ9lmoFRA6W/RweWryrx
         k6hW/5HMRT0D+YNarXP5AH37ZtA4DvzhiE385ZYc/xmNLpm623ZC7OOan/e7HrePy6Qu
         XOJ8pb4ONfB9xN4OoWt/zdzvFCrxizmQyXenfA0CiuRp5yED/UoxIPq/s3i5BSLYaKsq
         73GzfXGyQ27qU5xbs/rmuYT92OjCCsvNPaKSvYmzIR23EnO6ay9MfdD4v6ksCjYRZjIo
         sjaw==
X-Gm-Message-State: AKS2vOwsdatNsXJFX3Ttb3guW+RvOlwUyYtYdyD2PGS+2z53hPhF264t
        dufBTTcYCZWgpg==
X-Received: by 10.99.37.70 with SMTP id l67mr38171492pgl.212.1498065761555;
        Wed, 21 Jun 2017 10:22:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:b0bd:d7d3:4f2e:5016])
        by smtp.gmail.com with ESMTPSA id c66sm31347226pfl.81.2017.06.21.10.22.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 21 Jun 2017 10:22:39 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v4 2/8] sha1_file: rename LOOKUP_UNKNOWN_OBJECT
References: <cover.1497920092.git.jonathantanmy@google.com>
        <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1497920092.git.jonathantanmy@google.com>
        <93c459ee90fac0d040d262bef072188b7ea69af0.1497920092.git.jonathantanmy@google.com>
Date:   Wed, 21 Jun 2017 10:22:38 -0700
In-Reply-To: <93c459ee90fac0d040d262bef072188b7ea69af0.1497920092.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Mon, 19 Jun 2017 18:03:09 -0700")
Message-ID: <xmqqpodxqmqp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> The LOOKUP_UNKNOWN_OBJECT flag was introduced in commit 46f0344
> ("sha1_file: support reading from a loose object of unknown type",
> 2015-05-03) in order to support a feature in cat-file subsequently
> introduced in commit 39e4ae3 ("cat-file: teach cat-file a
> '--allow-unknown-type' option", 2015-05-03). Despite its name and
> location in cache.h, this flag is used neither in
> read_sha1_file_extended() nor in any of the lookup functions, but used
> only in sha1_object_info_extended().
>
> Therefore rename this flag to OBJECT_INFO_ALLOW_UNKNOWN_TYPE, taking the
> name of the cat-file flag that invokes this feature, and move it closer
> to the declaration of sha1_object_info_extended(). Also add
> documentation for this flag.

All of the above makes sense, but ...

> diff --git a/cache.h b/cache.h
> index 4d92aae0e..e2ec45dfe 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1207,7 +1207,6 @@ extern char *xdg_cache_home(const char *filename);
>  
>  /* object replacement */
>  #define LOOKUP_REPLACE_OBJECT 1
> -#define LOOKUP_UNKNOWN_OBJECT 2
>  extern void *read_sha1_file_extended(const unsigned char *sha1, enum object_type *type, unsigned long *size, unsigned flag);
>  static inline void *read_sha1_file(const unsigned char *sha1, enum object_type *type, unsigned long *size)
>  {
> @@ -1866,6 +1865,8 @@ struct object_info {
>   */
>  #define OBJECT_INFO_INIT {NULL}
>  
> +/* Allow reading from a loose object file of unknown/bogus type */
> +#define OBJECT_INFO_ALLOW_UNKNOWN_TYPE 2

... this contradicts the analysis given, doesn't it?

Does something break if we change this to 1 (perhaps because in some
cases this bit reach read_sha1_file_extended())?  I doubt it, but
leaving this to still define the bit to 2 makes readers wonder why.

