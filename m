From: Junio C Hamano <gitster@pobox.com>
Subject: Re: why still no empty directory support in git
Date: Mon, 29 Dec 2008 23:45:18 -0800
Message-ID: <7viqp25coh.fsf@gitster.siamese.dyndns.org>
References: <46dff0320812291942y6aeec941k9394586621e9151b@mail.gmail.com>
 <alpine.DEB.2.00.0812300008060.31590@vellum.laroia.net>
 <3ab397d0812292128j65e2e1e1xf403a998f4653aac@mail.gmail.com>
 <200812300758.41988.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jeff Whiteside" <jeff.m.whiteside@gmail.com>,
	"Asheesh Laroia" <asheesh@asheesh.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Tue Dec 30 08:46:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LHZJY-0006J6-Qw
	for gcvg-git-2@gmane.org; Tue, 30 Dec 2008 08:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbYL3Hpe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Dec 2008 02:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751551AbYL3Hpe
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Dec 2008 02:45:34 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34901 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbYL3Hpd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Dec 2008 02:45:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 443548BA35;
	Tue, 30 Dec 2008 02:45:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C87DF8BA34; Tue,
 30 Dec 2008 02:45:20 -0500 (EST)
In-Reply-To: <200812300758.41988.robin.rosenberg.lists@dewire.com> (Robin
 Rosenberg's message of "Tue, 30 Dec 2008 07:58:41 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D26E59EC-D645-11DD-A988-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104166>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:

> You can have an empty tree, but the index doesn't store them, so they
> would be lost on checkout/commit. Linus sketched a solution, but nobody
> took the bait. Seems doable if anyone really wants it, but I'm certain
> it adds a lot of special cases.

I think the original poster covered that "a lot of special cases" as
"unclear semantics", and there are more.  Do you want to have the presense
of empty directory "sticky"?  Perhaps it later becomes non-empty at some
point; will the "will always present" attribute kept then?  What happens
when such a directory becomes empty later?  What should happen when a
branch that has such a directory with "sticky existence" and another
branch with the same directory but without the stickiness are merged?

But I think one bigger reason missing from the list is that many people
loudly talked about "wants", but nobody made convincing argument on
"needs" of such a feature.
