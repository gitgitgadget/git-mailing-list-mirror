From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: convert from perl internal to utf8 for commitdiff_plain
Date: Mon, 28 Jan 2008 21:39:27 -0800
Message-ID: <7vir1dqjg0.fsf@gitster.siamese.dyndns.org>
References: <87ve5dicih.wl@mail2.atmark-techno.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yasushi SHOJI <yashi@atmark-techno.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 06:40:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJjCt-0008Uo-62
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 06:40:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbYA2Fjz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jan 2008 00:39:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbYA2Fjz
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jan 2008 00:39:55 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48710 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750778AbYA2Fjy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jan 2008 00:39:54 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id D2CE6267B;
	Tue, 29 Jan 2008 00:39:51 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 5E70D2679;
	Tue, 29 Jan 2008 00:39:47 -0500 (EST)
In-Reply-To: <87ve5dicih.wl@mail2.atmark-techno.com> (Yasushi SHOJI's message
	of "Tue, 29 Jan 2008 11:14:00 +0900")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71948>

Yasushi SHOJI <yashi@atmark-techno.com> writes:

> This patch effectively revert the commitdiff plain part of the commit
>
> 	59b9f61a3f76762dc975e99cc05335a3b97ad1f9
>
> which converted from print to here-doc. but it doesn't
> explain why in the commit log.

I think the patch makes sense but the above is misleading.  Read
it again.

Doesn't it sound like you are accusing that 59b9f61a introduced
a regression when it converted existsing "print utf8()" to
"print <<here-doc" without saying that is what it is doing?

I think the change in that commit was meant for writability (I
do not necessarily think here-doc is good for readability), and
I personally do not care---Perl is ugly to read either way ;-)
