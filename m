From: Junio C Hamano <gitster@pobox.com>
Subject: Re: General support for ! in git-config values
Date: Wed, 01 Feb 2012 17:41:20 -0800
Message-ID: <7v39au1073.fsf@alter.siamese.dyndns.org>
References: <CACBZZX6U+1Fmdaz2ikbbc6zUyF=pMGQOqUGVOWCkUFBUkovCBw@mail.gmail.com>
 <20120201184020.GA29374@sigill.intra.peff.net>
 <CACBZZX5mX55Rh8b2GYv7wKbCCypCkrn5AiM9BpXydgcYxHWdQA@mail.gmail.com>
 <7v62fq2o03.fsf@alter.siamese.dyndns.org>
 <CANgJU+X+UZmycwE6xkJ-zHfT7ai6nV9zbeR4WYnAXczL5JtqjA@mail.gmail.com>
 <7vliom13lm.fsf@alter.siamese.dyndns.org>
 <CANgJU+XQWdFmfmBJ4KX4GBz1a=TrVbp9BphGmhEb5Gphmzogjw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 02 02:41:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rslfz-0007dI-T9
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 02:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754074Ab2BBBlX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Feb 2012 20:41:23 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42389 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754053Ab2BBBlW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2012 20:41:22 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 451A06880;
	Wed,  1 Feb 2012 20:41:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AnF5IAEGHyFS78v+7cklvouc+X8=; b=hi/7Rl
	4qWpDla1voZeoJbievG32asiOE93Ryq1kwxcGDdS8UkK3AVHZhao1BqTgWBk1xcR
	nwcnG7b3YT9uwG4edQlC9MBe4x4J0MmBbCDdDP64GOKB01BCddI3ZjovLhC00tT+
	PBxx9Np4iEg2xQOzyiuCdIMimLmLLykS5w98w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Bw73WXSo2aIfTEuSlx3pH1Hn+DLzNUjQ
	M4jA+pqaPx/RS+mpknay9UbmCAskEpKSnwXpPH8Zf50OuLwLOjOg8TjGj84qygZw
	w7/ahog8wSFEMl+Hr98AAAIsMtpxtAG4owK2N21nBr8NIyaLveTPyi9Y9gURzXGj
	el4b1U9WXp4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3C839687F;
	Wed,  1 Feb 2012 20:41:22 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C4C84687E; Wed,  1 Feb 2012
 20:41:21 -0500 (EST)
In-Reply-To: <CANgJU+XQWdFmfmBJ4KX4GBz1a=TrVbp9BphGmhEb5Gphmzogjw@mail.gmail.com>
 (demerphq@gmail.com's message of "Thu, 2 Feb 2012 02:14:26 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0281DD98-4D3F-11E1-86CF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189571>

demerphq <demerphq@gmail.com> writes:

>> When you say "alias.co = !git checkout --foo-bar", you are not saying
>> "instead of usual aliases like 'alias.co = checkout' that defines what
>> string replaces the 'co' alias, please run !whatever command, capture
>> its output, and that is the _value_ of alias.co variable, i.e. the command
>> line that is going to be run".
>
> I think I see your point. Using the same "!" notation for "execute
> this command and exit" and "execute this command and use its result as
> the config value" might be confusing.

I am afraid that you are not seeing it.  In "alias.co = !whatever", bang
does *NOT* mean "execute this command and exit".
