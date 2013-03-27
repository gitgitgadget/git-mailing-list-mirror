From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Composing git repositories
Date: Wed, 27 Mar 2013 09:06:06 -0700
Message-ID: <7vvc8comj5.fsf@alter.siamese.dyndns.org>
References: <CALkWK0=CsuAWQwk5Guf0pbC4_ZEoZiwQpamcRvBGz5LJ0QGKHg@mail.gmail.com>
 <7vmwtqt8rs.fsf@alter.siamese.dyndns.org>
 <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 27 17:06:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKss3-0003Wb-4u
	for gcvg-git-2@plane.gmane.org; Wed, 27 Mar 2013 17:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752392Ab3C0QGK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Mar 2013 12:06:10 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45494 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752115Ab3C0QGI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Mar 2013 12:06:08 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 763A29DE7;
	Wed, 27 Mar 2013 12:06:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZB0n64BjmE57zJFfzkCh7ulS7A0=; b=T6Qri5
	xWO8pf8KNnFqz80Jm3u8DQzLPrkdl+nTq/mMM3LOIkkmgSlPdTxXEnNXsVSv7dej
	BCYspUJIv7U/fxVjSawrQR5+RV+iD25j35o3uITnDhk6Bj+YajtDbu+JEZK/OkBL
	Ynkto9SW4bKCq1Oosc8oeuRr1EJiEkEdlwsn0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vddUXdxyoaap7UT9KhIPhPZ248YT6ATA
	wuMNC1+ylcXJN5JasQehCGNG/PFm9BA8cKSdt4Sa1crzla1GZvpr1TkW/cdZGaIP
	LSCsgUCPuQrKvRAVkH7OdgGkRkGZXrpUT9YouBNpwS34h8rhRU72XARANgQQWrkB
	dKaUFvG66E4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B0C99DE6;
	Wed, 27 Mar 2013 12:06:08 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CB3319DE4; Wed, 27 Mar 2013
 12:06:07 -0400 (EDT)
In-Reply-To: <CALkWK0kNH2A4eLML22RTofarR3MB++OECiNXMi-bWLLMWK1GAg@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Wed, 27 Mar 2013 17:19:38 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3C1205F2-96F8-11E2-8C43-B1692E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219264>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> So you have to stash it somewhere.  We could have made it to move
>> them to $HOME/.safeplace or somewhere totally unrelated to the
>> superproject.  So in that sense, the repositories are *not* owned by
>> the superproject in any way.  However, you are working within the
>> context of the superproject on the submodule after all, and
>> somewhere under $GIT_DIR/ of the superorject is not too wrong a
>> place to use as such a safe place.
>
> Thanks for the explanation.

What do you _exactly_ mean by that?  You understood why things are
arranged in that way, and no longer think that it is unnecessary,
ugly and unwieldy to stash the real copy of $GIT_DIR of submodules
away from their working trees and store them inside $GIT_DIR/modules
of the superproject?

> The paths in .git/modules are unnecessary ugly and unwieldy,
> especially in the case of multiple levels of nesting...
