From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-shell needs $(COMPAT_OBJS)
Date: Sun, 20 Jul 2008 15:38:53 -0700
Message-ID: <7vprp82nb6.fsf@gitster.siamese.dyndns.org>
References: <200807202111.48332.johannes.sixt@telecom.at>
 <200807202334.36506.johannes.sixt@telecom.at>
 <7vzloc2odx.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0807210034050.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 21 00:40:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKhZV-0006ta-0y
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 00:40:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752626AbYGTWjF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 18:39:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752421AbYGTWjD
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 18:39:03 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58122 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751668AbYGTWjB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 18:39:01 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id A3A6F37A5C;
	Sun, 20 Jul 2008 18:38:59 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EEA1437A4C; Sun, 20 Jul 2008 18:38:55 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0807210034050.3305@eeepc-johanness> (Johannes
 Schindelin's message of "Mon, 21 Jul 2008 00:35:18 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A52D607C-56AC-11DD-9E0D-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89251>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 20 Jul 2008, Junio C Hamano wrote:
>
>> Why do we care about the size of git-shell so much in the first place 
>> anyway to begin with?
>
> It was not me who proposed it, but I guess it was for auditing purposes: 
> git-shell is often the only point of entry for certain untrusted ssh 
> users, and the less code is linked, the less code has to be analyzed for 
> reachability (and then for security holes).

That's a rather misguided approach, isn't it?

After all, the work requested by the end user will be handled by code in
the main git executable by spawning a subprocess, and you are auditing the
codepath that leads to the spawning anyway.
