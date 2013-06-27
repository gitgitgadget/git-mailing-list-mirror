From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pull: require choice between rebase/merge on non-fast-forward pull
Date: Thu, 27 Jun 2013 13:58:26 -0700
Message-ID: <7vmwqbqnil.fsf@alter.siamese.dyndns.org>
References: <CAEBDL5WqYPYnU=YoCa2gMzcJCxeNbFmFgfWnHh=+HuouXLLsxg@mail.gmail.com>
	<20130523102959.GP9448@inner.h.apk.li>
	<20130523110839.GT27005@serenity.lan>
	<7vd2shheic.fsf@alter.siamese.dyndns.org>
	<20130523164114.GV27005@serenity.lan>
	<7vbo81e7gs.fsf@alter.siamese.dyndns.org>
	<20130523215557.GX27005@serenity.lan>
	<7vli75cpom.fsf@alter.siamese.dyndns.org>
	<CA+55aFz2Uvq4vmyjJPao5tS-uuVvKm6mbP7Uz8sdq1VMxMGJCw@mail.gmail.com>
	<7v4ncjs5az.fsf_-_@alter.siamese.dyndns.org>
	<20130627203007.GG9999@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	John Keeping <john@keeping.me.uk>,
	Andreas Krey <a.krey@gmx.de>,
	John Szakmeister <john@szakmeister.net>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Jun 27 22:58:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsJGz-00080Q-8k
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 22:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753854Ab3F0U63 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Jun 2013 16:58:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43663 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753741Ab3F0U62 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Jun 2013 16:58:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 58DA729C0E;
	Thu, 27 Jun 2013 20:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OYhvobB3ixEK1JHf9HuqzXI4p8w=; b=nYA31+
	V4qyiX7lAlICQo649K/o/d60QgdhFN0g653P8ejsRBT8/inf3tYAV1UBZF52W9bw
	+LawYBHoxdc2qrSmRWnOQAzwv1xGf73KT6G7C2vtXS3nrUoEd5MfEtroJ2Tc+nyQ
	mq6cFAx2754cxCbdsYNM6oPZLXjpmgnS9LBlE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Tn4g8OUyLEz41qFKFVH5txQFHWJiRGa+
	ZFrCsg/08kucHpqoB6Nya3lZWxHJSkKqupaeDvr3y5NrsRhGO3JteryDzfBbDAcc
	ImKi8rJzakvpQMycaHOrq664worGwwYkLvu3wo1UE65U+OQIIEtFzxUY1ZsQVb0Q
	1537xjoNzc4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4B10029C0D;
	Thu, 27 Jun 2013 20:58:28 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9B29629C0C;
	Thu, 27 Jun 2013 20:58:27 +0000 (UTC)
In-Reply-To: <20130627203007.GG9999@odin.tremily.us> (W. Trevor King's message
	of "Thu, 27 Jun 2013 16:30:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 509DB252-DF6C-11E2-BB43-E636B1368C5F-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229157>

"W. Trevor King" <wking@tremily.us> writes:

> Assorted minor edits:
>
> On Thu, Jun 27, 2013 at 12:48:52PM -0700, Junio C Hamano wrote:
>> Because letting a trivial merge automatically handled by Git is so
>
> Maybe:
>
>   Because letting Git handle a trivial merge automatically is so…
>
>> that the project s/he is interacting with may prefer "rebase"
>> workflow.  Add a safety valve to fail "git pull" that is not a
>
> Maybe (adding an "a"):
>
>   a "rebase" workflow.

Thanks.
