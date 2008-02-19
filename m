From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Add support for host aliases in config files
Date: Tue, 19 Feb 2008 13:35:32 -0800
Message-ID: <7vy79ghbob.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.00.0802182317520.5816@iabervon.org>
 <47BAF18F.5040709@freescale.com>
 <alpine.LNX.1.00.0802191127080.19024@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Loeliger <jdl@freescale.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 22:36:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRa8Y-0005rW-Ad
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 22:36:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754617AbYBSVfv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 16:35:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754550AbYBSVfv
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 16:35:51 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:65212 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754488AbYBSVfu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 16:35:50 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 387147D0D;
	Tue, 19 Feb 2008 16:35:49 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 4BBCA7D08; Tue, 19 Feb 2008 16:35:39 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74460>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Tue, 19 Feb 2008, Jon Loeliger wrote:
>
>> Also, is "host" really the right config key?  Maybe "rewritehost"?
>> Or is this thought to be the basis of other (perhaps not rewrite
>> related) properties of the same host as well?
>
> I think it's likely that other properties of the host could show up. I 
> suspect that uploadpack and receivepack would be useful host-wide if you 
> were using a lot of ad-hoc repository names on a big site. Rewriting the 
> URLs is just the itch I had with this scope.

I'd agree that per-host configuration may be useful, and your
"paths to programs" may be a good example.  But I think it is
plausible that a host needs multiple <rewritefrom,rewriteto>
tuples.  Either your '[host "$this_url"] aka = $that_url' or
Dscho's earlier '[rewrite "$this_url_to"] url = $that_url' shows
that this is not about host but "prefix part of URL".
