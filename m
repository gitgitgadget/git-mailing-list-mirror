From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git diff --name-status does not always list changed files
Date: Thu, 28 Feb 2008 14:51:08 -0800
Message-ID: <7v63w8hezn.fsf@gitster.siamese.dyndns.org>
References: <fq6hhi$cub$1@ger.gmane.org>
 <7vablkkhac.fsf@gitster.siamese.dyndns.org>
 <bdca99240802281323x1ec904ddq914ac2c484e7c468@mail.gmail.com>
 <7vejawhi6a.fsf@gitster.siamese.dyndns.org>
 <bdca99240802281419o3fcea2e8u277d8e5e48131b6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Sebastian Schuberth" <sschuberth@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 28 23:52:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUrba-000067-SV
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 23:51:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757918AbYB1WvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 17:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755014AbYB1WvV
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 17:51:21 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56355 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754091AbYB1WvU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 17:51:20 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AADD5131E;
	Thu, 28 Feb 2008 17:51:18 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EC1AC131C; Thu, 28 Feb 2008 17:51:10 -0500 (EST)
In-Reply-To: <bdca99240802281419o3fcea2e8u277d8e5e48131b6d@mail.gmail.com>
 (Sebastian Schuberth's message of "Thu, 28 Feb 2008 23:19:35 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75472>

"Sebastian Schuberth" <sschuberth@gmail.com> writes:

> Thanks, -FX works, though I do not understand why it did not with just
> -F. From what I understood, -F just makes "less" quit immediately
> (instead of waiting for the user to press "q") if the lines to display
> fit completely on screen. In no case it should display nothing if
> there actually is something to display.

My reading and understanding of less manual page, especially the
part that talks about -X suggests that everything is working as
it is meant to.

"git diff --name-status" displays something, less shows it, and
it quits immediately (because you asked it to with -F).  As part
of its quitting, it clears the screen because you did not ask
less not to do that by giving it an -X.

I am tempted to call it a bug in less, but I am a very nice
person and I would not actually do so ;-).  But it certainly
feels like a misfeature between less and terminfo to me.

