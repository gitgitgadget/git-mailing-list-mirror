From: Junio C Hamano <gitster@pobox.com>
Subject: Re: BUG: "git checkout" displays Q-escaped commit titles
Date: Sat, 03 May 2008 18:54:10 -0700
Message-ID: <7vlk2qsukd.fsf@gitster.siamese.dyndns.org>
References: <20080502133903.GA3079@mithlond.arda.local>
 <20080502140536.GA3518@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun May 04 03:55:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JsTRW-0007r4-N0
	for gcvg-git-2@gmane.org; Sun, 04 May 2008 03:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbYEDByX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 May 2008 21:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753467AbYEDByW
	(ORCPT <rfc822;git-outgoing>); Sat, 3 May 2008 21:54:22 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49971 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbYEDByW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 May 2008 21:54:22 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 98F732BF5;
	Sat,  3 May 2008 21:54:19 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 099412BF3; Sat,  3 May 2008 21:54:12 -0400 (EDT)
In-Reply-To: <20080502140536.GA3518@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 2 May 2008 10:05:36 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0298804C-197D-11DD-B57E-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81125>

Jeff King <peff@peff.net> writes:

> .... It seems like pp_title_line should perhaps just be checking
> for fmt == CMIT_FMT_EMAIL, but I'm not sure if that would break anything
> else,...

Yeah, your patch obviously would fix the caller, as subject and
after_subject should not be given unless you are doing FMT_EMAIL.  But I
also think we should not even look at subject and after_subject unless fmt
is CMIT_FMT_EMAIL inside pp_title_line().
