From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Tabs in commit messages - de-tabify option in strbuf_stripspace()?
Date: Tue, 15 Mar 2016 17:45:21 -0700
Message-ID: <xmqq4mc76yji.fsf@gitster.mtv.corp.google.com>
References: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Mar 16 01:45:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afzab-0006xF-Vd
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 01:45:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934041AbcCPAp0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 20:45:26 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:62096 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932337AbcCPApY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 20:45:24 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 589634D4CD;
	Tue, 15 Mar 2016 20:45:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=d8RiU69gAuUxJ9E0hJP5xW6fK2A=; b=YXtWnh
	PwUCGSsEbwfA37XCgtLmemigJpG0/0+1kVsfY39M8OdIJbL/KchYdhEVGVSW12c+
	oBO9e3pGau7p0O0sEmKagKNX1Z3+mVUWCtXAOm3xDHhDtRHZHo7VzKYKxEnoMR+z
	E9X48Yp9pMfiwgohlFReO5jtaHaad7VChhzzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BejT8h11bhqXlXf1IiAR+pmsEWjAFi9e
	41F/U9ZEOrAAb+x9Ski9NbkoPA5QW3smIxsUIFr9cXxHYYnA1A5bZJqXJsNKmuS6
	SAjoh1zSuGvnn2aGtZF+EReuY9f6w16GYmsNS+HxsEMmnzhMQVphUjtF5DGjEJ4I
	PT/mdNUvDZI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4E6D14D4CC;
	Tue, 15 Mar 2016 20:45:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C32A44D4CB;
	Tue, 15 Mar 2016 20:45:22 -0400 (EDT)
In-Reply-To: <CA+55aFzHMp4hiCp7+2Yxy=KNQ_rBru3RM-pghXUPtoxr_L+w2w@mail.gmail.com>
	(Linus Torvalds's message of "Tue, 15 Mar 2016 17:16:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5DAAAE98-EB10-11E5-AA83-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288932>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Do people hate that idea? I may not get around to it for a while (it's
> the kernel merge window right now), but I can write the patch
> eventually - I just wanted to do an RFC first.

Wouldn't it be nicer to do this kind of thing at the output side?  A
stupid way would be to have an option to indent the log text with a
tab instead of 4-spaces, but a more sensible way would be to keep
the visual 4-space-indent and do the expand-tab for each line of
text.

That way, your viewing of existing commits that use 8-space HT to
align (and worse yet, mixture of 8-space HT and 8 spaces and assume
the end result would align in the output) would become more pleasant
without you having to run filter-branch ;-)
