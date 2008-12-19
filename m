From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge
 commit.
Date: Thu, 18 Dec 2008 19:03:46 -0800
Message-ID: <7vej04eui5.fsf@gitster.siamese.dyndns.org>
References: <200812182039.15169.bss@iguanasuicide.net>
 <alpine.DEB.1.00.0812190353520.14632@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Dec 19 04:05:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDVft-00086k-5p
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 04:05:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462AbYLSDDz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 22:03:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752428AbYLSDDy
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 22:03:54 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58108 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751519AbYLSDDy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 22:03:54 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1E89288BB6;
	Thu, 18 Dec 2008 22:03:53 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id EFB0588BB4; Thu,
 18 Dec 2008 22:03:48 -0500 (EST)
In-Reply-To: <alpine.DEB.1.00.0812190353520.14632@racer> (Johannes
 Schindelin's message of "Fri, 19 Dec 2008 03:57:57 +0100 (CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AACA880E-CD79-11DD-948B-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103534>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Wow.  That must be one of the, uhm, less beautiful ways to write
>
> 		if (action == REVERT)
> 			warning("revert on a merge commit may not do what you "
> 				"expect.");
> 		else if (action != CHERRY_PICK)
> 			die("Unknown action on a merge commit.");
>
> Besides, I am actually pretty much against this change.  You already have 
> to ask very explicitely to revert a merge, by specifying a parent number.  
> If I ask for something explicitely, I do not want the tool to tell me that 
> it's dangerous.  I know that already, thankyouverymuch.

Or you may not have known that it is dangerous, but the new warning does
not give you enough clue where to go next, so this warning does not give
real value.  It is pretty much meaningless noise to users.
