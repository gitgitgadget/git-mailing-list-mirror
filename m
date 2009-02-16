From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-remote: better handling of multiple remote HEADs
Date: Sun, 15 Feb 2009 18:21:45 -0800
Message-ID: <7v7i3rglza.fsf@gitster.siamese.dyndns.org>
References: <20090214034345.GB24545@coredump.intra.peff.net>
 <1234607430-5403-1-git-send-email-jaysoffian@gmail.com>
 <20090215052740.GA11522@coredump.intra.peff.net>
 <76718490902150613i79517e6dwcec8e1e40c56bcc8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	barkalow@iabervon.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 03:23:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYt8j-0003qa-Vu
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 03:23:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755751AbZBPCVy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 21:21:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755618AbZBPCVy
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 21:21:54 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35269 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755568AbZBPCVx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 21:21:53 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 618312B37E;
	Sun, 15 Feb 2009 21:21:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6BC342B36E; Sun,
 15 Feb 2009 21:21:47 -0500 (EST)
In-Reply-To: <76718490902150613i79517e6dwcec8e1e40c56bcc8@mail.gmail.com>
 (Jay Soffian's message of "Sun, 15 Feb 2009 09:13:09 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 92B12072-FBD0-11DD-AA9D-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110111>

Jay Soffian <jaysoffian@gmail.com> writes:

>        Bash allows both the standard output (file descriptor 1) and
>        the standard  error
>        output  (file  descriptor 2) to be redirected to the file whose
>        name is the expansion of word with this construct.
>
>        There are two formats for redirecting standard output and
>        standard error:
>
>               &>word
>        and
>               >&word
>
>        Of the two forms, the first is preferred.  This is semantically
>        equivalent to
>
>               >word 2>&1

Just to clarify, the above is not a recommendation for shell scripts in
git project.  The last one is the only one we recommend in our scripts.

By the say, does anybody know why bash people recommend &>word form?

Neither &>word nor >&word to send both stderr and stdout to the file is
from true Bourne, but at least the use of >&word form for this purpose is
more familiar to people who are used to Csh.
