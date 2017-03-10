Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9ED0C1FC43
	for <e@80x24.org>; Fri, 10 Mar 2017 23:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932675AbdCJXqI convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Fri, 10 Mar 2017 18:46:08 -0500
Received: from limerock04.mail.cornell.edu ([128.84.13.244]:50560 "EHLO
        limerock04.mail.cornell.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932179AbdCJXqG (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Mar 2017 18:46:06 -0500
X-Greylist: delayed 905 seconds by postgrey-1.27 at vger.kernel.org; Fri, 10 Mar 2017 18:46:06 EST
X-CornellRouted: This message has been Routed already.
Received: from exchange.cornell.edu (sf-e2013-03.exchange.cornell.edu [10.22.40.50])
        by limerock04.mail.cornell.edu (8.14.4/8.14.4_cu) with ESMTP id v2ANUvcH010365
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 18:30:59 -0500
Received: from sf-e2013-09.exchange.cornell.edu (10.22.40.56) by
 sf-e2013-03.exchange.cornell.edu (10.22.40.50) with Microsoft SMTP Server
 (TLS) id 15.0.1210.3; Fri, 10 Mar 2017 18:30:57 -0500
Received: from mail-qt0-f198.google.com (209.85.216.198) by
 exchange.cornell.edu (10.22.40.56) with Microsoft SMTP Server (TLS) id
 15.0.1210.3 via Frontend Transport; Fri, 10 Mar 2017 18:30:57 -0500
Received: by mail-qt0-f198.google.com with SMTP id b51so965883qta.4
        for <git@vger.kernel.org>; Fri, 10 Mar 2017 15:30:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=Dq3pXeiZSMlG11xGhalB/a2VjFijUYDshDaJATYWPqs=;
        b=mIR2qfd86q5P4VQWZQ44KlQjy4R9ZbcukytcziYvmh0WfrH5zQ0wnJH913xtA4eAy+
         ipjGpaxhIe+KLsS39ZOIgUXmyyLo8+LIgeYf7wTBccQMITfrMQsS/NjrL4HcfW/4WEDR
         ipvO0WKjGKWbnSWJOZOwGdYjjXoSxDVYH9lFRjvm/pra6X4xAbkuAzpXC2G8OJiNnnUS
         2hSv0WXFfAxs8SttT6IXKcYFM7kiUT9gfd31AK6tU7y0sOOAfWPlPQZ5o0R0YDN9UCBO
         544CyWakHJXPyfreJuF4pyNBt5tozKgpqMl0W4ks89pyBedtsosspElUV4IDqusKtBxr
         DyLw==
X-Gm-Message-State: AFeK/H1GDv35UQat2QYmijKp/DYTxa74YEtalK0O3TPk7LprEr8KFWkrlgI9+k7ZUu237QHOK/M9YioJpimmZ41w4bRZwtYXi8BPOeqWO/zIcTK9Rty2MYzwH1LLRSTs8u0B//6BqT+VSSgIvWs=
X-Received: by 10.233.220.6 with SMTP id q6mr23029908qkf.105.1489188656943;
        Fri, 10 Mar 2017 15:30:56 -0800 (PST)
X-Received: by 10.233.220.6 with SMTP id q6mr23029898qkf.105.1489188656778;
        Fri, 10 Mar 2017 15:30:56 -0800 (PST)
Received: from dhcp-hol-1198.eduroam.cornell.edu (nat-128-84-124-0-174.cit.cornell.edu. [128.84.124.174])
        by smtp.gmail.com with ESMTPSA id h27sm7359911qtf.24.2017.03.10.15.30.56
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Mar 2017 15:30:56 -0800 (PST)
From:   Devin Lehmacher <djl329@cornell.edu>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0 (Mac OS X Mail 10.2 \(3259\))
Subject: [GSoC] Move ~/.git-credential-cache to ~/.cache/git
Message-ID: <8BE1A361-32BB-4164-AD54-949555855C52@cornell.edu>
Date:   Fri, 10 Mar 2017 18:30:55 -0500
To:     <git@vger.kernel.org>
X-Mailer: Apple Mail (2.3259)
Received-SPF: Neutral (sf-e2013-03.exchange.cornell.edu: 209.85.216.198 is
 neither permitted nor denied by domain of djl329@cornell.edu)
X-ORG-HybridRouting: 9e0c991bb9bc9f90ae52f3794ca7ea5b
X-ORG-RouteOnPrem: False
X-ORG-MsgSource: cmail
X-PMX-CORNELL-AUTH-RESULTS: dkim-out=none;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I started working on this microproject and am not quite sure what is necessary for backwards compatibility. Since the socket is recreated whenever the credential daemon exits backwards compatibility shouldn’t really be a concern with regard to where the socket is located in the filesystem.

However, contrib/persistent-https depends on the socket being at ~/.git-credential-cache/socket, so changing the default location would break this. However, if we need to keep the socket at that location for cases like this I don’t understand how this change would be helpful in any way.

Is it safe to change the default location for this socket and removing the original location?

Thanks in advanced,
Devin Lehmacher
