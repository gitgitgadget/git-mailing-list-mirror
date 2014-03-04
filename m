From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] test-lib: GIT_TEST_ONLY to run only specific tests
Date: Tue, 04 Mar 2014 11:01:51 -0800
Message-ID: <xmqq1tyhlrds.fsf@gitster.dls.corp.google.com>
References: <1393842298-5944-1-git-send-email-ilya.bobyr@gmail.com>
	<1393842298-5944-2-git-send-email-ilya.bobyr@gmail.com>
	<CAPig+cT46ekT87TuoTtwvt0G+DraB9cdgW1wd6NsodjJ5FmJrA@mail.gmail.com>
	<xmqqob1mn9t6.fsf@gitster.dls.corp.google.com>
	<531514D9.4000101@gmail.com>
	<xmqq4n3en7un.fsf@gitster.dls.corp.google.com>
	<53157B72.3000205@gmail.com>
	<xmqqvbvul62n.fsf@gitster.dls.corp.google.com>
	<53159A55.70105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ilya Bobyr <ilya.bobyr@gmail.com>,
	Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Thomas Rast <tr@thomasrast.ch>
To: Ilya Bobyr <ilya.bobir@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 20:02:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKubX-0003J4-R8
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 20:02:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755397AbaCDTCF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 14:02:05 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39283 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752144AbaCDTCA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Mar 2014 14:02:00 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 810AB71348;
	Tue,  4 Mar 2014 14:01:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6URvfkFi2g0Vn5+K13XOsim5Zh0=; b=C71kQ0
	UMo7uShV2x493yiKQ55r/yTF1TDZkZOnAIUQbTbp9u9uIElw/6CNtp84aSKILanH
	ZHX2bbjROKh7N1VuX6CHkTJv6yVdqseJiRmGpVqrphwr/B70thXkxb1z/ETdQbE3
	zBMcaQvCV4b5CR5rbxCtF9jpr7GBtMqOo/q20=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jyj2FxKLOnTUzyqD69+e7d7UMzL9lV5J
	15/EETIhByXuftHNdmMlYuRwfihRZIUGRfC72nmaStDl7p05NL1+IrU2RW0kd3NA
	Jc3+h+3I6Y4VO/R81wRnHY5ZhGL7R6DxIkMltKo5DhkVbIvqmjdXkwEgOTcDeZBy
	tayeSB856Co=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A7B2271342;
	Tue,  4 Mar 2014 14:01:57 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A19B471337;
	Tue,  4 Mar 2014 14:01:54 -0500 (EST)
In-Reply-To: <53159A55.70105@gmail.com> (Ilya Bobyr's message of "Tue, 04 Mar
	2014 01:18:13 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 73BF4C00-A3CF-11E3-BDA2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243370>

Ilya Bobyr <ilya.bobir@gmail.com> writes:

> On 3/4/2014 12:29 AM, Junio C Hamano wrote:
> ...
>> then you
>> shouldn't be mucking with environment variables in the first place,
>> primarily because running:
>>
>>      $ GIT_TEST_ONLY='1 4' make test
>>
>> to run test .1 and .4 of all the test scripts would not make any
>> sense.
>
> No it does not.  It only makes sense for one test suite.
>
>> I think your "simplicity" argument is a total red-herring.
>> Of course if you do not have to say the test script name, your
>> specification would be shorter, but that is only because your
>> specification is not specific enough to be useful.
>
> In my case it is very useful :)

It invites a nonsense usage (i.e. running "make test" under that
environment variable setting); that is not a good trade-off.

>>   * Even though GIT_SKIP_TESTS mechanism still allows you to skip
>>     individual test pieces, it has never been a serious "feature" in
>>     the first place. Many of the tests unfortunately do rely on state
>>     previous sequences of tests left behind, so it is not realistic
>>     to expect that you can skip test pieces randomly and exercise
>>     later test pieces reliably.
>>
>>   * The numbering of individual test pieces can easily change by new
>>     tests inserted in the middle; again, many tests do take advantge
>>     of the states earlier tests leave behind, so "do not add new
>>     tests in the middle" is not a realistic rule to enforce, unless
>>     you are willing to clean up existing test scripts so that each
>>     test piece is independent from all the previous ones.
>
> Both are true, but do not apply to the TDD case.

The existing tests are designed to be black-box tests, not function
level unit tests, and touching lower level code carelessly affects
other parts of the system you did not know the interactions about.

What does "TDD case" change anything in that equation?
