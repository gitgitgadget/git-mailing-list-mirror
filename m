From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Should "git log --decorate" indicate whether the HEAD is detached?
Date: Wed, 18 Feb 2015 11:49:25 -0800
Message-ID: <xmqq8ufv2e62.fsf@gitster.dls.corp.google.com>
References: <CACdBeKmNazMtzK4hdd7WXMPDr7HdPe+EFpyd3M-TPBAUEY+HpA@mail.gmail.com>
	<xmqqa90d4fdp.fsf@gitster.dls.corp.google.com>
	<CACdBeKnWJvUmFaHNrzcX7LtovOLu3PFaeTyoUAUeC7wmYUboDg@mail.gmail.com>
	<54E46635.4060009@drmicha.warpmail.net>
	<xmqq8ufv408l.fsf@gitster.dls.corp.google.com>
	<54E4EBC4.6000802@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Julien Cretel <j.cretel@umail.ucc.ie>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Wed Feb 18 20:49:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOAco-0000HB-AJ
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 20:49:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754854AbbBRTta (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 14:49:30 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:53450 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751826AbbBRTt2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 14:49:28 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9396C38FA1;
	Wed, 18 Feb 2015 14:49:27 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cCHDJZxDZbgdW38Focezd3catfw=; b=IKoizS
	FIqYtkHY5xKA4ct8Iwg2Fo0haqwb609/zZ5TZHJsjMB1IHqPYEXYGkwCd6xzqdKg
	nnET4Lriry3gzaY9F20tO/xPxTu7olr9KJ73kS59gJh7djaqLPT7h0c7NDTSZy6s
	LZFOfYz2QllTgDIpai09foNyneKoQmJwsxfXs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LhYy15XODPA417Aj4JdEkb/ohlW0en1u
	jZDZseKTAgZKnTU9oJAvPfHsd7D29+7grPMBETt5pjgxb3iMnRCgYqOk8P+ooU3q
	+2naopEuHhkZyeUPiFU5rSSpsT/VvR1hSX+N9g1UUPR4fv1p8337LWPH1wE20U+g
	v7n+WmJAfBc=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8A9C138FA0;
	Wed, 18 Feb 2015 14:49:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1494C38F9E;
	Wed, 18 Feb 2015 14:49:27 -0500 (EST)
In-Reply-To: <54E4EBC4.6000802@drmicha.warpmail.net> (Michael J. Gruber's
	message of "Wed, 18 Feb 2015 20:45:08 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3EEADADE-B7A7-11E4-BFF1-A4119F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264059>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Yep, it very well is. Also, that approach would tell you which branch is
> checked out, though I don't consider that git log's business.
>
> OTOH, it's "backwards" in the sense that it marks the "ordinary" case
> (HEAD is symref, branch is checked out) specially compared to the
> "exceptional/dangerous" case (HEAD is ref, detached).

Both are ordinary and there is nothing exceptional or dangerous
about your HEAD temporarily being detached during a "rebase -i"
session, for example.

> And status, branch
> will point out that latter case more verbously, too.

Yeah, but as you said, that is not "log"'s business.
