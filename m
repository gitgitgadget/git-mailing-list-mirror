From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add an "-i" option to git-reset, to confirm a reset.
Date: Sun, 16 Dec 2007 12:09:40 -0800
Message-ID: <7vwsrejta3.fsf@gitster.siamese.dyndns.org>
References: <1197775596-14329-1-git-send-email-kelvie@ieee.org>
	<Pine.LNX.4.64.0712160332140.27959@racer.site>
	<94ccbe710712151946u22f02a8fkbc3c4cbc96ee22f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: "Kelvie Wong" <kelvie@ieee.org>
X-From: git-owner@vger.kernel.org Sun Dec 16 21:10:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3zoj-0006gS-JS
	for gcvg-git-2@gmane.org; Sun, 16 Dec 2007 21:10:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823AbXLPUJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2007 15:09:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364AbXLPUJ7
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Dec 2007 15:09:59 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56640 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752870AbXLPUJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2007 15:09:58 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E579249EF;
	Sun, 16 Dec 2007 15:09:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id C02DF49EC;
	Sun, 16 Dec 2007 15:09:47 -0500 (EST)
In-Reply-To: <94ccbe710712151946u22f02a8fkbc3c4cbc96ee22f5@mail.gmail.com>
	(Kelvie Wong's message of "Sat, 15 Dec 2007 19:46:10 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68484>

"Kelvie Wong" <kelvie@ieee.org> writes:

> On Dec 15, 2007 7:35 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> ..
>> I am slightly negative on this patch.  Not only do I think that it is both
>> easier and more natural to run diff/status/an-alias to see what a reset
>> would do, but the patch only handles the index_file part (missing the --
>> <file> part AFAICT).

I am in principle very negative on additional option that does the same
thing as what the users on odd occasions can run a separate command
themselves to achieve, and I think "reset -i" falls into that category.

And I am negative on this "-i" not just because I think that would be
only in "odd occasions" (i.e. rare), but because I think it would not
help much.  Either you are sure about resetting, in which case you would
not even use "-i" option (and not get this safety), or you are unsure,
in which case you can do "git status" or whatever commands that are
already available.

> w.r.t. the style, you were referring to just the array initializers
> right?  Or was there something else I did that doesn't look right?

I spotted only two classes.

+
+	/* Show the user what is about to be reset, and in more detail, if they
+	 * like. */

	/*
         * Show the user what is about to be reset, and in more detail,
         * if they like.
         */

+	if(confirm_reset) {

	if (confirm_reset) {
