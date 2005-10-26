From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: git 565ebbf79f61873042c22a7126d002c104e056f4 broken on OpenBSD
Date: 26 Oct 2005 11:50:32 -0700
Message-ID: <86mzkwdsef.fsf@blue.stonehenge.com>
References: <200510261722.j9QHMLGY006576@laptop11.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 20:53:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUqMI-0006JQ-TK
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 20:50:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964859AbVJZSui (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 14:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbVJZSui
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 14:50:38 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:59993 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP id S964859AbVJZSuh
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 14:50:37 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id A05988F5A8;
	Wed, 26 Oct 2005 11:50:32 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 03348-01-11; Wed, 26 Oct 2005 11:50:32 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 366E38F697; Wed, 26 Oct 2005 11:50:32 -0700 (PDT)
To: Horst von Brand <vonbrand@inf.utfsm.cl>
x-mayan-date: Long count = 12.19.12.13.7; tzolkin = 4 Manik; haab = 5 Zac
In-Reply-To: <200510261722.j9QHMLGY006576@laptop11.inf.utfsm.cl>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10686>

>>>>> "Horst" == Horst von Brand <vonbrand@inf.utfsm.cl> writes:

Horst> This is EVIL.... why not just:

Horst>   #ifndef ENOTSUP
Horst>   #define ENOTSUP EXDEV
Horst>   #endif

I'd consider that a worse hack.  It affects any place where EXDEV
is not really equivalent to ENOTSUP.

It's cleaner to test for the ones that work, building up an OR'ed expression.

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
