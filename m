From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach remote machinery about remotes.default config variable
Date: Fri, 11 Jan 2008 22:03:38 -0800
Message-ID: <7vbq7ry405.fsf@gitster.siamese.dyndns.org>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com>
	<1200022189-2400-2-git-send-email-mlevedahl@gmail.com>
	<7v1w8o4ws0.fsf@gitster.siamese.dyndns.org>
	<30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com>
	<7v63xzzszp.fsf@gitster.siamese.dyndns.org>
	<478855B5.9070600@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 07:04:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDZTa-0004eC-Fj
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 07:04:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751197AbYALGDr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 01:03:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757472AbYALGDr
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 01:03:47 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:41253 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbYALGDq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 01:03:46 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CA9754BD2;
	Sat, 12 Jan 2008 01:03:44 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 94BF24BD0;
	Sat, 12 Jan 2008 01:03:40 -0500 (EST)
In-Reply-To: <478855B5.9070600@gmail.com> (Mark Levedahl's message of "Sat, 12
	Jan 2008 00:52:53 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70275>

Mark Levedahl <mlevedahl@gmail.com> writes:

> My use really is a different use-case than is typical....
>
> This breaks down in a project like mine where there are multiple
> servers and the differences are important. Content and usage vary
> server to server, not just connectivity. At this point, hiding the
> server names is counterproductive. Basically, use of origin is data
> hiding, and data hiding is not good when you actually need the data.

If you need explicit name, you do not have to use "origin".

You can spell URL explicitly to name which exact repository you
mean to reach over which datapath (one physical host may have
different name depending on the network interface you reach it
via).  You can always say

	$ git pull git://that.exact.machine/repo that-branch

if you want to avoid ambiguity.

And that is not atypical at all.  Scan the kernel mailing list,
looking for "please pull" requests.  You will never see 'origin'
or any short nickname.  The names used in communication should
be unambiguous in the context of the communication.  If you know
'origin' mean different things to different people, do not use
that in public communication.

It's that simple.  Isn't it?
