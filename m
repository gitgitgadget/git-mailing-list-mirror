From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/6] Miscellaneous merge fixes
Date: Tue, 12 Apr 2016 18:23:12 -0700
Message-ID: <xmqqd1pumhdr.fsf@gitster.mtv.corp.google.com>
References: <1460268820-8308-1-git-send-email-newren@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 03:23:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq9Wi-0003H3-MT
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 03:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756279AbcDMBXQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Apr 2016 21:23:16 -0400
Received: from pb-smtp0.pobox.com ([208.72.237.35]:54885 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752008AbcDMBXP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 21:23:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1604D55469;
	Tue, 12 Apr 2016 21:23:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=rg8IquVPtWfucLJQAWfPh/zhAK0=; b=xp2LIM
	LcgLDl5hfVjxyou/jf9+YYs6ZxDHXTWnG4N3JuCdnnq/lRUy8EFd2TTrZkWONh1w
	JedbrBFE4+9L9+GU8B8okXVn1+FFEisAn3HLymrttiWzoKEZ/r3wSuPC8jP8MzqK
	ViomzpbQnP/dJgL3dfP+PiF6/MyaX0A1a66e4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lJj1fUBv+SZYvmvLdBcy56SjUCKE1fBR
	3W5K8+dU7QvAPeRN4OyjednOLmGYmbcQU1GgZz55YmiO0CpTnOQOPPaMRo7fME6Y
	4p+KPeDojkPoD931MZmF2kWCDsQJaa6WbVUcMlEck9xXmMOBWI9gMWMRHPGfzIyz
	UHesoZsKRME=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0D0DE55468;
	Tue, 12 Apr 2016 21:23:14 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 7E64155467;
	Tue, 12 Apr 2016 21:23:13 -0400 (EDT)
In-Reply-To: <1460268820-8308-1-git-send-email-newren@gmail.com> (Elijah
	Newren's message of "Sat, 9 Apr 2016 23:13:34 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4AAF7C08-0116-11E6-B016-45AF6BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291356>

Elijah Newren <newren@gmail.com> writes:

> Elijah Newren (6):
>   Remove duplicate code
>   Avoid checking working copy when creating a virtual merge base
>   Add merge testcases for when index doesn't match HEAD
>   merge-octopus: Abort if index does not match HEAD
>   Add a testcase demonstrating a bug with trivial merges
>   builtin/merge.c: Fix a bug with trivial merges

Please be careful when giving titles to your patches.  They will be
shown in a context that is much wider than the area your attention
is currently concentrated on.  E.g. does "Remove duplicate code"
tell readers of "git shortlog --no-merges v2.8.0..v2.9.0" what the
change was about when it eventually appears in the upcoming release?

>
>  builtin/merge.c                          |   8 ++
>  git-merge-octopus.sh                     |   6 ++
>  merge-recursive.c                        |   8 +-
>  t/t6044-merge-unrelated-index-changes.sh | 153 +++++++++++++++++++++++++++++++
>  t/t7605-merge-resolve.sh                 |   6 +-
>  5 files changed, 175 insertions(+), 6 deletions(-)
>  create mode 100755 t/t6044-merge-unrelated-index-changes.sh
