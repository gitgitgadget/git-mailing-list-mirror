From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 10/16] add NO_EXTERNAL_GREP build option
Date: Thu, 13 Mar 2008 08:50:24 +0100
Message-ID: <47D8DCC0.9090303@viscovery.net>
References: <cover.1205356737.git.peff@peff.net> <20080312213916.GK26286@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Whit Armstrong <armstrong.whit@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 13 08:51:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZiDS-0002qI-Si
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 08:51:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751572AbYCMHu2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 03:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbYCMHu2
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 03:50:28 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:5188 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480AbYCMHu2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 03:50:28 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JZiC3-0001KR-Sb; Thu, 13 Mar 2008 08:49:40 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4AA8C6B7; Thu, 13 Mar 2008 08:50:24 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080312213916.GK26286@coredump.intra.peff.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77050>

Jeff King schrieb:
> Previously, we just chose whether to allow external grep
> based on the __unix__ define. However, there are systems
> which define this macro but which have an inferior group
> (e.g., one that does not support all options used by t7002).
> This allows users to accept the potential speed penalty to
> get a more consistent grep experience (and to pass the
> testsuite).
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> This might have fallouts for msysgit (i.e., they need to define
> NO_EXTERNAL_GREP instead of relying on __unix__ not being defined).

You name it. Would you mind converting exec_grep() to use run_command(),
too? Or better inline it since it won't do a lot more than run_command()?
That way we at least won't get a broken git when I merge git.git that has
this patch.

Thanks,
-- Hannes
