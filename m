From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: shell compatibility issues with SunOS 5.10
Date: Wed, 06 May 2009 08:45:30 +0200
Message-ID: <4A01320A.2050600@viscovery.net>
References: <20090506055913.GA9701@dektop>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 06 08:45:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M1at3-0005s5-IP
	for gcvg-git-2@gmane.org; Wed, 06 May 2009 08:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756826AbZEFGpl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 May 2009 02:45:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbZEFGpl
	(ORCPT <rfc822;git-outgoing>); Wed, 6 May 2009 02:45:41 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:22516 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753242AbZEFGpk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 May 2009 02:45:40 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M1asl-00060a-7U; Wed, 06 May 2009 08:45:37 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id DD45E6C4; Wed,  6 May 2009 08:45:30 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090506055913.GA9701@dektop>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118327>

Nguyen Thai Ngoc Duy schrieb:
> I did "make test" on a SunOS 5.10 and it failed. With the below patch,
> only t7400 and t8005 kept failing. For the first case, t7400.5 failed
> because extensive use of sed to normalize path in git-submodule.sh
> 
> 	# normalize path:
> 	# multiple //; leading ./; /./; /../; trailing /
> 	path=$(printf '%s/\n' "$path" |
> 		sed -e '
> 			s|//*|/|g
> 			s|^\(\./\)*||
> 			s|/\./|/|g
> 			:start
> 			s|\([^/]*\)/\.\./||
> 			tstart
> 			s|/*$||
> 		')

There was a lengthy thread that lead to this version of the sed
expression. Could you please tell what your sed has to say about it? It
works even on AIX 4.3.3.

-- Hannes
