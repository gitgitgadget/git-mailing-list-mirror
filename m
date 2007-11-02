From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] post-update hook: update working copy
Date: Fri, 02 Nov 2007 01:49:46 -0700
Message-ID: <7vd4ut58wl.fsf@gitster.siamese.dyndns.org>
References: <1193964304-10847-1-git-send-email-sam.vilain@catalyst.net.nz>
	<7vd4ut7948.fsf@gitster.siamese.dyndns.org>
	<472A9B26.2020608@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Fri Nov 02 09:50:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InsEK-0002X6-HQ
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 09:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752508AbXKBIty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 04:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752476AbXKBIty
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 04:49:54 -0400
Received: from sceptre.pobox.com ([207.106.133.20]:49424 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752082AbXKBItx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 04:49:53 -0400
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id B5E3F2F2;
	Fri,  2 Nov 2007 04:50:13 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 4CBF390547;
	Fri,  2 Nov 2007 04:50:10 -0400 (EDT)
In-Reply-To: <472A9B26.2020608@vilain.net> (Sam Vilain's message of "Fri, 02
	Nov 2007 16:36:06 +1300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63075>

Sam Vilain <sam@vilain.net> writes:

> changes as you suggested are below;

I squashed these and looked the result over, but I see it is
contradicting with itself.  You do not want to "publish" a live
git repository so running git-update-server-info in a repository
that is served by this script feels very wrong.

How about having this in contrib/hooks/post-update-worktre?

By the way, there are quite a few careless places that use shell
variables without quoting.
