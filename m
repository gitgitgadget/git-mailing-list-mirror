From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add NO_RSYNC to allow building without rsync
Date: Wed, 30 Jul 2008 13:11:01 -0700
Message-ID: <7vod4f3zfu.fsf@gitster.siamese.dyndns.org>
References: <20080730185225.GG10399@yugib.highrise.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Aidan Van Dyk <aidan@highrise.ca>
X-From: git-owner@vger.kernel.org Wed Jul 30 22:12:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOI1t-0007jH-UZ
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 22:12:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753671AbYG3ULJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 16:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753156AbYG3ULI
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 16:11:08 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46496 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbYG3ULH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 16:11:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 6C22F432A2;
	Wed, 30 Jul 2008 16:11:06 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 5F0C4432A1; Wed, 30 Jul 2008 16:11:03 -0400 (EDT)
In-Reply-To: <20080730185225.GG10399@yugib.highrise.ca> (Aidan Van Dyk's
 message of "Wed, 30 Jul 2008 14:52:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: A473C760-5E73-11DD-93B1-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90847>

Aidan Van Dyk <aidan@highrise.ca> writes:

> This is similar to NO_CURL.

I am not sure if this is a good change.

We link with libcurl so supporting NO_CURL makes sense for an environment
without the library, but for rsync transport we just spawn it as a
separate process.  The net effect on a machine without rsync installed is
the same (you cannot use rsync transport), but you can later choose to
install rsync and things will start working without recompiling git.

> Signed-off-by: Aidan Van Dyk <aidan@highrise.ca>
> ---
>
> I came about this because SCO OpenServer doesnt' have mkdtemp.  But I never use
> rsync, so making it optional was an easy fix.

Perhaps "make NO_MKDTEMP=YesPlease" is a much better fix for your
particular environment?

The patch is seriously whitespace damaged, in any case.
