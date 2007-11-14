From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] send-pack: assign remote errors to each ref
Date: Tue, 13 Nov 2007 22:12:06 -0800
Message-ID: <7vabphnyo9.fsf@gitster.siamese.dyndns.org>
References: <20071113102500.GA2767@sigill.intra.peff.net>
	<20071113113710.GC15880@sigill.intra.peff.net>
	<7vbq9xpprg.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0711140159550.4362@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Nov 14 07:12:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsBUF-0001RE-Qx
	for gcvg-git-2@gmane.org; Wed, 14 Nov 2007 07:12:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751611AbXKNGMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Nov 2007 01:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbXKNGMQ
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Nov 2007 01:12:16 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:54791 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750893AbXKNGMP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Nov 2007 01:12:15 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 6E07A2F0;
	Wed, 14 Nov 2007 01:12:36 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C1A8E9379C;
	Wed, 14 Nov 2007 01:12:29 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0711140159550.4362@racer.site> (Johannes
	Schindelin's message of "Wed, 14 Nov 2007 02:01:14 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64953>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> >   2. the status parsing is not foolproof. We get a line like
>> >
>> >          ng refs/heads/master arbitrary msg
>> >
>> >      which cannot be parsed unambiguously in the face of
>> >      refnames with spaces.
>
> Since when can refnames contain spaces?  In my copy of git, bad_ref_char() 
> in refs.c returns 1 if ch <= ' '.  It's the first error path, even.

Bah.  You are right.
