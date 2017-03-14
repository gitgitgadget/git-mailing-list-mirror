Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E3A220323
	for <e@80x24.org>; Tue, 14 Mar 2017 06:18:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751047AbdCNGSA (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 02:18:00 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:33539 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751041AbdCNGR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 02:17:59 -0400
Received: by mail-qk0-f196.google.com with SMTP id j127so40065607qke.0
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 23:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4Zc8o/pYqaXLnw2T2l1oWHVBO30ddAAGFNp73Libxt4=;
        b=S/WqiNJWb1DZstXPM0jNdplD1BgkKK0OdOM9rxzbZD2sxYHaYT+LuDk6q9DH1rJVR4
         3cbWIgUDzWoEcvDgBE+CBO1MxtuiDeXPXtg7xDU2uyLRDKx/1736l96VM+/7kxmD3HbX
         0WpPAj1NrvyyaYkwFDjMySW8nvkReKU/I1ULE0ODA53guJRa9n5kJyn62IVl0zNPy0Wh
         8aD8dZ/HJR/yuVlFz1pPhriGSxaTJmscMcQrLpphDim8sUJbDZde3kSASpm0pVawWIk3
         k1mHM0RteDPQf1MrxxtUR6oUsR6q3vjkncSrtQKsxgoH8I7ufwmBno+kPLAauh9nM0oL
         kgdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4Zc8o/pYqaXLnw2T2l1oWHVBO30ddAAGFNp73Libxt4=;
        b=L3Jb8pXynfpdrvLKHdAekATXX5ph1S4noa4Y9nJguPTk/xbsP57B/chBfizx+VH+oM
         LYpXvsqVpqMkcmsxCICgnVpk5NA4Od85nntqKPKCU7sCU6X5zQN0+cPBPe9zYQt5mfic
         iLODl/H+STJMzYSTW4ld+DVpWAhtnZr9TPRGh7afHFSvPYqb73Hp9oGvzqgDDF0k6zDQ
         xgAAJzjlP2FyIbjLboLiOsLnVHrSv9w/RdRcrSJ7U1pVgAnKLLCd/6GKoYwsafeOu4BO
         LVWjOXH1EAkP2awWd9NuJFQeIDfzB4G+NNiRetxcKBipGXUGYVLGNOK+4+EWfbxvb3Rn
         Ft5w==
X-Gm-Message-State: AFeK/H0VPuvK1fulCsRi0knAFfgU/bN1+dn4cODvUs9YENp6cuO68yJiGCUspBircfUbnA==
X-Received: by 10.55.111.2 with SMTP id k2mr38017549qkc.138.1489472277726;
        Mon, 13 Mar 2017 23:17:57 -0700 (PDT)
Received: from dhcp-mcfad-10356.eduroam.cornell.edu (nat-128-84-124-0-116.cit.cornell.edu. [128.84.124.116])
        by smtp.gmail.com with ESMTPSA id z29sm13817948qtz.67.2017.03.13.23.17.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 23:17:57 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: Re: [GSoC][PATCH/RFC v3 3/3] credential-cache: only use user_socket
 if a socket
From:   Devin Lehmacher <lehmacdj@gmail.com>
In-Reply-To: <xmqqo9x4jsmi.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 14 Mar 2017 02:17:54 -0400
Cc:     git@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <AAFF0938-E7F7-4EEE-9338-CD9049E51AE2@gmail.com>
References: <xmqqa88orgjd.fsf@gitster.mtv.corp.google.com>
 <20170314003246.71586-1-lehmacdj@gmail.com>
 <20170314003246.71586-4-lehmacdj@gmail.com>
 <xmqq8to8lj59.fsf@gitster.mtv.corp.google.com>
 <xmqqo9x4jsmi.fsf@gitster.mtv.corp.google.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3259)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Also I think you would want to use S_ISFIFO() and/or S_ISSOCK()
> macros (I do not offhand recall which one credential cache daemon
> uses), not the S_IFxxx constant.

Huh. These macros are not on the man page for lstat.

> Having said that, I do not think ~/.git-credential-cache/socket is
> the right thing to test.  If the ~/.git-credential-cache directory
> already exists, it is likely that the user has a set-up that works
> well with "socket" inside it, and it is safer to keep using that
> location.
>
> On the other hand, if that directory does not exist, we know it is
> safe to use whatever new location---after all, the lack of the
> directory tells us that the user has never used the traditional
> location successfully ;-)

That makes sense

-Devin
