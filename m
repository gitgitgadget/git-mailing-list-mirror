From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Makefile: Add cache-tree.h to the public headers list
Date: Wed, 05 Sep 2007 17:16:47 -0700
Message-ID: <7vy7fkfy1c.fsf@gitster.siamese.dyndns.org>
References: <20070905232251.GC331@nomad.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 02:17:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT53L-0007AP-SG
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 02:17:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754784AbXIFAQw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 20:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754744AbXIFAQw
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 20:16:52 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:42944 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbXIFAQw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 20:16:52 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9481E12F32C;
	Wed,  5 Sep 2007 20:17:10 -0400 (EDT)
In-Reply-To: <20070905232251.GC331@nomad.office.altlinux.org> (Dmitry
	V. Levin's message of "Thu, 6 Sep 2007 03:22:51 +0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57780>

"Dmitry V. Levin" <ldv@altlinux.org> writes:

> Some external projects (e.g. parsecvs) need cache-tree.h file.

Your patch shows that our Makefile has been lacking a necessary
dependency for a long time.  LIB_H is not "public headers list",
but more like "the headers everybody depends on", and the header
file should have been on that list.  Thanks.

I am however not convinced it is a good idea to treat libgit.a
as if it is a library.  It is not a library in the usual sense
of the word.  Originally we did libgit.a primarily so that we do
not have to list all the *.o dependencies in the Makefile out of
laziness ;-)
