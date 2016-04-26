From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/15] submodule groups (once again)
Date: Tue, 26 Apr 2016 15:19:57 -0700
Message-ID: <xmqqshy8c8s2.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: jrnieder@gmail.com, git@vger.kernel.org, Jens.Lehmann@web.de,
	pclouds@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 00:20:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avBKy-0006wD-If
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 00:20:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbcDZWUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Apr 2016 18:20:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57446 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752313AbcDZWUA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Apr 2016 18:20:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E2CE15382;
	Tue, 26 Apr 2016 18:19:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nlWyx2HY1+DaObXvnVHJqlkOaCg=; b=L9KqIu
	sfD66keqRwDPJxtp+a51GuCT+TGtHe6lwdFX6f0s491vPoA5a0qj5QoaneGqEvAz
	QtTUeP4Q543nu8JAk/+Vq0p4JGkYOYBwjXCoe9GNAKy8UPXsx37Au74bflsnzXgP
	M267/NkPVMSghaK+FQdvNxJ/UK445wJfIrO5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=SDlM+09Jh3pDpwL6GKMnQ8emdT6vd1HQ
	ddDffTUPlPxwqf8q0mjj7lllYse3icHC/99tnAVfJHOXOJQjjVYLIoBsHI4lAePU
	7B3Q97Zy0Z+nqk8s6Lov/wImQUy23dWp22+a4a500P0c7jhDnMfzafWVt9WXlZrh
	42IritQ5gZQ=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5582615380;
	Tue, 26 Apr 2016 18:19:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B22EE1537E;
	Tue, 26 Apr 2016 18:19:58 -0400 (EDT)
In-Reply-To: <1461703833-10350-1-git-send-email-sbeller@google.com> (Stefan
	Beller's message of "Tue, 26 Apr 2016 13:50:18 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 031079A0-0BFD-11E6-AAFE-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292689>

Stefan Beller <sbeller@google.com> writes:

> git diff is supposed to view the differences between "what would I
> get after checkout" (i.e. what is in the index run through smudge filters)
> compared to the actual worktree.

I do not think it affects your conclusion, but the above is wrong.
"git diff" is a preview of what you would add (i.e. what will be in
the index after passing working tree contents via the clean filter)
relative to what is actually in the index.
