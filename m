From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: .git/info/refs
Date: Wed, 24 Jan 2007 08:24:22 -0800
Message-ID: <45B78836.5080508@zytor.com>
References: <45B70D06.3050506@zytor.com> <ep78r0$h2u$1@sea.gmane.org> <45B7818F.6020805@zytor.com> <Pine.LNX.4.63.0701241658490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 24 17:26:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9kvO-0001TG-8s
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 17:24:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751308AbXAXQYf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 11:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751586AbXAXQYf
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 11:24:35 -0500
Received: from terminus.zytor.com ([192.83.249.54]:34481 "EHLO
	terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbXAXQYe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 11:24:34 -0500
Received: from [172.27.0.16] (c-67-180-238-27.hsd1.ca.comcast.net [67.180.238.27])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.8/8.13.7) with ESMTP id l0OGOM6c032566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 24 Jan 2007 08:24:24 -0800
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
In-Reply-To: <Pine.LNX.4.63.0701241658490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Virus-Scanned: ClamAV 0.88.7/2486/Wed Jan 24 06:47:09 2007 on terminus.zytor.com
X-Virus-Status: Clean
X-Spam-Status: No, score=0.5 required=5.0 tests=AWL,BAYES_00,
	DATE_IN_FUTURE_48_96,RCVD_IN_SORBS_DUL autolearn=no version=3.1.7
X-Spam-Checker-Version: SpamAssassin 3.1.7 (2006-10-05) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37649>

Johannes Schindelin wrote:
> 
> To me, it seems like all boils down to caching parsed data structures. 
> I.e. parse the config, then serialize the parsed data to a file. Don't 
> reparse the config unless it is 1 hour older than the config.
> 
> Likewise, run for-each-ref, and serialize the parsed data into a file. 
> Don't rerun for-each-ref if that file is younger than 15 minutes.
> 
> Maybe the same for the first 200 commits of each branch.
> 
> (I made those times up, but you get the idea.)
> 

A much better idea is to have that data structure updated on repository 
updates, which is the whole point behind .git/info/refs.  On kernel.org, 
at least, if you don't keep .git/info/refs up to date you need to get 
your fingers whacked anyway, since it damages usability for one 
particular class of users.

	-hpa
