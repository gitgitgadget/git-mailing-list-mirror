From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: setup-git-server-over-http: Mention davfs2
Date: Mon, 18 Aug 2008 22:57:45 -0700
Message-ID: <7vwsidh7hi.fsf@gitster.siamese.dyndns.org>
References: <48A9E8BE.9040807@gmail.com>
 <1219095967-15971-1-git-send-email-gafunchal@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	git@wingding.demon.nl, Matthieu.Moy@imag.fr
To: Giovanni Funchal <gafunchal@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 07:59:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVKFE-0005EN-HA
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 07:59:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752934AbYHSF56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 01:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752896AbYHSF56
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 01:57:58 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbYHSF56 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 01:57:58 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 66E265EE62;
	Tue, 19 Aug 2008 01:57:56 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id EAAD65EE61; Tue, 19 Aug 2008 01:57:49 -0400 (EDT)
In-Reply-To: <1219095967-15971-1-git-send-email-gafunchal@gmail.com>
 (Giovanni Funchal's message of "Mon, 18 Aug 2008 23:46:07 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C515FFE8-6DB3-11DD-A05C-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92812>

Giovanni Funchal <gafunchal@gmail.com> writes:

> I just came across an interesting file system driver that allows to mount
> WebDAV resources into file system tree: davfs2. I though it would be worth
> mentioning this on setup-git-server-over-http.txt.

I might agree with "It would be worth mentioning", but I do not think that
is what you did.

> +
> +Step 2 1/2: testing your WebDAV server
> +--------------------------------------
> +
> ...
> -A command line tool to test WebDAV is cadaver. If you prefer GUIs, for
> -example, konqueror can open WebDAV URLs as "webdav://..." or
> -"webdavs://...".
> +An alternative is to use davfs2, a driver that allows mounting a WebDAV
> +resource into the system tree. This requires root access and kernel
> +support (probably your kernel includes this).
> +
> +  $ apt-get install davfs2
> +  $ mkdir -p /mnt/webdav
> +  $ mount -t davfs http://<servername>/ /mnt/webdav
> +  $ ls /mnt/webdav
> +  $ umount /mnt/webdav
> +
> +If you prefer GUIs, for example, konqueror can open WebDAV URLs as
> +"webdav://..." or "webdavs://...".

You are dropping mention of cadaver and the only remaining suggestion for
command line testing is via davfs2.

Googling for "davfs2 WebDAV" returns 13,600 hits, while "cadaver WebDAV"
hits 39,100.  In addition, testing with davfs2 requires you to have root
access.  

When troubleshooting a nonworking system, it often is easier to do it from
a command line tool than from GUI (one of whose main point is to hide away
the low-level details).  And I thought the title of this semi-section was
"Testing"?

Offering alternatives for command line tools is good, but that is not what
this patch does.
