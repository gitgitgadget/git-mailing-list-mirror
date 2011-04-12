From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2] Allow git mv FileA fILEa on case ignore file systems
Date: Tue, 12 Apr 2011 08:16:12 +0200
Message-ID: <4DA3EE2C.2010702@viscovery.net>
References: <201103191528.34646.tboegi@web.de> <7vsjuitk59.fsf@alter.siamese.dyndns.org> <4DA144A5.2080103@web.de> <7vd3ksybfr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	kusmabite@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 12 08:16:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q9Wti-0002zT-0l
	for gcvg-git-2@lo.gmane.org; Tue, 12 Apr 2011 08:16:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753815Ab1DLGQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2011 02:16:16 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22508 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752314Ab1DLGQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2011 02:16:16 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Q9WtZ-0007gW-9F; Tue, 12 Apr 2011 08:16:13 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 091551660F;
	Tue, 12 Apr 2011 08:16:12 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <7vd3ksybfr.fsf@alter.siamese.dyndns.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171371>

Am 4/11/2011 18:55, schrieb Junio C Hamano:
> Yeah, I forgot about the primary thing we are trying to do in this
> discussion.  Sorry about that.  My thinking stopped at 'if we rename "A"
> to "a in the index, that is sufficient.  We already know that we can still
> open("A") because the filesystem is case insensitive.'
> 
> In fact, we want both the index entry "A" renamed to "a" _and_ also we
> want to see next "/bin/ls" to show "a", not "A".  For the latter, we do
> want to run rename(2) on them.

I wonder why we need this at all. You can always break this into two
operations:

  git mv A a1
  git mv a1 a

Is 'git mv A a' on a case-insensitive filesystem such an every-day
operation that we have to provide special support for it in git?

-- Hannes
