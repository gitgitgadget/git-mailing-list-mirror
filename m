From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Fix compilation of git.c
Date: Wed, 16 Nov 2005 07:54:30 +0100
Message-ID: <437AD7A6.6050906@op5.se>
References: <Pine.LNX.4.63.0511160243360.14176@wbgn013.biozentrum.uni-wuerzburg.de> <7v4q6de1oc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Nov 16 07:54:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcHBm-0007GI-6F
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 07:54:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030198AbVKPGyc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 Nov 2005 01:54:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbVKPGyc
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Nov 2005 01:54:32 -0500
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:45557 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S1751184AbVKPGyc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Nov 2005 01:54:32 -0500
Received: from vrrx50sn1.teliamobile.net (192.71.148.196) by pne-smtpout2-sn2.hy.skanova.net (7.2.060.1)
        id 4378EBDA000871B5 for git@vger.kernel.org; Wed, 16 Nov 2005 07:54:31 +0100
Received: from [212.181.228.90] (host-n13-90.homerun.telia.com [212.181.228.90])
	by vrrx50sn1.teliamobile.net (8.11.6/8.11.6) with ESMTP id jAG6sUf26088
	for <git@vger.kernel.org>; Wed, 16 Nov 2005 07:54:30 +0100
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <7v4q6de1oc.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12005>

Junio C Hamano wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> 
>>Some systems do not define GLOB_ABORTED and GLOB_NOMATCH.
> 
> 
> That's true, but the glob does not distinguish executables and
> others anyway, do wouldn't it be more portable and easier to do
> readdir, stat and list in the loop?
> 

Got one implementation of that too, but it doesn't sort the command list 
and I thought it was nice to have them that way while too lazy to 
implement myself.

OTOH, that switch/case thing was for debugging (forgot prefix=/usr when 
compiling...). I'm perfectly fine with

if (glob(....)) {
	error_out("friendly message");
}

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
