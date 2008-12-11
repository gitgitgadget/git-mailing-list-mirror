From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] cgit in git?
Date: Thu, 11 Dec 2008 14:35:34 -0800
Message-ID: <7vwse6bart.fsf@gitster.siamese.dyndns.org>
References: <8c5c35580812111348iceaf30dyb55183017cff5b1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Seth Vidal" <skvidal@fedoraproject.org>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Lars Hjemli" <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 23:37:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAu9U-0006sK-4V
	for gcvg-git-2@gmane.org; Thu, 11 Dec 2008 23:37:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758034AbYLKWfm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Dec 2008 17:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757948AbYLKWfm
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Dec 2008 17:35:42 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58466 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757870AbYLKWfl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Dec 2008 17:35:41 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id B74A986A34;
	Thu, 11 Dec 2008 17:35:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C804486A32; Thu,
 11 Dec 2008 17:35:35 -0500 (EST)
In-Reply-To: <8c5c35580812111348iceaf30dyb55183017cff5b1d@mail.gmail.com>
 (Lars Hjemli's message of "Thu, 11 Dec 2008 22:48:45 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 098069D2-C7D4-11DD-A5E8-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102834>

"Lars Hjemli" <hjemli@gmail.com> writes:

> 2) the cgit release tarballs includes the needed git sources
>
> Option 2 is doable but still requires the fedora project to support
> two git packages (but now the 'git-for-cgit' package is hidden inside
> the cgit source tree). The good thing about this option is that it
> only requires some minor modifications to the cgit releases.

I do not understand why this is any extra work for fedora.  Instead of
running "make get-git" and then running your build procedure, they need to
just run your build procedure because you now ship your source with the
matching version of the git source, which sounds like the right thing to
me.  You do not install anything from the contained git.git area (we do
not do shared objects, nor public header files) to the end product, right?

Doesn't cgit bind git.git as a subproject at the source level?  I would
expect that the most natural release tarball for such a project would be a
single tarball that has both the superproject itself _and_ the submodules
it contains already extracted, iow, the state of your tree after you run
"make get-git".
