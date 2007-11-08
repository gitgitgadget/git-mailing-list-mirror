From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] git-fetch: avoid local fetching from alternate (again)
Date: Thu, 08 Nov 2007 02:07:14 -0800
Message-ID: <7vhcjx2gq5.fsf@gitster.siamese.dyndns.org>
References: <20071108080058.GC16690@spearce.org>
	<20071108100039.GM14735@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 08 11:07:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iq4IS-0004n4-D1
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 11:07:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714AbXKHKHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 05:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbXKHKHU
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 05:07:20 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:60748 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750708AbXKHKHT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 05:07:19 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 882CD2F2;
	Thu,  8 Nov 2007 05:07:40 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id D078C9281C;
	Thu,  8 Nov 2007 05:07:37 -0500 (EST)
In-Reply-To: <20071108100039.GM14735@spearce.org> (Shawn O. Pearce's message
	of "Thu, 8 Nov 2007 05:00:40 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63989>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> I'm starting to suspect heap corruption again in builtin-fetch.
> This patch alters the malloc() calls we are doing and may be shifting
> something around just enough in memory to cause a data overwrite or
> something and that's why this tag just drops out of the linked list?
> But then why does that happen in the test suite but not outside.
> Maybe because the test suite is setting environment variables that
> I'm not and the impact of those combined with these additional
> mallocs is what is breaking it?  *sigh*

Thanks for working hard on this one.

It is starting to look like today was "let's kill other people's
bugs" day.  I'd go to bed before I completely miss sleep, which
I often end up doing when thinking too long about bugs.
