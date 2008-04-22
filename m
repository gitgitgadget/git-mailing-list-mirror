From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Always copy template files (no symlinking)
Date: Tue, 22 Apr 2008 10:05:01 -0700
Message-ID: <7vprshyg5e.fsf@gitster.siamese.dyndns.org>
References: <20080422140359.GA9590@roadkill.foldr.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 22 19:06:37 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoLwS-0001mI-2w
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 19:06:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755851AbYDVRFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 13:05:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755778AbYDVRFI
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 13:05:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:61275 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755812AbYDVRFH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 13:05:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2C17D1950;
	Tue, 22 Apr 2008 13:05:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 96ECD194F; Tue, 22 Apr 2008 13:05:04 -0400 (EDT)
In-Reply-To: <20080422140359.GA9590@roadkill.foldr.org> (Michael Weber's
 message of "Tue, 22 Apr 2008 16:03:59 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80140>

Michael Weber <michaelw@foldr.org> writes:

> Previously, git would readlink(2) template files that are symlinks,
> and then symlink(2) the result into .git/.  This does not work for
> relative symlinks (as produced by, e.g., encap), and is probably not a
> good idea either: it is an irrelevant detail that a file in the
> template directory is symlinked.

This was very deliberately done to allow a relative symlink that points at
e.g. ../../hooks/pre-commit with .git/hooks/pre-commit.  IOW, "use what
the project suggests".
