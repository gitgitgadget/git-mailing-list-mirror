From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] git-rebase fails when a commit message contains a diff
Date: Thu, 08 Nov 2007 17:39:48 -0800
Message-ID: <7vlk98xkm3.fsf@gitster.siamese.dyndns.org>
References: <20071109011214.GA5903@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonas Fonseca <fonseca@diku.dk>
X-From: git-owner@vger.kernel.org Fri Nov 09 02:40:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqIqv-0004hh-MF
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 02:40:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751360AbXKIBjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 20:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbXKIBjz
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 20:39:55 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60398 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbXKIBjy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 20:39:54 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 08EC32F2;
	Thu,  8 Nov 2007 20:40:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id A063E93A08;
	Thu,  8 Nov 2007 20:40:11 -0500 (EST)
In-Reply-To: <20071109011214.GA5903@diku.dk> (Jonas Fonseca's message of "Fri,
	9 Nov 2007 02:12:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64110>

That's a known design limitation of applymbox/mailinfo.  Any
line that looks like a beginning of a patch in e-mail ("^--- ",
"^---$", "^diff -", and "^Index: ") terminates the commit log.
