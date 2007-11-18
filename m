From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-commit: fix "git add x y && git commit y" committing x, too
Date: Sun, 18 Nov 2007 01:18:57 -0800
Message-ID: <7v8x4vykqm.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0711150038020.4362@racer.site>
	<1195138198-24511-1-git-send-email-krh@redhat.com>
	<Pine.LNX.4.64.0711151611090.30886@racer.site>
	<1195146094.21076.6.camel@hinata.boston.redhat.com>
	<Pine.LNX.4.64.0711160036450.30886@racer.site>
	<7vk5ohuunv.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 18 10:19:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItgJm-00042D-JP
	for gcvg-git-2@gmane.org; Sun, 18 Nov 2007 10:19:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930AbXKRJTO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Nov 2007 04:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752972AbXKRJTN
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Nov 2007 04:19:13 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:33026 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752580AbXKRJTI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Nov 2007 04:19:08 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 278E62EF;
	Sun, 18 Nov 2007 04:19:29 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id B9BE296061;
	Sun, 18 Nov 2007 04:19:23 -0500 (EST)
In-Reply-To: <7vk5ohuunv.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 17 Nov 2007 00:45:56 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65350>

Junio C Hamano <gitster@pobox.com> writes:

> I noticed that the implementation left next-index crufts almost
> every time it was run, and started to clean it up.  Here is
> still a WIP and it does not optimize the read_tree(HEAD) part,
> but you should be able to replace that part with your one-way
> merge easily.  As I haven't done that ls-files --error-unmatch
> equivalent, this does not pass tests that involve partial
> commits with added or removed paths.

I was working on this tonight.  Will send out a proposed fix
based on this WIP shortly.  The result seems to pass all the
tests.
