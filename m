From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Performance regression due to #33d4221: write_sha1_file: freshen existing objects
Date: Mon, 20 Apr 2015 13:12:54 -0700
Message-ID: <xmqqwq16k189.fsf@gitster.dls.corp.google.com>
References: <CADoxLGPYOkgzb4bkdHq5tK0aJS2M=nWGzO=YYXPDcy-gh45q-g@mail.gmail.com>
	<20150417140315.GA13506@peff.net>
	<CADoxLGOPXDgb0LBcSBm+xRDhbnGV_y-TXENyPV7oK_+KZzPKRQ@mail.gmail.com>
	<20150420195337.GA15447@peff.net>
	<xmqq1tjelg78.fsf@gitster.dls.corp.google.com>
	<20150420200956.GA16249@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Saasen <ssaasen@atlassian.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 20 22:13:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YkI3x-0005Dz-VS
	for gcvg-git-2@plane.gmane.org; Mon, 20 Apr 2015 22:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752390AbbDTUM5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2015 16:12:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:57173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751807AbbDTUM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2015 16:12:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6BF9E49CA0;
	Mon, 20 Apr 2015 16:12:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O7sWSA2sHQainXcdE2XvNzvqQoI=; b=IeAA2a
	EUxP6ye7U3RWvEUCsjcjHl9qISKzsflz47ZmFA9ASkcchu6aYXT0NQmoFKaszbq4
	02/cF7AzRRcivqzxwNZycf9y38CVAb92vC1OqFwWF22eCbgmNnZ2IP5Ng/D4mTMZ
	t/tQ+jj5b/qC33x0pnI6WSp1YH85w2AyyqlQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BHMIdROj6AUoFJOYO3HF/Dwv6hlk065e
	WJNLb2SyAy66GkyqY6mUt6vbbn71U3SpFxQBbQyFHLlltkijBsDQGm/ojzMqhdAx
	gUo1orFbiV/WH5prNmNN2NiVDH1zctfGY1jPwwhnxNZXiCvKsGUtQczNkTu0Vksv
	6oWW4UGu630=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 62F2349C9F;
	Mon, 20 Apr 2015 16:12:56 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D644649C9D;
	Mon, 20 Apr 2015 16:12:55 -0400 (EDT)
In-Reply-To: <20150420200956.GA16249@peff.net> (Jeff King's message of "Mon,
	20 Apr 2015 16:09:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A1D290C0-E799-11E4-B2E1-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267498>

Jeff King <peff@peff.net> writes:

> Either way, though, I do not think it is the upstream Git project's
> problem.

The commit to pick where to queue the fixes actually is my problem,
as I have this illusion that I'd be helping these derived works by
making it easier for them to merge, not cherry-pick.

But I would imagine that they may go the cherry-pick route anyway,
in which case I may be wasting my time worrying about them X-<.
