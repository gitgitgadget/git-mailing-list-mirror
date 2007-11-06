From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] Reduce the number of connects when fetching
Date: Tue, 06 Nov 2007 00:34:00 -0800
Message-ID: <7v7ikvkc1z.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711041614390.7357@iabervon.org>
	<7v1wb4kuoc.fsf@gitster.siamese.dyndns.org>
	<47302218.3060409@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 06 09:34:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpJtB-0005bA-PY
	for gcvg-git-2@gmane.org; Tue, 06 Nov 2007 09:34:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753417AbXKFIeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Nov 2007 03:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752605AbXKFIeK
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Nov 2007 03:34:10 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54563 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951AbXKFIeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Nov 2007 03:34:09 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E5FF32EF;
	Tue,  6 Nov 2007 03:34:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 2200D9095F;
	Tue,  6 Nov 2007 03:34:24 -0500 (EST)
In-Reply-To: <47302218.3060409@viscovery.net> (Johannes Sixt's message of
	"Tue, 06 Nov 2007 09:13:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63642>

Johannes Sixt <j.sixt@viscovery.net> writes:

> The tags that the server provides are those (and only those[*]) that
> reference objects in the packfile that it's going to send.
>
> [*] This way the client doesn't have to figure out which tags it
> wants; ...

Yes, but that shifts the burden to the sending side which is
always bad.  We want to make the client work as much as possible
when it is practical.
