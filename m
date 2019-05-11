Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=0.0 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MISSING_SUBJECT,PI_EMPTY_SUBJ,RCVD_IN_DNSWL_HI shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CEC6F1F461
	for <e@80x24.org>; Sat, 11 May 2019 15:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728683AbfEKPya (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 May 2019 11:54:30 -0400
Received: from mail-pl1-f169.google.com ([209.85.214.169]:35756 "EHLO
        mail-pl1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbfEKPya (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 May 2019 11:54:30 -0400
Received: by mail-pl1-f169.google.com with SMTP id g5so4254614plt.2
        for <git@vger.kernel.org>; Sat, 11 May 2019 08:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:from:to:mime-version:content-transfer-encoding;
        bh=COkengh+ZmVm4QGiynDPf71pwZgVTRVSKlyvc8TRs+o=;
        b=d36GTUCbbQVkdnUWPozTVfXuvO1j38CZu726m8evLMLtcqQn1GTkmT2wcHdCN69oDr
         ctouqMDjwxWZvP2qA/rAvhMtrjPVDNjuPGiDh5PNaqkQp25MYdw9zgGbSRrzU3YrDRAm
         lUJ7J6lshw7YO7D1qPGVjzeyR6aWb1etuXBOgFwtdzgNodpHESO/RojV1QMSanWSGSGq
         gFMGt2Om2Mthaz0Jy+dTfzd6pAWN4kJYUbBbLQNs7MsH6GlML0WQsqOFmyS83bHdv4aX
         VOsczFf+A+DJJDRHBQk+a4tM1EjkeTy2LbNRmWa9ZlQE/0S/VPfFDOQxeLHf9PvYtWnu
         i56w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:from:to:mime-version
         :content-transfer-encoding;
        bh=COkengh+ZmVm4QGiynDPf71pwZgVTRVSKlyvc8TRs+o=;
        b=iS+bl72z6ChCZ+PDIjPhKplGnNoWdRlayD6JXhVPKZH5QuKIUya9MRMwuhgyd/XIrn
         FAfG/znLotr+cTccoMwi0tgK/Publ+sJRovAy7pvNRB/Tzpvsk72QFU9ZijhkGv2alDj
         Nk+uDBnkux0EV5YO1myA/MLCjwkl9w2yeW22FknDE7t76scOVaBPtG0AOJ34sEtsbf3P
         AFRE8DkcEbAdKW8cGai55ZjBL/4dZZsEXryUn2JMQfZFOATk+qFTVLBrQbQ2F/k/wkrd
         z0NoptVt4uINcUY/Q9otZ1uQbAS43lI0XZpeI+JB+z/s8wQKHEQRw95rAmV8bKqG7nu+
         fgDQ==
X-Gm-Message-State: APjAAAW2nUKyXrryFVTnGdJE7+FTKYNVxDlqspMD+xypHd0PF++FMQRS
        B1ZsQzuMRnE5CCqkVeo5XIyXmsr5
X-Google-Smtp-Source: APXvYqwkJ5UPk4HU+UjkmKranKikn8Le4cmPDALEi0Fbpml9d66VsbL9CdlYOLbs9sLTlNYUvCkyBw==
X-Received: by 2002:a17:902:b589:: with SMTP id a9mr21278930pls.66.1557590068739;
        Sat, 11 May 2019 08:54:28 -0700 (PDT)
Received: from ?IPv6:2001:44c8:455c:da52:933e:bfef:d899:d240? ([2001:44c8:455c:da52:933e:bfef:d899:d240])
        by smtp.gmail.com with ESMTPSA id u123sm15081108pfu.67.2019.05.11.08.54.26
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 May 2019 08:54:27 -0700 (PDT)
Date:   Sat, 11 May 2019 22:54:24 +0700
X-Priority: 3
Message-ID: <-6qbj18-j08oo4-fma0us36ltvq-om95p1labl34-6hnvggq4l3mc-8vox8h-kvzwov-ld8h8t-m22xep-btffnf971oup-f5l01b-ynnar9-1em6q5r79nfyusaoj-f7xz15-xacanc-42o02knaac42r0bdme.1557590064427@email.android.com>
From:   Sirawan Primvihan <new0887822911@gmail.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

CgrguKrguYjguIfguIjguLLguIHguYLguJfguKPguKjguLHguJ7guJfguYzguKHguLfguK3guJbg
uLfguK0gSHVhd2VpIOC4guC4reC4h+C4ieC4seC4mQ==

