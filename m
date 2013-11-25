From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH 2/2] commit-slab: declare functions "static inline"
Date: Mon, 25 Nov 2013 20:53:43 +0100
Message-ID: <878uwc2r7c.fsf@thomasrast.ch>
References: <cover.1385405977.git.tr@thomasrast.ch>
	<f4d1ff9f487f797da35faa86c72d11832903a50d.1385405977.git.tr@thomasrast.ch>
	<xmqqy54cxohs.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 20:54:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl2ET-0005bW-2C
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 20:54:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753938Ab3KYTyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 14:54:05 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:56385 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757057Ab3KYTyC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 14:54:02 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 9811D4D658F;
	Mon, 25 Nov 2013 20:54:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id o5VHzffkJsz1; Mon, 25 Nov 2013 20:53:50 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 132834D64DE;
	Mon, 25 Nov 2013 20:53:49 +0100 (CET)
In-Reply-To: <xmqqy54cxohs.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 25 Nov 2013 11:36:31 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238335>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <tr@thomasrast.ch> writes:
>
>> This shuts up compiler warnings about unused functions.
>
> Thanks.
>
>> While there, also remove the redundant second declaration of
>> stat_##slabname##realloc.
>
> I think the latter was done very much deliberately to allow the
> using code to say:
>
> 	define_commit_slab(name, type);
>
> by ending the macro with something that requires a terminating
> semicolon.  If you just remove it, doesn't it break the compilation
> by forcing the expanded source to define a function
>
> 	slabname ## _at(...)
>         {
>         	...
> 	};
>
> with a trailing and undesired semicolon?

Oooh.  The sudden enlightenment.

-- 
Thomas Rast
tr@thomasrast.ch
