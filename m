From: Guido Ostkamp <git@ostkamp.fastmail.fm>
Subject: Re: [RFH] Solaris portability
Date: Sun, 18 Nov 2007 13:08:20 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0711181302360.3945@bianca.dialin.t-online.de>
References: <7vy7d08her.fsf@gitster.siamese.dyndns.org>
 <1195089303-28085-1-git-send-email-B.Steinbrink@gmx.de>
 <Pine.LNX.4.64.0711152253430.4090@bianca.dialin.t-online.de>
 <7v640340kp.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0711161954510.7139@bianca.dialin.t-online.de>
 <7vtznlww0t.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Guido Ostkamp <git@ostkamp.fastmail.fm>, git@vger.kernel.org,
	Shawn O Pearce <spearce@spearce.org>,
	Jason Riedy <ejr@EECS.Berkeley.EDU>,
	Dennis Stosberg <dennis@stosberg.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 18 13:08:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItixJ-0006cN-42
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 13:08:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751844AbXKRMIg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 07:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751760AbXKRMIg
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 07:08:36 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:56935 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751505AbXKRMIf (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Nov 2007 07:08:35 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id EC42346F03;
	Sun, 18 Nov 2007 07:08:33 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Sun, 18 Nov 2007 07:08:34 -0500
X-Sasl-enc: JRh8FdSrySkp9AlZ8zoogT+HEoZyHaMWlX7v779isjBn 1195387713
Received: from [192.168.2.101] (p549A2F35.dip0.t-ipconnect.de [84.154.47.53])
	by mail.messagingengine.com (Postfix) with ESMTP id 44E8228D5E;
	Sun, 18 Nov 2007 07:08:32 -0500 (EST)
In-Reply-To: <7vtznlww0t.fsf_-_@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65368>

On Fri, 16 Nov 2007, Junio C Hamano wrote:
> This makes me wonder if treating it just like strcasestr() might be 
> simpler.  Could folks with access to Solaris boxes of different vintages 
> please see if the attached patch makes sense?

I think the patch makes sense as neither Solaris 8, 9 nor 10 supports 
mkdtemp().

> Can we also unify UNSETENV, SETENV, C99_FORMAT and STRTOUMAX, by the 
> way?

No.

I've just checked on our Solaris Sparc systems, and found that the 
C-library provides unsetenv(), setenv() and strtoumax() beginning with 
Solaris 10; also the 'man sprintf' page mentions the 'z' and 't' 
specifiers for printf (which is what is behind C99_FORMAT) only beginning 
with Solaris 10.

So workarounds are needed for all 4 cases for Solaris 8 and 9 but not 10.

Regards

Guido
