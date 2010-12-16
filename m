From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: How to unpack recent objects?
Date: Thu, 16 Dec 2010 17:06:59 -0500
Message-ID: <4D0A8D83.9080705@cfl.rr.com>
References: <4D0A77A7.9080702@cfl.rr.com> <alpine.LFD.2.00.1012161616170.10437@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Dec 16 23:05:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTLxU-0000nt-7W
	for gcvg-git-2@lo.gmane.org; Thu, 16 Dec 2010 23:05:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756776Ab0LPWFs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 17:05:48 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:62433 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755201Ab0LPWFr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Dec 2010 17:05:47 -0500
Authentication-Results: cdptpa-omtalb.mail.rr.com smtp.user=psusi@cfl.rr.com; auth=pass (PLAIN)
X-Authority-Analysis: v=1.1 cv=uESSSoDEku2quKX/oFXS2Smn5+55LTFcWFr5T5T8nFs= c=1 sm=0 a=Tegedtfkc20A:10 a=8nJEP1OIZ-IA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:17 a=l6hnJiYQ2ZinPb6tiKEA:9 a=iVf76xgksS5H-kO1yLF3h1YeD2YA:4 a=wPNLvfGTeEIA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 72.242.190.170
Received: from [72.242.190.170] ([72.242.190.170:1529] helo=[10.1.1.235])
	by cdptpa-oedge01.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTPA
	id DF/A2-07087-93D8A0D4; Thu, 16 Dec 2010 22:05:46 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <alpine.LFD.2.00.1012161616170.10437@xanadu.home>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163821>

On 12/16/2010 4:19 PM, Nicolas Pitre wrote:
> What makes you think that unpacking them will actually make the access 
> to them faster?  Instead, you should consider _repacking_ them, 
> ultimately using the --aggressive parameter with the gc command, if you 
> want faster accesses.

Because decompressing and undeltifying the objects in the pack file
takes a fair amount of cpu time.  It seems a waste to do this for the
same set of objects repeatedly rather than just keeping them loose.
