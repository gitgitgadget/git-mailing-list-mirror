From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 00/14] ref-transactions-reflog
Date: Thu, 20 Nov 2014 09:34:01 -0800
Message-ID: <xmqqa93l4vzq.fsf@gitster.dls.corp.google.com>
References: <1416274550-2827-1-git-send-email-sbeller@google.com>
	<546B2CE0.6020208@alum.mit.edu>
	<CAL=YDWn1x9TMGOWrmT5KMpQ_iBR0AQ5Ej1yr1pBb4==k0-vchw@mail.gmail.com>
	<546BA21C.9030803@alum.mit.edu>
	<xmqqr3x0uu81.fsf@gitster.dls.corp.google.com>
	<546BB722.5020901@alum.mit.edu>
	<xmqqsihgtcyx.fsf@gitster.dls.corp.google.com>
	<CAGZ79kb3DOrL_txW-qxzd0=4sKrOiPTdSg-17_0+__wuj0TBaQ@mail.gmail.com>
	<20141120032453.GH6527@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Ronnie Sahlberg <sahlberg@google.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 20 18:34:13 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XrVcS-0002ka-Tg
	for gcvg-git-2@plane.gmane.org; Thu, 20 Nov 2014 18:34:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756291AbaKTReH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2014 12:34:07 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51608 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751406AbaKTReF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2014 12:34:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AC14D1E5FC;
	Thu, 20 Nov 2014 12:34:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZblTfNsrxbxt1acPa8oPtWhHYNI=; b=gv+Dtk
	o3E+0k+jV9aDZlHpreX7IuWuG7tsNDTfdk5Q5lTwimKstomJijIP/H54/OszQ0Rs
	HooKHWI+vqSE0oity11A8yZ/XNS/z6xVJrRpRJaB7HvIMPyrOa4bDkwGNuozRl/8
	dcZJ5Ja32FQXwy5agFABuMG3xEm0f3ZBjH7rE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BIu8gf551oocD3FyTUcMTJvFMaK1fXKF
	m2HlCAc5XB8XmB57Izm9zDgBYQp4+JV6oN4bpYqDMUWYiyNUgm9Cm8o0HO2pfmN9
	HO2Zl4y/UMC8GfyPXUfnuhZvB8vosPyjRNZqdbCuipZPqpso09joUqR1G4FFlECq
	uBSuy/BzjVI=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A2D9E1E5FB;
	Thu, 20 Nov 2014 12:34:04 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3172B1E5F9;
	Thu, 20 Nov 2014 12:34:04 -0500 (EST)
In-Reply-To: <20141120032453.GH6527@google.com> (Jonathan Nieder's message of
	"Wed, 19 Nov 2014 19:24:53 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6C1FEC14-70DB-11E4-89C9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I also have some thoughts about how those operations can be
> implemented without such a performance hit (reading the whole
> reflog into memory as part of the transaction seems problematic to
> me), but that should probably wait for a separate message (and
> I've talked about it a bit in person).

Perhaps iterator interface such as for_each_reflog_ent() would help?
