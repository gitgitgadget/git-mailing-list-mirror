From: Junio C Hamano <gitster@pobox.com>
Subject: Re: MIME headers in introductory message (git send-email --compose)
Date: Tue, 25 Mar 2008 13:47:05 -0700
Message-ID: <7vhceuleeu.fsf@gitster.siamese.dyndns.org>
References: <1205426419-4594-1-git-send-email-sam@rfc1149.net>
 <7vhcfaxxxk.fsf@gitster.siamese.dyndns.org>
 <200803252031.17017.tlikonen@iki.fi>
 <76718490803251217q27ae4381h298ec6de8a4d965a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Teemu Likonen" <tlikonen@iki.fi>, git@vger.kernel.org,
	"Junio C Hamano" <gitster@pobox.com>,
	"Samuel Tardieu" <sam@rfc1149.net>
To: "Jay Soffian" <jaysoffian@gmail.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 25 21:48:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JeG3x-0000oJ-Gc
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 21:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbYCYUrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 16:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752058AbYCYUrX
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 16:47:23 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61779 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751975AbYCYUrX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 16:47:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E5F6825C7;
	Tue, 25 Mar 2008 16:47:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 1BA2A25C2; Tue, 25 Mar 2008 16:47:08 -0400 (EDT)
In-Reply-To: <76718490803251217q27ae4381h298ec6de8a4d965a@mail.gmail.com>
 (Jay Soffian's message of "Tue, 25 Mar 2008 15:17:10 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78219>

"Jay Soffian" <jaysoffian@gmail.com> writes:

> I stuck this in my config and it works-for-me:
>
> [format]
> 	headers = \
> "MIME-Version: 1.0\n\
> Content-Type: text/plain; charset=UTF-8\n\
> Content-Transfer-Encoding: 8bit\n"

I suspect that you shouldn't do this.  This would badly interfere both
with existing format-patch behaviour that adds these MIME-Version and
Content-Type headers by looking at the contents, and with recent
format-patch fix 6bf4f1b (format-patch: generate MIME header as needed
even when there is format.header, 2008-03-14) to make the detection based
on contents (and presense of format.headers).
