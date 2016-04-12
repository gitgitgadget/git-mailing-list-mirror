From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 0 bot for Git
Date: Tue, 12 Apr 2016 13:49:07 -0700
Message-ID: <xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
	<CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
	<vpq60vnl28b.fsf@anie.imag.fr>
	<CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com>
	<vpqoa9ea7vx.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Tue Apr 12 22:49:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq5Fs-0003NE-Ua
	for gcvg-git-2@plane.gmane.org; Tue, 12 Apr 2016 22:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965465AbcDLUtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 16:49:36 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965576AbcDLUtK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 16:49:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4140E555A3;
	Tue, 12 Apr 2016 16:49:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yY63LnF6G+APismMp/ng59fS4eE=; b=nVPQZT
	rKQOLuuEJMoypfkP9uvPT8CjthKzQ7iz3REulSeFl6Y99v42+rDlLMhJ/Y308LOT
	ti7j27/EFqY4KtdZyZsbbbma7y5b1MASzGQ30LF7WMZ9MKOi3XEnQ987zjfG0Q3/
	nZSf+N57JFiXL8LCiIfuwHhmFYKV3AAeGlPk4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qFWCwNGed/O5pBNLLyB8x9ZW5+e8hfqp
	l2EXtvB+2rs4q1dsKv9BAX65Wkr6NWwF8SWOB+rsgVWWWSC2ve1/2MgyXOLmoDOv
	rJfPl6i5QvQW5vfvEfjwgl6un14RrOdqK91CW0P3L55Y/xVEL/3HzJ8nOQVV1PnU
	p1MdQxXgO5Q=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 387B4555A2;
	Tue, 12 Apr 2016 16:49:09 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A7016555A1;
	Tue, 12 Apr 2016 16:49:08 -0400 (EDT)
In-Reply-To: <vpqoa9ea7vx.fsf@anie.imag.fr> (Matthieu Moy's message of "Tue,
	12 Apr 2016 22:29:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 00CD831C-00F0-11E6-AC30-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291294>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> But my point wasn't to say "we already have everything we need", but
> rather "we already have part of the solution, so an ideal complete
> solution could integrate with it".

Yes.  That is a good direction to go.

They may already have part of the solution, and their half may be
better than what we have, in which case we may want to switch, but
if what we have already works well there is no need to.

> I don't know how 0 bot solves this, but the obvious issue with this
> approach is to allow dealing with someone sending a patch like
>
> +++ Makefile
> --- Makefile
> +all:
> +	rm -fr $(HOME); sudo rm -fr /
>
> to the list. One thing that Travis gives us for free is isolation:
> malicious code in the build cannot break the bot, only the build
> itself.

True, presumably the Travis integration already solves that part, so
I suspect it is just the matter of setting up:

 - a fork of git.git and have Travis monitor any and all new
   branches;

 - a bot that scans the list traffic, applies each series it sees to
   a branch dedicated for that series and pushes to the above fork.

isn't it?
