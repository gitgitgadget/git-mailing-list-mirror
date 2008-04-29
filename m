From: Junio C Hamano <gitster@pobox.com>
Subject: Re: bug: git-diff silently fails when run outside of a repository
 (v1.5.4.2)
Date: Tue, 29 Apr 2008 15:53:28 -0700
Message-ID: <7vabjc5l3r.fsf@gitster.siamese.dyndns.org>
References: <3c6c07c20804291304n36976417wf3c2a13303aa3133@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Mike Coleman" <tutufan@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 30 00:54:32 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqyiT-0008M2-0j
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 00:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbYD2Wxl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 18:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751270AbYD2Wxl
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 18:53:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64865 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751262AbYD2Wxk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 18:53:40 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1BE383FEB;
	Tue, 29 Apr 2008 18:53:39 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 6FF323FE8; Tue, 29 Apr 2008 18:53:36 -0400 (EDT)
In-Reply-To: <3c6c07c20804291304n36976417wf3c2a13303aa3133@mail.gmail.com>
 (Mike Coleman's message of "Tue, 29 Apr 2008 15:04:32 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 1B7EA0F0-163F-11DD-8458-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80761>

"Mike Coleman" <tutufan@gmail.com> writes:

> At least in version 1.5.4.2, git-diff silently fails when not run
> inside a repository.  It should give an error diagnostic, especially
> since "no output" would otherwise be a meaningful response.

Unfortunately this does not have enough information to go by, as unlike
many other programs, "git diff" contains a hack to be usable as a better
(for certain definition of "better" I may not necessarily agree with) GNU
diff replacement when run outside a repository.

i.e.

	mkdir -p /var/tmp/junk
        cd /var/tmp/junk
        rm -fr .git ;# make sure it is not a repository
	echo >a hello
        echo >b world
	git diff --color a b

is supposed to work.
