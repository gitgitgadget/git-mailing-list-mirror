From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v2] commit-slab: declare functions "static inline"
Date: Mon, 25 Nov 2013 21:15:46 +0100
Message-ID: <87wqjw1bm5.fsf@thomasrast.ch>
References: <878uwc2r7c.fsf@thomasrast.ch>
	<89b534b37f5689a675f0f97d3627a0668ce2a71d.1385409724.git.tr@thomasrast.ch>
	<20131125201200.GN4212@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 21:15:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl2ZV-0007WP-U4
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 21:15:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754934Ab3KYUPu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 15:15:50 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:56480 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754597Ab3KYUPt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 15:15:49 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 78C5C4D65A0;
	Mon, 25 Nov 2013 21:15:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id U8i39g707i7Z; Mon, 25 Nov 2013 21:15:47 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id D9F1C4D659F;
	Mon, 25 Nov 2013 21:15:46 +0100 (CET)
In-Reply-To: <20131125201200.GN4212@google.com> (Jonathan Nieder's message of
	"Mon, 25 Nov 2013 12:12:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238339>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thomas Rast wrote:
>
>> This shuts up compiler warnings about unused functions.
>
> If that is the only goal, I think it would be cleaner to use
>
> 	#define MAYBE_UNUSED __attribute__((__unused__))
>
> 	static MAYBE_UNUSED void init_ ...
>
> like was done in the vcs-svn/ directory until cba3546 (drop obj_pool,
> 2010-12-13) et al.
>
> I haven't thought carefully about whether encouraging inlining here
> (or encouraging the reader to think of these functions as inline) is a
> good or bad change.

Hmm.

I actually had this idea after seeing the same trick in khash.h.  Is
__atribute__((__unused__)) universal?  If so, maybe we could apply the
same also to khash?  If not, I'd rather go with the inline.

-- 
Thomas Rast
tr@thomasrast.ch
