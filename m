From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch series overview)
Date: Fri, 12 Sep 2014 12:56:52 -0700
Message-ID: <xmqqk358a9yz.fsf@gitster.dls.corp.google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
	<CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
	<CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
	<CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
	<20140820231723.GF20185@google.com>
	<20140911030318.GD18279@google.com>
	<xmqqfvfxdcjz.fsf@gitster.dls.corp.google.com>
	<20140912004717.GY18279@google.com>
	<xmqqsijwaclo.fsf@gitster.dls.corp.google.com>
	<20140912191812.GZ18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 21:57:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSWxn-0005lN-Uu
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 21:57:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100AbaILT44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Sep 2014 15:56:56 -0400
Received: from smtp.pobox.com ([208.72.237.35]:59482 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbaILT4z (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Sep 2014 15:56:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D81C838BD3;
	Fri, 12 Sep 2014 15:56:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3nPNWiq5JVyUGtwXumMzY/ZorPU=; b=hf3IVS
	De0GpBJkJliuWsU8cueeI1Zc7IekMxBDSvHJRsw96Z83vvyFZdPraqBU5EUhiC1f
	a3UDJKSdiy+9w3/bL72vLhhlOT0MjmcmpgT8SRq830rOZXryfKB5KLCbeJNzJu7e
	FCuW5os05ekuPZVt+6ICv1o4l5nTpMfNuLLcw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DO6OlU/ndwu51LJuY/+z+oCqcaLw0tMm
	L85QrhJJo3/pOCs6CDEZzKPnZjiDmFKkBWPM9cpvrnrWhFItvFTsGAeK7sK/SY+O
	JEO+NV821oQevL0upuvr0a2KkKgX5OrC/8ccIAH1kvofviDtqJJAhQ6nmvlEK4Se
	sJukXr/haDo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CCFED38BCB;
	Fri, 12 Sep 2014 15:56:54 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 48C8F38BC9;
	Fri, 12 Sep 2014 15:56:54 -0400 (EDT)
In-Reply-To: <20140912191812.GZ18279@google.com> (Jonathan Nieder's message of
	"Fri, 12 Sep 2014 12:18:12 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F1CBA7B4-3AB6-11E4-A05B-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256948>

Jonathan Nieder <jrnieder@gmail.com> writes:

> It's "Oops, the next one (refs.c: do not permit err == NULL) is broken,
> and this is to patch it up in advance". :)
>
> But it should apply on top, too.

I think "in advance" makes sense for this one, too.

> There were a few other minor changes, and I think with them the series
> should be ready for "next".  My "send and hope that more reviewers
> appear" strategy didn't really work,...

You sent them just a few days ago.  Expecting anybody to have a
solid time to sit thru a 19-patch series inside that timeframe is
not so realistic.

> so I'll send a reroll of the series as-is in an hour or so.

OK.  Thanks.
