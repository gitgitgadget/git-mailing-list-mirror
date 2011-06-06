From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 0/3] submodule add: allow relative repository path even when
 no url is set
Date: Mon, 06 Jun 2011 21:56:16 +0200
Message-ID: <4DED30E0.6090608@web.de>
References: <7vaae2ihe1.fsf@alter.siamese.dyndns.org> <1306943792-1825-1-git-send-email-marcnarc@xiplink.com> <7vsjrth4iy.fsf@alter.siamese.dyndns.org> <4DE69945.1080601@web.de> <7v39jsdulf.fsf@alter.siamese.dyndns.org> <4DE93B29.4030401@web.de> <7vipskb0br.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Marc Branchaud <marcnarc@xiplink.com>, git@vger.kernel.org,
	Mark Levedahl <mlevedahl@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 06 21:56:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTfuW-0003PR-UW
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 21:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756084Ab1FFT4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2011 15:56:20 -0400
Received: from fmmailgate02.web.de ([217.72.192.227]:52178 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755790Ab1FFT4S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2011 15:56:18 -0400
Received: from smtp06.web.de  ( [172.20.5.172])
	by fmmailgate02.web.de (Postfix) with ESMTP id C363E1A24FEB9;
	Mon,  6 Jun 2011 21:56:16 +0200 (CEST)
Received: from [93.240.124.249] (helo=[192.168.178.43])
	by smtp06.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QTfuK-0005Ze-00; Mon, 06 Jun 2011 21:56:16 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7vipskb0br.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18x0Aq1vBJiSHpsdtJCBKiHW+sjDgI2ga+VoeF1
	UmDUJmb/PCmPKfgC26qHAvL0wDECa0gMHA6dV9sCtC+x1KvNOw
	OeSLN7y0tZiD7C7G9zxw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175154>

Am 05.06.2011 20:27, schrieb Junio C Hamano:
> If you think about "absense of the remote in the superproject means the
> project originates from here", what you are doing in step 3. is to
> changing the origin of these set of projects. After changing the origin of
> these set of projects, isn't "git submodule sync" an established way to
> adjust to the change? I was hoping that that would update .git/config in
> step 3. so you wouldn't have the problem in step 4. at all.

Thanks for explaining that in detail, I think I do get it now.

So what about this series: The first commit adds a test for the error we
are talking about, the second one implements the logic you proposed and
the last one removes some duplicated code I stumbled across while staring
at the code.


Jens Lehmann (3):
  submodule add: test failure when url is not configured in
    superproject
  submodule add: allow relative repository path even when no url is set
  submodule add: clean up duplicated code

 Documentation/git-submodule.txt |    4 +++-
 git-submodule.sh                |   12 ++----------
 t/t7400-submodule-basic.sh      |   10 ++++++++++
 3 files changed, 15 insertions(+), 11 deletions(-)

-- 
1.7.6.rc0.3.g28a66
