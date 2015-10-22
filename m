From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Consider object stores in alternates during a dissociating clone
Date: Thu, 22 Oct 2015 11:48:17 -0700
Message-ID: <xmqqzizarb7y.fsf@gitster.mtv.corp.google.com>
References: <561F8DE9.4040703@cetitec.com>
	<alpine.DEB.1.00.1510151609280.31610@s15462909.onlinehome-server.info>
	<561FBA48.3050609@cetitec.com> <56274922.80007@cetitec.com>
	<xmqqpp085cth.fsf@gitster.mtv.corp.google.com>
	<5628EBAF.1030205@cetitec.com>
	<xmqq7fmeubkf.fsf@gitster.mtv.corp.google.com>
	<562911AD.50004@cetitec.com>
	<xmqqd1w6ssg5.fsf@gitster.mtv.corp.google.com>
	<56292612.3020609@cetitec.com>
	<xmqq4mhisqgg.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>
To: Alexander Riesen <alexander.riesen@cetitec.com>
X-From: git-owner@vger.kernel.org Thu Oct 22 20:48:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZpKud-0000ua-2M
	for gcvg-git-2@plane.gmane.org; Thu, 22 Oct 2015 20:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965578AbbJVSsX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Oct 2015 14:48:23 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60469 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965394AbbJVSsU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Oct 2015 14:48:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 28D1D24755;
	Thu, 22 Oct 2015 14:48:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4LMV/66rh7nvUVVYsk2zqSw4dq4=; b=J1T8Rn
	FzgM9naMz8x25uQ+ar1dzv6PIiA7K1huLdHgx/dtntgKTxiNSqoQ65J2g6t2g6oy
	cxxqMh7qDxLGGiDY8eSbVarVWVdLx4JAhWGe+i5huLbcywdpIGPRylYkI7GuwD9/
	ib2G/ZT75bGGKfKBgdvsaUQm5/5V/1Ivxc2BA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=k03dcCZKDEVxgmGKtBO+8eL1zqZlWjrF
	opuQA2OdtlN7/sFCyKC7qHXjF6UYzJCFJtXfdllypKuCh8JmMtcURCaSzha/puXf
	Cmn8N5hWyZklkMKOLHZ8v7b8JRk7aQHRxDxCMd5nU6ttJT+kHHvDAhac+Le5gJIc
	eFyxXrgcu4U=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 20B2C24753;
	Thu, 22 Oct 2015 14:48:19 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9E03D24752;
	Thu, 22 Oct 2015 14:48:18 -0400 (EDT)
In-Reply-To: <xmqq4mhisqgg.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 22 Oct 2015 11:33:51 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 75FA5E48-78ED-11E5-AD71-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280070>

Junio C Hamano <gitster@pobox.com> writes:

> Alexander Riesen <alexander.riesen@cetitec.com> writes:
>
>> Incidentally, what does "---" mean in the documentation hunk?
>
> Heh, good eyes.  I was hoping that it would turn into an em-dash,
> but it seems I just get three dashes instead.

Outside relnotes, there seem to be a handful instances of those
that expresses em-dash with "---".

$ git grep -E '[A-Za-z]{2,}---[A-Za-z]{2,}' Documentation/
git-bisect.txt:command not found, 126 is for command found but not executable---these
git-clone.txt:	repository---the new repository will borrow objects from the
git-fetch.txt:  the refspecs---they specify which refs to fetch and which local refs
git-push.txt:be omitted---such a push will update a ref that `<src>` normally updates
technical/index-format.txt:  first subtree---let's call this A---of the root level...

I'll leave it for a separate topic to clean these up later.
