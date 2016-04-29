From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v2] travis-ci: build documentation
Date: Fri, 29 Apr 2016 16:40:10 +0200
Message-ID: <vpqd1p8xyut.fsf@anie.imag.fr>
References: <1461922534-49293-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, stefan.naewe@atlas-elektronik.com,
	gitster@pobox.com, peff@peff.net
To: larsxschneider@gmail.com
X-From: git-owner@vger.kernel.org Fri Apr 29 16:40:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aw9ax-0005en-Cg
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 16:40:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753094AbcD2Okf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2016 10:40:35 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43906 "EHLO mx1.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752819AbcD2Okf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 10:40:35 -0400
Received: from clopinette.imag.fr (clopinette.imag.fr [129.88.34.215])
	by mx1.imag.fr (8.13.8/8.13.8) with ESMTP id u3TEe9DM016162
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NO);
	Fri, 29 Apr 2016 16:40:09 +0200
Received: from anie (anie.imag.fr [129.88.7.32])
	by clopinette.imag.fr (8.13.8/8.13.8) with ESMTP id u3TEeA0K014984;
	Fri, 29 Apr 2016 16:40:10 +0200
In-Reply-To: <1461922534-49293-1-git-send-email-larsxschneider@gmail.com>
	(larsxschneider@gmail.com's message of "Fri, 29 Apr 2016 11:35:34
	+0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (mx1.imag.fr [129.88.30.5]); Fri, 29 Apr 2016 16:40:09 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: u3TEe9DM016162
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1462545609.86061@mQ/z/s4lJPlmW5ybQIrMsA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293007>

larsxschneider@gmail.com writes:

> +      before_install:
> +      before_script: make doc
> +      script: ci/test-documentation.sh

If you are to re-roll, I think before_script and script should be
merged, i.e. just write

script: ci/test-documentation.sh

and have ci/test-documentation.sh be:

#!/bin/sh

set -e

make doc
test -s Documentation/git.html
test -s Documentation/git.xml
test -s Documentation/git.1

In the perspective of using another CI tool, everything within ci/ is
potentially shared between systems so I'd tend to minimize the content
of .travis.yml in favor of ci/*

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
