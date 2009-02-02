From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-config: add --exec-editor for use in scripts
Date: Sun, 01 Feb 2009 19:04:10 -0800
Message-ID: <7v4ozdo7yt.fsf@gitster.siamese.dyndns.org>
References: <20090201025349.GA22160@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon Feb 02 04:06:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTp8E-0007Eh-RM
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 04:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754035AbZBBDER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 22:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754016AbZBBDEQ
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 22:04:16 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:62014 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753970AbZBBDEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 22:04:16 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id BA547940BE;
	Sun,  1 Feb 2009 22:04:15 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 4D260940BD; Sun,
  1 Feb 2009 22:04:12 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 2CDFA71E-F0D6-11DD-850A-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108039>

Eric Wong <normalperson@yhbt.net> writes:

> This exposes the launch_editor() library function for use by
> various scripting languages.  This allows the ensure consistent
> handling of GIT_EDITOR/VISUAL/EDITOR environment variables as
> well as the handling of special characters such as spaces in the
> various environment variables.
>
> Signed-off-by: Eric Wong <normalperson@yhbt.net>
> ---
>
>  I'm not sure if git-config is the best place to stick it.  I plan to
>  start using this in git-svn but I don't want to implement Git::Editor
>  in Perl and have to keep track of editor.c.  Of course this also makes
>  the logic/rules used in libgit usable to any other scripting language
>  capable of launching other programs.

I agree that git-config is probably a wrong place.  A separate command
"git editor" (or "git user-preference --editor", if you extend it to pager
and others) perhaps?

I also agree that something like this would make scripting Porcelains a
much pleasant experience.
