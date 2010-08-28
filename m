From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 0/2] checkout: diff.ignoreSubmodules: Add test and honor per
 submodule settings too
Date: Sat, 28 Aug 2010 16:48:29 +0200
Message-ID: <4C7921BD.7030600@web.de>
References: <alpine.DEB.1.00.1008251225200.4020@intel-tinevez-2-302> <4C755778.7010306@web.de> <7vlj7uqwr6.fsf@alter.siamese.dyndns.org> <4C7591D7.9050508@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 28 16:48:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OpMi8-0002yu-Ns
	for gcvg-git-2@lo.gmane.org; Sat, 28 Aug 2010 16:48:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751561Ab0H1Osb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Aug 2010 10:48:31 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:33361 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751139Ab0H1Osa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Aug 2010 10:48:30 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate01.web.de (Postfix) with ESMTP id 99D99166D139E;
	Sat, 28 Aug 2010 16:48:29 +0200 (CEST)
Received: from [93.240.119.11] (helo=[192.168.178.29])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #24)
	id 1OpMhp-0001WU-00; Sat, 28 Aug 2010 16:48:29 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <4C7591D7.9050508@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18A8o70Bsdyi10WlMLW3KrZpRXeYmkCL2R5pQc6
	Cxb1Tu5JRfMi8frUtX1s9GU/vItcgn1zI3h1sqFhEcADd3Qbmx
	2WE6B3p0pV6joNQbtyqg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154644>

Am 25.08.2010 23:57, schrieb Jens Lehmann:
> Am 25.08.2010 22:10, schrieb Junio C Hamano:
>> Thanks.  Perhaps we would want a new test or two in t2013?
> 
> Sure, I will add some as soon as I find some time ...

Ok, here we go!

While writing the test I noticed it might be nice to use the
configuration settings consistently. So I did a second patch
teaching checkout to honor the submodule.*.ignore settings
the same way diff and status do.

Two other issues surfaced while working on these patches:

1) We might have to teach the --ignore-submodules option to
   checkout too to be able to override the configuration on
   the command line and in scripts.

2) It might be a good idea to let "git status" honor the
   diff.ignoreSubmodules setting too, so that the output is
   consistent with that of diff and checkout.

Opinions?

(While I am willing to write the patches, I am not a user of
these config options myself, so feedback from people who do
use them is very much appreciated!)


Jens Lehmann (2):
  checkout: Add test for diff.ignoreSubmodules
  checkout: Use submodule.*.ignore settings from .git/config and
    .gitmodules

 Documentation/config.txt      |    3 ++-
 builtin/checkout.c            |    5 +++++
 t/t2013-checkout-submodule.sh |   23 +++++++++++++++++++++++
 3 files changed, 30 insertions(+), 1 deletions(-)

-- 
1.7.2.2.515.g13860
