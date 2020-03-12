Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75CDEC2BB1D
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 14:38:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48D9F20716
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 14:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aYB3m1/c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgCLOiG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:38:06 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:41278 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727699AbgCLOiG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 10:38:06 -0400
Received: by mail-ot1-f42.google.com with SMTP id s15so6443617otq.8
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 07:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=4V6HIK2Fs6TjvUmiwhdncDwkauj6NbMClDSWy0SrZ9o=;
        b=aYB3m1/cZmTwitnZrQPft7k6Xg0r3ZSExzQ8GGyvIQcm4phBl57QVbe0CG7PEri+fw
         zH7uAwKrDl4uNArj4nSXL/B8odXXzz2htKI2zGRuV3R/TFg6S8C0o45nnAU+FPQ+PpKe
         tf2dLhE62O1GBQJCKy9N80Ozn5Qz2PREmOQ3yxVwBsOoOVO9CzmkoYlZqrsZqIiO6otE
         8RE2tkafB5rHV3XCdgZpoOc4DVBgZsZdlFRm/XT35MV8TneunND5VcYLwk28mXEmvu6Y
         nFcI67ypGOLkkaqxhmxnvVGlQuGi2/AZJzOT84oyUidchO14TbtvPIKwBibvqsuSuNil
         t7yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4V6HIK2Fs6TjvUmiwhdncDwkauj6NbMClDSWy0SrZ9o=;
        b=D8LlDqyPFb9opnQJZYC4DPzPMp0bcOXD5Ysl9hOLqhjujcVVWZpNr4SZpbMM2XT87x
         qupEj7+YWP9s3dPrghnFXUyPT33OKA31F0sUZmEanQ2Xj2ULHcTtXaxLPaef0l7DnbuV
         KxUxyE0q+hwuHbRkVAekmaTd1CvVSHU4NE1xcWMss7/0PnTmtbsG+w+6E+LLNOfI2Yba
         zyrPMrhTCh6KFrPjBgt0AOGEKypj6LElUCBPGjwYOeMhJOZvV674hPhwUNLPd1rDMh0r
         Lk2ebT3hRr40b1BYzb2WBsCrJqodyIuVyH2uRVpVff4AozwNjC75pWjObaJ86LZd+91c
         5rWg==
X-Gm-Message-State: ANhLgQ14Jb1aee9XRJKo6OCh5P2JD0Rq69zIHaxyzVqHzeEIVobNamBL
        NIh7nfGmW1uPBy11oremKldVd90G1d4=
X-Google-Smtp-Source: ADFU+vt8N0+cvw3mlfLLMfaWSyYj0EKIEUSeVpbZn51LNa1yxb8aY2pDpNcqGPCCIRaNJ/USYqci0g==
X-Received: by 2002:a05:6830:19e2:: with SMTP id t2mr6268146ott.97.1584023884509;
        Thu, 12 Mar 2020 07:38:04 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id w21sm1686566otm.10.2020.03.12.07.38.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Mar 2020 07:38:03 -0700 (PDT)
Subject: Re: Notes from Git Contributor Summit, Los Angeles (April 5, 2020)
To:     James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <a6ef088a-0c68-58ec-ef5b-4f353f0b0299@gmail.com>
Date:   Thu, 12 Mar 2020 10:38:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/11/2020 11:55 PM, James Ramsay wrote:
> It was great to see everyone at the Contributor Summit last week, in person and virtually.
> 
> Particular thanks go to Peff for facilitating, and to GitHub for organizing the logistics of the meeting place and food. Thank you!

Thanks for taking excellent notes!

> On the day, the topics below were discussed:
> 
> 1. Ref table (8 votes)
> 2. Hooks in the future (7 votes)
> 3. Obliterate (6 votes)
> 4. Sparse checkout (5 votes)
> 5. Partial Clone (6 votes)
> 6. GC strategies (6 votes)
> 7. Background operations/maintenance (4 votes)
> 8. Push performance (4 votes)
> 9. Obsolescence markers and evolve (4 votes)
> 10. Expel ‘git shell’? (3 votes)
> 11. GPL enforcement (3 votes)
> 12. Test harness improvements (3 votes)
> 13. Cross implementation test suite (3 votes)
> 14. Aspects of merge-ort: cool, or crimes against humanity? (2 votes)
> 15. Reachability checks (2 votes)
> 16. “I want a reviewer” (2 votes)
> 17. Security (2 votes)

Wow, this split into separate emails was a fantastic idea to control the multi-threaded discussion. Kudos!

-Stolee
