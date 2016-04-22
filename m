From: Junio C Hamano <gitster@pobox.com>
Subject: Re: issue upgrading git from 1.8.2.1 to 2.8.0
Date: Fri, 22 Apr 2016 15:57:27 -0700
Message-ID: <xmqq37qdntew.fsf@gitster.mtv.corp.google.com>
References: <CA+UAp04e9-CcUJ+2fheHGw1q6MS6smyHhvyw34NeoT7HbKgnnQ@mail.gmail.com>
	<CAGZ79kYt_D7F3Uq_bhDpJa6Hnc1xfazhU1oree_nM0xbgROqsQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Gennaro Torre <gtorre@tumblr.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sat Apr 23 00:57:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atk10-0004jx-Vj
	for gcvg-git-2@plane.gmane.org; Sat, 23 Apr 2016 00:57:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbcDVW5b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 18:57:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64994 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751742AbcDVW5a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 18:57:30 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E76D216AEC;
	Fri, 22 Apr 2016 18:57:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=AS2UwzoUM353i7ONzQazUEGAV8M=; b=RT74H3
	Bn8aH1MrcUdDB+KGE4HRetgBHp+BRFl0PRPeulraL9kZNZhsoOhakGGbfpUB1reh
	TyDEfOQ6nv6oynccOmUx4aiLxtK9iE+aAgYczQ9bDc/+vZir5GGpXzY+4PGyTCks
	SFzX4xlDfq6+NXkmmXG8wZ/0k9wY5RVPKit5s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qBtMKX3oLIQhJ8+LUkH/iSd8XRZYKifF
	w++5MjTfR2/hqipzec2GrmZwOBGCnFiPx7rjhZslCSxlcLVKoI2wrvF97bTIw0NH
	T+zCci3A1+JWaEK9IIRARN7st2rsuAFKTcQe3X0DqDBOexDsy85NF/PhQ9krBZzM
	FKd9FvhBi9k=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DFCA016AEB;
	Fri, 22 Apr 2016 18:57:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4D8E516AEA;
	Fri, 22 Apr 2016 18:57:28 -0400 (EDT)
In-Reply-To: <CAGZ79kYt_D7F3Uq_bhDpJa6Hnc1xfazhU1oree_nM0xbgROqsQ@mail.gmail.com>
	(Stefan Beller's message of "Fri, 22 Apr 2016 15:48:49 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 9645969C-08DD-11E6-AD04-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292288>

Stefan Beller <sbeller@google.com> writes:

> Although 1.8..2.8 is a lot, Git ought to stay compatible there.

In principle that is true, but there were deliberate backward
incompatible changes at around 2.0 boundary, and those who followed
along the upgrade paths were given warnings and advice messages to
guide them to adjust their configurations during the incremental
upgrade path.  It is not all that surprising if somebody who jumped
between the two versions in one hop didn't benefit from any such
guidance, though.

Offhand, perhaps .git/config left by ancient versions and recent
versions may differ in such a way that it affects the particular
workflow deployed there?
