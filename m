From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] clone: always fetch remote HEAD
Date: Sun, 05 Jun 2011 17:47:06 -0700
Message-ID: <7vei37bxbp.fsf@alter.siamese.dyndns.org>
References: <20110603050901.GA883@sigill.intra.peff.net>
 <20110603051805.GC1008@sigill.intra.peff.net>
 <BANLkTim03_3DLdDkc3QgFrcUa0Fqhhqnbw@mail.gmail.com>
 <20110603181052.GA17538@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Dmitry Ivankov <divanorama@gmail.com>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 06 02:47:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTNyY-0002Qv-UN
	for gcvg-git-2@lo.gmane.org; Mon, 06 Jun 2011 02:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246Ab1FFArV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Jun 2011 20:47:21 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:65388 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754118Ab1FFArV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Jun 2011 20:47:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 760756790;
	Sun,  5 Jun 2011 20:49:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+PDeLa101h2kF1G2Gsg01Jq5b+c=; b=mdj9Jz
	5muxq0J3+sXKS5HHEMs20jzxLGltLkq/Aw6fO/PogaTvOdsdOAzG7n1FMxVhH4la
	GwzkkK7RZSqYI7+A+drkAN4oP7YRdzNaNcXrKu4+FXtij3OmDMbv0AprMOrjOIoR
	H3OpkZvoBKW58UOte5sclLK7nRx5F1yWbda+s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Py6dAcumtzgX0nr6UJk3p16srM4S4hV8
	Oeucd2ZvgPbLBqgFPV2+YfBguvW8gVWyCy7P32dDb7YR/L9loa60RxfkcDh+5qMd
	7ZhGekSAbkYSOSAxOTL1dVhZLKQ3ccQ59R8tDXl/VmMh5XhhYNfQglo9U5jNPjER
	TxTipvX7B+o=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1EA3D6787;
	Sun,  5 Jun 2011 20:49:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9CAEF6786; Sun,  5 Jun 2011
 20:49:18 -0400 (EDT)
In-Reply-To: <20110603181052.GA17538@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 3 Jun 2011 14:10:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D335E7B2-8FD6-11E0-A011-EA23C7C1A288-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175088>

Jeff King <peff@peff.net> writes:

> I did some more digging. I don't think the problem is with HEAD at all,
> but rather with asking for more than one ref at all.
> ...
> Does that make sense? If so, then I think the right fix is for testgit
> ti ignore all imports after the first one (since the first one will have
> done all available refs). And the patch is:

After reading Sverre's answer, I think this makes sense as a short-term
workaround.  Shall we squah it in to 3/3?
