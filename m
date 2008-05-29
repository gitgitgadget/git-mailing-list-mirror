From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git-what: explain what to do next
Date: Wed, 28 May 2008 22:09:46 -0700
Message-ID: <7vlk1tpug5.fsf@gitster.siamese.dyndns.org>
References: <1211877299-27255-1-git-send-email-sbejar@gmail.com>
 <200805290639.38134.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Thu May 29 07:11:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1aQL-0001yo-3v
	for gcvg-git-2@gmane.org; Thu, 29 May 2008 07:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbYE2FKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 May 2008 01:10:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbYE2FKB
	(ORCPT <rfc822;git-outgoing>); Thu, 29 May 2008 01:10:01 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:55035 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873AbYE2FKA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 May 2008 01:10:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AD4A23BC3;
	Thu, 29 May 2008 01:09:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 15DFF3BC2; Thu, 29 May 2008 01:09:55 -0400 (EDT)
In-Reply-To: <200805290639.38134.chriscool@tuxfamily.org> (Christian Couder's
 message of "Thu, 29 May 2008 06:39:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7C8ED72E-2D3D-11DD-BB66-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83175>

Christian Couder <chriscool@tuxfamily.org> writes:

> It seems not very friendly to just "return 1" when not bisecting.
> And before my last patch to use BISECT_START to check if we are bisecting, 
> it would perhaps have been better to use 'test -f "$GIT_DIR/BISECT_NAMES"'.

The reason for this silence is because Santi wants to call potential
culprits in turn and stop when one responds "Yeah, I am the guilty one who
threw a monkey wrench into the user's workflow".  For that to work, "No,
the user is not in the middle of any interaction with me" response needs
to be silent.
