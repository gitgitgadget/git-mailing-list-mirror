From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 05:09:19 -0400
Message-ID: <E29971BA-7306-4570-8383-26D0C9C0B814@mit.edu>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <471476B7.5050105@users.sourceforge.net> <8c5c35580710160204s5a4f9fb3j68c0a86c4d080cb7@mail.gmail.com> <47148F72.1090602@users.sourceforge.net> <1192548367.3821.4.camel@lt21223.campus.dmacc.edu> <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net> <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org> <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org> <20071017015109.303760cc@localhost.localdomain> <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 11:10:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii4ur-00012x-ID
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 11:10:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757702AbXJQJJc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 05:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757131AbXJQJJc
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 05:09:32 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:44533 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933604AbXJQJJ2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 05:09:28 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9H99P7g014738;
	Wed, 17 Oct 2007 05:09:26 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9H99OwP008052
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 17 Oct 2007 05:09:25 -0400 (EDT)
In-Reply-To: <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61354>


On 17 Oct 2007, at 3:17:08 AM, Luke Lu wrote:

> But I still haven't seen any compelling arguments against the "all  
> space" case

Overhead!

If you use 8 spaces instead of one tab,
that's using up 7x more space!

Consider:

     # calculates the extra space required to
     # use the given number of spaces/tab.
     size()
     {
         count=`grep -RIo "\`printf \"\t\"\`" . | wc -l`;
         perl -e "print $count*$(($1-1))/1024/1024 . \" MB\n\"";
     }

     Then in in a git working tree:

         size 8; # 1.28701210021973 MB
         size 4; # 0.551576614379883 MB

     In a linux kernel working tree:

         size 8; # 61.4902725219727 MB
         size 4; # 26.3529739379883 MB

Conclusion:

     Yikes!


I hate tabs, but I can't argue with that!

Michael Witten
