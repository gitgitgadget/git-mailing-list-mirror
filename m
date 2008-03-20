From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Invalid refspec?
Date: Thu, 20 Mar 2008 12:08:47 -0700
Message-ID: <7vhcf1w6v4.fsf@gitster.siamese.dyndns.org>
References: <2008-03-20-11-53-31+trackit+sam@rfc1149.net>
 <alpine.LNX.1.00.0803200914420.19665@iabervon.org>
 <7vy78dwdh2.fsf@gitster.siamese.dyndns.org>
 <alpine.LNX.1.00.0803201256080.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Samuel Tardieu <sam@rfc1149.net>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Mar 20 20:09:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcQ92-0003EZ-W9
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 20:09:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754291AbYCTTJD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 15:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751863AbYCTTJD
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 15:09:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:47068 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754110AbYCTTJC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 15:09:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 3D66E3000;
	Thu, 20 Mar 2008 15:08:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 2D7402DE0; Thu, 20 Mar 2008 15:08:52 -0400 (EDT)
In-Reply-To: <alpine.LNX.1.00.0803201256080.19665@iabervon.org> (Daniel
 Barkalow's message of "Thu, 20 Mar 2008 13:12:38 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77681>

Daniel Barkalow <barkalow@iabervon.org> writes:

> ... but there's no particular need to give a 
> different error for "HEAD~1:foo" versus 
> "e83c5163316f89bfbde7d9ab23ca2e25604af290:foo" based on the presence of a 
> ~.

This is a valid argument in that e83c51... could be (and currently has to
be) a ref name in a fetch refspec.

But we still need to reject something like "HEAD**1:foo".
