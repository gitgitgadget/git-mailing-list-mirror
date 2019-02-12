Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 763C91F453
	for <e@80x24.org>; Tue, 12 Feb 2019 09:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfBLJ4K (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Feb 2019 04:56:10 -0500
Received: from mail-pl1-f169.google.com ([209.85.214.169]:40108 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbfBLJ4K (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Feb 2019 04:56:10 -0500
Received: by mail-pl1-f169.google.com with SMTP id bj4so1050252plb.7
        for <git@vger.kernel.org>; Tue, 12 Feb 2019 01:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fx19fz/I2Rf/Dk7eNj7XvPaawJ+8MB4Rt3J8eCsDW+c=;
        b=b/K1RsBtod4DAQS3acYN+Tx43zYofydj2TrZF/mJneBZ+E39aZPJpkXAe4ZAOfYTIK
         8eF3GFmoiSPm4vdjgZsWNAhjDuh+lC0h8qPdzt0JkrYV/en8ijcKC7CU712OFrGW3Q7o
         sHuG8woN+X2re2rYlQqTYGGCEJUbdht0BoVFV2imv8M8k8Jw+9Ecw/rC1zLq128YnGBq
         +5EJ+VefmA6788snWQjGvwsbexDEqTaVa/JxBNOD7tSr4Jqrlum7vSpIFviFPfqCArfb
         W5nJWN3LHuoWwUxrcbdjwZ8eA0188hDFaclwKZHRIC/f8eMEXW5WiklOJr6xqJQ/aLuj
         5VxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fx19fz/I2Rf/Dk7eNj7XvPaawJ+8MB4Rt3J8eCsDW+c=;
        b=pegXLrgwpTHYiF+cE3e58BgDinPJ7364WEp+2SZhhP97pQGsU3E0ED93kF4WRNaP7U
         onzG1cpny5XAxKNFlHP4not+QYUnvAvOAdFNsGRnXkfkY5HXynBpmXY8NbHou7UrEsHD
         oobgA25oJAUZ2vxQhTX+1fKYAq2nd2ms65qvymAvcyPfpGYRi4IXrQIq7q1U9PD+bCSQ
         eCMKcmzbp0fA5uQt6MtamyJDwjxWoBgsVar5u5vJHv/9HCWAIxpfanTpaR4Uoylt6RRk
         QIHfsPnF6a5T0aiXddK/TMF8JJaVrf8ZTkTLJUSgShFa14HZgKpaFSmY8NWZVGgEYbCb
         iXcQ==
X-Gm-Message-State: AHQUAuYrzbfrJkVlTyKInJqCldm3Y/rN8wpnryHBpfwLZGo02qQhR1XD
        SRwiADlByMmo2nztj2btWAoVF4CU
X-Google-Smtp-Source: AHgI3Ibo2Qk9O3IwdmMF+kGL3h4S7Lk4cv4FZTdsRki6624AnN6dIoTJRd8aqroTa4jK4jNxgUK12g==
X-Received: by 2002:a17:902:7202:: with SMTP id ba2mr3109847plb.147.1549965369114;
        Tue, 12 Feb 2019 01:56:09 -0800 (PST)
Received: from archbookpro.localdomain (c-73-222-73-77.hsd1.ca.comcast.net. [73.222.73.77])
        by smtp.gmail.com with ESMTPSA id a13sm17011576pgq.65.2019.02.12.01.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Feb 2019 01:56:08 -0800 (PST)
Date:   Tue, 12 Feb 2019 01:56:05 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com
Subject: [PATCH v2 0/3] Document git-submodule's default behavior
Message-ID: <cover.1549965172.git.liu.denton@gmail.com>
References: <0b62f65a8016c41b96aa6caead366e1ed9dda333.1549944164.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b62f65a8016c41b96aa6caead366e1ed9dda333.1549944164.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the suggestion, Duy.

While I was fixing that up, I noticed a few other discrepancies so I
decided to fix those up too.

Changes since v1:

* Incorporate Duy's suggestion of "The default command is '...'"
* Fix additional discrepancies between git-remote and git-submodule (on the
  submodule side)


Denton Liu (3):
  git-remote.txt: be specific about default behavior
  git-submodule.txt: make subcommands underlined
  submodule: document default behavior

 Documentation/git-remote.txt    |  4 ++--
 Documentation/git-submodule.txt | 22 +++++++++++++---------
 git-submodule.sh                |  3 ++-
 3 files changed, 17 insertions(+), 12 deletions(-)

-- 
2.20.1.522.gd8785cdd01

