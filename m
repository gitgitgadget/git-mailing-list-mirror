From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What is the scenario for a commit with 3 or more parents
Date: Thu, 29 Jul 2010 14:01:33 -0700
Message-ID: <7vvd7yroia.fsf@alter.siamese.dyndns.org>
References: <AANLkTikMRa_LrD2fU9Piv3GW2H0r7Jf_9s5iM0wc9t6s@mail.gmail.com>
 <20100729021946.GG25268@spearce.org>
 <AANLkTik-wOB-iEGK8EnW1Rdk9wwc1E86tYoBU26WepYJ@mail.gmail.com>
 <C77AA970-4288-487F-9568-E86CF776FCED@gmail.com>
 <AANLkTikpLHdMzbpix8jnyS6YwSkgie=Ts44AJP5dA4=T@mail.gmail.com>
 <7vzkxarqry.fsf@alter.siamese.dyndns.org>
 <AANLkTinT4SpdYHfaiwPqVHDEaN6gEr-3kyHbE4-g=HN5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Joshua Juran <jjuran@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Bradley Wagner <bradley.wagner@hannonhill.com>,
	git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 29 23:01:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OeaEm-0004RC-FE
	for gcvg-git-2@lo.gmane.org; Thu, 29 Jul 2010 23:01:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756325Ab0G2VBv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Jul 2010 17:01:51 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:35401 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754203Ab0G2VBu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 17:01:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id DA6C7C8808;
	Thu, 29 Jul 2010 17:01:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wKJz7cuwFuhAY0sQwYlnObkNWoA=; b=nHUU5X
	CRfxREQxVHiDuYqKmAxdJGpn2HE1ckkdWlilEvUqA8IHVSPoFO9KcXb3N6OZ6Lku
	urMqVLdM3uDroE46PqC83TBb9YQP6C8vQWvct4x/m95QsNqawzYlqOOFugYSwHo1
	kvYYUNCZcJtVfrJwnjrbNMJn1KnKrskonMGSE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lNKAUtqykaM0n+KgEn6skBk9REP6AfBO
	qga2O9O9s0ThfpDxZNEwxvphGBO/ClNdzEZkeNynWkX/+PKbjtHdMOfHcFSWqzF3
	CufeyCoE5zVd64y2T5TYHOifT0Fjp9GmNdajwpVgnIhr8SkTOxu2Wu3n9qaapZ+h
	sXT659B80vY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 86309C8806;
	Thu, 29 Jul 2010 17:01:42 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7FA3EC8803; Thu, 29 Jul
 2010 17:01:35 -0400 (EDT)
In-Reply-To: <AANLkTinT4SpdYHfaiwPqVHDEaN6gEr-3kyHbE4-g=HN5@mail.gmail.com>
 (Sverre Rabbelier's message of "Thu\, 29 Jul 2010 15\:50\:33 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 7D3E2A08-9B54-11DF-A782-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152198>

Sverre Rabbelier <srabbelier@gmail.com> writes:

> On Thu, Jul 29, 2010 at 15:12, Junio C Hamano <gitster@pobox.com> wrote:
>> Compared to that downside, it is not worth to use an Octopus, only to have
>> a smaller number of merge commits and a cool-looking lantern-shaped merge
>> commit in the history.
>
> Ok, do we have _that_ documented anywhere?

Outside the list archive, I don't think so.
