Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C125AC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 15:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbiKCPAx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 11:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbiKCPAt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 11:00:49 -0400
X-Greylist: delayed 599 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 03 Nov 2022 08:00:44 PDT
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261F95F70
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 08:00:43 -0700 (PDT)
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
        by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4N361L00WBz3tLx
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 15:42:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rd10.de; s=key2;
        t=1667486566; bh=1/4elYNo/09AUdP62fO1a4sg0lMmYAEFx4Qzo6KOdBQ=;
        h=Date:To:From:Subject:From;
        b=EIDgEiQYe/6HSwbjQnaEHo2plWVYNQFJ26Zt/PV3PJInCSM8T2X8ZXpEYMFfps79Y
         fDPrk8kQ1fBLIutBPhyLC1fh5QpHKLM9VxSAF7oJzExhbhlphkf7pPz3fP3IVQD5S3
         iooRJDn4MQIn2M6lG4284gaeaNzBxYAZXs9fg5DHe6Yi6y8Y1N2jUQK8I0FIiBb1WY
         4ncbyOMVAkgJLfaf24uxXcOcs5J/hbaSLD8mdj9X0RQaUAySs2c262DV785YIv2U47
         Z+ScMoeoHko1Di4kz3k4E6pWy5/aYj3PaiWXABmX/6m8aLooRBR1bRo4qB4T7nPH2p
         VjeYHj2wOWU5w==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
        by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4N361K6WQwz3tLv
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 15:42:45 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at policy02-mors.netcup.net
Received: from mx2eb1.netcup.net (unknown [10.243.12.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by policy02-mors.netcup.net (Postfix) with ESMTPS id 4N361K3LdMz8sbs
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 15:42:45 +0100 (CET)
Received: from [IPV6:2003:cf:cf0d:9b00:22b1:5275:edda:907f] (p200300cfcf0d9b0022b15275edda907f.dip0.t-ipconnect.de [IPv6:2003:cf:cf0d:9b00:22b1:5275:edda:907f])
        by mx2eb1.netcup.net (Postfix) with ESMTPSA id CEC8B1400F7
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 15:42:44 +0100 (CET)
Authentication-Results: mx2eb1;
        spf=pass (sender IP is 2003:cf:cf0d:9b00:22b1:5275:edda:907f) smtp.mailfrom=rdiez-temp3@rd10.de smtp.helo=[IPV6:2003:cf:cf0d:9b00:22b1:5275:edda:907f]
Received-SPF: pass (mx2eb1: connection is authenticated)
Message-ID: <b200ecb4-3e01-9bf1-f27b-0beb05c11cb0@rd10.de>
Date:   Thu, 3 Nov 2022 15:42:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To:     git@vger.kernel.org
Content-Language: en-GB
From:   "R. Diez" <rdiez-temp3@rd10.de>
Subject: git instaweb but not in daemon mode
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <166748656503.20096.8506099660059245487@mx2eb1.netcup.net>
X-PPP-Vhost: rd10.de
X-Rspamd-Queue-Id: CEC8B1400F7
X-Spamd-Result: default: False [-5.55 / 15.00];
        BAYES_HAM(-5.45)[99.88%];
        MIME_GOOD(-0.10)[text/plain];
        FROM_EQ_ENVFROM(0.00)[];
        MIME_TRACE(0.00)[0:+];
        ASN(0.00)[asn:3320, ipnet:2003::/19, country:DE];
        RCVD_COUNT_ZERO(0.00)[0];
        RCPT_COUNT_ONE(0.00)[1];
        TO_DN_NONE(0.00)[];
        MID_RHS_MATCH_FROM(0.00)[];
        FROM_HAS_DN(0.00)[];
        TO_MATCH_ENVRCPT_ALL(0.00)[];
        ARC_NA(0.00)[]
X-Rspamd-Server: rspamd-worker-8404
X-NC-CID: PsPee2j9ZjGzXLPBUgAUjqQk3jjBcL/AuU/QDOAy
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all:

It is very easy to launch "git instaweb" for temporary browsing and forget to shutdown the HTTP server.

It would be nice to have some option so that "git instaweb" does not fork, but waits for the server to exit. You could then kill it with Ctrl+C on your console. This way, it is harder to forget that the server is running in the background, and it is more convenient to stop it.

Regards,
   rdiez
