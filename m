From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: statistics
Date: Fri, 25 Jul 2008 15:34:38 +0200
Message-ID: <4889D66E.9090802@viscovery.net>
References: <4889B66D.4020306@keyaccess.nl> <4889B912.9040006@viscovery.net> <alpine.DEB.1.00.0807251519290.11976@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Rene Herman <rene.herman@keyaccess.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Jul 25 15:35:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMNSQ-0000uW-4T
	for gcvg-git-2@gmane.org; Fri, 25 Jul 2008 15:35:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753362AbYGYNel (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Jul 2008 09:34:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753355AbYGYNel
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Jul 2008 09:34:41 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:25704 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753285AbYGYNek (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Jul 2008 09:34:40 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KMNRO-0000cc-Iw; Fri, 25 Jul 2008 15:34:38 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 4FDA5AFCC; Fri, 25 Jul 2008 15:34:38 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <alpine.DEB.1.00.0807251519290.11976@eeepc-johanness>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 0.2 (/)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_80=2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90049>

Johannes Schindelin schrieb:
> On Fri, 25 Jul 2008, Johannes Sixt wrote:
> 
>>   comm -13 <(git diff --name-only your-rev-here) <(git ls-files)
> 
> But should it not be -12?

I don't think so:

  -1 .. suppress lines unique to 1st arg, i.e. removed files
  -2 .. suppress lines unique to 2nd arg, i.e. unmodified files
  -3 .. suppress lines in both, i.e. modified and added files

We want to keep lines that -2 would remove, that leaves -1 and -3.

-- Hannes
