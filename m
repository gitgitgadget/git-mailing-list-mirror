Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 049B520C11
	for <e@80x24.org>; Fri,  1 Dec 2017 05:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752617AbdLAFXd (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 00:23:33 -0500
Received: from mail-wr0-f175.google.com ([209.85.128.175]:41987 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbdLAFXa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 00:23:30 -0500
Received: by mail-wr0-f175.google.com with SMTP id s66so8777357wrc.9
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 21:23:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9VFrhlt9I3+P1dOi5SQjp2921hbHRpnOMrtWDTCEyIw=;
        b=ua3wONSuJuJOH4ioOkoveRv8GgETp3DZmUjQvCKDI/QB+JJ4Sh9PBGSsWYWVMRTOxQ
         n5JoxfMqd8vEe2HCZtKBr5WckFldeVPPc3fQib+wVu8eDNSH3zlZtUVH5GMtqkfnuPlr
         5+t6kPUWTrp0gNEVqUzH4o7HIZ/F0SXW5tQ5LMyVRGQBQRi/WCl1i3zIP0GVbx+hzq36
         nUVWPj7APzUm4ec/ymae1eTsAO/5rLD6FrghzDp57fdyn0xcbLiaWNtUA6f6Ca4V/3HD
         /JBbdMVYnl8ObeSqK8Du7tS4nqyh1yE5xv0vZVjZ0xesWb+DRuvj+F2xUyfowxqIQCkD
         HJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9VFrhlt9I3+P1dOi5SQjp2921hbHRpnOMrtWDTCEyIw=;
        b=nGg/nDVp3ptJhZRH9u7kQyMbLJ856CyMPRkcZWhd1llWPFKPJ7huze+FVtoCNbEorj
         4S/EdpiRDAkj7gJjEnhWv9AyiX2W7O56wTCBWVbOpvw3pV8D6b8m70s5O5gNlTTNpfQx
         0YOTR3u2KH602rOHMLXl64jchOOaIIlKdMotpUWSHVHfQ0hiwHcMeVlG8PAmVCw2CyxP
         L4hIci6ansxe4w5spyMPhbQmcnN7MTipcVS2j8MPbICQHkJDIutddHYtHLx0g5rGaQez
         GUrGOia6S5g1rTt0yfVfnO3forxPi2gzlx5ZulNhN/KOjofaj9j2hJLGNfhKD1szuLea
         CxDg==
X-Gm-Message-State: AJaThX7FsbmmsMogyH+j4CmEw3Wv9NLKLnKnasm0qws1RWC+fzmFTvQF
        PLnPu/pfg8dku1/cISuIZtU=
X-Google-Smtp-Source: AGs4zMbF1pJBfiuBIGZUUSnMaEA6T3/YmM6Bf4YkCNWQk/cYd5Pm7OLLCDdFW5nMMUVC9JLCnm0YkA==
X-Received: by 10.223.136.164 with SMTP id f33mr3746137wrf.162.1512105809534;
        Thu, 30 Nov 2017 21:23:29 -0800 (PST)
Received: from ?IPv6:2001:4c50:35e:4100:c9a0:7388:2d59:22d2? ([2001:4c50:35e:4100:c9a0:7388:2d59:22d2])
        by smtp.gmail.com with ESMTPSA id l140sm231057wma.5.2017.11.30.21.23.27
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Nov 2017 21:23:28 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: Bare repository fetch/push race condition
From:   Dmitry Neverov <dmitry.neverov@gmail.com>
In-Reply-To: <CAC+L6n3D1O+7U2F4sn6O+UD25t6hMGECMYZWgb45_FW6TBLz1g@mail.gmail.com>
Date:   Fri, 1 Dec 2017 06:23:28 +0100
Cc:     Git List <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <94F893CA-8739-41BD-82F3-C68F9346E4B6@gmail.com>
References: <CAC+L6n3D1O+7U2F4sn6O+UD25t6hMGECMYZWgb45_FW6TBLz1g@mail.gmail.com>
To:     Dmitry Neverov <dmitry.neverov@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for misleading subject. It should be "Race condition between =
pushing to and pushing from a bare repository"
