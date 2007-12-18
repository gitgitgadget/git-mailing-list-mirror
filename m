From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] provide advance warning of some future pack default changes
Date: Mon, 17 Dec 2007 16:41:19 -0800
Message-ID: <7vbq8o4yxc.fsf@gitster.siamese.dyndns.org>
References: <7vsl2jh3rb.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999999.0712132227090.8467@xanadu.home>
	<m3fxy5qwbq.fsf@roke.D-201>
	<alpine.LFD.0.999999.0712140836140.8467@xanadu.home>
	<20071214215206.GB7300@mail.oracle.com>
	<alpine.LFD.0.999999.0712141724260.8467@xanadu.home>
	<20071214223957.GC7300@mail.oracle.com>
	<alpine.LFD.0.999999.0712141744460.8467@xanadu.home>
	<20071215004230.GF7300@mail.oracle.com>
	<alpine.LFD.0.999999.0712142114400.8467@xanadu.home>
	<20071217200920.GB19816@mail.oracle.com>
	<alpine.LFD.0.999999.0712171517320.8467@xanadu.home>
	<7v3au16myj.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.0.999999.0712171641460.8467@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Joel Becker <Joel.Becker@oracle.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Dec 18 01:42:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4QXC-00032S-N9
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 01:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756317AbXLRAlp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 19:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759968AbXLRAlp
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 19:41:45 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34302 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756317AbXLRAlo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 19:41:44 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 3F95740D2;
	Mon, 17 Dec 2007 19:41:38 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8728940D0;
	Mon, 17 Dec 2007 19:41:32 -0500 (EST)
In-Reply-To: <alpine.LFD.0.999999.0712171641460.8467@xanadu.home> (Nicolas
	Pitre's message of "Mon, 17 Dec 2007 16:45:26 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68674>

Nicolas Pitre <nico@cam.org> writes:

> On Mon, 17 Dec 2007, Junio C Hamano wrote:
> ...
>> Instead we unconditionally said "if you are downloading with the new
>> client, we assume you would never be using older client to access that
>> repository locally, if you did so, you are screwed."
>> 
>> IOW, I think e4fe4b8ef7cdde842a9e5e2594d0fba1367d9dd3 (let the GIT
>> native protocol use offsets to delta base when possible) could have been
>> a bit more careful in this respect.
>
> Probably.  But this can hardly be called a "corruption" since nothing 
> was actually lost, rather an incompatibility problem.

It is not a corruption, but the distinction doesn't matter much to the
end user who wants to get the job done with the data right now.  The
data that was made inaccessible is inaccessible.  The only difference is
that it is recoverable once the user upgrades, but that may be painful,
even though it may be rewarding afterwards and worth doing so, and the
user may not be able to afford doing so right at that moment.
