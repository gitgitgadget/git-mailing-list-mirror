From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch series overview)
Date: Sat, 13 Sep 2014 10:52:25 -0700
Message-ID: <xmqqvbor8l2e.fsf@gitster.dls.corp.google.com>
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
	<xmqqk358a9yz.fsf@gitster.dls.corp.google.com>
	<xmqqd2b0a7m9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 13 19:52:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSrUv-0000kk-7H
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 19:52:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752168AbaIMRw3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 13:52:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:50484 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752061AbaIMRw2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 13:52:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A6B4537559;
	Sat, 13 Sep 2014 13:52:27 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9Vypv8U2r46DGBfPzMeZZkilbCo=; b=Jjfr5Y
	75oyYttWgV3v4bY8uNobbSYRmi21v3leszp7dJ6RpgtqpicMNWUIr37gT+AvIXvl
	WsQgollN5loJftSWpNdQF2Li42H7vMXLKAwXMT1LO+9x8y1d6dnZWme/i6AsWCgB
	XNDAJTWHjlY7/2GpRPdJewq6Lz0QBddYTFIaQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZH54pWuPRCUX7yGPeVwRpjMKLTlrVTWx
	Rbx6qFttB3q/fWOHx5NxXnNGZ965Kgc3XAc0xwUi8Xn9VSx+a3SqiyBXpTDBb8v6
	Qv2A1uzG5PngwgaB3/bUT9Ge8e8acLPKPkoJLRcSCLJb3S4ict+pw5qjwcBfw+Ad
	J9PlDW2dnAo=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9A45A37557;
	Sat, 13 Sep 2014 13:52:27 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 1726D37554;
	Sat, 13 Sep 2014 13:52:27 -0400 (EDT)
In-Reply-To: <xmqqd2b0a7m9.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Fri, 12 Sep 2014 13:47:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: B968E86A-3B6E-11E4-8617-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256969>

Junio C Hamano <gitster@pobox.com> writes:

> I noticed that with this series merged to the version I use daily,
> detaching HEAD (i.e. "git checkout HEAD^0") breaks my HEAD reflog,
> which made me redo the integration ejecting the series out of 'pu'.
>
> Not happy, as my workflow relies fairly heavily on detached HEAD
> X-<.

Just FYI.

Bisecting the series using the attached as a test script points
"branch -d: avoid repeated symref resolution" as a possible culprit.
Perhaps these tests may want to be added to t3200 which is touched
by the said commit (or add them earlier in the series)?

-- >8 --

#!/bin/sh

test_description='reflog not nuked with co HEAD^0'
. ./test-lib.sh

check_reflog () {
	while read name
	do
		git rev-parse --verify "$name"
	done >expect &&
	if test -f "$2"
	then
		while read object rest
		do
			git rev-parse --verify "$object"
		done >>expect <"$2"
	fi &&
	while read object rest
	do
		git rev-parse --verify "$object"
	done >actual <"$1" &&
	test_cmp expect actual
}

test_expect_success setup '
	test_tick &&
	git commit --allow-empty -m initial &&
	git branch side &&
	test_tick &&
	git commit --allow-empty -m second &&
	git log -g --oneline >baseline &&
	check_reflog baseline <<-\EOF
	master
	master^
	EOF
'

test_expect_success 'switch to branch' '
	git checkout side &&
	git log -g --oneline >switched &&
	check_reflog switched baseline <<-\EOF
	side
	EOF
'

test_expect_success 'detach to other' '
	git checkout master^0 &&
	git log -g --oneline >detach-1 &&
	check_reflog detach-1 switched <<-\EOF
	master
	EOF
'

test_expect_success 'attach to self' '
	git checkout master &&
	git log -g --oneline >detach-2 &&
	check_reflog detach-2 detach-1 <<-\EOF
	master
	EOF
'

test_expect_success 'detach to self' '
	git checkout master^0 &&
	git log -g --oneline >detach-3 &&
	check_reflog detach-3 detach-2 <<-\EOF
	master
	EOF
'

test_expect_success 'attach to other' '
	git checkout HEAD^0 &&
	git checkout side &&
	git log -g --oneline >detach-4 &&
	check_reflog detach-4 detach-3 <<-\EOF
	side
	EOF
'

test_done
