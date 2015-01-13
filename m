From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash clear: allow -v/--verbose to be passed
Date: Tue, 13 Jan 2015 10:51:39 -0800
Message-ID: <xmqqy4p6cy4k.fsf@gitster.dls.corp.google.com>
References: <1421171677-12215-1-git-send-email-kuleshovmail@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Alexander Kuleshov <kuleshovmail@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 13 19:51:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB6Z9-00019P-Vn
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 19:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753674AbbAMSvn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 13:51:43 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52477 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753622AbbAMSvm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 13:51:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 86DD42CEF2;
	Tue, 13 Jan 2015 13:51:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vkyhgiuW5TkATqXsz7M9PSGWSfQ=; b=aP4tAG
	yKCy1/YtyxaKmhc+71qzB8bdqCgk4Vfk9ya1C5PV9+ahpKjyl9W/yOGzR/2r4hGD
	+LJPlZHCOFD3BVNUabrhFip6voq7CZW8c5/bsXsKGngRoBgmU5QOZJES9edI3XUD
	RBW4y1hoC62pwU9Qij8Zl0kcqVkKo5I8eRGCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=AomLEf3ryYuJ8xsnQqD4fbjqDYcL1ww9
	ZOQ/cQq8bs3NevRb0+kbPLhUhAN4b/bDDT3JyV8cTUIHJmfI/OYZZkEC3AOi4duh
	q0NA8tYzoIObb+CavCJcq/tscsXXZIUw7YK0jpoekrMo0T+n/W7SZG/vMhUHAWLI
	ct9b5w7ofgQ=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7DC582CEF1;
	Tue, 13 Jan 2015 13:51:41 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BEE762CEEE;
	Tue, 13 Jan 2015 13:51:40 -0500 (EST)
In-Reply-To: <1421171677-12215-1-git-send-email-kuleshovmail@gmail.com>
	(Alexander Kuleshov's message of "Tue, 13 Jan 2015 23:54:37 +0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 35F7F498-9B55-11E4-A5A7-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262347>

Alexander Kuleshov <kuleshovmail@gmail.com> writes:

> Added new option -v/--verbose to 'git stash clear' for verbose output.

Why?

I would sort-of understand if it were "git stash clear --confirm"
that internally runs "git stash list" and then asks "Are you sure
(Y/n)?"  and then finally clears [*1*], but what value does it add
to the system to be able to see what you lost and cannot recover
anymore after the damage is done?

Note that I am not advocating adding "clear --confirm" here (that is
what I mean by "sort-of understand"); the users can do that "Do I
really want to discard these?" themselves.


[Footnote]

*1* Or perhaps copying the stash to boneyard/stash before removing
them so that they can "undo" once.
