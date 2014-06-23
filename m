From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How should git-config include.path option work in ~/.gitconfig file?
Date: Mon, 23 Jun 2014 10:36:15 -0700
Message-ID: <xmqqegyfcyuo.fsf@gitster.dls.corp.google.com>
References: <CAK6hiNhumFhKd9tjr07SgtZe23LwW8RKSp3BbwVRh06-L0C8EA@mail.gmail.com>
	<20140621100803.GB16599@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Cox\, Michael" <mhcox@bluezoosoftware.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 19:36:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wz8AS-0008Pv-C3
	for gcvg-git-2@plane.gmane.org; Mon, 23 Jun 2014 19:36:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756648AbaFWRgZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2014 13:36:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55626 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756506AbaFWRgX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jun 2014 13:36:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9FC7B229F3;
	Mon, 23 Jun 2014 13:36:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=yGSrkQILOmkBFqq8itu+ML2TIro=; b=vglvAu
	qOq3eKOVTb9emPiwYbPdMhkm03synSfZt4lj0l7etWK7R3lSuwrpLTu7yMgJgGM+
	48+VSUlsSAdBQfMqs8XzumgVX2Fl5TUiakJQYBiRFxLc+BPT3CZvRxu1uxyncxx4
	U7A+2k2hARSKxqxCNkr57ZcWkQSfZp4EFnpTg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xd+sEGCHCpDT0iBc+csHCN1uJryVY7Kb
	9ZWkXngU9xUWXvW672JiFn3XlmG41AoFEnd7jVFjhgYGbmVlhI2iiZqgamxueiYj
	MUR+U/3gvHbQASW74W3Zbn7BODzTdaNQv6NM4IJcD4KKdB95JWT1yt7NoI8gPoRQ
	Lw2uBCAv/XY=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 92A34229F2;
	Mon, 23 Jun 2014 13:36:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id DC52C229E8;
	Mon, 23 Jun 2014 13:36:12 -0400 (EDT)
In-Reply-To: <20140621100803.GB16599@sigill.intra.peff.net> (Jeff King's
	message of "Sat, 21 Jun 2014 06:08:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DEDF8BBA-FAFC-11E3-B94C-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252360>

Jeff King <peff@peff.net> writes:

> ... Recently we discussed supporting environment
> variables in expansions of path-oriented config variables. So something
> like:
>
>   [include]
>   path = $GIT_DIR/../.gitremotes
>
> would do what you want. We'd have to give some thought on what that
> should do when $GIT_DIR is not set (e.g., when you run a git command
> outside of a repository). I'd be inclined to say that such an include
> should be ignored (the naive shell interpretation would be to look for
> "/../.gitremotes", which is almost certainly not what the user wants).

I agree with everything in the above paragraph.
Thanks for forwarding.
