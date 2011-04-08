From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] pathspec: rename per-item field has_wildcard to use_wildcard
Date: Fri, 08 Apr 2011 10:29:19 +0200
Message-ID: <4D9EC75F.1060901@drmicha.warpmail.net>
References: <7vr59gl581.fsf@alter.siamese.dyndns.org> <BANLkTikJ3=H_OgcNueMjnwwQ2W-2kamf=w@mail.gmail.com> <7vfwpvjobl.fsf@alter.siamese.dyndns.org> <4D9D9B60.4030404@drmicha.warpmail.net> <7vvcypeti4.fsf@alter.siamese.dyndns.org> <7vr59detcu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 08 08:29:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q85CE-00089N-UY
	for gcvg-git-2@lo.gmane.org; Fri, 08 Apr 2011 08:29:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753800Ab1DHG3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Apr 2011 02:29:24 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:41033 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753198Ab1DHG3Y (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 Apr 2011 02:29:24 -0400
Received: from compute4.internal (compute4.nyi.mail.srv.osa [10.202.2.44])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 9D08C207E8;
	Fri,  8 Apr 2011 02:29:23 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute4.internal (MEProxy); Fri, 08 Apr 2011 02:29:23 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=6TmQx9uGGw2wiLIO7tLIFPw9CY0=; b=tCfQeHNy3n60T4GIVDAgsPP8mJHA501ciD8AIIElZ0tcN3PWlxsevWWbpK5OqY8H7avbfb7Z+YdO95gqx1UbkVSxAyccWrjx6U9oUKbIgpBWNVhx3Ot+C97a9112xT8M+eCRBrALVft03X+JU9I+8heweEEUML/2rsZhhwYMHn0=
X-Sasl-enc: J0jWCs4mGeXtYW1aI6aFVJkmZoIPqOErZ5TdzEXL6o/Y 1302244163
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 0A3BA4045D4;
	Fri,  8 Apr 2011 02:29:22 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <7vr59detcu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171106>

Junio C Hamano venit, vidit, dixit 07.04.2011 21:47:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Because I doubt that the major restructuring we discussed earlier won't be
>> ready within the 1.7.6 timeframe,...
> 
> I think people involved in this thread have dealt with my bad writing long
> enough and understood what I meant, but just in case, I meant to say that
> I do not think restructuring would be ready to ship with 1.7.6,
> in other words, s/won't/will/ is needed above.
> 
> Sorry for a noise.

No problem, that was clear from the context. "Doubt" is such a weak form
of negation that many people miss that possible double negation. In
several languages (or even dialects) a double negation is a strong form
of negation.

The time line sounds very sane, and I'm with the parentheses. What I'm
wondering about are :foo and :foo:bar (which have no modifiers to
parse). I thought you meant to eat the ":" only in the former and not
the latter but I guess I was mistaken. Maybe we can make the ":" literal
when it can't be parsed, or make it do something (":/" as you
suggested), because swallowing it and then doing nothing seems doubly bad.

Michael
