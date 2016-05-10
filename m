From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/13] worktree.c: mark current worktree
Date: Tue, 10 May 2016 10:32:56 -0700
Message-ID: <xmqq8tzhrf7b.fsf@gitster.mtv.corp.google.com>
References: <1461158693-21289-1-git-send-email-pclouds@gmail.com>
	<1461330096-21783-1-git-send-email-pclouds@gmail.com>
	<1461330096-21783-6-git-send-email-pclouds@gmail.com>
	<CAPig+cQszEZLaebwqXNny6_EnhFpwU1xYqEX2_0N=vTEXTk2Fw@mail.gmail.com>
	<CACsJy8D+anuZ-278kaz2ewpcLCGOSrdn2Qq1F7fFTuVUTLv5Yw@mail.gmail.com>
	<20160510141416.GA22672@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>,
	Reto =?utf-8?Q?Habl=C3=BCtzel?= <rethab.ch@gmail.com>,
	Mike Rappazzo <rappazzo@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 19:33:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0BWs-0005ZE-Cj
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 19:33:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbcEJRdB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 13:33:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64693 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750864AbcEJRdA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 13:33:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6240F19DC9;
	Tue, 10 May 2016 13:32:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gfjZ4ecUjYWmiNDGAOoLOUYMzRg=; b=Wr61UD
	I5BqXzgqz2VKQg/0sAnou8rfa4lZMQA8Bt6IiUMOQetAOCyed/c44NQ3XvDoHZUV
	M8ENjBkE/BqhKhUCDleUQbkEZa86a2tXg8obucIHDkvbd/fPlJy5mdBPYEj2sEsd
	7pVf/kLP4A3UMJlncrtlfiStfw9HC2vuMJxlM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RwYzxsf11RG90XsbIUqejgArqPEuxynN
	GjqzNFz8DcgyzNcoQOujforfadlgoQFaA3k1y5agl3lwhofkNw9/v+M6BBNEnRhC
	T1TjIH2/krTho8DF51TaBHHS1oCu+4Lk/SQAYx+4taGbxoV24+XdA+R1FhDKxgTH
	lR1sApDp81I=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 57C4719DC8;
	Tue, 10 May 2016 13:32:59 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BD4DF19DC7;
	Tue, 10 May 2016 13:32:58 -0400 (EDT)
In-Reply-To: <20160510141416.GA22672@lanh> (Duy Nguyen's message of "Tue, 10
	May 2016 21:14:16 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 3CFEE222-16D5-11E6-AA55-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294162>

Duy Nguyen <pclouds@gmail.com> writes:

> On second thought, why hold patches back, lengthen the worktree-move
> series and make it a pain to review? I moved a few patches from
> worktree-move into this series and I took two other out to create
> nd/error-errno. So I'm going to take more patches out of it, creating
> two bite-sized series, to be sent shortly.
>
> The first one is purely cleanup (ok, 1/7 is not exactly cleanup)
>
>   [1/7] completion: support git-worktree
>   [2/7] worktree.c: rewrite mark_current_worktree() to avoid
>   [3/7] git-worktree.txt: keep subcommand listing in alphabetical
>   [4/7] worktree.c: use is_dot_or_dotdot()
>   [5/7] worktree.c: add clear_worktree()
>   [6/7] worktree: avoid 0{40}, too many zeroes, hard to read
>   [7/7] worktree: simplify prefixing paths
>
> And the second one adds "git worktree lock" and "git worktree
> unlock". This series is built on top of the first one, it needs 1/7.
>
>   [1/5] worktree.c: add find_worktree_by_path()
>   [2/5] worktree.c: add is_main_worktree()
>   [3/5] worktree.c: add is_worktree_locked()
>   [4/5] worktree: add "lock" command
>   [5/5] worktree: add "unlock" command
>
> After this, worktree-move becomes ~10 patch series.

Yay.  Thanks; will take a look.
