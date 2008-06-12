From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Added mergetool.kdiff3.doubledash config option
Date: Thu, 12 Jun 2008 13:36:32 -0700
Message-ID: <7vve0ez8z3.fsf@gitster.siamese.dyndns.org>
References: <1213300505-3867-1-git-send-email-patrick.higgins@cexp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
To: Patrick Higgins <patrick.higgins@cexp.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 22:37:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6tY9-0006IM-Rt
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 22:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417AbYFLUgn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 16:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755460AbYFLUgn
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 16:36:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46322 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417AbYFLUgm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 16:36:42 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E92DB361F;
	Thu, 12 Jun 2008 16:36:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 3DE16361B; Thu, 12 Jun 2008 16:36:34 -0400 (EDT)
In-Reply-To: <1213300505-3867-1-git-send-email-patrick.higgins@cexp.com>
 (Patrick Higgins's message of "Thu, 12 Jun 2008 13:55:05 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 42AB46D6-38BF-11DD-A0F0-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84789>

Patrick Higgins <patrick.higgins@cexp.com> writes:

> Qt-only builds of kdiff3 (no KDE) do not support a bare '--' on the command
> line. It will fail silently and mysteriously.
>
> Signed-off-by: Patrick Higgins <patrick.higgins@cexp.com>

Hmm, I am seeing this patch for the first time, I have not seen any
discussion history leading to the patch, and I have not been primarily
involved in mergetool.  I'll Cc Ted to see what he thinks...

> +mergetool.kdiff3.doubledash::
> +	A boolean to indicate whether or not your kdiff3 supports a '--'
> +	on the command line to separate options from filenames. If you
> +	built it without KDE, it probably doesn't have this support and
> +	you	should set this to false.  Defaults to true.

The above description makes it clear that there is an issue that needs to
be addressed.  I however am wondering if this can be either autodetected
at runtime, or if it can't, the user should be able to specify the option
when the user runs mergetool from the command line.  It would be necessary
to countermand whichever choice you configured in your config when you
need to run kdiff3 with KDE from one machine and the one without from
another machine, wouldn't it?
