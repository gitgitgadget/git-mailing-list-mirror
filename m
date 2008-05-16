From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3] Add support for GIT_CEILING_DIRS
Date: Fri, 16 May 2008 09:03:20 +0200
Message-ID: <482D31B8.8000707@viscovery.net>
References: <482C85C8.90804@facebook.com> <7vej83gxjm.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0805152131390.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Reiss <dreiss@facebook.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 16 09:04:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwtzB-0001Ia-C4
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 09:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805AbYEPHDX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 03:03:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751904AbYEPHDX
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 03:03:23 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:41957 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751678AbYEPHDW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 03:03:22 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1JwtyL-0004ds-1x; Fri, 16 May 2008 09:03:21 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id CE21B6C4; Fri, 16 May 2008 09:03:20 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0805152131390.30431@racer>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82260>

Johannes Schindelin schrieb:
> On Thu, 15 May 2008, Junio C Hamano wrote:
> 
>> David Reiss <dreiss@facebook.com> writes:
>> How well would this colon separated list work with msys folks?
> 
> Not well at all.  At least for the moment, I think setting this variable 
> would fail (since it would be rewritten into a Windows-PATH-style string).  
> Though honestly, I have no idea what getcwd() does on MinGW.

We would have to use ';' instead of ':' in longest_prefix(). Then it will
work automatically. Except that it does not ignore case in path names and
drive letters. Hence, the user must set this environment variable to the
precise path name(s).

> Steffen is working on that rewriting stuff, so maybe it will be a 
> non-issue, eventually.

This will not matter. When we change the code to use is_path_separator()
instead of hard-coded c == ':', then it will work automatically. We do
that already for GIT_ALTERNATE_OBJECT_DIRECTORIES.

-- Hannes
