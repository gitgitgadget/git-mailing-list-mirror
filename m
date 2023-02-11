Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01C5DC61DA4
	for <git@archiver.kernel.org>; Sat, 11 Feb 2023 13:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjBKNFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Feb 2023 08:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjBKNFF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Feb 2023 08:05:05 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5480340BE2
        for <git@vger.kernel.org>; Sat, 11 Feb 2023 05:05:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1676120693; bh=m85SlCCmGdT8fyUGJYuBPgEcgyDZ7sZMEdy1sZJgKJ0=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=maDvk/IX36tuYVev+we5v14D24BeXYPkT6iL8JmbxGWlwqQNn6yffcnJNLdbMgmNr
         rmeM5N/UaWRUXzCSWhpUnl2biryCAFBeSNtZWVKH9Ptfilal8tYC4sE1qgDWsKmVeJ
         4ddGigrUvsYBrhcTnCCYrmFlipzVmsBR24hZcm8BsUiGj48jd+kEBkzV3zlmJJA3lo
         Npy8i+H/1AE7PsRVEgz20RXLCP0zrQly+buGYxnGpsfjUaALnKJxB/d3VezOqHNJL4
         Iy5Qc/iSEyoMcm5lR71z31P+wg3jXbkMgeLxbqO5MtdvSj6dBEuAsp4nGTEAmgiNxC
         vYcRmj4nYVeZQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.21.51]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mtguh-1oaFhq03aB-00v899; Sat, 11
 Feb 2023 14:04:53 +0100
Message-ID: <06da58d6-6aae-7b1d-6ce6-f07d27f05d97@web.de>
Date:   Sat, 11 Feb 2023 14:04:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.7.2
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Masahiro Yamada <masahiroy@kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 0/3] test-ctype: test all classifiers
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0tNoWEWXwYZfvVtawZXJlf+7G3vinri8iD3vUmFlFn6Ro1iMi7J
 yeXzRugqWCfv4G6I5kbkegXJgybpl0wiQYVaPbrkX5Nxx1T/AGwfV95EY6hvLhpQbPmopWL
 PLsaKqJa0v3XSK6UkdWbaCuyRhZH8CT1uzC8Bzgj8XxEJrdtWpskEOuMhosiiPp+9yoM8Dt
 OyoLXIp/jqnUVLngK6zQQ==
UI-OutboundReport: notjunk:1;M01:P0:zGD5lEPGCzQ=;d4yFxQBj+Chu9GmSDLHAFKPNbHz
 8gNYrmXKRDYqGlDAWsVn+ea61nvelFmp6ftnhXU5mbaHyNfIXLBW89xJDEvUiJRCWxQ+jSPKm
 23K4KrT6M5gc+Ub6hWTa9vLfChDwLCF/OLn0U2jPm5ehVesMSYPxmfysRQnJ1iSSTEhsbGNma
 VmnziZ2zc/DxEa3mf0TcvA5nkTOb223JNTbA0DUCdOhrPpDcaGOFiGTodm5g4Hd1e1Yav2Lbw
 JBl6KlYWOY5eZmrS/BJL5/e940lzf0YRcT1K5mqIBtAyu+h0KwRix2jQL9K3kUtk5sHaiZkUM
 B/MjPH42r3xVlhc9+UWS9zaQM11WZS2Aja6kZWJT5T6azmHAfdztegwre2loatPt64SerO1Sf
 bt1u2Jk145DgKoenc0sXxeCSuYm+6k8ikexeg7uS0it7tQgfBAqQY1qqfpEH4d2APvmO1b/1q
 JVEGkgH1mrUK3dfhyC08YfrXcGHqCa3FvUvR4chyoPUqjig3YAm79kubW4TPUuOIVNtTywuJd
 D/uR8hU+cBMg641mEYruNUSwnuKD5loUwe5VqwNRr9hwC+08L0/kPltS+dkUEEgr7+P8YbzBP
 uIbiDus0fkZABXUA+jICH35Ew9XUsA4n6/leY+Y/TEMLHfJLAHaNahoaVNrUgND8vQivt3EX9
 UnP4DMchPUfXC66f/1owt7toGVNWnzZaTNN7b1zgUxtiVW5V+W5fNwFZU74aDyF64+yQSWmW4
 19XNarx2HU2oaWWDj6rnX5tT1DVMoEnGfPOok7xKjOxIeN0c4VZtXfQvkUFp/PquwN3vCERWW
 9kzJsugbMY5SLoqvzYKeduvSV3ddtbXuDeAsGVfevDiZRQzLqj+pHhaXevqbgh+kkJCYLmAEQ
 2R5ya26QkT+6f87Z7r/SQaCEAFyMCiMj/21xvqrC1h64zZQz7CP8aY826K+Vpy/KkuWm6u4Fm
 7ICyyw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests to cover the remaining character class test functions.

  test-ctype: test isascii
  test-ctype: test islower and isupper
  test-ctype: test iscntrl, ispunct, isxdigit and isprint

 t/helper/test-ctype.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

=2D-
2.39.1
