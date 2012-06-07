From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 2/4] Let core.excludesfile default to
 $XDG_CONFIG_HOME/git/ignore
Date: Thu, 07 Jun 2012 16:31:12 -0700
Message-ID: <7vk3ziem2n.fsf@alter.siamese.dyndns.org>
References: <1338754481-27012-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-1-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 <1338988885-21933-2-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>
To: Huynh Khoi Nguyen NGUYEN 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
X-From: git-owner@vger.kernel.org Fri Jun 08 01:31:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ScmAv-00085W-Og
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jun 2012 01:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755504Ab2FGXbS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jun 2012 19:31:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33374 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753476Ab2FGXbR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2012 19:31:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 57EB282AC;
	Thu,  7 Jun 2012 19:31:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pV6vibFHaTAwN6ijUeESRrKfMKU=; b=bQsY2M
	lC4Y8MAwJEjAoIo2qcx+J4P78NSffWbm+Oom30Oq8c3AS2i2lkEZv+CV/i+nmybB
	B5L7mO84xeJGUhSHJ136oKb3KyvPA+cifZQNzLLRZ2LJ4U89bMH1ps6zW3zUl3FL
	w0FZuUNPXNN16YghHbEXzBpew3Ha3gvApbYzs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eAvEhdw+HZYC/tB9SeRH8EZ+uF0oHgiM
	tLxNSMs+b+yPWpNbKXmPapPoIOggDGACivzP0F2Vw3m/hOgIYmS5LGReBxoMXHzq
	vxp3Lu/Qqy47U9UVPPUIRyr+mJ2QnhvcQp765Ognl1bzPVjEnQFpnBPGZV3SDyLL
	G1NhmyuGW3c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 47AB082AB;
	Thu,  7 Jun 2012 19:31:14 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C777282A8; Thu,  7 Jun 2012
 19:31:13 -0400 (EDT)
In-Reply-To: <1338988885-21933-2-git-send-email-Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
 (Huynh Khoi Nguyen NGUYEN's message of "Wed, 6 Jun 2012 15:21:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF0E7E34-B0F8-11E1-89F1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199459>

Huynh Khoi Nguyen NGUYEN  <Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>
writes:

> From: NGUYEN Huynh Khoi Nguyen <nguyenhu@ensibm.imag.fr>
>
> If core.excludesfile is not defined, its default value will be
> $XDG_CONFIG_HOME/git/ignore in order to follow XDG specification.

I find the above statement hard to understand and harder to agree
with.

Right now, when core.excludesfile is not defined, the user does not
have to worry about any "global" ignore file to get in the way while
working on a specific project.  With this change, if the user does
not want random paths in the project that happens to match a pattern
in this XDG_CONFIG_HOME/git/ignore file that is totally outside of
the project's control, the user needs to make sure core.excludesfile
is set to an empty file or something.

That sounds like a huge downside; does XDG specification mandates
such a regression?  Do they say "you must treat XDG_CONFIG_HOME/git/ignore
as your global ignore file"?  It is hard to believe.

Perhaps you are doing two or more unrelated things and stating what
you are doing poorly, which is what is confusing me?

Perhaps the problem you are solving is something like this (by the
way, you didn't state what problem you are trying to solve at all):

 - Use of core.excludesfile is an opt-in feature to keep ignore
   patterns in a file and use it across projects defined per user.
   To use this feature, the user needs to create such a file, and
   add configuration variable to point at it.  The feature needs two
   user actions to enable.

 - Instead, we can define a filename that is unlikely to already
   exist on the system, and use the presense of the file as a cue
   that the user wants to use that feature.  The user can simply
   create the file without adding configuration variable to point at
   it. Now the feature needs only one user action to enable, which
   is the primary problem I wanted to solve.

 - Now we need to decide what that magic filename should be.  We
   could pick any random filename that user can create, and no other
   user can create for the user, which means that it has to be under
   $HOME.  Let's use "${XDG_CONFIG_HOME:-$HOME/.config/git}/ignore";
   it is as good as any random filename in $HOME/ and follows the
   XDG guideline.

But that may not be what you meant to say.  I dunno.
