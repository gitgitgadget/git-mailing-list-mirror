From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] Referring to a submodule state recorded in a supermodule
 from within the submodule
Date: Wed, 05 Nov 2008 09:45:20 -0800
Message-ID: <7vhc6mkqxb.fsf@gitster.siamese.dyndns.org>
References: <200811051824.28374.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 18:46:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxmSt-0007KA-0O
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 18:46:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752AbYKERpd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 12:45:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbYKERpd
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 12:45:33 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64950 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbYKERpc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 12:45:32 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 48439937AB;
	Wed,  5 Nov 2008 12:45:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 36DED937A5; Wed, 
 5 Nov 2008 12:45:21 -0500 (EST)
In-Reply-To: <200811051824.28374.johan@herland.net> (Johan Herland's message
 of "Wed, 5 Nov 2008 18:24:28 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8A624E10-AB61-11DD-A883-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100166>

Johan Herland <johan@herland.net> writes:

> I have a stand-alone project, "foo", that I work on myself. The "foo" 
> project is included as a submodule in two other projects, "bar" 
> and "baz", that I don't have any direct affiliation with.
>
> Semi-regularly, I like to keep tabs on bar and baz, to see what versions 
> of foo they are using, what changes they have made to foo, and if there 
> are things I could pick up from them, or maybe even things they could 
> learn from eachother.
>
> Doing this currently is quite tedious:
> 1. Clone/Fetch bar and initialize/update its foo submodule
> 2. Clone/Fetch baz and initialize/update its foo submodule

If I am reading you right and you are only interested in the part "foo" in
these projects, there is something wrong with the setup of "bar" and "baz".

The submodule mechanism is designed to bind an independent project on its
own as a subdirectory of another project.  It seems to me that the problem
is that "bar" and "baz" projects do not give direct access to clone "foo"
part of them for you or other people.
