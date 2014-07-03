From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 0/2] always run all lint targets when running the test suite
Date: Fri, 04 Jul 2014 00:19:42 +0200
Message-ID: <53B5D6FE.2090700@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 04 00:19:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X2pM8-0004X5-AL
	for gcvg-git-2@plane.gmane.org; Fri, 04 Jul 2014 00:19:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbaGCWTs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jul 2014 18:19:48 -0400
Received: from mout.web.de ([212.227.17.12]:53322 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752957AbaGCWTs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2014 18:19:48 -0400
Received: from [192.168.178.41] ([84.132.191.233]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MTyDl-1XBJmQ259l-00QjLz; Fri, 04 Jul 2014 00:19:43
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:3cOxQw4/Mi3mBPyvKimT1x1zfCS2Gk3/xokA5iJmx0CcIuwk4cO
 4QpJB7M0BUxZ9aLO2x5xd4Q+Y/nH+1h5rArqT36Sry23V2PJRMgREAyFDZxUQ8/Kv2xhwDP
 QIvcXLEM5MUPnuFnjrAnflSTeXJvUtyRQTyFLUqhOOG3ziO5D8sgdjICkSctGasrdrvtpP/
 VU++0/tIdavLKaxW+uKLQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252884>

I recently accidentally added a non-portable "echo -n" to a test
suite helper which "make test" didn't show. This series attempts
to detect such problems early when running the test suite.

The first patch includes the helper scripts to be tested too when
running "make test-lint" (and thus the test-lint-shell-syntax
target) in the test directory.

The second patch then uses all lint tests in the test run.

Jens Lehmann (2):
  t/Makefile: check helper scripts for non-portable shell commands too
  t/Makefile: always test all lint targets when running tests

 t/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

-- 
2.0.1.474.g5b85b58
