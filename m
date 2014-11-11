From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [Opinions] Integrated tickets
Date: Tue, 11 Nov 2014 10:24:23 -0800
Message-ID: <xmqqzjbx61ew.fsf@gitster.dls.corp.google.com>
References: <20141105124429.GF15384@paksenarrion.iveqy.com>
	<xmqqvbmsgocj.fsf@gitster.dls.corp.google.com>
	<54620522.4060600@ira.uka.de>
	<xmqqioil7j20.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Holger Hellmuth <hellmuth@ira.uka.de>
X-From: git-owner@vger.kernel.org Tue Nov 11 19:24:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XoG7G-000084-8r
	for gcvg-git-2@plane.gmane.org; Tue, 11 Nov 2014 19:24:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbaKKSY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Nov 2014 13:24:27 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52925 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751673AbaKKSY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Nov 2014 13:24:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B53241B7D0;
	Tue, 11 Nov 2014 13:24:25 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BQ740tuK4I4FOz8l7rrzvO7p+CQ=; b=O7Jt4O
	BojgYZQYs4Pi55m3Ucx9Hjz3GaVsLh3i2w/5SdIpzCM0UiYBbxanQJe812k4WgFA
	JG8tTIYOlM+cEMwWMpSUBogdFcqcclL/BH6uSIH1VQdBENaYjlJnxYFyCRCpcg4t
	kueQK4eFFw5psXr3s++ApQHjGoSiEznG8NInU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=LzD8B2WK1WbjqUtGbxYjvXN/IKpepn57
	CTmMLPVjg9SwjQoMpFUe5vLz+gxIKJ44tgy7r/71oVuQZjY6MviUpYYJK3gxSmyR
	rQofEP0Q8TQxH/1kh4RjW8HCk0EBtyVKz8JGMoaH8POczyCPba1pXpKsoxSiv7RT
	y8QP/Qh7yNM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABF2B1B7CF;
	Tue, 11 Nov 2014 13:24:25 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 34F4C1B7CE;
	Tue, 11 Nov 2014 13:24:25 -0500 (EST)
In-Reply-To: <xmqqioil7j20.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 11 Nov 2014 09:17:59 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F7121E9A-69CF-11E4-B73D-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Either way, I do not see how such an arrangement is the most
> convenient way to organize the tickets and ask questions such as
> "what are the known, untriaged, or unresolved issues in v1.8.5?",
> "what are the issues that didn't exist in v1.7.0 but appear in
> v1.8.5?", "what are the outstanding issues around refs handling that
> are the highest priority?", etc.  With your arrangement of data, any
> of the common questions I think of asking would require a linear
> scan of a commit range, followed by an enumeration and parsing of
> all the notes attached to the commits to answer.
>
> So I would have to say that your expectation makes even less sense
> than annotating an exact buggy commit with a note saying what is
> broken by it.

Not that annotating the commit as "this commit has this bug" makes
much sense, though, of course ;-)  But at least it would let us
answer "Does this commit introduce a bug?" question, and if the
annotated information also records "... and that other commit is a
fix that can be cherry-picked (or merged)", that would be even
better.  That would allow us, when merging down the commit thusly
annotated, to stop and consider either not merging (because it is
known to introduce a bug) or merging with fixes also merged (because
the solution is already known and recorded).
