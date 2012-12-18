From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal: create meaningful aliases for git reset's
 hard/soft/mixed
Date: Tue, 18 Dec 2012 07:22:24 -0800
Message-ID: <7vk3sfidvz.fsf@alter.siamese.dyndns.org>
References: <CAGK7Mr4GZq5eXn4OB+B0ZborX-OVoXiWU8Lo1XM5LRZDuRe1YA@mail.gmail.com>
 <7vlir6brjw.fsf@alter.siamese.dyndns.org>
 <CANiSa6h3Qf=6hw6fzHVw=CeuhnNeq+cuEvwwmVhUaSOcVgCSBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Philippe Vaucher <philippe.vaucher@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 16:22:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tkz0H-0006pv-JP
	for gcvg-git-2@plane.gmane.org; Tue, 18 Dec 2012 16:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932161Ab2LRPW2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Dec 2012 10:22:28 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47022 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932067Ab2LRPW1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Dec 2012 10:22:27 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E71397CF;
	Tue, 18 Dec 2012 10:22:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jeW/9XGSi70nEDjITovRe93b+iw=; b=df7RK5
	seM4rdHUcyBCOpmRJC3oJMBIGXkCLgJn1iVtUzRV7Z8g3NgCeTE2ZPyPmLNE3tqS
	To8WgXkDM9cTG+/DoyZssFSlamI8mtHMP5qFT0r6usnViPPlWe2FwniePrUGYaYw
	AZASvLEblzdHTpWr+Fe8FKx+zVDzCg4mehag8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cQh6vo7Rd+r8b41ONQIXyNOf17FNDZFl
	1K/HSs6iavVpj0H739Z4RRheGhPZuuOT8hZXbNLJj61YomXcQ/H+vLzbYDxT/0F3
	3Lt6z3CS8TkQdK6Hp1ONoWlbCV18aGkr0ip9oFlro6tUOvJfLYHQn24tZY7r9Ac2
	Og3EjT32brA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6BE1797CE;
	Tue, 18 Dec 2012 10:22:26 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D436D97CD; Tue, 18 Dec 2012
 10:22:25 -0500 (EST)
In-Reply-To: <CANiSa6h3Qf=6hw6fzHVw=CeuhnNeq+cuEvwwmVhUaSOcVgCSBA@mail.gmail.com> (Martin
 von Zweigbergk's message of "Mon, 17 Dec 2012 22:34:07 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA5D18D6-4926-11E2-BE86-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211752>

Martin von Zweigbergk <martinvonz@gmail.com> writes:

> On Wed, Nov 23, 2011 at 10:51 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>> I am guilty of introducing "git reset --soft HEAD^" before I invented
>> "commit --amend" during v1.3.0 timeframe to solve the issue "soft" reset
>> originally wanted to.
>
> I do use "commit --amend" a lot, but I still appreciate having "reset
> --soft". For example, to squash the last few commits:
>
> git reset --soft HEAD^^^ && git commit --amend

Yeah, I do that sometimes myself, but the key word is "sometimes".
These days, I think most users (not just mortals but experienced
ones) use "rebase -i" to squash them altogether, either with "fixup",
with which you lose the messages from the follow-up fixes, just
like the soft reset to an old one with an amen,) or with "squash",
with which you can pick pieces of messages from the follow-up fixes
while updating the message from the original one.
