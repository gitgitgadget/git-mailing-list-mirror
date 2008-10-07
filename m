From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 3/4] diff: introduce diff.<driver>.binary
Date: Tue, 07 Oct 2008 17:17:08 +0200
Message-ID: <48EB7D74.40302@viscovery.net>
References: <20081005214114.GA21875@coredump.intra.peff.net> <20081005214336.GC21925@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Oct 07 17:27:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KnEKk-0000cf-Qh
	for gcvg-git-2@gmane.org; Tue, 07 Oct 2008 17:18:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753411AbYJGPRO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Oct 2008 11:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753375AbYJGPRO
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Oct 2008 11:17:14 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:38691 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753411AbYJGPRN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Oct 2008 11:17:13 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KnEJA-0003NS-Ii; Tue, 07 Oct 2008 17:17:10 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5587D54D; Tue,  7 Oct 2008 17:17:08 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20081005214336.GC21925@coredump.intra.peff.net>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97716>

Jeff King schrieb:
> The "diff" gitattribute is somewhat overloaded right now. It
> can say one of three things:
> 
>   1. this file is definitely binary, or definitely not
>      (i.e., diff or !diff)
>   2. this file should use an external diff engine (i.e.,
>      diff=foo, diff.foo.command = custom-script)
>   3. this file should use particular funcname patterns
>      (i.e., diff=foo, diff.foo.(x?)funcname = some-regex)
> 
> Most of the time, there is no conflict between these uses,
> since using one implies that the other is irrelevant (e.g.,
> an external diff engine will decide for itself whether the
> file is binary).
> 
> However, there is at least one conflicting situation: there
> is no way to say "use the regular rules to determine whether
> this file is binary, but if we do diff it textually, use
> this funcname pattern." That is, currently setting diff=foo
> indicates that the file is definitely text.

I don't get your point. Can you provide an example?

The reason why I'd like to understand the issue is because I like the
diff.foo.textconv that you introduce in patch 4/4, but I dislike that I
have to set diff.foo.binary to false in order to use the textconv. So, why
is this .binary needed?

> This patch introduces a "binary" config option for a diff
> driver, so that one can explicitly set diff.foo.binary. We
> default this value to "don't know". That is, setting a diff
> attribute to "foo" and using "diff.foo.funcname" will have
> no effect on the binaryness of a file. To get the current
> behavior, one can set diff.foo.binary to true.

-- Hannes
