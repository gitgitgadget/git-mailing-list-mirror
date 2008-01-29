From: Junio C Hamano <gitster@pobox.com>
Subject: Re: --first-parent plus path limiting
Date: Tue, 29 Jan 2008 01:11:35 -0800
Message-ID: <7v63xdov20.fsf@gitster.siamese.dyndns.org>
References: <479EE405.1010001@viscovery.net>
	<7vk5ltow61.fsf@gitster.siamese.dyndns.org>
	<479EEC3D.9030100@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jan 29 10:13:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJmWS-0007PU-LY
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 10:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755786AbYA2JLs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 04:11:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754278AbYA2JLs
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 04:11:48 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57237 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754100AbYA2JLq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 04:11:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D34133C01;
	Tue, 29 Jan 2008 04:11:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E67F3C00;
	Tue, 29 Jan 2008 04:11:42 -0500 (EST)
In-Reply-To: <479EEC3D.9030100@viscovery.net> (Johannes Sixt's message of
	"Tue, 29 Jan 2008 10:05:01 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71971>

Johannes Sixt <j.sixt@viscovery.net> writes:

> I was expecting that it works like "First follow the first-parent, and
> then simplify the history with respect to builtin-fetch.c."

If you first follow the first-parent, the result will by
definition not have any merges, so there is nothing left to
simplify.  History simplification is about merge removal,
looking at all parents.

Removing commits from a single strand of pearls that do not
touch the specified pathspecs is called "--dense" (which is on
the default) and can be disabled with "--sparse".

So, no, it is not a matter of definition, as "first follow the
first-parent then simplify" does not make much sense.
