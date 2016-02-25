From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 1/2] t/lib-http/apache.conf: load mod_unixd module in apache 2.4
Date: Thu, 25 Feb 2016 15:18:52 -0800
Message-ID: <xmqq37sgml9f.fsf@gitster.mtv.corp.google.com>
References: <1456426632-23257-1-git-send-email-jacob.e.keller@intel.com>
	<20160225220045.GA10267@sigill.intra.peff.net>
	<xmqqbn74mlco.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, Mark Strapetz <marc.strapetz@syntevo.com>,
	Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 26 00:18:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZ5BT-0005xX-Cq
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 00:18:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752242AbcBYXS4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 18:18:56 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57112 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751701AbcBYXSz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 18:18:55 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6F9E347599;
	Thu, 25 Feb 2016 18:18:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TjfmOByqGGusF75EKnaaX2KkrJA=; b=C6gGrM
	ED9hOrRe5In96AhN78VXeAoV1i+PAkYBDifkh1WtugJIN+CveSbeH0GyqUPG4fP4
	m9Spcm3xcsMs6oC5bWpSuHIO/SkByheLS2q3TF7DTowhnnHGChAlGMnRo304MQhb
	L35TJTte+7vfo3hVno/1i4oThuaTyR48SMdy4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eBdTMyRxth7kQR+ZNGjiv17nP8xHAJ98
	VArnt7Cvt3muNmoMSHuma5Qm7ZjPAdkeepGcHyk9Km3iTGzJeS9ksG/rftOUw6J0
	nNcS8Hv1AT62dvveHlSGsEuV7rhWOQbuK4WUaJxsJ/XgRRD/sznyEtolrFHc6vN1
	Rvh7Mx3uer8=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 63FBF47598;
	Thu, 25 Feb 2016 18:18:54 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id CCC0547595;
	Thu, 25 Feb 2016 18:18:53 -0500 (EST)
In-Reply-To: <xmqqbn74mlco.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 25 Feb 2016 15:16:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 22FFE258-DC16-11E5-A956-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287488>

Junio C Hamano <gitster@pobox.com> writes:

>> Michael (cc'd) posted an identical patch with some more discussion back
>> in May:
>>
>>   http://article.gmane.org/gmane.comp.version-control.git/268770
>>
>> The series languished because none of the reviewers had systems that
>> reproduced the problem, and I think there's some additional work needed
>> to get all of the svn-over-http tests running[1].
>>
>> I think this bit should be OK to take without the rest (though I like
>> the extra discussion in the original).
>
> I can resurrect 745a5487 (t/lib-httpd: load mod_unixd, 2015-04-08),
> which is still on 'pu', and apply 2/2 from Jacov on top of it.

Ahh, the one you quoted does have a better log message.  Let's
replace the ancieint one I have and use Jacob's 2/2 on top of it.
