From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] submodule: add 'deinit' command
Date: Wed, 12 Dec 2012 14:34:47 -0800
Message-ID: <7vlid23nnc.fsf@alter.siamese.dyndns.org>
References: <20121130032719.GE29257@odin.tremily.us> <50B54A68.60309@web.de>
 <20121130175309.GA718@odin.tremily.us>
 <CABURp0qNBcFnxbvhn7PsKWLUOsTiK4u5vx-=6cG3JQHw9aUeHA@mail.gmail.com>
 <50BA2892.7060706@web.de> <50BA3412.60309@web.de>
 <7vy5hhmcwp.fsf@alter.siamese.dyndns.org> <50BBB22A.7050901@web.de>
 <7vhao31s9e.fsf@alter.siamese.dyndns.org> <50BE6FB9.70301@web.de>
 <50C89DF3.20303@drmicha.warpmail.net> <50C8BD6B.9010702@web.de>
 <7vr4mv3w2x.fsf@alter.siamese.dyndns.org> <50C90469.8080303@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Phil Hord <phil.hord@gmail.com>,
	"W. Trevor King" <wking@tremily.us>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Dec 12 23:35:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TiutQ-0007R9-9n
	for gcvg-git-2@plane.gmane.org; Wed, 12 Dec 2012 23:35:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755740Ab2LLWev (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2012 17:34:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38679 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755564Ab2LLWeu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2012 17:34:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CCFB9A41D;
	Wed, 12 Dec 2012 17:34:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=37Pj4+GKEN/TqCGBr9T4YNxXgxY=; b=S4yL2L
	7u85nGDio/WUQ0+TzeTMAQ2To2awkSCd+EcdZW9n5gT7L5oVG1x0MYe1gLlz+OeG
	sr5DTmGK99AHZyzO7zMe/43Kan3OGafWEZGOdbu9PJa3XAa71Sy6v25ARohVOznc
	pdUL91QaHB8tYX3LqQ5y754NhGfzXwJAWEUlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hSis94EwQLrryuYR8Hxo1dCqIXtD9TCs
	3CWLwuAn83iB5ac63SnWq7mEuUSzw472i0VEHHPm0Vgs4w9iX1xzLoxW+2i2c9vL
	Z6GY8RsDTRxDqk3+MQt2A5Hkc0IFN6mfnjxa7L5csP8KWjFn97VzRpNOvqvJb4Li
	Buj5H5p4la0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B81FCA41B;
	Wed, 12 Dec 2012 17:34:49 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 26917A416; Wed, 12 Dec 2012
 17:34:49 -0500 (EST)
In-Reply-To: <50C90469.8080303@web.de> (Jens Lehmann's message of "Wed, 12
 Dec 2012 23:25:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 23514170-44AC-11E2-959A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211403>

Jens Lehmann <Jens.Lehmann@web.de> writes:

> So unless people agree that deinit should also remove the work
> tree I'll prepare some patches teaching all git commands to
> consistently ignore deinitialized submodules. Opinions?

While I agree that consistency is good, "deinit" that does not
remove the working tree of the submodule the user explicitly said he
no longer wants to have the checkout for is a bug, and I think these
two are orthogonal issues.

In other words, "Ignore deinitialized submodules even when an
earlier bug in deinit failed to remove the working tree" is a
robustness issue for the other recursing commands, not an excuse for
"deinit" to have such a bug in the first place, I think.
