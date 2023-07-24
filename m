Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66956C41513
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 12:30:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjGXMaX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 08:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230346AbjGXMaK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 08:30:10 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B69C1721
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 05:29:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1690201787; x=1690806587; i=l.s.r@web.de;
 bh=fPidp18jj1k7xbCodVcvPs/ANSp730tZOx7UsqIVoM4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=GG/3BfzAPvo7f9B5L2yD1HX/chMf/YGkCAszsf6zZOzCSrxiXrhVpp8X5ETvtVw066UeZuB
 R21bTSAhsenh3W0j+LZbMWHhrs1KWpFoQzn9xUhEmCln1vE3n/SY/xdxTmU1UR3CGesQAn+23
 TtTn+9PJuTYl5BB1LS2kIwcHZDSr0zlDHzBBD6V5fm8GjqFhALh5/DqqQ/dsSZsb97CfJL4CX
 xCaKR9G+gyfcqowj1SLcSL8Blq4XcHIqdg5UGTNvNR7kCuws/ly0lnOVejekXyZiDm/skjt1D
 4Y8eEA4RGNGkoc2AF49Vzq3VSQ/dG6+3IB8BxLa/N55Sck6ovmRQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MiMEM-1pioVp3GEA-00fkl4; Mon, 24
 Jul 2023 14:29:47 +0200
Message-ID: <4d01e971-07cb-4f11-3cc6-9d9f21e590c1@web.de>
Date:   Mon, 24 Jul 2023 14:29:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: [PATCH v2 0/5] show negatability of options in short help
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <xmqq4jlxuiuu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1HGuIsz+ft01QExXxejpPzraMqs8jPyYBn5wHhzZWOwy3xEWOp2
 tkG/8i0e/W7qRo2liSbq+Rj+qExC30BoxIAaJ7HYXWmgLbqGntCUaY/8J2db+M5Jtaf/ZQi
 mJv2OoL6AdkqCrnmW7kXWB+an2vdie5VOV6M2VaKq96P4eNIpF/8zKSM4yg9GA9Hf0Ib6yp
 tX6SiR3SuXHQrTvNCgDzg==
UI-OutboundReport: notjunk:1;M01:P0:hUrwLwnRmO0=;BMjgJrzvTuovc5JHW+xruogjzF5
 ed/PZnzY739PreagfdImGMKWeMUqkIevuOClD1SGGe5nyw8uWnf9StQkdrQe4h+L700jxv0Ju
 Cj4hJ5B3vMKr+tY7yjOH+MKiDyBVmeNtojdUGoNniUDvxceM5VhBzjnbDFqRAR8HCMWiEYN+p
 eb5u6kyzSDkOtv2eVTOP6oF0zLygrcDNFYgUOVgTspAlKc0qfITqcZ366Dte6Y3FEe0wc/62T
 Nx7Ku5Y9RETZ3TerQJ2lhUerM3Q2CzyrE8YKVaPtTOakd7lwp8fVw+sEjkxPiwpmPHrQfqXZp
 uw8ywJk5eIS8V8FXmxKiQzygr+ZBFFcvL5bF6GSrujzbcsuR67wFYxliDUj2b1AJ+XaDYQu+6
 62ko3wnyojYdCev0fJgRAX/ihUPpDmwBzRXF2QZXfG2VWcmCb4uFMsgBESdT4CasfgA4GtsXC
 am+kgb9gJTMBVtQEc18WLsRI6vI73bdx9FwlICo96h2szhZ9L1kU0Cm5jmtDRKAHI+Tfm5J/1
 v5V6sOwri18KeX/IXhdf4JMXD5/e1RPQ3agTksQ4jHql2dmhT3XEv5kSSuzOBYfBFt0liEudu
 hLD5LGOcgUpSwZgVYfR9cMSsZFWRr+1QIKwSLEl/rhE3g7csNPT3Jyea2LKH6FT8kN8zhrKFM
 ey0bqhtoz1wCvAxBLOdwRpKiap8wL3JHaVWekWGVcNEhhLhAZlMa4JKGGvzcfDqL/dwEl+p/9
 F6PekWKt0plUpkdQpwpuQz2zMd6b/0rwwU1IESvqWH4gp5gTiEZTO+LTWZd1V16fYCHem6SlG
 plro+tiKB3JkkaNW8WIi9kpKIv14HGZmM9pHhsWVIjoQfze5ibA+V3vjsEHzPs1dyb5+I2vyb
 SI05Ew4Np2W9fPcX6d+5+wtBKJHY1jG/V1S5sQSmMFF9r00bYHh5YcWZ7mA+PpAToKoxVoV7x
 PFOTuA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v1: More fallout, still reduce size of final patch:
- Disable negation of "git subtree" options that don't support it.
- Adjust t7900 in contrib/subtree/t to the changed output.
- Adjust git-rev-parse.txt to the changed output.
- Disable negation of --help in t1502.
- Add negation tests to t1502.
- Deduplicate expected output in t1502.

  subtree: disallow --no-{help,quiet,debug,branch,message}
  t1502, docs: disallow --no-help
  t1502: move optionspec help output to a file
  t1502: test option negation
  parse-options: show negatability of options in short help

 Documentation/git-rev-parse.txt    |  10 +--
 contrib/subtree/git-subtree.sh     |  10 +--
 contrib/subtree/t/t7900-subtree.sh |   2 +-
 parse-options.c                    |  10 ++-
 t/t0040-parse-options.sh           |  44 +++++-----
 t/t1502-rev-parse-parseopt.sh      | 131 ++++++++++++-----------------
 t/t1502/.gitattributes             |   1 +
 t/t1502/optionspec-neg             |   8 ++
 t/t1502/optionspec-neg.help        |  11 +++
 t/t1502/optionspec.help            |  39 +++++++++
 10 files changed, 157 insertions(+), 109 deletions(-)
 create mode 100644 t/t1502/.gitattributes
 create mode 100644 t/t1502/optionspec-neg
 create mode 100644 t/t1502/optionspec-neg.help
 create mode 100755 t/t1502/optionspec.help

=2D-
2.41.0
