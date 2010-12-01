From: Spelic <spelic@shiftmail.org>
Subject: Re: Forward-port a patch using git
Date: Wed, 01 Dec 2010 19:11:23 +0100
Message-ID: <4CF68FCB.2030301@shiftmail.org>
References: <4CF66BAA.1010203@shiftmail.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 01 19:12:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNrAS-0003f4-0T
	for gcvg-git-2@lo.gmane.org; Wed, 01 Dec 2010 19:12:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753034Ab0LASMa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Dec 2010 13:12:30 -0500
Received: from mx2.isti.cnr.it ([194.119.192.4]:4370 "EHLO mx2.isti.cnr.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752844Ab0LASMa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Dec 2010 13:12:30 -0500
Received: from SCRIPT-SPFWL-DAEMON.mx.isti.cnr.it by mx.isti.cnr.it
 (PMDF V6.5 #31825) id <01NUX0ZJTIDCLS6UTX@mx.isti.cnr.it> for
 git@vger.kernel.org; Wed, 01 Dec 2010 19:11:22 +0100 (MET)
Received: from conversionlocal.isti.cnr.it by mx.isti.cnr.it (PMDF V6.5 #31825)
 id <01NUX0ZJJCVKLS6VHB@mx.isti.cnr.it> for git@vger.kernel.org; Wed,
 01 Dec 2010 19:11:21 +0100 (MET)
Received: from [192.168.7.52] (firewall.itb.cnr.it [155.253.6.254])
 by mx.isti.cnr.it (PMDF V6.5 #31826)
 with ESMTPSA id <01NUX0ZIMZ6QLX4D33@mx.isti.cnr.it> for git@vger.kernel.org;
 Wed, 01 Dec 2010 19:11:20 +0100 (MET)
In-reply-to: <4CF66BAA.1010203@shiftmail.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11)
 Gecko/20100713 Thunderbird/3.0.6
X-INSM-ip-source: 155.253.6.254 Auth Done
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162563>

On 12/01/2010 04:37 PM, Spelic wrote:
> Hi all
> I have patches (xyz.patch files) which apply cleanly to kernel 2.6.36 
> and 2.6.36.1 and do not apply cleanly on 2.6.37-rc4 (I mean they do 
> apply but with massive offsets...)
> I would like to forward-port them to 2.6.37-rc4, i.e. create 
> equivalent patch files that would apply cleanly on 2.6.37-rc4 with 
> zero offsets.
>

I found it myself, sorry for having asked.

It was:

checkout v2.6.36
apply 1 patch
commit
apply 1 patch
commit
...
rebase v2.6.37-rc4
git format-patch -o <destdir> -numpatches
