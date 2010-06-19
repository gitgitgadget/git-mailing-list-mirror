From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: What's cooking in git.git (Jun 2010, #03; Fri, 18)
Date: Sat, 19 Jun 2010 00:27:26 -0400
Message-ID: <74E790B7-BDC9-479B-A7E7-259ACB7E60B9@silverinsanity.com>
References: <7v7hlvyi50.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 19 06:33:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPpk4-0007yp-Ic
	for gcvg-git-2@lo.gmane.org; Sat, 19 Jun 2010 06:33:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751578Ab0FSEdK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jun 2010 00:33:10 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:35797 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751364Ab0FSEdI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Jun 2010 00:33:08 -0400
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Sat, 19 Jun 2010 00:33:08 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id 4CE501FFC058; Sat, 19 Jun 2010 04:27:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-67-185-155.rochester.res.rr.com [74.67.185.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id D7D401FFC056;
	Sat, 19 Jun 2010 04:27:16 +0000 (UTC)
In-Reply-To: <7v7hlvyi50.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149374>


On Jun 18, 2010, at 8:34 PM, Junio C Hamano wrote:

> * ab/tap (2010-06-09) 4 commits
> - We use TAP so the Perl test can run without scaffolding
> - Skip tests in a way that makes sense under TAP
> - Merge branch 'jc/t9129-any-utf8' into ab/tap
> - Make test-lib.sh emit valid TAP format
> 
> I was not sure why TAP is worth the trouble, and I still am not sure.

Having looked it over, using prove (a TAP harness) would allow me to do things like save which tests fail to use either while trying to fix a bug or performing a bisection.

cd t/
prove --state=save t*.*
cd ..
git bisect start HEAD good
git bisect run 'make && (cd t && prove --state=failed t*.*)'

Also, the fact that it makes the perl tests be more "normal" is definitely in its favor.

~~ Brian