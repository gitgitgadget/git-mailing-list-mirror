From: Charles Bailey <cbailey32@bloomberg.net>
Subject: Re: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Wed, 26 Mar 2014 22:46:16 +0000
Message-ID: <20140326224616.GA9454@hashpling.org>
References: <20140224073348.GA20221@sigill.intra.peff.net>
 <20140224074905.GE9969@sigill.intra.peff.net>
 <20140326110559.GA32625@hashpling.org>
 <20140326182103.GB7087@sigill.intra.peff.net>
 <20140326185153.GA12912@sigill.intra.peff.net>
 <xmqqr45oixa6.fsf@gitster.dls.corp.google.com>
 <20140326192536.GA13989@sigill.intra.peff.net>
 <20140326193359.GA14105@sigill.intra.peff.net>
 <20140326212227.GC6991@hashpling.org>
 <20140326215741.GA17716@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Mar 26 23:46:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSwaZ-0000zI-Pr
	for gcvg-git-2@plane.gmane.org; Wed, 26 Mar 2014 23:46:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199AbaCZWqW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Mar 2014 18:46:22 -0400
Received: from avasout06.plus.net ([212.159.14.18]:35120 "EHLO
	avasout06.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755910AbaCZWqW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Mar 2014 18:46:22 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout06 with smtp
	id iNmG1n0052iA9hg01NmH58; Wed, 26 Mar 2014 22:46:20 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=dodVCjQ4 c=1 sm=1 tr=0
 a=wpJ/2au8Z6V/NgdivHIBow==:117 a=wpJ/2au8Z6V/NgdivHIBow==:17 a=EBOSESyhAAAA:8
 a=0Bzu9jTXAAAA:8 a=zd_RDMET5nsA:10 a=ZWHkJ8qrxXAA:10 a=N2sEI2mohSIA:10
 a=BHUvooL90DcA:10 a=kj9zAlcOel0A:10 a=BNFp--SqAAAA:8 a=Ew9TdX-QAAAA:8
 a=3uCvuFcehay2wOQzRW4A:9 a=CjuIK1q_8ugA:10
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1WSwaO-0002WY-9M; Wed, 26 Mar 2014 22:46:16 +0000
Content-Disposition: inline
In-Reply-To: <20140326215741.GA17716@sigill.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245252>

On Wed, Mar 26, 2014 at 05:57:41PM -0400, Jeff King wrote:
> Hmm, so the year you got is actually: 1623969404. That still seems off
> to me by a factor 20. I don't know if this is really worth digging into
> that much further, but I wonder what you would get for timestamps of:
> 
>   99999999999999999
>   9999999999999999
>   999999999999999
>   etc.
> 

AIX goes negative at about the same time Linux and Solaris segfault:

9999999 Sun Apr 26 10:46:39 1970 -0700
99999999 Sat Mar 3 02:46:39 1973 -0700
999999999 Sat Sep 8 18:46:39 2001 -0700
9999999999 Sat Nov 20 10:46:39 2286 -0700
99999999999 Wed Nov 16 02:46:39 5138 -0700
999999999999 Thu Sep 26 18:46:39 33658 -0700
9999999999999 Sun May 20 10:46:39 318857 -0700
99999999999999 Sat Nov 7 02:46:39 3170843 -0700
999999999999999 Sat Jul 4 18:46:39 31690708 -0700
9999999999999999 Sat Jan 25 10:46:39 316889355 -0700
99999999999999999 Wed Sep 6 02:46:39 -1126091476 -0700
999999999999999999 Thu Oct 24 18:46:39 1623969404 -0700

So, very bogus values.

Charles.
