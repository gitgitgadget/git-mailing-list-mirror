From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH] git-cvsserver runs hooks/post-receive
Date: Fri, 30 Nov 2007 07:26:41 -0500
Message-ID: <BDA3CE08-FFA4-4D84-A2FC-5810AAA6EEAB@MIT.EDU>
References: <1195809174-28142-1-git-send-email-mfwitten@mit.edu> <7v3aup291c.fsf@gitster.siamese.dyndns.org> <7F81126E-5A76-40CA-94BF-82B46C57AFF6@mit.edu> <Pine.LNX.4.64.0711301202230.27959@racer.site>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 30 13:27:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iy4xf-0000sp-FZ
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 13:27:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752496AbXK3M04 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Nov 2007 07:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752678AbXK3M04
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Nov 2007 07:26:56 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:39939 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751483AbXK3M0z (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Nov 2007 07:26:55 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id lAUCQhBi017114;
	Fri, 30 Nov 2007 07:26:44 -0500 (EST)
Received: from [18.239.5.240] (MACGREGOR-TWO-FORTY.MIT.EDU [18.239.5.240])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id lAUCQgr1016223
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 30 Nov 2007 07:26:43 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711301202230.27959@racer.site>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66639>


On 30 Nov 2007, at 7:03:15 AM, Johannes Schindelin wrote:

> Hi,
>
> On Thu, 29 Nov 2007, Michael Witten wrote:
>
>> In any case, I haven't taken a thorough look at how git-cvsserver  
>> works,
>> but it seems to duplicate a lot of git-receive-pack.
>>
>> How about turning git-cvsserver into a true middleman, so that it
>> constructs a 'temporary git working tree' and then does a real git- 
>> push
>> into the final git repository.
>
> That would yield a horrible performance.
>
> Would be opposed, if a regular cvsserver user,

How come?

git-cvsserver it seems already does just that!
The difference is that it puts objects in place
by hand, requiring the code to mirror hook calls
anyway.

I'm simply proposing that the code be reworked,
so that cvs commits actually become git pushes,
so that all future changes to the pushing mechanism
are automatically handled.

It just makes sense as far as design; git-cvsserver
should be an adaptor between the two kinds of repositories,
not an infiltrator.
