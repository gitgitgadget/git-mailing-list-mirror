From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] daemon: give friendlier error messages to clients
Date: Fri, 14 Oct 2011 22:55:13 -0700
Message-ID: <7vk486x0hq.fsf@alter.siamese.dyndns.org>
References: <7vsjn9etm3.fsf@alter.siamese.dyndns.org>
 <1317678909-19383-1-git-send-email-pclouds@gmail.com>
 <20111012200916.GA1502@sigill.intra.peff.net>
 <20111013044544.GA27890@duynguyen-vnpc.dek-tpc.internal>
 <20111013182816.GA17573@sigill.intra.peff.net>
 <7vvcrs181e.fsf@alter.siamese.dyndns.org>
 <20111014131041.GC7808@sigill.intra.peff.net>
 <20111014192326.GA7713@sigill.intra.peff.net>
 <20111014210251.GD16371@elie.hsd1.il.comcast.net>
 <20111014211244.GA16429@sigill.intra.peff.net>
 <20111014211921.GB16429@sigill.intra.peff.net>
 <CAMK1S_g0aKUa=+ndAm7rqeoPAobjVb6oJ1Z4DqSeNrdauXNH3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Oct 15 07:55:25 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RExDQ-0001wS-7Q
	for gcvg-git-2@lo.gmane.org; Sat, 15 Oct 2011 07:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053Ab1JOFzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Oct 2011 01:55:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39142 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750818Ab1JOFzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Oct 2011 01:55:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A2DD436B2;
	Sat, 15 Oct 2011 01:55:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JTSsYPnglrkZN1UTAR3l5irHlIg=; b=My5FVs
	kdcaV2/cfQyOkqTJns+yETP/zqlETT3b33AkC/ikhFMrLFHRSNG+AbZ6U550v5m4
	2DOoPtZN2csUjiVPhjELOV51g5DjLPXyrcGPV0oas6/ib3cogJwbimgzVbGMqIPt
	nQMssBIK7rM9JyqBb5YGxS1VqIzLC2pwUvcYU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WDJulLcwM56HAE459SP1Dtd0PMaQJJfL
	4gT/MpljZd1bBHSHzOICUuyy1YR4VzMCkyXbi6Cd73HAMzZ5a5KKvSLvwswzhJUI
	SgcuH9G5cmpiyHmgWSQ4yv3G1OzsDUvezI+GmBiGyfI9SanB7L/cPbybBm0LfV6o
	NHNLZlx2MeU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96FEE36B1;
	Sat, 15 Oct 2011 01:55:15 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2B8E136AF; Sat, 15 Oct 2011
 01:55:15 -0400 (EDT)
In-Reply-To: <CAMK1S_g0aKUa=+ndAm7rqeoPAobjVb6oJ1Z4DqSeNrdauXNH3w@mail.gmail.com> (Sitaram
 Chamarty's message of "Sat, 15 Oct 2011 05:09:33 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 40DE007E-F6F2-11E0-AAEB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183644>

Sitaram Chamarty <sitaramc@gmail.com> writes:

>> Because there is a risk of leaking information about
>> non-exported repositories, by default all errors simply say
>> "access denied". Sites which don't have hidden repositories,
>
> I suggest that even the "secure" version of the message say something
> like "access denied or repository not exported".  You're still not
> leaking anything, but it reduces confusion to the user, who otherwise
> may not realise it *could be* the latter.

I kind of like the suggestion, but I am afraid that "access denied,
repository nonexistent or not exported" can soon easily get long enough to
be unmanageable.
