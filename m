From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2] grep: use slash for path delimiter, not colon
Date: Mon, 26 Aug 2013 20:37:37 -0700
Message-ID: <xmqq7gf7iz26.fsf@gitster.dls.corp.google.com>
References: <1377528372-31206-1-git-send-email-hordp@cisco.com>
	<20130826192826.GA23598@sigill.intra.peff.net>
	<20130826195331.GA21051@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Phil Hord <hordp@cisco.com>, git@vger.kernel.org,
	phil.hord@gmail.com, Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 05:37:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEA6D-0000MT-0y
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 05:37:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752778Ab3H0Dhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Aug 2013 23:37:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63128 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752090Ab3H0Dhk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Aug 2013 23:37:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A062336A7E;
	Tue, 27 Aug 2013 03:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KJG4/UwxlLLUHf6i/ATO+YNR9fs=; b=mybTUR
	jRCSVy0m1zhO6khVIS8l5Ksg+z9Ia/5IuJ3mgQMvDIQQTSo47k9OmLjh130QOvnB
	D/9JFkrtkeUpfIMCh0oWaiH7uytlDGLtiQALje4NlJwO47Im4KO4xsq12O5+diXg
	pT1FboMf3gy5unmRacnkj03VcBaYCSm12QMrk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Kod8U0KSeoxnmfsIe8qvBFcehNI21msT
	zjIXQQuh/xInNHliatKhJryExcvgyvvMErKxvGdzkHzupP0O+et9Tok5sOHyrNne
	B5DDmfLmpeCLuFXA0CcjhDCwgMEggJDkegiflyPAnnslxUMxUS8ZOcoR4TbPGDBn
	Mva/E/yh7Nc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 96FF236A7D;
	Tue, 27 Aug 2013 03:37:39 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E934F36A74;
	Tue, 27 Aug 2013 03:37:38 +0000 (UTC)
In-Reply-To: <20130826195331.GA21051@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 26 Aug 2013 15:53:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 057F392A-0ECA-11E3-9BF1-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233042>

Jeff King <peff@peff.net> writes:

> On Mon, Aug 26, 2013 at 03:28:26PM -0400, Jeff King wrote:
>
>> Changing the object_array API would be hard, but I don't think we need
>> to do it here. Can we simply stop using object_array to pass the list,
>> and instead just have a custom list?
>> 
>> I'll see how painful that is.
>
> Not very, I think. Here's the series.
>
>   [1/2]: grep: stop using object_array
>   [2/2]: grep: use slash for path delimiter, not colon

I agree that if we were to do this, these patches show a reasonable
approach to do so.

I however am not yet convinced if its output is necessarily better
X-<.
