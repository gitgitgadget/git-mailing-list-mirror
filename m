From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: [PATCH] Use exit 1 instead of die when req_Root fails.
Date: Wed, 17 Oct 2007 14:40:41 -0400
Message-ID: <8B2F7666-DCEB-4D58-ACFE-F40587CD415D@silverinsanity.com>
References: <20071017140547.GA21691@Hermes.cust.hotspot.t-mobile.com> <118833cc0710170739i179e7389k1e44f70086ca88be@mail.gmail.com> <DC3D43FD-F03D-4E0A-9C2B-DE56F9C16D60@silverinsanity.com> <8c5c35580710170839l4b31a4fao5b41efafc5a83883@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Morten Welinder" <mwelinder@gmail.com>, git@vger.kernel.org,
	spearce@spearce.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 17 20:40:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiDow-0002ol-Hy
	for gcvg-git-2@gmane.org; Wed, 17 Oct 2007 20:40:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754502AbXJQSka (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Oct 2007 14:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753131AbXJQSka
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Oct 2007 14:40:30 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:38601 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbXJQSk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Oct 2007 14:40:29 -0400
Received: from [192.168.1.2] (cpe-69-205-115-17.rochester.res.rr.com [69.205.115.17])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id 8F4521FFC22E;
	Wed, 17 Oct 2007 18:40:26 +0000 (UTC)
In-Reply-To: <8c5c35580710170839l4b31a4fao5b41efafc5a83883@mail.gmail.com>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61406>

I wish I got this much attention the first time I tried to get this  
problem fixed.  ;-)

On Oct 17, 2007, at 11:39 AM, Lars Hjemli wrote:

> This makes me wonder: what about all the other instances of die() in
> git-cvsserver? Or in any of the other perl scripts, for that matter?
> Should they all be fixed, or is it this particular test that is wrong?

The reason this comes up is because t/test-lib.sh:test_expect_failure 
() thinks codes > 128 (or negative values if you want to look at it  
that way) are bad tests.  I believe this is because many shells use  
these codes to indicate things like "command not found" or other  
probably unexpected failures.

Other than that, does it matter what die() returns, as long as it's  
non-zero?

~~Brian
