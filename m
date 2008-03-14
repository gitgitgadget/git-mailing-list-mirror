From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Support caching projects list
Date: Thu, 13 Mar 2008 17:19:53 -0700
Message-ID: <7v63vqw40m.fsf@gitster.siamese.dyndns.org>
References: <20080313231413.27966.3383.stgit@rover>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Mar 14 01:20:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZxf9-0006ti-Mc
	for gcvg-git-2@gmane.org; Fri, 14 Mar 2008 01:20:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758012AbYCNAUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 20:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759028AbYCNAUA
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 20:20:00 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:64432 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758840AbYCNAUA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 20:20:00 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 90ED321D7;
	Thu, 13 Mar 2008 20:19:58 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 122D321D5; Thu, 13 Mar 2008 20:19:55 -0400 (EDT)
In-Reply-To: <20080313231413.27966.3383.stgit@rover> (Petr Baudis's message
 of "Fri, 14 Mar 2008 00:14:14 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77156>

Petr Baudis <pasky@suse.cz> writes:

> To prevent contention when multiple accesses coincide with cache
> expiration, the timeout is postponed to time()+120 when we start
> refreshing. When showing cached version, a disclaimer is shown at the
> top of the projects list.

Isn't this still racy when two requests come at about the same time?
Perhaps you can avoid it by using a lockfile?
