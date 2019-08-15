Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MISSING_SUBJECT,
	PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D2B321F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 02:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbfHOCEt (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 22:04:49 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:53871 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfHOCEs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 22:04:48 -0400
Received: by mail-wm1-f43.google.com with SMTP id 10so52890wmp.3
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 19:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:mime-version:content-transfer-encoding;
        bh=2LsBC7a3tpm40H3OeR6FqizbDmyrXC8tg9SVIVTZhXo=;
        b=GaiMIjEjTrEX1PJsQPtG6MfznCtMR0BxnSKyuz6Nq8LkWqz4oYLE1lM1QBJKQ9FWKB
         M/vhLWpxPT0FGBhJRLEFSuKSvzRMQahp9P8diATR1KmqRx4KFUZV7YWkUtahv5TAWrxb
         CkAYM4dOwhakEz7HxJWSxjbiDRC6pcrWhM5jKpmWOaOe+uj3sYMe1OfF9jnZJgk25w1S
         xdxugVbA41kKW7XcwjLFv2sTIPlWwLz8MZXi8X0GCoe9K3T+Ga4l7pz7q8OrVJYQNTLn
         0Q02TdFIHB9iL1BhtkWt+97fA7nomt4a/nTPx2yk6w0D0tf18cwj5NWQf+8IW7TyUdTo
         QEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:mime-version
         :content-transfer-encoding;
        bh=2LsBC7a3tpm40H3OeR6FqizbDmyrXC8tg9SVIVTZhXo=;
        b=itf9dtI3a8JBcJtNfIKepzuJpmFATOeXwtOGzn9VeR2z/2o5qYWYAjbsV5bjKgnJYP
         c2DYgItjsObXaVgSax4Pqnd9XNUqV1MLD5jfUhbq48QMh2bq9jP/olvgW45/SgecBmgc
         VqKRftZu2wYynjLK6jaI/9zlFDRMi40oMR64on/9tyTdh2VJIyPWWUysia3Qqtkeq5Wi
         mzJ9R1eTBgymV3/obRpckjocLyk78532oDcHB/enUo2v9lYZ8ncPCTHhbgnVE9lqtsFT
         9+7TZeT2qfLijgMXPvJQpC5jti14KN7Xewc8V93vT+x+vI085e79p7uVTB52JcgzTtyp
         iktw==
X-Gm-Message-State: APjAAAXkobg7NmIW/qxtxcQaDXCNriYdXtOYYN9N0Fc2z++PD8EraZu/
        ZlbTcrYP/QteZu2aC88H9R2qbBzqSg==
X-Google-Smtp-Source: APXvYqyAVSIVEFwEMcYAFiZMqnLBX2sdaLlp3r5JcIfeozGs3kdvBVn2+sioUoJC/YdjIhBXVyw3SQ==
X-Received: by 2002:a1c:b342:: with SMTP id c63mr138900wmf.84.1565834686915;
        Wed, 14 Aug 2019 19:04:46 -0700 (PDT)
Received: from [192.168.1.34] ([78.168.212.170])
        by smtp.gmail.com with ESMTPSA id z25sm64334wml.5.2019.08.14.19.04.45
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 19:04:46 -0700 (PDT)
Date:   Thu, 15 Aug 2019 05:04:43 +0300
X-Priority: 3
Message-ID: <-di2fdtgdyo0l4l7ybqangg6fbwndhnoac2fagjvym5jfixsr-4jdx7fcucb4h-j823k7-jjunasjru5cj-xvqq5yw1fhq8hul08d-fe06db3vdruxudn0wcj4mw57-fb4p3o-d4fj3o-qt575goasrk0.1565834683582@email.android.com>
From:   Sevil Olcar <sevilolcar818181@gmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CgpIdWF3ZWkgTW9iaWwnaW1kZW4gZwpUaGlzIGRvY3VtZW50IGlzIG92ZXJ3cml0dGVuIAoKCgoK
CgoKCgoKCgoKCgoKw7ZuZGVyaWxkaQ==

