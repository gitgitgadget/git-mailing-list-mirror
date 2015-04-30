From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: add blame.showemail config option
Date: Thu, 30 Apr 2015 14:43:06 -0700
Message-ID: <xmqqk2wtxpg5.fsf@gitster.dls.corp.google.com>
References: <1429841612-5131-1-git-send-email-qneill@quicinc.com>
	<CAPig+cQrUPHOaKjNhsmLho+bFdAOQxb0NK2YK2QsFmdDBF6h4g@mail.gmail.com>
	<CACfD1vvaAGkx2P3yMfZPOZrRvG3-H96zQVOCevnd-O0rBJ7wjw@mail.gmail.com>
	<xmqqwq0xwige.fsf@gitster.dls.corp.google.com>
	<CAPig+cRTfB9aiinhSJp=jY7-__6dRvfAqhWZYVN3+Ut=Y79LcQ@mail.gmail.com>
	<xmqqmw1svigd.fsf@gitster.dls.corp.google.com>
	<CACfD1vtfO_rqr4wv4oHm7W7DSn-Gk-du6nCuJzYvpPXK_d=y=g@mail.gmail.com>
	<CAPig+cQ1JNeg5eoJib07nc6UrREE80pssokbk+xthXTXDcQz1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Quentin Neill <quentin.neill@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 23:43:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnwEl-0003Sd-Ea
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 23:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750911AbbD3VnK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 17:43:10 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63265 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750800AbbD3VnJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 17:43:09 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B47E94DD30;
	Thu, 30 Apr 2015 17:43:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BtYxNLd6SWPprf7ah+Omm2HxNg8=; b=w7E1Ol
	1FJbXwkOjbG9+tnGqqAW/Duy+Yiy7o6VmqAKzXux63s4mPzNniV06HKJ65hauypb
	JX4FF8LpwYYZ88or9cndx5mImxYzWg5dQSf15/F6W2QowLJ1PDlZ8ty+7OyYxorn
	mKTHmmucBZK+9RCOX8DD4aDJUmFtHcEqJbRvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AXgcaC4RWwtZS1/m58qw1akBtqoh7Zrh
	gDD0aBJj78xsejfzL1pVTHxIb+isNCSo5qOC/aO+8lmlG2909Sv7B48HxkIKp2HJ
	ydbfNGdQXKSOxOfFN+ADJDSBSYl9OyRWG0cVJcEobOrT2vAEje3tpv3aGGgR8/gk
	2Ri5qGVwoqE=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABFB64DD2F;
	Thu, 30 Apr 2015 17:43:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 177AD4DD2E;
	Thu, 30 Apr 2015 17:43:08 -0400 (EDT)
In-Reply-To: <CAPig+cQ1JNeg5eoJib07nc6UrREE80pssokbk+xthXTXDcQz1g@mail.gmail.com>
	(Eric Sunshine's message of "Thu, 30 Apr 2015 17:33:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: E3E36D50-EF81-11E4-9E21-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268108>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Thu, Apr 30, 2015 at 10:03 AM, Quentin Neill <quentin.neill@gmail.com> wrote:
>> I'm thinking of a test file that will test all the git blame options,
>> but for this
>> patch it will only test the new showEmail config.  I read t/README and
>> tentatively named the new test file "t/8009-blame-config.sh".
>
> I'm not sure that these new proposed tests warrant a new test script.
> Moreover, the tests presumably will be testing combinations of
> configuration options and command-line switches, so having "config" in
> the script name doesn't seem quite correct.
>
> t8002-blame.sh already contains a test for --show-email, so it may be
> logical to add the new tests there, alongside the existing one. On the
> other hand, if you do add a new test script, then perhaps the existing
> --show-email test in t8002-blame.sh should be moved to the new script.

Good thinking. I would vote for the former, unless the number of
additional tests exceed 20 (as t8002 has about 100 tests).
