Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68FBD1FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 19:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933816AbcLATtb (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 14:49:31 -0500
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33881 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932933AbcLATta (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 14:49:30 -0500
Received: by mail-pf0-f180.google.com with SMTP id c4so47727616pfb.1
        for <git@vger.kernel.org>; Thu, 01 Dec 2016 11:49:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qB1Sk12E1XqNlibBqbIchajeA8pby6YIaDWzlG2EpbM=;
        b=JoA1HvEiAITcDba0KuF06wqo34z/VDNA3wKu8h46cwy4b8hNcJ2ZERIKnwQsRdsC0q
         LrqB0Y6g1f659Szgix6sBa6aG3YSA+2/+Ek2Z4b0esCfWAm4ooLFaKfUZywdGnjfJmfA
         i+Xbb3JLWqJh3A5YcQuY8BAMyimQEDxT/ZaW6iGVklpEbNGa7k7D3pw4++nPq6MBAHew
         HGO3LH4du7iqmX1GT4xdZgFehFEJy5BFDVUn976PTzE7WahSCvyNvDpDNmYQPdPt6n2Q
         AGagwOOd9Ix8xnlSggTZrXVtLomsitUPYo/KX8AYIjY4Z27eCHwB63aTenIguEf21jYB
         uhrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qB1Sk12E1XqNlibBqbIchajeA8pby6YIaDWzlG2EpbM=;
        b=SaRSM8lxCKTxqWYkiiUgZgPFNGKSZCq5lenHhSyBQLFOwSJCm7sdCMQmmRjeZ4wy8Y
         OGKrdH2iFEMIWiWRPRlt3hDdmB18qG5j5FznU279gUjoo+Wqsnbe6mVbfBmndleZZtrW
         XbWhFqRI9qe6q9u1A/daWdz8XkBISRG0t05mMEMM4XGzzJTVMApTsJWHG66zlUI0BAMA
         Gh/HrhzuKDhdsCqvGMQFLaSR59ab7TRB4CGOG0Pwgyk/1JDJasTuX6GeV/SjOli2Av7J
         kjR6Keyc7W6qPH6khiTd1K9R6JoYGOQKWLm/S+s7kRXvB1giNgLK2GB2Fs+BIE3sPCE6
         ut+A==
X-Gm-Message-State: AKaTC03/SUmgg3BhhUF/DA7aP7DQ3srNDagGrEd5BWqIEOyZ5RbTOOFxuFlN9HFNShjBL/rm
X-Received: by 10.84.142.70 with SMTP id 64mr86627775plw.177.1480621769926;
        Thu, 01 Dec 2016 11:49:29 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:2ce9:cac6:1258:bbf3])
        by smtp.gmail.com with ESMTPSA id p25sm2101649pfk.20.2016.12.01.11.49.28
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Dec 2016 11:49:29 -0800 (PST)
Date:   Thu, 1 Dec 2016 11:49:28 -0800
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v6 4/4] transport: check if protocol can be used on a
 redirect
Message-ID: <20161201194928.GD54082@google.com>
References: <1480621447-52399-5-git-send-email-bmwill@google.com>
 <1480621700-53222-1-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1480621700-53222-1-git-send-email-bmwill@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/01, Brandon Williams wrote:
> Add a the 'redirect' parameter to 'is_transport_allowed' which allows
> callers to query if a transport protocol can be used on a redirect.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  http.c      | 8 ++++----
>  transport.c | 6 +++---
>  transport.h | 7 ++++---
>  3 files changed, 11 insertions(+), 10 deletions(-)
> 

Accidentally sent out an old version of just this patch.  Here is the
updated one.

-- 
Brandon Williams
