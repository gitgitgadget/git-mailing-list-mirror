Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F68ECAAA1
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 23:12:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiJ1XMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 19:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJ1XMV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 19:12:21 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F85324CC9D
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 16:12:00 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-360a7ff46c3so55181647b3.12
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 16:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Czk5+T5qLE3sCKe+9iMd+0Pj3A3cDgg0g3PYVqrfJ6g=;
        b=hlP5p6aONqQqLbXq5b+jRUCdcst7D5pRKXYJa29xgh7cRmyVHFTA7QjhKFTu5Q1m1w
         9H4QdCa8hHIXirWKUB0r2i01Dlse4a6R+b0i0UN4JoiqXxOElCxf9w/9blFVw+l2HQPz
         yd/zSvaxsDsnpH+VawabAvtgsCyZnV3W8XNR8zFNJu4h+6yeq3PIYblmX25ct+iSSrTA
         IDl0cuImYMKtFYJ+Bt5F+mkwvlj/V/qUx/NpbZUli/h87RH/sVZevv+xpFi2ZOLwJaZY
         A/pqfaTTkrAWZbUKPYYld9qi7KjU/Iel47B6BSP5j0juQIKlC41Qfgto7wLoBTGAaB32
         I4mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Czk5+T5qLE3sCKe+9iMd+0Pj3A3cDgg0g3PYVqrfJ6g=;
        b=HO/K5fdLRkhu1co9aqL30bulVCfk8SoJ1RmWY6ybYNToFMh6DQ+nhrvn28tEhlfF46
         t/I64T4aLwj0omZEHzctRIux7chYezh+W1TKb8i4/ya1WQfM7BRqtNpgbU5RlEUnWY1j
         eGjy4Owesf96H7ojyixemw1OvaOBY2Vl6Ioynj6wNIwXRgOHigKQuNChCEkInj80uzYx
         iF4noPCXjAGGeA05Ijvvg3Mmb9FGuCaqEcIHGoaYnVBtyGlXyPdT+bdVOs+UkihFRS/G
         4E2B1Z56XfDwYUDBJ6r5eQKk4e5NJY8UfKpiGbuoq3wXF3qFZlxGHE0l3HXGuoZ7xh9y
         VlUA==
X-Gm-Message-State: ACrzQf1Vtpw+PiMoVADe1D06g+2hPtM3nrwD+UGvvzj5XSFAxxD8AGHb
        kgmzdA4gguu82a7YsZBob0ky3pIU8Xxl6g==
X-Google-Smtp-Source: AMsMyM7SUxbTshc/AwEdMlAhXOf5vEXLifGUji2ZLB3cdVid2+3kBGp6R6EZaqcFip+T1XLDIF/mEkiDn/v0jA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:a148:0:b0:36d:451:1ae3 with SMTP id
 y69-20020a81a148000000b0036d04511ae3mr4ywg.412.1666998719518; Fri, 28 Oct
 2022 16:11:59 -0700 (PDT)
Date:   Fri, 28 Oct 2022 16:11:58 -0700
In-Reply-To: <xmqqfsf7hb56.fsf@gitster.g>
Mime-Version: 1.0
References: <pull.1321.v2.git.git.1666297238.gitgitgadget@gmail.com>
 <pull.1321.v3.git.git.1666988096.gitgitgadget@gmail.com> <bd8ffd7cde2feb3853f837778d660c0f47db32ff.1666988096.git.gitgitgadget@gmail.com>
 <xmqqfsf7hb56.fsf@gitster.g>
Message-ID: <kl6l8rkzczlt.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH v3 5/8] submodule: return target of submodule symref
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>>  int resolve_gitlink_ref(const char *submodule, const char *refname,
>> -			struct object_id *oid)
>> +			struct object_id *oid, const char **target_out)
>>  {
>>  	struct ref_store *refs;
>>  	int flags;
>> +	const char *target;
>>  
>>  	refs = get_submodule_ref_store(submodule);
>>  
>>  	if (!refs)
>>  		return -1;
>> -
>> -	if (!refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags) ||
>> -	    is_null_oid(oid))
>> +	target = refs_resolve_ref_unsafe(refs, refname, 0, oid, &flags);
>> +	if (!target || is_null_oid(oid))
>>  		return -1;
>> +	if (target_out)
>> +		*target_out = target;
>>  	return 0;
>>  }
>
> Please remind me why we call this underlying helper _unsafe()?
>
> Isn't it because we return a temporary buffer  (static strbuf),
> whose contents is not permanent?

8cad4744ee (Rename resolve_ref() to resolve_ref_unsafe(), 2011-12-12)
seems to suggest so.

(For some reason, I thought it was *_unsafe() because it would die(),
but it obviously doesn't.)

> I am wondering if we should force the callers who care enough to
> pass the optional **target_out to xstrdup() the result.

Yes, makes sense. We even have the *_refdup() helper for that.
