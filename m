Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B69C43334
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 13:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236274AbiGWNsr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Jul 2022 09:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiGWNsq (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jul 2022 09:48:46 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196C5165A3
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 06:48:43 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id bb16so8433216oib.11
        for <git@vger.kernel.org>; Sat, 23 Jul 2022 06:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JZeXYCS0vSdBxYIwtCEaM/f2PkoWLIVeNwyrpsBkW0A=;
        b=RdYAaGBHsQQRQD9GSMuMoPMubKEQvLxXqVlnQRj6jquR/14q7b8qAOzBWMKMLVcgp5
         GV3eGikOLV+5ofX6+hkhJCn9mBtD+B0dLwGKUMW6NMRl+G7KyLlZxwLYRFyEv3i0TWmT
         zZCuCvhJ1+o8VXwfcvyf9B0LoQZU6RDisseSNQ8bNqqaaJJkWK7D+YSQnJ6MFar9znss
         N/OFwX4TOkDLuBvDqRBqQTJYEXpxd4IUcLw0UMa5O/p0RH7oWZEMaU56vdIVZLpQpx6k
         CriXCaVPqx/eQy85F4Bwz21yt6yRgXEzOsT6hWv5CSQJMqZmMbTQsrydU4F0yqQIVzeO
         +Otg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JZeXYCS0vSdBxYIwtCEaM/f2PkoWLIVeNwyrpsBkW0A=;
        b=T9/wgAFBRpySNFa1peNAOYVwXMR5Ve0KgoMkIqqvwB3qNV97trErBjn+sxKadDpENu
         XlmUDjvOM4iTg2y4eAhUhIfF0kHlybfPm7Gh1ilbH8GFyK+reZjKemSbC4jWE2ANUwud
         1j6ZPm+MG6YSKio+IMHcaYLWK1P6EpP1/UYFqgSXlLI0IirJgQJP4PN+cFI96VNzoTmg
         9vY5enyTTnFHmdx//eIZrv7FKBRAp822yp8LWfKPQzIe6lsxCRMD45OWtFbTkMbyV2wS
         KtALRI+uYkPopI2wOem/gk4SHY9eEk82dY7zZSBKGMzZw439P4It1XiWgKNRunPVeF0t
         XL0g==
X-Gm-Message-State: AJIora8faRt0aax0aMFHPiOyJQzcytMyCNaGHDkSHWTd+XiLE8TO+Qmu
        G5wRc9Xh7wbId43ZOPkryeYLmzXMiw5vSA==
X-Google-Smtp-Source: AGRyM1tK30+waSyHAHQs1LswLGmkRorEJUq+fTN6aVz5espiPbqNL9iHBF2rqndwRiLaoSMchqmEdQ==
X-Received: by 2002:a05:6808:20f:b0:33a:6151:4e54 with SMTP id l15-20020a056808020f00b0033a61514e54mr2122082oie.257.1658584122394;
        Sat, 23 Jul 2022 06:48:42 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.109.17])
        by smtp.gmail.com with ESMTPSA id a32-20020a056870a1a000b0010d997ffe7asm3703538oaf.37.2022.07.23.06.48.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Jul 2022 06:48:41 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     junio@pobox.com
Cc:     git@vger.kernel.org
Subject: mt/doc-config (Was: Re: What's cooking in git.git (Jul 2022, #07; Fri, 22))
Date:   Sat, 23 Jul 2022 10:48:34 -0300
Message-Id: <20220723134834.9693-1-matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <xmqqh738bq21.fsf@gitster.g>
References: <xmqqh738bq21.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 22, 2022 at 10:01 PM Junio C Hamano <junio@pobox.com> wrote:
>
> * mt/doc-config (2022-07-14) 3 commits
>  - doc: notes: unify configuration variables definitions
>  - doc: apply: unify configuration variables definitions
>  - doc: grep: unify configuration variables definitions
> 
>  Unify description of configuration variables used by individual
>  commands in the documentation of the commands and the documentation
>  of the "git config".
> 
>  Will discard (Retracted?).

Yes, feel free to discard this one. Thanks.
