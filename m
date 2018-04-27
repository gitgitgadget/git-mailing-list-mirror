Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1541F1F424
	for <e@80x24.org>; Fri, 27 Apr 2018 16:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758290AbeD0Qbs (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Apr 2018 12:31:48 -0400
Received: from mail-wr0-f169.google.com ([209.85.128.169]:40288 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757562AbeD0Qbr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Apr 2018 12:31:47 -0400
Received: by mail-wr0-f169.google.com with SMTP id v60-v6so2338951wrc.7
        for <git@vger.kernel.org>; Fri, 27 Apr 2018 09:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=QpoUmSXdbnkHDpvJQc84d+PpB7o71XIxj0roFThXyDw=;
        b=pWayP4pSN8rgx8a4TTsa9H1SrxNXQJszDwxitxRiVIMdXHT/AgAkp6Lqu95Sxfs4oP
         stbe/y5fwbCK0Z3zqY0Lg5ETA9pxVUfvTdzFvFnSPK/pyMJxm9WcQ+KFWesjck+AAgHd
         sI6wvZx84fWOKfUPIDGxgmyCCfkiqb5SX+C6Cmb2AW8de3T7pyxct0NU6/VY5csN91hY
         aRr2H/IGzWVL+Y8VoRxrYhNfU8rBb427LhGPfpiAt7seDj19GV73IBrhM6T+xM+v5UJ0
         bf6yG4OoD4JeOm04XMHZemGDcLOQLrCppUOmLVV0b3hIPneO/IxHsaZluBQyYcJkpRR0
         aKAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=QpoUmSXdbnkHDpvJQc84d+PpB7o71XIxj0roFThXyDw=;
        b=TI8/ppuQ0SfbF4Nxdmg1L5Qw4piUuSRYoOsM1yjDFayQnQJUVJZ4SJvwY62+YuRziU
         NkOUGbqaP4DqBFFJOYDcsVDIAY0Nv5ps6Qxy+QXtRQRpCRx26eBLfseq9c4peIsbxSiG
         vhHYcjCbwL1vmJYIfAgnj7FPuz1b5ZSvHu3gDgmgY3A3K+X4GtS2tRgvR4qKnsa13Q/v
         QstBpI5oLAOxjYBCuEbnAX5GPL44PQlRRtt18u1ZF+b77TNR8TQWs+lbMf1YxqYLIyqb
         CWThNi1kkK83nk7TqHCVcbkuaqSPgZF4ezMKMjr0PMA6ZYD6miybD/sCdVcKjrARPxX4
         PF2g==
X-Gm-Message-State: ALQs6tCJmkICnb6vuQSqeqQeByqNw4g6uuBOgXzAD0fCtKk5umOLRL8b
        cfFgFVFPQGrwu8MWpKehe+/Xlg==
X-Google-Smtp-Source: AB8JxZqT6dldNsLZu7bhVW9sMWcWJZFZxCo1NhdnxxP91YS8FbgQrE5tcM5tnUOZb4T0A4Q33hboFg==
X-Received: by 2002:adf:a6f8:: with SMTP id t111-v6mr2335141wrc.161.1524846706342;
        Fri, 27 Apr 2018 09:31:46 -0700 (PDT)
Received: from ?IPv6:2001:a62:81d:ab01:dd1e:a7ac:6cfc:1274? ([2001:a62:81d:ab01:dd1e:a7ac:6cfc:1274])
        by smtp.googlemail.com with ESMTPSA id y9-v6sm2035619wrg.46.2018.04.27.09.31.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Apr 2018 09:31:45 -0700 (PDT)
Subject: Re: [PATCH 5/6] git-svn: commit-diff does not support
 --add-author-from
To:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20180410183224.10780-1-asheiduk@gmail.com>
 <20180410183901.11859-1-asheiduk@gmail.com> <20180417061814.GA19648@dcvr>
From:   Andreas Heiduk <asheiduk@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <b06caf94-3c70-a2af-fc32-6f7db90ac4e3@gmail.com>
Date:   Fri, 27 Apr 2018 18:31:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417061814.GA19648@dcvr>
Content-Type: text/plain; charset=utf-8
Content-Language: de-BE
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.04.2018 um 08:18 schrieb Eric Wong:
> Andreas Heiduk <asheiduk@gmail.com> wrote:
>> Signed-off-by: Andreas Heiduk <asheiduk@gmail.com>
> 
> Thanks.
> Signed-off-by: Eric Wong <e@80x24.org>
> 
> And pushed for Junio:
[...]

I'd like to keep the patches together, so I borrow your 'Signed-off-By'
from the commit and do a complete reroll of this mini-series.
