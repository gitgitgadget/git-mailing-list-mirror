Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEC012047F
	for <e@80x24.org>; Mon, 24 Jul 2017 02:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751891AbdGXCB4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Jul 2017 22:01:56 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32818 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751782AbdGXCBz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Jul 2017 22:01:55 -0400
Received: by mail-pf0-f195.google.com with SMTP id k72so5909814pfj.0
        for <git@vger.kernel.org>; Sun, 23 Jul 2017 19:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=6mS50LUE2j84MTyyiksQG4FG2uQ4zK0jUy0Zm/V7XN0=;
        b=jiXW8A565CFgXHwWK3DXtPAf3/No3LNfGJjXIzh9dt7cd3BlBRvQo/HChqE9JEj8XF
         MHj31qzMdfCwzCv67zxb2kTpzGQ1ppMj9zkyWqEOm7jmRgN+4XNuQLeTAbfMIZp4GxZv
         HGsvlHXzoorWSRLl/9M00xKYgfsLyzI95PatiyfnW3YRBu9MERj/l0po1nEhF8qG+n7F
         iN5ez59mZQR1/GriT1F9kMAxPWKe8isRGqyzJK09dLEDkcMq9fBVESA46TzFseEgBo3D
         Db2UyH/Wd4RXBS4zNgYhksPqbyGlJL8hEtXhl/Bn9DNu5AGNzJYAqZKOwflMZp9FP99o
         PmFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=6mS50LUE2j84MTyyiksQG4FG2uQ4zK0jUy0Zm/V7XN0=;
        b=llbGLM7fBW9CRXOtpHlVvGxXUKR2k9I+EAsclKatOS0MXRyvPkD9PfFhy77pJlnjts
         6BvKlT7FWBmkNODVeZsCt8tbYTHsuUq8TU4imuphKwU8a9OwyHgAWHB3V1Rd3QilMSyo
         eyKw8tazVq5P8YnwvJfS3aABwj3wPac2Kr82KNqM0opIc0I9hLp8uIfOci/cnGVPkIwx
         qy5gZWN2Y0wRBDuieUx6gENQIPn5NXGMLcfuRZskc/C8/s3cr/DlIP4cxc4Vvj8MWtKy
         U/9pCT1BaYh+C+rxwHHwPPi2JicC0c0N73lRJkp+EunwN3or+fid8SMzoisqSEexxFz/
         hW1g==
X-Gm-Message-State: AIVw113xaTSl4fr+H5u12w0ld0bWXUPzmw8+rRY6u8DzSlB9eUa5uYH2
        Xn+PSmyYnGosb/KbDHk=
X-Received: by 10.98.102.85 with SMTP id a82mr14694235pfc.82.1500861715003;
        Sun, 23 Jul 2017 19:01:55 -0700 (PDT)
Received: from [10.45.43.99] (220-245-230-18.static.tpgi.com.au. [220.245.230.18])
        by smtp.gmail.com with ESMTPSA id x126sm363853pfb.179.2017.07.23.19.01.53
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Jul 2017 19:01:54 -0700 (PDT)
From:   Farshid Zavareh <fhzavareh@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Should I store large text files on Git LFS?  
Message-Id: <AC260BC2-FED8-4811-9F5D-220EF1DAAA53@gmail.com>
Date:   Mon, 24 Jul 2017 12:01:50 +1000
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3273)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey all.=20

I'v been handed over a project that uses Git LFS for storing large CSV =
files.

My understanding is that the main benefit of using Git LFS is to keep =
the repository small for binary files, where Git can't keep track of the =
changes and ends up storing whole files for each revision. For a text =
file, that problem does not exist to begin with and Git can store only =
the changes. At the same time, this is going to make checkouts =
unnecessarily slow, not to mention the financial cost of storing the =
whole file for each revision.

Is there something I'm missing here?

Thanks=
