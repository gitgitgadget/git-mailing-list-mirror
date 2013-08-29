From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Re* [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Thu, 29 Aug 2013 14:44:43 -0700
Message-ID: <xmqq4na82mus.fsf@gitster.dls.corp.google.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
	<1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
	<vpqhae97f8j.fsf@anie.imag.fr>
	<CAMP44s2bu9gUE=McYq1prhjC3O2CRj1W_Yc+-CjTkk6Gc3JFTw@mail.gmail.com>
	<vpqy57l4jcx.fsf@anie.imag.fr>
	<xmqq7gf58okw.fsf@gitster.dls.corp.google.com>
	<xmqqhae82nsb.fsf_-_@gitster.dls.corp.google.com>
	<CALWbr2xe8jC4QnLTEOWJX_kn_FcQjSafPn=NKd3UsK9fO5f=_g@mail.gmail.com>
	<xmqq8uzk2mzb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 29 23:45:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFA1T-0007PZ-O1
	for gcvg-git-2@plane.gmane.org; Thu, 29 Aug 2013 23:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755068Ab3H2Vo4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Aug 2013 17:44:56 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:51201 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752490Ab3H2Voz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Aug 2013 17:44:55 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 99CC83DB4B;
	Thu, 29 Aug 2013 21:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WeTqXw1L2GAa77Hm1ybfJbG+d/0=; b=EtZUNq
	6sqBqUCyY01L8GsH3469o+JNrjMSOlPB6yPqNgrUu5NYq4O6sU7+8jiAI2zpeJ9S
	hbUN/iTjaUQCIPabPxwHWs7Ts665aKPs3CQ90Ircoajb05GAb9kRGvSXL0LZuOUz
	O4buMxXlyShIni3RmBpp8Fa+DrkDgqxZ8XZLk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ut9sZLEzs6H82MnkXZTtOBAd8cE0F8/8
	Q9+X289v3pQcCf4vlpxRlOVyFUTUywWhC2m/DkxTERVd9zZtiXQJuvAlRLvGPguL
	yy8VWlPl2AvJGT+07ApvEc8KKJ5pc8reyZ/r1YCab1TBm0C7Be3vgbmr1fq68FOp
	n8kJXaVxuao=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80C463DB4A;
	Thu, 29 Aug 2013 21:44:54 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CC76E3DB45;
	Thu, 29 Aug 2013 21:44:52 +0000 (UTC)
In-Reply-To: <xmqq8uzk2mzb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Thu, 29 Aug 2013 14:42:00 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 3CBF4FB6-10F4-11E3-926F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233369>

Junio C Hamano <gitster@pobox.com> writes:

>> May I ask what pattern you used to replace all these or if you went
>> through manually ?
>
> "M-x query-replace" from "> " to ">" with manual inspection. I never
> use full automation myself, as I do not trust that I am careful
> enough and it is prone to unexpected changes that I can easily miss.

... I forgot to add:

    An extra pair of eyeballs to make sure I didn't make stupid
    misconversions is greatly appreciated.

Thanks.
