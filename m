From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/GSoC 3/3] Nousage message in error
Date: Thu, 24 Mar 2016 09:23:49 -0700
Message-ID: <xmqqh9fvalpm.fsf@gitster.mtv.corp.google.com>
References: <1458785018-29232-1-git-send-email-dj.dij123@gmail.com>
	<CAFZEwPN2vp+zOMdGY51LwNpgNcYxsGD4GBXHNOA8_qJ8vtE5OQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Diwas Joshi <dj.dij123@gmail.com>, Git List <git@vger.kernel.org>
To: Pranit Bauva <pranit.bauva@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 17:23:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj83C-0005aF-DQ
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 17:23:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120AbcCXQXz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 12:23:55 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:53002 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754205AbcCXQXx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 12:23:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EB2ED4B269;
	Thu, 24 Mar 2016 12:23:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=lca81RFktCduUJhwymF05nuHU7M=; b=w6GBvP
	DO9WXlLlade2p2opvr8W3cDHUnJGkwkFsYTD+EiFQOcG1XDC3puV6as0c6LWy95j
	b9F67K0YKejuYZF6lOjdJYLg8RxlceFBiySdXMSAzot8pcSnivskVDk30Jsm0rFu
	tjVsoTUYyb62iAAuvT2Z+65zO7nD8DvLu4lwg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Q7hKBCWC1EGy8KBxiSk0IcClbrUGJ4FV
	5bHwPtIPbYtNwOBViMTbCkwzZoBsMUEVrE3QZmQLfZjUdrGdNyWMZtkdwfkVU+Le
	Y5mbiUbW8f75B8vOyEMm5NTq6x3ZIOHHjAwh2PYUPKTtVccjq5hw3lE2F3C5Xnvk
	NlgpoVF9mqg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E207F4B268;
	Thu, 24 Mar 2016 12:23:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 35E894B267;
	Thu, 24 Mar 2016 12:23:51 -0400 (EDT)
In-Reply-To: <CAFZEwPN2vp+zOMdGY51LwNpgNcYxsGD4GBXHNOA8_qJ8vtE5OQ@mail.gmail.com>
	(Pranit Bauva's message of "Thu, 24 Mar 2016 10:44:08 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: CB68096C-F1DC-11E5-9FD4-EB7E6AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289757>

Pranit Bauva <pranit.bauva@gmail.com> writes:

> A general convention followed by git users it to write the commit
> message as "What he did to the code?" rather than "What problem was
> there in the code?"

It is OK for other projects to adopt a different convention, but The
project convention here is different.

We tend to write our log message like this in this order:

 - Explain relevant behaviour and code structure in the current code
   to refresh memory of readers to help them understand the next two
   items better.  This paragraph is optional and you see it only in
   difficult patches.

 - Desribe the problem.  What the end user would do and what she
   sees in response to it, why that is not a good outcome, and what
   would be a better outcome.  For a patch to only improve code,
   replace "the end user" with "other codepaths that interact with
   the code being changed".

 - Explain the approach to implement a better outcome.  This
   paragraph is optional and you see it only in patches that
   implement tricky solutions.

 - Describe the solution, as if you are giving orders to the
   maintainers to change the code this way and that way.
