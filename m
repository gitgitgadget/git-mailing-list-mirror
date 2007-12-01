From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH] git-cvsserver runs hooks/post-receive
Date: Fri, 30 Nov 2007 19:19:32 -0500
Message-ID: <AB064BA5-1F99-4CCF-9BA5-048BB14E9157@MIT.EDU>
References: <1195809174-28142-1-git-send-email-mfwitten@mit.edu> <7v3aup291c.fsf@gitster.siamese.dyndns.org> <7F81126E-5A76-40CA-94BF-82B46C57AFF6@mit.edu> <Pine.LNX.4.64.0711301202230.27959@racer.site> <BDA3CE08-FFA4-4D84-A2FC-5810AAA6EEAB@MIT.EDU> <47500F0B.10300@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 01 01:20:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyG5d-00064M-EY
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 01:20:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755930AbXLAATw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 19:19:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755864AbXLAATw
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 19:19:52 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:52312 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755869AbXLAATv (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Nov 2007 19:19:51 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id lB10JZ72001005;
	Fri, 30 Nov 2007 19:19:35 -0500 (EST)
Received: from [18.239.5.240] (MACGREGOR-TWO-FORTY.MIT.EDU [18.239.5.240])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id lB10JXto002636
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 30 Nov 2007 19:19:34 -0500 (EST)
In-Reply-To: <47500F0B.10300@viscovery.net>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66669>


On 30 Nov 2007, at 8:24:27 AM, Johannes Sixt wrote:

>> The difference is that it puts objects in place
>> by hand, requiring the code to mirror hook calls
>> anyway.
>> I'm simply proposing that the code be reworked,
>> so that cvs commits actually become git pushes,
>> so that all future changes to the pushing mechanism
>> are automatically handled.
>
> But in order push something, you must first have the commit in a  
> repository. How would git-cvsserver do that? For example, by  
> putting objects in place by hand. You gain nothing, except that it  
> would push instead of call the hooks directly.

"The difference is that it puts objects in place
by hand, requiring the code to mirror hook calls
anyway."

As far as I can tell, hook calls are the only thing.

However, I still had to write a patch to include post-receive;
by doing everything by hand, git-cvsserver is inherently unsafe
and incomplete over time.

The question is not the RESULT, but HOW YOU GET that result;
the current design is---essentially---a hack; it is written
in perl, after all ;-P
