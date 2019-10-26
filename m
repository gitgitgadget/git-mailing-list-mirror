Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E1CF71F4C0
	for <e@80x24.org>; Sat, 26 Oct 2019 19:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbfJZTTr (ORCPT <rfc822;e@80x24.org>);
        Sat, 26 Oct 2019 15:19:47 -0400
Received: from sonic310-27.consmr.mail.ne1.yahoo.com ([66.163.186.208]:38528
        "EHLO sonic310-27.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726410AbfJZTTq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 26 Oct 2019 15:19:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rogers.com; s=s2048; t=1572117585; bh=ntIPLxzG8rp9KVp1FC7yzb/da3kJoc2uDzFSpwCOGsU=; h=From:To:Cc:Subject:Date:From:Subject; b=cqGhoxVI/qnsEe/W6PmbemYHfSUHd5khXQhznoBkde03sFCGGCdSWO2bEL78s8298iAdgEYNEw7tzDAXMIxePu8roQNZM8OIzzmlxu6h11FBFghJ0wY939YTloh1l1jrdi7UI8p/N+tj40IgzUSB22F/Sbl4Fm1rHgJ/oHSBHd3xqhFzOctBd6XxmzdsRiWrTY7MX1uVWJqx8qxIA2S1b0FNiXZG8YMP1GOQ0rL7z24KJcMmxolwCKFj1zZ0ic/Zd3SPzC4AsLcmlauuaPYXeZ87SpyPHDzviOmqZ2P1Tc8IzIhFI6bvtmKJyBnpOKomOGECuTc7YM+xxvs6PvAijQ==
X-YMail-OSG: UQ6TuqAVM1n68z5_.onmHhieC688n6aIJj.T4qID5BLpK1YRnDXOM4qK9.Wg7mB
 YzSetWqZxlO.Vhya9kv4kaWJe78UPOeVxC6va1CFKd0LctK7aKjDHBlFT_AmUB24uM3G_4j7FjLW
 E.7TYA3v2BuAWompxH7ySNI8v_ETChZyJTirqSRoRp.wxX5PkBtCUcpTiaJQ1vStIUZO5Ex2A_gs
 TOZCh_Dw7273FIiMB5.JXllyNoNV1FjCPd8hkgyHe3WEwrlpcsEsSzAN.sPhcxSIzojRwyowkRtc
 iHm3ODoBCQdbU5t4b1lvTVua.q2i0NF_9EO84.V5gUtDwGIuhJexOMJlP30hg9dfkGqcWevzG.oQ
 YWVj9ISuJ.hAzwpv6Je0QXB.GML8E73C0c6y5I04Qacw3QQ5cC8baJwwI0KKBBbzF940swRnCLir
 ADHsvUsS2TGw9mXy9FCqBTKHZf3tFk1agA5wbSgULiDvj4EsQv5ADE.CXNJxsV6OgqiyBiz.7irF
 6bVyUHu4KToiqNtTIAgyrCbS79OF0lgB72c_1stxdfJk5uJFwVlgiCFbpi_lwnVzkvDLl3Jah6zN
 8d64tjy4ZuJWhstKHTwqdQTX8.CcfuMtwcZ7sUr8bzkk7ldEHGzVRv6L_TlUfGmeoh6Gf5HzoGjV
 _TEa.ZyEv4FtpkKJqgkHr0Q.sRkshAeCnSnREqFJrY3dd3NwvSYeR9sPe9Xvf5LnDslKG_tBngbH
 69qyyve5LJmhMawk7e89H1FYVxtH68OBzYLZX8UVkm2uztuMstWqCF21HxYvLw6iTWQMjtwi0ezO
 hTHdDR01luUiSiXqNVcDlpj0WDgmqj3XnUFLWdafzis1nY.B0DOFvhlZAsXgps3sAUbmzIVVKgbp
 zUWTCNfy0kunhZnm3alVn_rk2.blQYp6XggqYX.16vbr.D0nZh1X3EncUlKGpdO9YOdjH1F_RzGM
 jZxufTbjPT3TQyO1Gnf4NgWbvh15lWCupOw.cFHxymfR4RtSP4VY0AJmkjF5YgGeTA5g6SUqF_kg
 2ydmAK.XOeAt3Pl.Xm9RWWYN7CGDd4Dj3RQBCWYp3bFwBALxkSpLEbvrNkof37oTphaHVaUN4Jdj
 g83Fk5pMmsk4L2GUUfYK1I7Tw0wjaPQZ.h3GY6U6YH3KudViyNhHcs.Hh7qzF5ABdt9ptcjdZkOi
 1CEpAuTYbM14zc44l_CUDoKHDOtk91n9sFktd_OS4Mm1v2iVPjfx9VclLWHj3Ai0KF.sCfTCmv.A
 8acJHrz_XuheKDspm7CrUacyuliI0VT8Mg4s8_iawFBRgbpxY_sb2AMievJBakqd5yny4NYiQJg3
 KFh.LUVf5i0COqXEU_vkSUAV3gQKdlDicVQ--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Sat, 26 Oct 2019 19:19:45 +0000
Received: by smtp424.mail.ne1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 0e6ac9ea0018cf5110a8435284ef58d7;
          Sat, 26 Oct 2019 19:19:40 +0000 (UTC)
From:   <randall.s.becker@rogers.com>
To:     <git@vger.kernel.org>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.24.0-rc1 - Test Summary for NonStop
Date:   Sat, 26 Oct 2019 15:19:37 -0400
Message-ID: <021601d58c32$4f632a10$ee297e30$@rogers.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdWML/ICv092FarvQgSEje3kXY8uNw==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the test summary for the HPE NonStop TNS/E platform for git
2.24.0-rc1. All tests passed except as follows:

[NEW] 1. t0500-progress-display - failed 7 out of 11. This appears to
consistently fail when run under Jenkins but consistently succeeds when run
from a non-disconnected real terminal. The difference from a pipe handling
standpoint with Jenkins is that it provides a stdout opened using O_WRONLY
rather than O_RDWR or other open() modes that might exist - we have seen
problems resulting from differences between process initiation under Jenkins
and connected terminals in other products. This failure was not present in
2.23.0.

2. t9001-send-email - obvious failure because there is no working sendmail
on the platform. This is an expected failure, so no issue.

3. t9020-remote-svn - there is no svn on platform, but the test detection
does not deal with this. This is an expected failure, so again, no issue.

It would be nice to understand why t0500 is failing before we release the
official build to our community.

Cheers,
Randall

-- Brief whoami:
NonStop developer since approximately 211288444200000000
UNIX developer since approximately 421664400
-- In my real life, I talk too much.




