From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fwd: [PATCH 4/5] Replace {pre,suf}fixcmp() with {starts,ends}_with()
Date: Thu, 05 Dec 2013 10:04:51 -0800
Message-ID: <xmqqa9gfi37g.fsf@gitster.dls.corp.google.com>
References: <20131201074818.3042.57357.chriscool@tuxfamily.org>
	<20131201074919.3042.92026.chriscool@tuxfamily.org>
	<CAP8UFD0jg_Vr7Zf+DiMX9RG6vmmQvmk2NvmL7j=MC-x3fLOOBA@mail.gmail.com>
	<20131203124645.GB26667@sigill.intra.peff.net>
	<CAP8UFD0By77QVH1amsh85dX6h1S3iFZcmPzs3JjPZmiD_AmOPQ@mail.gmail.com>
	<xmqqk3fkjq5c.fsf@gitster.dls.corp.google.com>
	<xmqqfvq8jmv5.fsf@gitster.dls.corp.google.com>
	<CAP8UFD1+2-JuU0EPcfWUHpcfqrp9MODZBd4XEwVv-d6C8Nk=nA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 05 19:05:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VodIL-0006Jp-4h
	for gcvg-git-2@plane.gmane.org; Thu, 05 Dec 2013 19:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757745Ab3LESE4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Dec 2013 13:04:56 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64088 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757703Ab3LESEz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Dec 2013 13:04:55 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6B9A4572ED;
	Thu,  5 Dec 2013 13:04:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=09/kU8VSm5PWwXKL3q6I27ajMVM=; b=PQeKyE
	eDnytSj92kSRzbAYCtztYopdX7sn85nhJdRmufaR6eXHRFwEL3NykeVE50HgJ1TN
	hLPBxF4q9db3/rkxfhxX82Xjv3VqJLGyHafAUY6+eOq12rtJNLK15GARwYv2onRi
	2qvBTzDN885wvbN00KnwAi5hv/MA7ueBokGD4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h1tpKwQhuVWoSkZww4LnarSEXq6OPrb4
	Dndt8f8xYcMJDCt/hBEis9B3R0nokoJWtnYLozPr2aImAq3oSWWCBQ4oMIcKhlPB
	qAtxbRk8Pm2rR8+ufUktogRCvHz1chBPboaxuH8n7EQUw5jX/1e1YlwMDA42G4gD
	/+JjsTH3fZ4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5CE40572EA;
	Thu,  5 Dec 2013 13:04:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A1A7D572E8;
	Thu,  5 Dec 2013 13:04:54 -0500 (EST)
In-Reply-To: <CAP8UFD1+2-JuU0EPcfWUHpcfqrp9MODZBd4XEwVv-d6C8Nk=nA@mail.gmail.com>
	(Christian Couder's message of "Thu, 5 Dec 2013 08:19:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BE80DAF8-5DD7-11E3-AA3A-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238892>

Christian Couder <christian.couder@gmail.com> writes:

> Tell me if I can do something.

I think the tip of 'pu' with cc/starts-n-ends-with-endgame is in
fairly a good shape.  The evil merge there may need to be updated
over time, but I think I can manage.
