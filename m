From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] t/t3308-notes-merge.sh: succeed with relaxed notes refs
Date: Tue, 06 Jan 2015 15:54:44 -0800
Message-ID: <xmqqoaqbmpmj.fsf@gitster.dls.corp.google.com>
References: <d4509363c8f670483dacdd2a5070f5a@74d39fa044aa309eaea14b9f57fe79c>
	<e514c72c481c66f9808f1dd09117a16@74d39fa044aa309eaea14b9f57fe79c>
	<xmqq8uhgqkge.fsf@gitster.dls.corp.google.com>
	<F6072C48-FA50-4F9D-AD26-0B4C4DD64B91@gmail.com>
	<xmqqtx03pxzf.fsf@gitster.dls.corp.google.com>
	<A5A16FEC-D72C-4B21-8BE1-3A41696DFF49@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git mailing list <git@vger.kernel.org>,
	Scott Chacon <schacon@gmail.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 07 00:55:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8dxc-0003bp-Ah
	for gcvg-git-2@plane.gmane.org; Wed, 07 Jan 2015 00:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbbAFXyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 18:54:47 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:64829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751667AbbAFXyq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 18:54:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 572A62DDCB;
	Tue,  6 Jan 2015 18:54:46 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=P+ugZShjPdqdFfnLba0uwUFKk7A=; b=psiUyV
	4QyuCTrWZ42v5t3cdxJNdAP0YzyOHIt4IFyHLwy3qzp/6q9Eugz+UY/uOSvINhjO
	XF3raRL0aznF2uZTQ1J/THWa55G2RiN75nzU82Owf7KTVoUL82/bJiK8CiKzkEt2
	jK9Tz+lqxvDfrmfRR8oqtPFvIZBCFS/mUk+F0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mwHPsQPE1wdNc51JgzqEAsFJgt7YaRZu
	Z2MT7wJT824itgO0goeymf1klgvyWf08ILgvUAHe6w5oqt7cMOEeXFXbtAHhhOjg
	MV3flq58VcKWFgLdLkbBrsUmlaIc1t74tVpoDOkuexaFlwin6d3s9TweMmhwtFtL
	4VnV7g4yqG0=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4CEC22DDCA;
	Tue,  6 Jan 2015 18:54:46 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AD1BD2DDC7;
	Tue,  6 Jan 2015 18:54:45 -0500 (EST)
In-Reply-To: <A5A16FEC-D72C-4B21-8BE1-3A41696DFF49@gmail.com> (Kyle J. McKay's
	message of "Tue, 6 Jan 2015 15:29:08 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 642DF02A-95FF-11E4-BA42-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262114>

"Kyle J. McKay" <mackyle@gmail.com> writes:

> A whitelist solves issue (1) but is no help for issue (2) unless some
> additional additional part of the refs namespace were to be also
> whitelisted.  Perhaps something like refs/x-<anything>/... in the same
> vein as the various IETF standards for experimental names.

Your (2) is about people who are _experimenting_, no?

Why can't they use refs/notes/x-<anything>/* while doing so, and
when that matures and proves useful to wider public we can make it
more official by whitelisting refs/<that-thing> in addition to
refs/notes/, and the problem is solved, no?
