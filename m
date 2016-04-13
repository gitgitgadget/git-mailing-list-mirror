From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Ambiguous sha-1 during a rebase
Date: Wed, 13 Apr 2016 15:42:44 -0700
Message-ID: <xmqqr3e9i10b.fsf@gitster.mtv.corp.google.com>
References: <20160413222919.GA10474@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Apr 14 00:42:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqTUu-0007hv-SN
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 00:42:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754725AbcDMWmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2016 18:42:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57747 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751942AbcDMWmw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 18:42:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AC7B12AA2;
	Wed, 13 Apr 2016 18:42:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=OLgmzAYs2BGdaizMKRn5pysGjfs=; b=wFoBAg
	OmYqdNg60EaiJ79tb8r+AXWliM3J3hifQ/k3aaVq2NBIHSVPY7vL58EJRsyYa7ok
	aBcQL58DVz0qMfd5xKQi++vrq/CQ/z2H0LNIqFqfneLR0hzkbcyYJ9APOxezFAW1
	QTY+DKS5D5apeYuJoZdpDEMe2/oKu3mbEyjts=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=UiVmo0LbuekuqR+BmHIDN/9aKswsV3oS
	uusvx6cFmnfOsAx/rVYG7yDuJAEvsuJ3c1j0tQgJulG5Voj1a9wafJbEqrxjcSDZ
	gFH9rtHg6SRbJ+y5K4kz/869lKEIK3DMlDJps5UrxcLFR+wcLlz9wtTVXTJDzZ66
	haU5Rc1Wh5A=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 00D8012AA1;
	Wed, 13 Apr 2016 18:42:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 486E712A9E;
	Wed, 13 Apr 2016 18:42:45 -0400 (EDT)
In-Reply-To: <20160413222919.GA10474@glandium.org> (Mike Hommey's message of
	"Thu, 14 Apr 2016 07:29:19 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 0A3B55B2-01C9-11E6-AE9D-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291507>

Mike Hommey <mh@glandium.org> writes:

> Should git-rebase use full sha-1s under the hood to avoid these type of
> races?

It already should be doing so since Aug 2013, IIRC.
