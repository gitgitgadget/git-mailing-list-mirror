From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] branch -d: test if we can delete broken refs
Date: Wed, 26 Nov 2014 10:43:24 -0800
Message-ID: <xmqqbnntreer.fsf@gitster.dls.corp.google.com>
References: <CAGZ79kao0CpeidBzVL4O-4jfNd7nGbOJwtvsJCEgOjb370z8uw@mail.gmail.com>
	<1416963565-32318-1-git-send-email-sbeller@google.com>
	<547593FF.6040507@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>, jrnieder@gmail.com,
	ronniesahlberg@gmail.com, git@vger.kernel.org,
	Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Nov 26 19:43:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XthYp-0003Sh-BY
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 19:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbaKZSn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Nov 2014 13:43:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752077AbaKZSn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Nov 2014 13:43:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 67F862121A;
	Wed, 26 Nov 2014 13:43:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RAtCmPus5FydKqi4tF0eRorh8hM=; b=mh8EHI
	DwnOOREm2LWE1dEUIbA1r1prKABh20g7r24Ha9yypn0HHwdII1d+NygcCjmiQxib
	SyzCQ4y4Mukvqt9kMWNIYDlN74eIuaUCvAG22WkDatEgoPD+9m/zJbsOJVqfEo87
	s0LITOEJms2wX8OIFtzuNyx1dqUoSrdV5/l8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DK0eqKosagASLCFDI1IpLJDARhNf9Gm+
	OPWhiEmnxlpY9JMfFMskviRJ//qMSo717Mh559Q8n547zWVsMiGmHnWcGwrjMNIy
	os80p3tUP7bo4WOR71KXWMY2t9JxmjT4XrzNcheIZ9+1uSGYpL2Zsa9Zefv5Mnhc
	1BiJX4fzK4Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5BDC721219;
	Wed, 26 Nov 2014 13:43:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C6ABF21218;
	Wed, 26 Nov 2014 13:43:25 -0500 (EST)
In-Reply-To: <547593FF.6040507@alum.mit.edu> (Michael Haggerty's message of
	"Wed, 26 Nov 2014 09:49:03 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1B297292-759C-11E4-8DBE-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260291>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> ... On the other hand, this is kind of an "aspirational test"; I don't
> know that the tested functionality has ever worked or that anybody has
> ever claimed that it works. So my feeling is that the addition of the
> test would feel more natural in the patch series that implements the new
> feature. But I don't feel strongly about it.

I share your feeling.  

In the "aspiration followed by realization" pattern, the realization
commit shows a change in t/ hierarchy that turns test_expect_failure
into test_expect_success and it is likely that what is being tested
will fall outside the context.  Unless the test title is phrased
very well, it would not be obvious from the patch text to the t/
hierarchy alone what behaviour is being corrected when looking at
the realization commit.

If aspiration and realization are in a same series, that would not
be a problem, but it is if the commits that add "aspirational test"
and "realization" are too far apart.

If it is pretty clear to everybody that another topic to realize the
aspiration will be coming in a not so distant future, I think it is
fine, though.
