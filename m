From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: rename gitlink macro to linkgit
Date: Thu, 03 Jan 2008 13:01:10 -0800
Message-ID: <7vejcypqsp.fsf@gitster.siamese.dyndns.org>
References: <87sl1mqt10.fsf@offby1.atm01.sea.blarg.net>
	<4775B87D.4010507@gmail.com>
	<20071229155705.GA23659@genesis.frugalware.org>
	<449c10960712290824yd2c5783l8d0ba91bbad95789@mail.gmail.com>
	<47767710.7040405@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: srackham@methods.co.nz, Eric Hanchrow <offby1@blarg.net>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	asciidoc-discuss@lists.metaperl.com
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 22:01:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAXCG-0001Zj-4s
	for gcvg-git-2@gmane.org; Thu, 03 Jan 2008 22:01:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752326AbYACVBV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2008 16:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752206AbYACVBV
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jan 2008 16:01:21 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:48731 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752161AbYACVBU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2008 16:01:20 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 485E9366F;
	Thu,  3 Jan 2008 16:01:19 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B219366D;
	Thu,  3 Jan 2008 16:01:12 -0500 (EST)
In-Reply-To: <47767710.7040405@gmail.com> (Dan McGee's message of "Sat, 29 Dec
	2007 10:34:24 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69533>

Dan McGee <dpmcgee@gmail.com> writes:

>>From 68bf426e810e732ff3f9f75ffcd69f777b538685 Mon Sep 17 00:00:00 2001
> From: Dan McGee <dpmcgee@gmail.com>
> Date: Sat, 29 Dec 2007 00:20:38 -0600
> Subject: [PATCH] Documentation: rename gitlink macro to linkgit
>
> Between AsciiDoc 8.2.2 and 8.2.3, the following change was made to the stock
> Asciidoc configuration:
>
> @@ -149,7 +153,10 @@
>  # Inline macros.
>  # Backslash prefix required for escape processing.
>  # (?s) re flag for line spanning.
> -(?su)[\\]?(?P<name>\w(\w|-)*?):(?P<target>\S*?)(\[(?P<attrlist>.*?)\])=
> +
> +# Explicit so they can be nested.
> +(?su)[\\]?(?P<name>(http|https|ftp|file|mailto|callto|image|link)):(?P<target>\S*?)(\[(?P<attrlist>.*?)\])=
> +
>  # Anchor: [[[id]]]. Bibliographic anchor.
>  (?su)[\\]?\[\[\[(?P<attrlist>[\w][\w-]*?)\]\]\]=anchor3
>  # Anchor: [[id,xreflabel]]
>
> This default regex now matches explicit values, and unfortunately in this
> case gitlink was being matched by just 'link', causing the wrong inline
> macro template to be applied. By renaming the macro, we can avoid being
> matched by the wrong regex.

What's already tagged, released to the wild and picked up by
distros cannot be taken back, so I'd most likely have to apply
your patch anyway, but I have to say I am not very amused.  I'd
call this a regression on AsciiDoc's part.

I would have expected some courtesy to make sure that updates to
AsciiDoc would not to break existing users, especially the ones
that they use as the top advertising material in the "Projects
using AsciiDoc" list at http://www.methods.co.nz/asciidoc/ ;-)

Stuart, is there anything we can help you to set up some
automated tests to catch AsciiDoc regression, so we do not have
to suffer like this again?
