From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Make Git accept absolute path names for files within the work tree
Date: Wed, 28 Nov 2007 00:20:56 +0100
Message-ID: <200711280020.57042.robin.rosenberg@dewire.com>
References: <1196119109-27483-1-git-send-email-robin.rosenberg@dewire.com> <7vmyt0edso.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 28 00:19:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ix9ht-0001vq-L1
	for gcvg-git-2@gmane.org; Wed, 28 Nov 2007 00:19:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753843AbXK0XSv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Nov 2007 18:18:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbXK0XSv
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Nov 2007 18:18:51 -0500
Received: from [83.140.172.130] ([83.140.172.130]:13043 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1752434AbXK0XSu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Nov 2007 18:18:50 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id AFC208027FA;
	Wed, 28 Nov 2007 00:09:32 +0100 (CET)
Received: from dewire.com ([127.0.0.1])
 by localhost (torino [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 05130-02; Wed, 28 Nov 2007 00:09:32 +0100 (CET)
Received: from [10.9.0.2] (unknown [10.9.0.2])
	by dewire.com (Postfix) with ESMTP id 55B78800783;
	Wed, 28 Nov 2007 00:09:32 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7vmyt0edso.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new at dewire.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66271>

tisdag 27 november 2007 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg@dewire.com> writes:
[...]
> >  	const char *orig = path;
> 
> Decl after statement.
Stupid C..
> 
> I do not think there is fundamental reason to object to this change, as
> long as the prefixing is done to the path that is trying to name a path
> in the working tree.
> 
> Also some codepath that does not require any work tree may want to call
> prefix_path().  I do not know what would happen in such a case.
ok, I'll add a test for whether we have a work tree.

> Although I didn't look at all the callers, I think the caller from
> config.c is not talking about a path in the work tree, and not all users
> of config.c need to have work-tree.

Oh dear. That wasn't on master when I looked. That one seems to be the only "other"
use and it is wrapped inside an if (!absolute_path()) tests so my magic does not conflict
there.

-- robin
