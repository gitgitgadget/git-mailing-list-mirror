From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 0 bot for Git
Date: Wed, 13 Apr 2016 09:27:18 -0700
Message-ID: <xmqqa8kxlbix.fsf@gitster.mtv.corp.google.com>
References: <CAGZ79kYWGFN1W0_y72-V6M3n4WLgtLPzs22bWgs1ObCCDt5BfQ@mail.gmail.com>
	<CAGZ79kZOx8ehAB-=Frjgde2CDo_vwoVzQNizJinf4LLXek5PSQ@mail.gmail.com>
	<vpq60vnl28b.fsf@anie.imag.fr>
	<CAGZ79kaLQWVdehMu4nas6UBpCxnAB_-p=xPGH=aueMZXkGK_2Q@mail.gmail.com>
	<vpqoa9ea7vx.fsf@anie.imag.fr>
	<xmqqmvoypn7g.fsf@gitster.mtv.corp.google.com>
	<88CF8CB5-4105-4D0C-8064-D66092169111@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Stefan Beller <sbeller@google.com>, lkp@intel.com,
	Greg KH <gregkh@linuxfoundation.org>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 18:27:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqNdW-0001KR-FM
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 18:27:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754532AbcDMQ1W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 12:27:22 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:55121 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751061AbcDMQ1V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 12:27:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7559D52A2F;
	Wed, 13 Apr 2016 12:27:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UooB6ZAvQ0uTjkqZit9tGg8JDPc=; b=mg3rav
	Pc/KRJWkotyr7zqZE3yJfnZZzhegJNlSFiTmiWj0N8cPuh+I542TewrBBTLibC7F
	6FtuwrKRgdVPUHmFEiPnhkbRAlRHJLSx6atRo7J6/RzRTb10L7PjsiOFHzjP+5kv
	n/wObNuQiC2wa96H77WGwZElll1NP7XpldGAk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fJiXCTlxNKEQuh3uu7F5H1KkM1TWzcFd
	bfCUDSncLFU1vs9S3Fd6ve7sBIH94lVK/8zZC8PZOrBxJvRE48GLDcuwPzT28lbU
	tFp2XSfjq2IlUX5nfu8/A9Vys7aUzHAHg8puGF/Jzjb85aHV4pcjKr/HswOROvdP
	KWvVEwztRKw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6C69752A2E;
	Wed, 13 Apr 2016 12:27:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id BE1D052A2C;
	Wed, 13 Apr 2016 12:27:19 -0400 (EDT)
In-Reply-To: <88CF8CB5-4105-4D0C-8064-D66092169111@gmail.com> (Lars
	Schneider's message of "Wed, 13 Apr 2016 08:11:54 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9804F450-0194-11E6-A959-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291458>

Lars Schneider <larsxschneider@gmail.com> writes:

> @Junio:
> If you setup Travis CI for your https://github.com/gitster/git fork
> then Travis CI would build all your topic branches and you (and 
> everyone who is interested) could check 
> https://travis-ci.org/gitster/git/branches to see which branches 
> will break pu if you integrate them.

I would not say such an arrangement is worthless, but it targets a
wrong point in the patch flow.

The patches that result in the most wastage of my time (i.e. a
shared bottleneck resource the community should strive to optimize
for) are the ones that fail to hit 'pu'.  Ones that do not even
build in isolation, ones that may build but fail even the new tests
they bring in, ones that break existing tests, and ones that are OK
in isolation but do not play well with topics already in flight.

Automated testing of what is already on 'pu' does not help reduce
the above cost, as the culling must be done by me _without_ help
from automated test you propose to run on topics in 'pu'.  Ever
heard of chicken and egg?

Your "You can setup your own CI" update to SubmittingPatches may
encourage people to test before sending.  The "Travis CI sends
failure notice as a response to a crappy patch" discussed by
Matthieu in the other subthread will be of great help.

Thanks.
