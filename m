From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/8] mv: unindent one level for directory move code
Date: Tue, 12 Aug 2014 10:56:37 -0700
Message-ID: <xmqqlhqt617u.fsf@gitster.dls.corp.google.com>
References: <1407637776-19794-1-git-send-email-pclouds@gmail.com>
	<1407637776-19794-7-git-send-email-pclouds@gmail.com>
	<xmqq61hy7tii.fsf@gitster.dls.corp.google.com>
	<CACsJy8B2P-UMvbkW2HtyxrYPP8TyXnt25CYw9=ZZp6Ks+ed=yA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 12 19:56:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHGJY-0002h3-1I
	for gcvg-git-2@plane.gmane.org; Tue, 12 Aug 2014 19:56:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754323AbaHLR4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2014 13:56:48 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57369 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426AbaHLR4r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2014 13:56:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 178B02FC69;
	Tue, 12 Aug 2014 13:56:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=z6AHRRMYeT70rranppQs1yXtSfA=; b=YHwcRl
	ep+GJG8RtxT58A6E6ntA0qGu1znZulu/QogDyMTPc0zNzQtCskETGM9cX9ylmyBt
	Wa6LLj+Q0B9TGnMd2tPzm6LamCu4uYer70VJQYBAEm2+WxcJimP1bKTyRdAqlSLy
	vHKbSzW94Diw9XN7fyXpr2NQNHPkOTJ982zkQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pRYv9EhBVCASTyS68xl+3onENaMfIcmt
	2P72bHkraQN2/sgzsbeYlITStd4llMy8m0rrkdaLTTCLbfjrM890htvv9+cklsUy
	rAJjyBs9B9wslTZ0HHsU79KTUW3e1HjO/IzggGY6VYlhSyQZ0HWSKlQ5uX47LqWN
	GpA2xh8L6cw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0E9CB2FC65;
	Tue, 12 Aug 2014 13:56:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B41EE2FC5E;
	Tue, 12 Aug 2014 13:56:39 -0400 (EDT)
In-Reply-To: <CACsJy8B2P-UMvbkW2HtyxrYPP8TyXnt25CYw9=ZZp6Ks+ed=yA@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 12 Aug 2014 21:57:17 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 02C6E5D6-224A-11E4-87E1-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255157>

Duy Nguyen <pclouds@gmail.com> writes:

>> Otherwise, perhaps squash this in?
>
> Sure. But I'm having second thought about this series.
>
> mv.c is centered around files on worktree, which makes it pretty hard
> if we want to make it more like rm.c where index and worktree entries
> are treated more equally and pathspec is applied. Doing that in mv.c
> would require a lot more reorganization that makes this series
> obsolete.

Well, you may have started these as preparatory clean-up, but taken
alone these are purely making the result more readable without
changing any behaviour, so let's get them right first.

Thanks.
