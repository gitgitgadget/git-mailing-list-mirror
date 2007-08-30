From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-filter-branch: document --original option
Date: Thu, 30 Aug 2007 16:13:34 -0700
Message-ID: <7v3ay07h0h.fsf@gitster.siamese.dyndns.org>
References: <11884893671845-git-send-email-giuseppe.bilotta@gmail.com>
	<1188493842963-git-send-email-giuseppe.bilotta@gmail.com>
	<11884938431525-git-send-email-giuseppe.bilotta@gmail.com>
	<7vy7fs7kmc.fsf@gitster.siamese.dyndns.org>
	<85d4x4d6oi.fsf@lola.goethe.zz>
	<7vodgo7jbn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Fri Aug 31 01:14:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQtD8-0007Uf-Eb
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 01:14:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755655AbXH3XNr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Aug 2007 19:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755974AbXH3XNr
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Aug 2007 19:13:47 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:55716 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755034AbXH3XNq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2007 19:13:46 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id CB63212B64D;
	Thu, 30 Aug 2007 19:14:02 -0400 (EDT)
In-Reply-To: <7vodgo7jbn.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 30 Aug 2007 15:23:40 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57090>

Junio C Hamano <gitster@pobox.com> writes:

> I agree we do not give the "portable to version 7" prize
> anymore.  But you made me realize another thing.
>
> I think it should make sure orig_namespace has one and only one
> trailing slash, because otherwise "--original refs/heads//"
> would lead you to the same disaster.

Perhaps,

	orig_namespace=$(expr "$OPTARG/" : '\(.*[^/]\)/*$')/

Well, I know people hate colon-expr, but we earlier ruled out
(and we still do) ${parameter//pattern/string} as bashism beyond
the portability line, and I do not see an alternative easier to
read than this...
