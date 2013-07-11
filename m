From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC] blame: accept multiple -L ranges
Date: Thu, 11 Jul 2013 09:44:48 -0700
Message-ID: <7vd2qprqpr.fsf@alter.siamese.dyndns.org>
References: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
	<7vk3l26695.fsf@alter.siamese.dyndns.org>
	<CAPig+cQ9sfV+PRqn5vrL0=xOZrKDDmsKdAPiB4PsCFb=jnk4kQ@mail.gmail.com>
	<7v38rnwuvb.fsf@alter.siamese.dyndns.org>
	<87ehb7d3za.fsf@hexa.v.cablecom.net>
	<CAPig+cT9U7L-03Fe5YLft=WS2EZY1B_BhLzkM_sT_3wQQ1g1MQ@mail.gmail.com>
	<7vy59fv9zr.fsf@alter.siamese.dyndns.org>
	<87a9lvcztv.fsf@hexa.v.cablecom.net>
	<7vppurv8bl.fsf@alter.siamese.dyndns.org>
	<87mwpuepst.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Thu Jul 11 18:44:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxJzE-0003cR-0I
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 18:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437Ab3GKQow (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 12:44:52 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38374 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752131Ab3GKQov (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 12:44:51 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 714E72FF12;
	Thu, 11 Jul 2013 16:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fxgkpd/PiUmyzNDVgi56ewm67Ng=; b=iS7+KV
	D5xGOp2cIkqr1/fmReHaJGDM4+b/DbaFDXgCeqVx9/2eh8GKypxDUHOsJmPArtQh
	chf4qCjm0OKQRacG0skJj51sBZK3VVyjwszeHvxvq46PMvovs/qUqfATisQeqtQb
	UFR0zg00GmI4csz7s9BDDtbRvdj+FlPTFU8dE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HKVa8/JpRJC41ja35KwrqtwWSMw1sAde
	wyNsBp0ECviedJwb5beM4qmUTEeAQfR1vdUbTiwGNd4LhrEWbh38OFYlyr1ekYaD
	y/+0sjzvH0hYC/Y/ofLMeMceKPGeg47yzyIOXENDomH9X4nR1/qTj1Rgi6FEg2+7
	ERJNW1YKzNc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65C542FF11;
	Thu, 11 Jul 2013 16:44:50 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B03EF2FF0E;
	Thu, 11 Jul 2013 16:44:49 +0000 (UTC)
In-Reply-To: <87mwpuepst.fsf@linux-k42r.v.cablecom.net> (Thomas Rast's message
	of "Wed, 10 Jul 2013 11:18:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 33CFE266-EA49-11E2-9411-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230115>

Thomas Rast <trast@inf.ethz.ch> writes:

> But still, log -L should then be changed to match this behavior (for all
> args affecting a single file).  Currently it always does the scan for
> the start of the range from line 1 of the file.

Thanks, I think that makes sense.
