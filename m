Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47B771FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 17:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758985AbcLARvL (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 12:51:11 -0500
Received: from mail-pg0-f53.google.com ([74.125.83.53]:33686 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755146AbcLARvK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 12:51:10 -0500
Received: by mail-pg0-f53.google.com with SMTP id 3so97337798pgd.0
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 09:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rd+NGsvvNJykIFn6ttEerBgKaP7eD2VwZ+HS1wyPPk4=;
        b=Bk2rl3ZLtWWo9LH5C9LzUpV/jHE+khR8uUXGVLFWOc463qy1vRN1oZHuTC/vA1aN+i
         xQUrY2p/8aKRL+VfsUM6Dng3pD2EF8l7UO8GAuJwrg3Y6hI6WNSdxOrO+hc3IiMz9aHe
         K963seAwoUB5fXQM36LlZqyl8JSaNAyCL+Mpht/1qwzaL7aexSWb+fMkGSYZcWEQo//a
         27QjnNe0O5Mm3ch8ZgfCzxeX4I2rCElgFNv9/0gFTrKQAIyGqXQKMjxFhRKJbOTzrIzZ
         QhRN/MU4w1DqMppoUcbpCDQzgE9fms0Q8N3TNcKDmNxLVQs0YBM4kV5HKL/GIaczgVIC
         d3CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rd+NGsvvNJykIFn6ttEerBgKaP7eD2VwZ+HS1wyPPk4=;
        b=MCNRf45JiurXRlYbQl+loOnIv1MDkN6q/9onRW+MEYPSSTpLddozpvis9TYhy6swnb
         v5K3lJWSXeN3uPTyIir1EYkOxFw9ECaKdGkNVJfiVOsbQNnO3ppef4Op18ocJ/D2foWA
         BFnA9/HXSlTxcQe8wE6GUUBPVhtLfLo0V4fFYZ5WfHM8TK0xP0fPhCJnpARJW/AFC5X5
         Ub2exHMmNb/uYteR1HsfHOPgBRjk1qrBh236CiK+wlzQspOxuSbSan/XUPEL0vusDAWu
         LbBn6UtVTToRzlBqeXYVr/6W/BpzleJS13i5YcVQs8jQYKBfLEF3cuAeOa+a3QDcfyyS
         LCXw==
X-Gm-Message-State: AKaTC01P6reaVQNubaQ3lZur+WvBBgRUev56CPf3UYCqWUyHAcKJJMaNdwTY1IxBE09yiHw5
X-Received: by 10.99.133.200 with SMTP id u191mr70789481pgd.28.1480614669338;
        Thu, 01 Dec 2016 09:51:09 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2ce9:cac6:1258:bbf3])
        by smtp.gmail.com with ESMTPSA id r88sm1596935pfe.93.2016.12.01.09.51.08
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 09:51:08 -0800 (PST)
Date:   Thu, 1 Dec 2016 09:51:07 -0800
From:   Brandon Williams <bmwill@google.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        jonathantanmy@google.com, gitster@pobox.com
Subject: Re: [PATCH v6 5/6] grep: enable recurse-submodules to work on <tree>
 objects
Message-ID: <20161201175107.GB51406@google.com>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com>
 <1480555714-186183-6-git-send-email-bmwill@google.com>
 <c6b2ddad-ac09-3457-8289-88a3f52b7e4b@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6b2ddad-ac09-3457-8289-88a3f52b7e4b@kdbg.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01, Johannes Sixt wrote:
> Am 01.12.2016 um 02:28 schrieb Brandon Williams:
> >+	git init "su:b" &&
> 
> Don't do that. Colons in file names won't work on Windows.
> 
> -- Hannes
> 

This test is needed to see if the code still works with filenames that
contain colons.  Is there a way to mark the test to not run on windows?

-- 
Brandon Williams
