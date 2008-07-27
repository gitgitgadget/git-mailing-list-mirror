From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] builtin-help: change the current directory back in
 list_commands_in_dir()
Date: Sun, 27 Jul 2008 13:02:41 -0700
Message-ID: <7vwsj7yu1q.fsf@gitster.siamese.dyndns.org>
References: <cover.1217037178.git.vmiklos@frugalware.org>
 <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org> <1217073292-27945-1-git-send-email-vmiklos@frugalware.org> <4f2b03391e3f85cf2224f97a2a7765d08707bd73.1217037178.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sun Jul 27 22:03:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNCT6-0000Zf-3p
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 22:03:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757624AbYG0UCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 16:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757641AbYG0UCs
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 16:02:48 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62010 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757615AbYG0UCr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 16:02:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 884093F7BE;
	Sun, 27 Jul 2008 16:02:46 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D8C2B3F7BA; Sun, 27 Jul 2008 16:02:43 -0400 (EDT)
In-Reply-To: <4f2b03391e3f85cf2224f97a2a7765d08707bd73.1217037178.git.vmiklos@frugalware.org> (Miklos Vajna's message of "Sat, 26 Jul 2008 13:54:46 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FB42DF18-5C16-11DD-8379-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90363>

Miklos Vajna <vmiklos@frugalware.org> writes:

> That function used to do a chdir() without switching back to the
> original directory. That was not a problem till this function was used
> only inside builtin-help, but once other builtins use it as well, this
> is a problem, for example when the object database path is relative.

Why does it even need to chdir() around to begin with?  Doesn't opendir()
work just fine with relative path as an input?
