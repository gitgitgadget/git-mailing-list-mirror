From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: "git am --abort" screwing up index?
Date: Mon, 17 Aug 2015 10:01:29 +0200
Organization: gmx
Message-ID: <03631611149f05dbcd862b4c1e8e9d6b@www.dscho.org>
References: <CA+55aFwDkQAS8ULiLt9N5NVOYJ242Nd2MOWeiRX8HrVHXf2zog@mail.gmail.com>
 <CA+55aFwwD=K-i9d40N5FtnTLT-ApZOzmgnXhnuA=C0zw2eBt3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Paul Tan <pyokagan@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 10:01:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRFMV-0003mV-GV
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 10:01:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752960AbbHQIBj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 04:01:39 -0400
Received: from mout.gmx.net ([212.227.15.15]:51394 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751331AbbHQIBi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 04:01:38 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MaZrd-1ZBePi0HOr-00KA13; Mon, 17 Aug 2015 10:01:31
 +0200
In-Reply-To: <CA+55aFwwD=K-i9d40N5FtnTLT-ApZOzmgnXhnuA=C0zw2eBt3Q@mail.gmail.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.2
X-Provags-ID: V03:K0:bVXnKgtuJMNNsAqzdTOVhJw/bclahQRbK7mnPD4gauQS6BqXPJi
 zo3Uk8LzGxXGPmdMFxYPRhN18noachh0OHcppasTEHpY5R90pif1xvDjoezYhZOuCXmxyKz
 SLVlVrSt70QDHv+iDa86CmR0FpvbCZi6m5qhgDf1SyBAuWrKoAQtWTGssHxRCI1DQ7wIWl2
 DV/yzAxUsJT1h+2b79DZA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:qZXMGNW8SG4=:9Ft8iq2IIom1SMYtnPSmkZ
 zOKHguCg+jAoTSz1xURjS/Ir/pmZ3p7Xb6VqlJd4+Ko5F5TiIgGpoOsNVdb9hNycOFt7cE0aP
 BkkZQ3pln04PUSb9M2YHAKJ4Rzd8fYV/stgkCVusRvE8KzuFjjL2y4gIM0BdGkUQcFkLHVE1u
 ZTqd7DQcnrsZwiS3LcFfZ74SVg8cCAyoNMzeT52Q4g0pGH8s+vHHwGQRuwO4MqfcNwFRc6qJ/
 xBPsATrFboZ3PKKmR/yC3GjpfHK5AbJV0ol85l8/R7FoJhxa2Ec/2XJnMR/VEf7PuCjXe+YSM
 ibgDVndEQkYXfNzDkNnpsMFdZYqukvnE6U/RnPMs2IPaC9phkbNi35pSKO7Vx3cP/W1CS0LZm
 TNMXGyaaqVQcX+h2nAWiy5BqjramUWhwNZGA36sPbUG7uu6Jbt/ByCoobfUt+g5kG+9gUfyUm
 gkYkMMHtEVrns/A/sRfTHFYHoyRviKPwgODJlQCslNSlOcBUD/Ptj6K2Cw00fOqqxHv9okqRD
 LzuwlwZjNr5LrB7ZAA1cRTqGCxlxDv9YvwkPIRM6dkV0tQJRwT6/h2H8uy1RaJyOkp2j5Y+Wr
 j+EPm07hiFkIUHyJYOEqMslhYr/Ky/em06qCYDwtXxaELJCqQS02u+825mP2RuWZ2cYH1cEpR
 kTVoDx3Sf2DavA/KDkf9n53pOyTEO6Y3cRAfjLWW2q+yXbcrvcQM10jkJ1mayNXCLaeeFOiVF
 q2cgO7u4O02XqJtFtsB3d34UoHYnv4z13LztJg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276035>

Hi Linus,

On 2015-08-17 01:33, Linus Torvalds wrote:
> On Sun, Aug 16, 2015 at 12:46 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
>>
>> Maybe it has always done this, and I just haven't noticed (I usually
>> _just_ do the "git reset --hard" thing, don't ask me why I wanted to
>> be doubly sure this time). But maybe it's an effect of the new
>> built-in "am".
> 
> I bisected this. It's definitely used to work, and the regression is
> from the new built-in am.

This patch is a reproducer:

-- snipsnap --
From 5323f1c309ad40721e2e19fa9c6ce5ad52d98271 Mon Sep 17 00:00:00 2001
From: Johannes Schindelin <johannes.schindelin@gmx.de>
Date: Mon, 17 Aug 2015 09:37:39 +0200
Subject: [PATCH] t4151: demonstrate that builtin am corrupts index' stat data

Reported by Linus Torvalds.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t4151-am-abort.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t4151-am-abort.sh b/t/t4151-am-abort.sh
index 05bdc3e..bf2e6f4 100755
--- a/t/t4151-am-abort.sh
+++ b/t/t4151-am-abort.sh
@@ -168,4 +168,16 @@ test_expect_success 'am --abort on unborn branch will keep local commits intact'
 	test_cmp expect actual
 '
 
+test_expect_failure 'am --abort leaves index stat info alone' '
+	git checkout -f --orphan stat-info &&
+	git reset &&
+	test_commit should-be-untouched &&
+	test-chmtime =0 should-be-untouched.t &&
+	git update-index --refresh &&
+	git diff-files --exit-code --quiet &&
+	test_must_fail git am 0001-*.patch &&
+	git am --abort &&
+	git diff-files --exit-code --quiet
+'
+
 test_done
-- 
2.3.1.windows.1.9.g8c01ab4
