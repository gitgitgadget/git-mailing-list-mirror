From: Junio C Hamano <gitster@pobox.com>
Subject: Re: t7005 and vi in GIT_EXEC_PATH
Date: Sun, 11 Nov 2007 11:43:02 -0800
Message-ID: <7v3avcefg9.fsf@gitster.siamese.dyndns.org>
References: <9A9986E7-E03D-458A-9A19-A3EF0E7B203D@silverinsanity.com>
	<Pine.LNX.4.64.0711111557370.4362@racer.site>
	<FCFF59B3-D3F1-4BEB-B3C3-D07DD5D5D8EF@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 20:43:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrIiL-0001DN-In
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 20:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756637AbXKKTnJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 14:43:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754878AbXKKTnJ
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 14:43:09 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:56296 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756637AbXKKTnI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 14:43:08 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id E8DD82F2;
	Sun, 11 Nov 2007 14:43:28 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 760749464E;
	Sun, 11 Nov 2007 14:43:25 -0500 (EST)
In-Reply-To: <FCFF59B3-D3F1-4BEB-B3C3-D07DD5D5D8EF@silverinsanity.com> (Brian
	Gernhardt's message of "Sun, 11 Nov 2007 11:10:12 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64499>

Brian Gernhardt <benji@silverinsanity.com> writes:

> I'm sorry, I should have been more clear.  I was referring to the
> GIT_EXEC_PATH build variable, not the environment variable.  The git
> wrapper always adds the path determined during build to the front of
> PATH.  When I was changing my build script, this got set to "/usr/
> local/bin" (I usually use /usr/local/stow/git, instead).  Since I have
> a /usr/local/bin/vim, PATH for git-commit.sh during the test was:
>
> - my git build directory
> - /usr/local/bin (containing a symlink vi -> vim)
> - the t/trash directory, added by the test via `PATH=".:$PATH"`
> (containing the test vi script)
> - my normal path

Maybe that is what is broken.  t/test-lib.sh makes the
environment variable point at the build directory, and that
should override the path that is compiled in, shouldn't it?
