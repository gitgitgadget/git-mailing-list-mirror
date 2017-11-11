Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0FC7C1F42B
	for <e@80x24.org>; Sat, 11 Nov 2017 01:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754555AbdKKBqn (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 20:46:43 -0500
Received: from mail-wr0-f181.google.com ([209.85.128.181]:53140 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdKKBqn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Nov 2017 20:46:43 -0500
Received: by mail-wr0-f181.google.com with SMTP id j23so9994313wra.9
        for <git@vger.kernel.org>; Fri, 10 Nov 2017 17:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=a8+TLhQ0GvHLjogm1HJLXLgLcaIdc+P1SxWT7WoKdnM=;
        b=fOaM81mFfL0qq7l7kOUOmlQI/OyeAhxWmjv9Oid5yR9xXKEY5e5fdXweG7IDMiJ1Iq
         q8Mrsym8b51lgslk6e17Dz64VR7taDUBq+GcYFvXl7kf3ZP+3Lt0UqodlWu3u6cKIlCD
         wRKgfRLFU8HU4Mtdam+QtKPqILA/mvgqCfAXpCHaj8WZ4epRuC8BqXsLAy6KF4l3HKXP
         4SueShShyZgLOgd9Zcvk5FLO/wdMg2PUKSh5VBN2FuCO5DizZU3/5QU3MWLHyy0jD8hh
         DrnRlnbwE3SnNblNMZuDIiK4ya33CKMWFOt9wiDmOVaC26X9V3rH35xgGqc5mHkVX2Tm
         Rvug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a8+TLhQ0GvHLjogm1HJLXLgLcaIdc+P1SxWT7WoKdnM=;
        b=StBAw0AFxJCVFAC2P1pLtwq6b6mhHfUfWxOhzWuU/VaLKUraJarV5LbUX1tXl/atsF
         QczBWjPFE2ni/+DfDxPYmKBAoYOM4yk3GFT+7MBNnRZ6xzTTWdYNeyG3NQVmyDEOBV3D
         zYEAg7cwQqTlquzwNwGqSzH0yWNHZbZBhw+TXSEb/bVPFCM3bOKjtzdrxrRqKbsZswQ2
         f2od8g/ZQx+le/X449c+BQpdVHKD+DGYoqkztuMvUYHnxH0AthFH4dof4JzS9Qqn7GHk
         w52nAPntzciJPu94soE/puEAlARe9t7Z8duzIqsL2yf5nYhQgoLus/BgDWZ9ByWIftyb
         RwrA==
X-Gm-Message-State: AJaThX5OAFM7VX2pSY13TU3W4+TaRqQz+vsfQubby5W2lbgEfxGb4Yhu
        Omvpt0F51U7iLZ7d6NGX8EcXVmA1
X-Google-Smtp-Source: AGs4zMYt8QnfhZ3BtBJtP/Sb3mcb0TIHMHAFVV5W4tdBLqF5NzuQFggXh9NlVk+IFxoJYMW9Z6vp+g==
X-Received: by 10.223.154.202 with SMTP id a68mr1712897wrc.8.1510364801536;
        Fri, 10 Nov 2017 17:46:41 -0800 (PST)
Received: from [192.168.1.8] (93-87-220-139.dynamic.isp.telekom.rs. [93.87.220.139])
        by smtp.gmail.com with ESMTPSA id b76sm1829217wmg.9.2017.11.10.17.46.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2017 17:46:40 -0800 (PST)
Subject: Re: Unify annotated and non-annotated tags
To:     anatoly techtonik <techtonik@gmail.com>, git@vger.kernel.org
References: <CAPkN8x+MELCnttE+xptKzYXsYPWqbiE59LABrwNBhFroayc+wQ@mail.gmail.com>
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
Message-ID: <ec4be1c2-a0cc-cec8-a566-06c11c8abe06@gmail.com>
Date:   Sat, 11 Nov 2017 02:46:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <CAPkN8x+MELCnttE+xptKzYXsYPWqbiE59LABrwNBhFroayc+wQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Anatoly,

On 10/11/2017 11:58, anatoly techtonik wrote:
> It is hard to work with Git tags, because on low level hash
> of non-annotated tag is pointing to commit, but hash for
> annotated tag is pointing to tag metadata.
> 
> On low level that means that there is no way to get commit
> hash from tag in a single step. If tag is annotated, you need
> to find and parse ^{} string of show-ref, if not, then look for
> string without ^{}.

That is not quite true, as you can always dereference any tag 
(annotated or not) using "<tag>^0" notation, see git-rev-parse[1]:

  "As a special rule, <rev>^0 means the commit itself and is used when 
  <rev> is the object name of a tag object that refers to a commit 
  object."
 
> So, why not just make all tags work the same so that every
> tag has its own hash and you need to dereference it in the
> same way to get commit hash?
> 
> This way I could get all commit hashes with just:
> 
>     git show-ref --tags -d | grep "\^{}"
> 
> or abandon ^{} completely and show commit hashes on -d:
> 
>     git show-ref --tags --dereference
>
Depending on what you would _exactly_ like to do, you could get all 
tagged commit hashes like this:

	git rev-list --tags --no-walk

Note that each commit will be listed only once, even if more tags 
(annotated or not) point to it.

If you would like to mimic output of "git show-ref", repeating 
commits for each tag pointing to it and showing full tag name as 
well, you could do something like this, for example:

	for tag in $(git for-each-ref --format="%(refname)" refs/tags)
	do
		printf '%s %s\n' "$(git rev-parse $tag^0)" "$tag"
	done


Hope that helps a bit.

Regards, Buga

[1] https://git-scm.com/docs/git-rev-parse#git-rev-parse-emltrevgtemegemHEADv1510em
