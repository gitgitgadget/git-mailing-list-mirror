Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EE401F424
	for <e@80x24.org>; Mon, 18 Dec 2017 18:44:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932677AbdLRSoy (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Dec 2017 13:44:54 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:35313 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757649AbdLRSox (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Dec 2017 13:44:53 -0500
Received: by mail-pl0-f68.google.com with SMTP id b96so5346277pli.2
        for <git@vger.kernel.org>; Mon, 18 Dec 2017 10:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HZ9v7kAnVHa3cY+qc7AyBG89muc4Hx44sk0sn6djonU=;
        b=jwRXgwojwgHT39+IR7dY8hky6xJV/sicOQzGWnEIL/4Zp+Y+O1PkE5Fh62+NmtBBGq
         kS6QlSU/mrcqr14qMtJ9ey7nK1P3/xoe9Dy+7gx9hxKPFQ4MAoxzbRrMe1ap1DW8VCd/
         by6UHBw/EmmZl5Baprz4EFBYIudD6bLEMCecomkVQ3IeG6RJSoj4OrHvfFR4jHnxkEtJ
         XlGQjWK9JcQKp4sWvZAndRWy0HZEuNNJMEomN3mveVPJYfU/YpKacdELr9QmPlSdx+Ee
         l0+rv+zSTVwdzgGXBQ6a7dUIkup6Y4dMt7BNXjKaY843LSxRCnFq0bfqr2Qxh0D6w6Qk
         JvXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HZ9v7kAnVHa3cY+qc7AyBG89muc4Hx44sk0sn6djonU=;
        b=VQF5DzoNyiH3/KsXP5OZVqVTi22VzmIf1Zn8vudmE6Ab/r0f8S1HneNsZ41Xrv4glQ
         L28vJjJDWtlTr+7GAR/CuQVgTzd/DvR3/Nvh7qwmAWy3ZOrjNgxZaKj7EMxcvb9IKnKA
         Ov8aGmbnQBbrfJ5MYf5maQZtVELvDwaUHVb6qvs4CGsJUGDoIgW2N3XQkQSNYMQt/c+X
         G2F3/iqLgkBfqtBBsznRyyXGKxAfKZ33xgkh8XNhXVYpEWWuc/xOWww6z7d1g94+yvt/
         dLWSMIVSM8HF7pwpTQiqw6Wmj7Rqyfe+Mf/9VBQDDGi7uE/kl7rH7JkS37GbWgDf0wIA
         STaA==
X-Gm-Message-State: AKGB3mLIJnVbcyPwzO1O7lDQoI7AcZlSJ72FFYaFLdcFIZ1q4ZRCPA8Z
        BlFZBDLmJnbIQ2ie9xL83oUhmFFL
X-Google-Smtp-Source: ACJfBosTxmPNgs4SR/S97Pz5BDuJShoFszTpVIs6f0up5CQ79VTDOnsNvE28yxmccCNe4dXsCeNUog==
X-Received: by 10.84.234.193 with SMTP id i1mr637570plt.146.1513622692027;
        Mon, 18 Dec 2017 10:44:52 -0800 (PST)
Received: from [10.4.2.238] ([218.248.21.162])
        by smtp.gmail.com with ESMTPSA id n24sm26803368pfi.33.2017.12.18.10.44.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Dec 2017 10:44:51 -0800 (PST)
Subject: Re: 'git format-patch <ref> --summary' seems to be turning off the
 stat
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <b620caf9-e11c-1511-67a6-d9f981f28728@gmail.com>
 <xmqqlghzyj9q.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <41f53071-185d-58a5-499c-d93208aa70fc@gmail.com>
Date:   Tue, 19 Dec 2017 00:14:43 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <xmqqlghzyj9q.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Cyberoam-smtpxy-version: 1.0.6.3
X-Cyberoam-AV-Policy: default
X-CTCH-Error: Unable to connect local ctasd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday 19 December 2017 12:07 AM, Junio C Hamano wrote:
> Kaartic Sivaraam <kaartic.sivaraam@gmail.com> writes:
> 
>> Note: I do see that "--summary" is a diff-option but does that mean we
>> should't be printing stat information in the patch when the user
>> didn't mention "--no-stat"? Yeah, "git format-patch <ref> --summary
>> --stat" does bring back the stat. --- Kaartic
> 
> The old design decision shared across "log" family of commands [*1*]
> wrt to these "how and what are shown" options is that they started
> without any default set of options and the user gave all options (if
> they want both summary and stat, they gave them from the command
> line); over time they gained a set of built-in default options that
> take effect only when the user gives no option.
> 
> So, yes, giving "--summary" will turn off the built-in ones that are
> "--summary --stat" (IIRC).
>

Is it worth documenting that built-in defaults are turned off when user 
gives other options? Not sure where, though?


-- 
Kaartic
