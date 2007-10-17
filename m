From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: On Tabs and Spaces
Date: Wed, 17 Oct 2007 07:23:31 -0400
Message-ID: <6A484AE6-ECCD-4473-BEF8-3451EBF8FAFF@mit.edu>
References: <634393B0-734A-4884-93E3-42F7D3CB157F@mit.edu> <B2F6DB0C-4EFE-4C56-8E7A-31820320CA02@mit.edu> <3awb7zw6.fsf@blue.sea.net> <alpine.LFD.0.999.0710161214530.6887@woody.linux-foundation.org> <1192565900.6430.16.camel@athena> <alpine.LFD.0.999.0710161559150.6887@woody.linux-foundation.org> <20071017015109.303760cc@localhost.localdomain> <alpine.LFD.0.999.0710161722320.26902@woody.linux-foundation.org> <3A9408D5-2667-43A6-A0CE-C0720B3A3987@vicaya.com> <E29971BA-7306-4570-8383-26D0C9C0B814@mit.edu> <dbfc82860710170321l458ebd1cr6bf619cef9bb7300@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nikolai Weibull <now@bitwi.se>
X-From: git-owner@vger.kernel.org Wed Oct 17 13:24:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ii70l-00016j-TY
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 13:24:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758715AbXJQLYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 07:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758393AbXJQLYR
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 07:24:17 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:57044 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757732AbXJQLYQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Oct 2007 07:24:16 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id l9HBNeDx002850;
	Wed, 17 Oct 2007 07:23:45 -0400 (EDT)
Received: from [18.239.2.43] (WITTEN.MIT.EDU [18.239.2.43])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id l9HBNYvj016195
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 17 Oct 2007 07:23:35 -0400 (EDT)
In-Reply-To: <dbfc82860710170321l458ebd1cr6bf619cef9bb7300@mail.gmail.com>
X-Mailer: Apple Mail (2.752.2)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61369>

On 17 Oct 2007, at 6:21:30 AM, Nikolai Weibull wrote:

> According to this calculation the waste is 47808782 bytes, or about
> 45.6 MiB, for 8-spaces-wide tabs.

I concede my calculation was crude.

Interestingly, modifying my calculation to look
for tabs at the beginning of the line gives a
similar result:

     # calculates the extra space required to
     # use the given number of spaces/tab.
     size()
     {
         count=`grep -RIo "^\`printf \"\t\"\`" . | wc -l`;
         perl -e "print $count*$(($1-1))/1024/1024 . \" MiB\n\"";
     }

     size 8; => 49.7416791915894 MiB

and for git:
	
     size 8; => 1.25082969665527 MiB


Anyway, thanks for the neat script.

mfwitten
