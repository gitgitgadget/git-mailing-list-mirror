From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Cygwin has trustable filemode
Date: Fri, 19 Jul 2013 12:16:33 -0700
Message-ID: <7vtxjquzqm.fsf@alter.siamese.dyndns.org>
References: <1373818390-14451-1-git-send-email-mlevedahl@gmail.com>
	<1374245631-15955-1-git-send-email-mlevedahl@gmail.com>
	<7vtxjqwlj2.fsf@alter.siamese.dyndns.org> <51E982D0.5040505@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 19 21:16:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0GAU-0002SH-E8
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jul 2013 21:16:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761201Ab3GSTQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 15:16:38 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38424 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761187Ab3GSTQg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 15:16:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 12C4B31C58;
	Fri, 19 Jul 2013 19:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9f2BsJCAbSNr2ks6SVbI67jzZ1k=; b=AUxpyI
	21acTlXn5/Tm/pDI3Cyd/B9GXhXcfUCGS9rnXWCftjx3FaG50ns7zvmjugInRJeK
	Yr2oi2mIfAKIYUYgzr7tjtfWA0X1HA9RmTGIZvQ1UUR/5nz7g4yKE4CKW+n0RDOO
	G+C1asEPDoGGQsPP2zKGCWV2/AGhLRsKqO2GA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=inow7jvPHg04CXmTOYA5St0RqUC6btXQ
	/flhiJbofkjlNqd0qou9PFnMgVEZ8BkGZcd9jba5PGTuJ5e9QO8Hzeds1Zx5gQyq
	WM829HnEXUdiG1RG3OnVXE+35pdjbg/jAV6KxB3xyMa2Ix80Xe/YncWUqAvudK2n
	YHnQStYaCNY=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 04AD431C57;
	Fri, 19 Jul 2013 19:16:36 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 51CF431C56;
	Fri, 19 Jul 2013 19:16:35 +0000 (UTC)
In-Reply-To: <51E982D0.5040505@gmail.com> (Mark Levedahl's message of "Fri, 19
	Jul 2013 14:17:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA7C95C0-F0A7-11E2-9E9F-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230841>

Mark Levedahl <mlevedahl@gmail.com> writes:

> Related: Should we have separate settings for 1.5 and 1.7 for several
> variables? Conflicts I see not reflected in config.mak.uname on pu:
>     trustable filemode   (1.7 has, 1.5 does not)
>     MMAP/Pread (1.7 pread is thread safe, 1.5 I dont think was, MMAP
> utility is convolved in this)
>     regex - 1.7 is broken, per Ramsay 1.5 works
>
> If you think its worth it, I'll create a patch series with the above
> and justifications for the different settings that I know.

I'd say that would be a sensible thing to do, given that the
alternative seems to be "let's drop 1.5 support right now, because
otherwise we cannot run Git on 1.7".
