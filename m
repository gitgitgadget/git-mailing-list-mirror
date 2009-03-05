From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] better introduction of GIT with USE_NSEC defined
Date: Thu, 05 Mar 2009 10:11:33 +0100
Message-ID: <49AF9745.8050207@viscovery.net>
References: <cover.1236187259.git.barvik@broadpark.no> <6d937a859ca499f534eea08720fca84f3d4ded2f.1236187259.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Kjetil Barvik <barvik@broadpark.no>
X-From: git-owner@vger.kernel.org Thu Mar 05 10:13:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lf9de-0006AZ-6H
	for gcvg-git-2@gmane.org; Thu, 05 Mar 2009 10:13:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbZCEJLm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2009 04:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752817AbZCEJLl
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Mar 2009 04:11:41 -0500
Received: from lilzmailso02.liwest.at ([212.33.55.13]:51277 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752565AbZCEJLk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2009 04:11:40 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Lf9c6-00055P-Bh; Thu, 05 Mar 2009 10:11:34 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 0B4666C4; Thu,  5 Mar 2009 10:11:34 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <6d937a859ca499f534eea08720fca84f3d4ded2f.1236187259.git.barvik@broadpark.no>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112276>

Kjetil Barvik schrieb:
> -	istate->timestamp.sec = st.st_mtime;
> -#ifdef USE_NSEC
> +	istate->timestamp.sec = (unsigned int)st.st_mtime;
>  	istate->timestamp.nsec = (unsigned int)st.st_mtim.tv_nsec;
> -#else
> -	istate->timestamp.nsec = 0;
> -#endif

Doesn't this break on systems where st_mtime is time_t and st_mtim does
not exist?

-- Hannes
