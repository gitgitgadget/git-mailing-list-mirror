From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Howto request: going home in the middle of something?
Date: Thu, 18 Oct 2007 12:37:50 +0200
Message-ID: <4717377E.1010604@viscovery.net>
References: <200710181144.22655.wielemak@science.uva.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jan Wielemaker <wielemak@science.uva.nl>
X-From: git-owner@vger.kernel.org Thu Oct 18 12:38:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiSlU-0001RD-OB
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 12:38:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762347AbXJRKhz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 06:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762278AbXJRKhy
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 06:37:54 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:46072 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762183AbXJRKhx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 06:37:53 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1IiSkz-0001Oj-Vg; Thu, 18 Oct 2007 12:37:38 +0200
Received: from [192.168.1.42] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 9F5C34E4; Thu, 18 Oct 2007 12:37:50 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <200710181144.22655.wielemak@science.uva.nl>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61514>

Jan Wielemaker schrieb:
> I've somewhere seen it in a mail, but I can't find it anymore. I have a
> bare central (public) repository and clones on various machines I work
> on. We all know it, you're right in the middle of something and it is
> really time to go home. You want to pick up your work at home, but
> without pushing to the shared repository.
> 
> I'm sure GIT can do this elegantly, but I'm not yet sure how.  I guess
> Ideally I want "git stash" at work, transfer the stashed changes to my
> other machine and apply them.  How do I do that?

One way is to use a bundle:

$ git checkout -b home
$ git bundle create home.bdl origin..home

Then put home.bdl on or USB stick or send by email. At home:

$ git fetch home.bdl home
$ git checkout -b to-be-continued FETCH_HEAD

You better make double sure that the commit "origin" that is used above is 
available at home.

Judge yourself whether this is "elegant".

-- Hannes
