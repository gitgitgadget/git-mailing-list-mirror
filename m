Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 919A320248
	for <e@80x24.org>; Wed, 13 Mar 2019 09:21:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfCMJVJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Mar 2019 05:21:09 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44546 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfCMJVJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Mar 2019 05:21:09 -0400
Received: by mail-io1-f67.google.com with SMTP id u12so1001848iop.11
        for <git@vger.kernel.org>; Wed, 13 Mar 2019 02:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DxRJ8qk7DW1onIyZ6wrA87hzoB/94u/gSt+9rZrb4DE=;
        b=k3/1Q3GPhDkjLJyxct9T0PY9fYeQZtR/HQdu4GnqUc2+pXRADK3HoLaBb06zNW/JsI
         KrklCxUBJbjIG3wzxNPqYavc3YCWEiSDcP2SPvfIVtvgfqZl8tnZ11/2NXuOuN90JRax
         pB8HHIDAIT8XFpP98sDkoisRPDPqAvnvje7ZxYYaw39gPlsS1VR6RfpZ0p0n2VC4Dno7
         p1NbUDkgmlbmm6PnfWYBnDBF5BGHztP7Bm5hnJ/8GTANRJ3NypHZca58iVzboEMcCbxu
         KU8z2p4uiaEiI1h+24nf8hUx0XU5htglFtkz2eJRqbY26O7AaF7tJj9qbxqgYrYrZaiV
         unew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DxRJ8qk7DW1onIyZ6wrA87hzoB/94u/gSt+9rZrb4DE=;
        b=kgUYkXnHzskIabHRphfn8Z3Lxef+lbpUgErl19S20rdQeVeGd19fABsc+SkPb64jnR
         dqY0c91lpRcIWs65G71GVGWhQhcqlTACxy19I5GYWay0AL8/8z+JN1HzVzFIuGXLqhks
         sPBwucILtcq810B79xFvUhwOnO1aQG7OZgNTp3Wa0M9PVIwa3lQ+pGMGeSFHDYSXVkSE
         P9CFtlo+Np08DWRU6ytUIIYW90DORyhat1X3x4QMg/ks89SDarDzmwpMbKmhE1AT9uUX
         qK/vEdUl2S6kj8dkPUcH9DM2eifPJ8h3MVbCVAjnUexWxt5M2CYxHqcbG+dubjHUTir0
         gNSg==
X-Gm-Message-State: APjAAAWjCWE1Mkh25KLn3AK/uwmoEcAllcvOm3uRZUuybMwPxHa7OkQQ
        ozqYs12FB7Xqf9k9CV6gWeC+gnycfeK/6U7k47s=
X-Google-Smtp-Source: APXvYqylCujxDAq4pYLXmNSuwh9X4wLZ8mz4iTtEQZLjSX+fn5j6YTKMPWWTiIZrXl3HFzJA+sC52ee3pqsENRDTz6o=
X-Received: by 2002:a5e:d616:: with SMTP id w22mr7620560iom.118.1552468868422;
 Wed, 13 Mar 2019 02:21:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-10-pclouds@gmail.com>
 <nycvar.QRO.7.76.6.1903131005180.41@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.1903131005180.41@tvgsbejvaqbjf.bet>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 13 Mar 2019 16:20:42 +0700
Message-ID: <CACsJy8Ce3Sn7sWDOqGPeOk7JiXg+3KSaox4PFZxfh90B6E81_Q@mail.gmail.com>
Subject: Re: [PATCH v1 09/11] t: add tests for restore
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 13, 2019 at 4:13 PM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Duy, have you thought about making use of the CI builds? You could catch
> those bugs before they hit the Git mailing list...

Using Azure? No.
-- 
Duy
