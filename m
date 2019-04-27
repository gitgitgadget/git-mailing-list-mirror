Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2856A1F453
	for <e@80x24.org>; Sat, 27 Apr 2019 12:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfD0MP7 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Apr 2019 08:15:59 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:45170 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfD0MP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Apr 2019 08:15:59 -0400
Received: by mail-pg1-f181.google.com with SMTP id y27so2164108pgl.12
        for <git@vger.kernel.org>; Sat, 27 Apr 2019 05:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lDAOFmCk1lEVw9Foc0st1EMJ+f+yckjzBaQjIU1P6/Y=;
        b=Pf8Wy7EHktHWvZ9h35dtD+lBPmhQjtM2jDszBJ6XvDXStKuuuAioMsjsghFHsqXFd4
         xSQRjqAUMRMaUyjyfrFEfIHURVUH6ENMR+jik2QEnh6Hcd2KvaymXBJP93qcVoLu8tFY
         dRcs5j67yOLVCV5hIeBvlNPD1AJw4rFAj+klKmkbwtcdfcleWprzmdr5K75Uc+ExTbaj
         j9DQqPnsysJD4FLxR5OwZQPynpj42vlG25M5hYDj9EvfdNKCRvAaEKxYXtfgswHoD0rW
         kbp3QRM0dQTVbt0iA6QhEsJAXxarcc/0HD7a1UR69pkV2nd8VU4r7xU69qgubFTQ9z1N
         Yfzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lDAOFmCk1lEVw9Foc0st1EMJ+f+yckjzBaQjIU1P6/Y=;
        b=Y9kguzvBhyv+CSkiaFkYh/E9z+Q2qi5eaGraazr1uNJpunHhTKXMZlCBWDStzI1K8i
         MEzLtOheoaGEs2dhkVvoeMS4VSf+7v41cSahuUYRkwUp8D8Aeb5gP9ilYzq7jFDIGmUl
         Jnjr++NpjRKnCm5gnoOQlhljResWoMkh/h52hLTzYP91988rb4ZxRGJ3wrwO1TkaL4le
         qbXAx8aHgCpEqywo0ImFMed132SLpKqGOKS+VMz0Fq01Wqm2XhYd81SxDf9C1I5MFdiw
         vDDfrMPaMeW0KR5BTy9NjAe7RWV6FWHP77iZ5ia/1GxiDrCME+gyUCgAVA0sr5QiK0W/
         Vikg==
X-Gm-Message-State: APjAAAXt1vdA7cFIbq+zDC81rbwqEHBW5Wp4yk4o0UhCL4KbNHDmfupv
        nFVzcpDYC8vZ7EbeU7p+DSNTHaYx
X-Google-Smtp-Source: APXvYqw6Z0eSzn1Zgup4UkyxwbyyUu8fyGz4XDkSjTNlxAvaZDxSfihZCLMS3iBtweDgEhbCHIdaxw==
X-Received: by 2002:a63:1550:: with SMTP id 16mr49893608pgv.132.1556367358563;
        Sat, 27 Apr 2019 05:15:58 -0700 (PDT)
Received: from archbookpro.localdomain ([216.9.110.6])
        by smtp.gmail.com with ESMTPSA id w23sm40225686pgj.72.2019.04.27.05.15.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 27 Apr 2019 05:15:57 -0700 (PDT)
Date:   Sat, 27 Apr 2019 05:15:55 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Andreas Heiduk <asheiduk@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 0/3] cleanup revisions.txt
Message-ID: <cover.1556367012.git.liu.denton@gmail.com>
References: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18c8ed70602271a28c93df922eb3da8fb7563e2e.1555913472.git.liu.denton@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review, Andreas.

I mulled over it for a bit and I think that marking optional arguments
with [] would increase the clarity of the documentation so I went ahead
and made this change across the whole file.

While I was at it, I found some instances of "<rev>" written as "rev" so
I fixed those too.

---

Changes since v1:

* Added patch to fix instances of "rev" to "<rev>"
* Marked all optional rev arguments with []

Denton Liu (3):
  revisions.txt: change "rev" to "<rev>"
  revisions.txt: mark optional rev arguments with []
  revisions.txt: mention <rev>~ form

 Documentation/revisions.txt | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

-- 
2.21.0.1000.g11cd861522

