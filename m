From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: janitoring
Date: Thu, 23 Jul 2009 09:27:42 +0200
Message-ID: <4A6810EE.4030902@viscovery.net>
References: <1248298475-2990-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Thu Jul 23 09:28:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTsib-00049m-NY
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 09:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbZGWH1u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2009 03:27:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbZGWH1t
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jul 2009 03:27:49 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:26341 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753614AbZGWH1t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2009 03:27:49 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MTsiM-0008Ri-T4; Thu, 23 Jul 2009 09:27:43 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A5FB96D9; Thu, 23 Jul 2009 09:27:42 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <1248298475-2990-1-git-send-email-madcoder@debian.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123853>

Pierre Habouzit schrieb:
> [PATCH 2/3] refactor: use bitsizeof() instead of 8 * sizeof()
> 
>   use a macro for CHAR_BIT * sizeof(...), I tend to find it more
>   readable than 8 * sizeof(...) in the code. YMMV.
> 
> [PATCH 3/3] janitor: add DIV_ROUND_UP and use it.
> 
>   Just use linux/kernel.h DIV_ROUND_UP(a, b), it's way easier to read
>   than (a + b - 1) / (b).

Quite frankly, using these two macros means that code readers have to
learn their meaning although the original code pieces are (IMO) well-known
paradigms. Moreover, DIV_ROUND_UP hides that b is evaluated twice. I am
not enthused by these patches (though, I don't see a reason to object).

-- Hannes
