From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jan 2013, #06; Mon, 14)
Date: Tue, 15 Jan 2013 18:37:52 -0800
Message-ID: <7v7gnd26pr.fsf@alter.siamese.dyndns.org>
References: <7vehhn8kub.fsf@alter.siamese.dyndns.org>
 <CAOkDyE_a4R7=A318VL2TxDn6X8Tu2+m2KNWWYqwBbygRrALQzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 03:38:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvItL-0006bt-Gn
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 03:38:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757944Ab3APChz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2013 21:37:55 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42797 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757282Ab3APChy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2013 21:37:54 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CC34A9C1;
	Tue, 15 Jan 2013 21:37:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=RY+gbLIFhMb8zOVxS7eBHXoRROk=; b=wguBX3
	UPK+Ov3asXqdPeff9iRSPfP884vNoE/JsXI4odhf6gpePKbgktYFZflKaF6dWx+I
	cDO5DV36aM4NA1aYcTOv7lrqwObNl/PKw2oCIQeIqwTmt5qefy0z0alnYuJS8YF+
	L0cdF6VxW9w3EDHSF5NrdMx/FcuT3le0+Ta8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ALfHuH7f2Y8I9CQkn8i9TMO7aJTjINRf
	4jcQcH2Hi4BWpdtf+3MAtPeLKpRfUIAuL/KrnZ6j4/IVFH0dcwTKMOZWttGEgy+R
	IRjLvL6NDtz9JgLucQL9UUUaXU6sWKF4HuSmK58L4adpetj0gUNuJxp393xYtikS
	WsQmG1ZJ0Ig=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 213F6A9C0;
	Tue, 15 Jan 2013 21:37:54 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 90D9CA9BE; Tue, 15 Jan 2013
 21:37:53 -0500 (EST)
In-Reply-To: <CAOkDyE_a4R7=A318VL2TxDn6X8Tu2+m2KNWWYqwBbygRrALQzg@mail.gmail.com> (Adam
 Spiers's message of "Wed, 16 Jan 2013 01:34:36 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BA55CA52-5F85-11E2-ACD5-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213717>

Adam Spiers <git@adamspiers.org> writes:

> On Mon, Jan 14, 2013 at 10:23 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> * as/check-ignore (2013-01-10) 12 commits
>>   (merged to 'next' on 2013-01-14 at 9df2afc)
>>  + t0008: avoid brace expansion
>>  + add git-check-ignore sub-command
>>  + setup.c: document get_pathspec()
>>  + add.c: extract new die_if_path_beyond_symlink() for reuse
>>  + add.c: extract check_path_for_gitlink() from treat_gitlinks() for reuse
>>  + pathspec.c: rename newly public functions for clarity
>>  + add.c: move pathspec matchers into new pathspec.c for reuse
>>  + add.c: remove unused argument from validate_pathspec()
>>  + dir.c: improve docs for match_pathspec() and match_pathspec_depth()
>>  + dir.c: provide clear_directory() for reclaiming dir_struct memory
>>  + dir.c: keep track of where patterns came from
>>  + dir.c: use a single struct exclude_list per source of excludes
>>
>>  Add a new command "git check-ignore" for debugging .gitignore
>>  files.
>
> The above is v4 plus the "t0008: avoid brace expansion" fix.  v4 is
> slightly outdated and not quite the right version to merge to 'next'.

Sigh.

The "What's cooking" is a report of what _has_ already happened.  I
would have appreciated if you said the above _before_ this happened.

> I'll post a v5 re-roll as per:

Now the series is in 'next', it is too late to _replace_ it X-<.
Could you instead make an incremental updates on top?  That way, we
do not have to re-review the whole thing; we only need to review the
changes relative to the old one, making sure that the fixes in the
updates are better than the v4 version.

Thanks.
