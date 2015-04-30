From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] blame: add blame.showemail config option
Date: Thu, 30 Apr 2015 09:10:40 -0700
Message-ID: <xmqq1tj138cf.fsf@gitster.dls.corp.google.com>
References: <1429841612-5131-1-git-send-email-qneill@quicinc.com>
	<CAPig+cQrUPHOaKjNhsmLho+bFdAOQxb0NK2YK2QsFmdDBF6h4g@mail.gmail.com>
	<CACfD1vvaAGkx2P3yMfZPOZrRvG3-H96zQVOCevnd-O0rBJ7wjw@mail.gmail.com>
	<xmqqwq0xwige.fsf@gitster.dls.corp.google.com>
	<CAPig+cRTfB9aiinhSJp=jY7-__6dRvfAqhWZYVN3+Ut=Y79LcQ@mail.gmail.com>
	<xmqqmw1svigd.fsf@gitster.dls.corp.google.com>
	<CACfD1vtfO_rqr4wv4oHm7W7DSn-Gk-du6nCuJzYvpPXK_d=y=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git List <git@vger.kernel.org>
To: Quentin Neill <quentin.neill@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 18:10:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ynr35-0007DA-Qv
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 18:10:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751031AbbD3QKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 12:10:47 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51444 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750804AbbD3QKn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 12:10:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 20BDC4D255;
	Thu, 30 Apr 2015 12:10:42 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XbrZdicaXMVlcA6CySmI5DO2KCE=; b=Du4IMw
	Tqy77YMV7OaQOZqCbU62qzxJIAJ/NgojEcOMqLEK5HKllQh1NZEWqIrufBO1dbsv
	FB75CB6fTRckLfxmeNbnMoKGgsX02Pw6sXCljJrJLO8dLkBQWESItAVVWWaeEr87
	AowhGusAkIHTDT8furMQJ29tKZY3yXlcPY6S8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Fy8lqc/M4ejdsgEkDUXMIVtirDvvX/7J
	OZhieHbYVwro2ehT5wJEmchr+LVBMB12ASA4L/HmOXmEbNNJpdhJbzLftZvkpWmm
	yRWnK3GQk9OpBB7n8p+QMYwHdL66ezlmqF4BRY8fJQ4ZvjeyCGaSgG7RRr4j5Qv4
	u8umFz9FlyI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 191E84D254;
	Thu, 30 Apr 2015 12:10:42 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8EC284D253;
	Thu, 30 Apr 2015 12:10:41 -0400 (EDT)
In-Reply-To: <CACfD1vtfO_rqr4wv4oHm7W7DSn-Gk-du6nCuJzYvpPXK_d=y=g@mail.gmail.com>
	(Quentin Neill's message of "Thu, 30 Apr 2015 09:03:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 72D70514-EF53-11E4-ABD3-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268077>

Quentin Neill <quentin.neill@gmail.com> writes:

> On Fri, Apr 24, 2015 at 12:22 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> Despite being case-insensitive and despite existing inconsistencies,
>> in documentation, it is customary to use camelCase for configuration
>> options, so "blame.showEmail".
>
> I noticed while testing that git_config()/git_value() lowercase
> everything, so to be clear this camelCase custom for configuration
> names is for documentation only, right?

Correct.  Write "section.variableName" in documentation and
invocations of "git config" command in scripts.  Compare key
with "section.variablename" in git_config() callback.

> I'm thinking of a test file that will test all the git blame options,
> but for this
> patch it will only test the new showEmail config.  I read t/README and
> tentatively named the new test file "t/8009-blame-config.sh".

I'd suggest

 [PATCH 1/2] blame: add blame.showEmail configuration

which would be the polished version of the patch we have been
discussing, plus tests for this particular feature, and

 [PATCH 2/2] blame: more tests

which would widen test coverage to other configuration variables and
features.
