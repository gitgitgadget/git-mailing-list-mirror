From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCHv3 4/5] gitweb: Starting work on a man page for
 /etc/gitweb.conf (WIP)
Date: Tue, 07 Jun 2011 10:00:01 -0700
Message-ID: <7vtyc160ha.fsf@alter.siamese.dyndns.org>
References: <1307382271-7677-1-git-send-email-jnareb@gmail.com>
 <1307382271-7677-5-git-send-email-jnareb@gmail.com>
 <20110606221236.GD30588@elie>
 <1307451658.12283.39.camel@drew-northup.unet.maine.edu>
 <20110607134404.GA12730@elie>
 <1307464037.12888.49.camel@drew-northup.unet.maine.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@ucw.cz>
To: Drew Northup <drew.northup@maine.edu>
X-From: git-owner@vger.kernel.org Tue Jun 07 19:00:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTzdj-0008Ra-7B
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 19:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757248Ab1FGRAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 13:00:22 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51550 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755393Ab1FGRAV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 13:00:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 4143F4509;
	Tue,  7 Jun 2011 13:02:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fdF8ZCLqMyjUwy7UnG0LSgqyzJQ=; b=voynXG
	DNMGyw+a27Lh9u7DA45qPISY4/rW1DlayAOrFVwnKDi9wQ/pCXvJFuUYpiGoZcRQ
	n4BMk4Luha8BNdB9UiIlhjYDUK/ZM1p+FUfKuZlpcU81EHNi/qi4e1Q0zhepUYUm
	ugjY0hORtkPIynD5qMyqKna72HBLFSONm8n8Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PKdxX4/a3vRAp840+AX2zZcjtspat6G8
	het4ywkM6lKpPFV2vt0PtKrZQPJEdUlSmGPlpkXxeVCQvY6ivd6zQK/JbBSE9GdO
	RLXcjrLJ2sYNjbkCN+2aAuCKeYdJoAl6ije89b/6tw++Jizld5ozSRySafqBP3Ao
	Xv2+3OhMReE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D667A4507;
	Tue,  7 Jun 2011 13:02:24 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id EB6E444EB; Tue,  7 Jun 2011
 13:02:14 -0400 (EDT)
In-Reply-To: <1307464037.12888.49.camel@drew-northup.unet.maine.edu> (Drew
 Northup's message of "Tue, 07 Jun 2011 12:27:17 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EAAA5A48-9127-11E0-8C19-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175215>

Drew Northup <drew.northup@maine.edu> writes:

> On Tue, 2011-06-07 at 08:44 -0500, Jonathan Nieder wrote:
> ...
> If this is what you are proposing then we should be working on a
> "gitweb_config.perl" manpage and not a "gitweb.conf" manpage. I know a
> fair number of people around here put priority on the former and would
> just as soon ignore the latter. That's what your proposed change says to
> me (while I also understand that your own position is likely far more
> nuanced than that).

Hmm, do you want to have two (and then three, see below) separate manpages
that essentially describe the same thing, and refer to each other when
they talk about the precedence order?

>> >>> +*NOTE:* If per-instance configuration file ('gitweb_config.perl') exists,
>> >>> +then system-wide configuration file ('/etc/gitweb.conf') is _not used at
>> >>> +all_!!!
>> >>
>> >> Over the top. :)  I think the best way to document this is to contrast
>> >> it with /etc/gitweb-common.conf once the latter exists.
>> >
>> > If we were to change gitweb to handle configuration files like the rest
>> > of git (and in fact like most things we deal with daily, where settings
>> > are overridden one by one) then this section becomes moot. Until or
>> > unless that becomes the case it is important to loudly make note of it. 
>> 
>> Does using three exclamation marks and italics make it clearer?
>
> That could probably be cut down to one, I'll grant you that. I was
> trying to avoid use of the <blink> tag.

I vaguely recall that there was an effort to document /etc/gitweb.conf as
a mere "fallback default", not a "system-wide configuration file", which
is what it is, and also to introduce a true "system-wide configuration" as
a separate file, so that the system-wide one will be read, and then either
per-instance gitweb_config.perl or the fallback default /etc/gitweb.conf
will update it. What happened to that effort?

In any case, with the current design, /etc/gitweb.conf is _not_ the
system-wide configuration file but it is a fallback default for instances
that do not have per-instance configuration, so the quoted part would need
rewording anyway, I think.
