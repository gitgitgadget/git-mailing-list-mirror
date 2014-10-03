From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC 5/5] add tests for checking the behaviour of "unset.variable"
Date: Fri, 03 Oct 2014 11:48:51 -0700
Message-ID: <xmqqwq8hkmzw.fsf@gitster.dls.corp.google.com>
References: <1412256292-4286-1-git-send-email-tanayabh@gmail.com>
	<1412256292-4286-6-git-send-email-tanayabh@gmail.com>
	<xmqqr3yqmdxa.fsf@gitster.dls.corp.google.com>
	<542DB2FE.609@gmail.com>
	<xmqqmw9emdax.fsf@gitster.dls.corp.google.com>
	<542DB711.9040503@gmail.com>
	<xmqqiok2m494.fsf@gitster.dls.corp.google.com>
	<vpqeguptz5k.fsf@anie.imag.fr>
	<xmqq1tqpm2na.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Oct 03 20:49:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xa7uf-0002hv-0s
	for gcvg-git-2@plane.gmane.org; Fri, 03 Oct 2014 20:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbaJCStF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 14:49:05 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60103 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573AbaJCStC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 14:49:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EC3403FB71;
	Fri,  3 Oct 2014 14:49:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Eyc5DDax5h+Pdi9Y3xg1JXiz/Nc=; b=K1677N
	zMOPm7kGaDgRPDb0Nlz5xDIQytEz6dseTcX+6nNoVtNXNQwgEbqZKRSXpJ7fO+wu
	Vv0ImDN+YuulAm9gtHFaLyMFxa+Bl1e0/FTaPtOmZ0QnyleOJCNNg78Pr2xFzTdc
	MBtB26SlvWXuKgo3kTUfWhCQIs6T11P+oGmdY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hqjfQqNLPd798cMG9bWJWHEjgp91cRo+
	HHeAapUNMHOlAwzY6WOulNEpdbBnrgtLzL/hFqRL7tZzEgTNuxKHodSlPWkuKbNa
	vN/UGzJ8PDfiqqUIt5kHxvmPsP0xwMFFqHtMfCRMMfrxsVb9bRh9S+dcndKCKf+S
	XN8fqNCn6Lo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E2A5C3FB70;
	Fri,  3 Oct 2014 14:49:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 47F1A3FB58;
	Fri,  3 Oct 2014 14:48:53 -0400 (EDT)
In-Reply-To: <xmqq1tqpm2na.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 03 Oct 2014 11:25:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EC01271E-4B2D-11E4-B9EE-9E3FC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257843>

Junio C Hamano <gitster@pobox.com> writes:

> That is why I said "unset.variable" is unworkable with existing "git
> config" command line.  Always appending at the end is usable for
> ordinary variables, but for unset.variable, it is most likely the
> least useful thing to do.  You can explain "among 47 different
> things it could do, we chose to do the most useless thing, because
> that is _consistent_ with how the ordinary variables are placed in
> the cofiguration file" in the documentation but it forgets to
> question if unset.variable should be treated the same way as
> ordinary variables in the first place.

This is a tangent, but the above also applies to the "include.path".
