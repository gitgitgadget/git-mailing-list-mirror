Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CD7E1F5FB
	for <e@80x24.org>; Thu,  2 Mar 2017 13:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbdCBNO7 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Mar 2017 08:14:59 -0500
Received: from mail-ot0-f180.google.com ([74.125.82.180]:34490 "EHLO
        mail-ot0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752110AbdCBNO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2017 08:14:57 -0500
Received: by mail-ot0-f180.google.com with SMTP id x10so51533003otb.1
        for <git@vger.kernel.org>; Thu, 02 Mar 2017 05:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Vi5loKoZpbCM11nzSNs5jK+wZz9YO/D/nHkmGADT1ZE=;
        b=Nygh+TDHLtcmB/jJF9RkLWjJTm/gSc9zpqkpdULSE4CJjefHV934Nef/HNr/ACwla0
         9dU0A1j+8lTM9UlNrhqAwEZ1vyMoWBTqjCnDsLC060zh+eJEKf5hWdFmPa1X2HcwJDNI
         OTYC8pJm9Fh9MnaL9Y9uDzRG/Cw0fikf7ScfTMAFPTxzwqHTbf5mNAFtuxHbvXsvSTN2
         mZMQRslLtlxRR0wnBc1pZi6sRtuxfCgKPpL/US6bIpKw76WdqhDZwOTYr/ugGscHIZaI
         re+IMYeNaqi3O4gObS/ELkVkUqqLVu+Hw+aKD26Z2HVu5dDs14ay7aO8iVJ9hPISQD4B
         UzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Vi5loKoZpbCM11nzSNs5jK+wZz9YO/D/nHkmGADT1ZE=;
        b=dgbH+eS2NyFbO6MHuv1G8MUI42IBGaYJi7mmrLSe+xuIO1aF7BKa4Cv+vpwYFweWZE
         bwk7NVjHSTfxQFwVjL8A4Yt9N6mlwG8VZn4VcYD4BnjLmkw3+qxlt5eLZ8sHNmDdUA/J
         HvIuZInWc0IFh4xHQW+nG7SatoWv0g3QEwXZB0yuAxzcHmlrwEcMxw3eXm2tr8qUuWPR
         L1inLl0DQd6RP4r7Q5C8ELC0TwwPCpDRYpfaGNYEu7fHSAGA3IlXsVWcvamObr2/RAj1
         cpDo/7SVmc0h0AlVOKMFPTuJWh5ngkg6ug6pQlA5U6/ChKg45nF7UdBhafzoWDMKZOLE
         o1nA==
X-Gm-Message-State: AMke39lRcxvQKsA1EdScBN6elOERRxbn+ZVu8oc4nTbsoAowb6G6aCC6vv1insUAdTNEO+vCPm9EFlr2zQf9tw==
X-Received: by 10.157.18.132 with SMTP id g4mr7718076otg.10.1488458360627;
 Thu, 02 Mar 2017 04:39:20 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.158.84 with HTTP; Thu, 2 Mar 2017 04:38:49 -0800 (PST)
In-Reply-To: <51f2ba5a-38c9-17eb-e845-3a84b65c7029@alum.mit.edu>
References: <20170218133303.3682-1-pclouds@gmail.com> <20170222140450.30886-1-pclouds@gmail.com>
 <20170222140450.30886-25-pclouds@gmail.com> <7e5ef9e7-bd90-1917-d8eb-c6310c2744ab@alum.mit.edu>
 <CACsJy8BOY8jsCrDYESJ6Gwy_p=J=c8m1qe64w18HX1Cv2AaYnA@mail.gmail.com>
 <8f4ec174-9060-0896-5135-bb50229fe149@alum.mit.edu> <CACsJy8DyjWC5WUE7=dWK-mi_piGZJf7L1B0t5RUROvqDS+aP5g@mail.gmail.com>
 <51f2ba5a-38c9-17eb-e845-3a84b65c7029@alum.mit.edu>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 2 Mar 2017 19:38:49 +0700
Message-ID: <CACsJy8DkZFMtBST9pmBO=r71FUaZeMKweJDQ2xuMAV-APFVWFw@mail.gmail.com>
Subject: Re: [PATCH v5 24/24] t1406: new tests for submodule ref store
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 2, 2017 at 3:16 PM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> The for-each-ref iteration is defined to be sorted by refname, but it's
> true that the for-each-reflog order is undefined.

Thanks. I'm going to add a few lines about this near for_each_ref and
for_each_reflog() then, assuming that this is the desired behavior,
not a bug. (Another patch, because I'm not happy until it gets 30+)
-- 
Duy
