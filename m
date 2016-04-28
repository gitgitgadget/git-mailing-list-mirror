From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config settings
Date: Thu, 28 Apr 2016 15:47:32 -0700
Message-ID: <xmqqshy52vwb.fsf@gitster.mtv.corp.google.com>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
	<89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
	<20160428112912.GB11522@sigill.intra.peff.net>
	<alpine.DEB.2.20.1604281405540.2896@virtualbox>
	<20160428134953.GB25364@sigill.intra.peff.net>
	<CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
	<20160428153902.GF31063@sigill.intra.peff.net>
	<CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com>
	<20160428165031.GA31421@sigill.intra.peff.net>
	<xmqq1t5p5z8v.fsf@gitster.mtv.corp.google.com>
	<20160428191038.GA10574@sigill.intra.peff.net>
	<xmqqwpnh4joq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYoRP=rkfaL+rLapmvouUdPxXGBr-KWOLhL94bYB1B2-w@mail.gmail.com>
	<xmqqoa8t4il8.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY1TB9sZpZcihiC5rPmbf8qD9KsAZsWDcon+UnHG7R3jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 29 00:47:44 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avuii-0002lq-T1
	for gcvg-git-2@plane.gmane.org; Fri, 29 Apr 2016 00:47:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbcD1Wrh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 18:47:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61730 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752201AbcD1Wrg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 18:47:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B5DD416CBC;
	Thu, 28 Apr 2016 18:47:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NRW9aSzjplHwcf9ELS5/rkKm1Bs=; b=IUuWhc
	VvVJtTc9vEOMXhKyeyY4PwkXCrZ1/f8mITh6hs1mBFB4mGNWEuYvI8gJbTugAwHq
	hYj17KZM7jAFPVj/dZ5TKihL8aILQugY6Bxb184hvFtEM//3qiBXO7BHK3/rK7Fs
	rIp7pKZCm9/RXdeyhOt8UapZ8huYuD80WPLl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dphB9cubNaQ83y6epzYTFgYSMN/uqcxY
	zcLyEdoJtB1sTUDVxDA+xeDuzWGKNjopveXldKMwjnx9/fh7PUHOp8e7eyWRZS+a
	FtCbCDGHI5cKCNd6DKAVvfnnX/Ny81Hv3x2GES46JBuBZF+vp5lJoWXk3QShYPht
	hEzszbs59w0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ADF4F16CBB;
	Thu, 28 Apr 2016 18:47:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 09B5716CB8;
	Thu, 28 Apr 2016 18:47:34 -0400 (EDT)
In-Reply-To: <CAGZ79kY1TB9sZpZcihiC5rPmbf8qD9KsAZsWDcon+UnHG7R3jw@mail.gmail.com>
	(Stefan Beller's message of "Thu, 28 Apr 2016 13:01:09 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 32924BEE-0D93-11E6-A2BB-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292959>

Stefan Beller <sbeller@google.com> writes:

> It doesn't even have to be a submodule related thing at all.
>
> I can imagine that `git gc` could learn to walk nested repos
> (not submodules, just repos on disk inside the work tree).
> And for that use case we'd maybe want to have a setting
> to pack the nested repos more aggressively than the toplevel repo.
>
> (Not sure if there would be a use case or such a thing, but it is the
> first I came up with)

I do not think we are in the business of mucking with "dump of
unrelated collections of repositories, whose inter-relationship the
user did not tell us anything about".

I however can foresee a value in "git gc --recurse-submodules", and
I could see users may want to gc different submodules in different
ways (which again brings us back to your "submodule group" thing).
