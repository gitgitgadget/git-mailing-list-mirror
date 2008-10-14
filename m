From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Problem with CRLF line endings and colored diff
Date: Tue, 14 Oct 2008 15:20:45 -0700
Message-ID: <7v4p3e7r9e.fsf@gitster.siamese.dyndns.org>
References: <48F50B97.9090106@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Jean-Luc Herren <jlh@gmx.ch>
X-From: git-owner@vger.kernel.org Wed Oct 15 00:22:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpsHD-00010L-FL
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 00:22:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751499AbYJNWUw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 18:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751568AbYJNWUw
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 18:20:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:49392 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbYJNWUv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 18:20:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 497748AA93;
	Tue, 14 Oct 2008 18:20:50 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 7883C8AA91; Tue, 14 Oct 2008 18:20:47 -0400 (EDT)
In-Reply-To: <48F50B97.9090106@gmx.ch> (Jean-Luc Herren's message of "Tue, 14
 Oct 2008 23:13:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 5B63E008-9A3E-11DD-A990-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98219>

Jean-Luc Herren <jlh@gmx.ch> writes:

>     <GREEN FOREGROUND>+<RESET><GREEN FOREGROUND>
>     line2<RESET><RED BACKGROUND><CR><RESET><LF>

This is expected and deliberate, as you haven't told about your desire to
consider carriage-returns not as line termination letter.  By default CR
is just one of the whitespace letters, and colored diff output is
reminding you that you introduced a line with a trailing whitespace.

Check git-config(1) and look for "core.whitespace", paying special
attention to "cr-at-eol".
