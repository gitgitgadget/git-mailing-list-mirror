From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Oct 2014, #08; Fri, 31)
Date: Mon, 03 Nov 2014 10:41:48 -0800
Message-ID: <xmqqioiwrus3.fsf@gitster.dls.corp.google.com>
References: <xmqqzjccrm53.fsf@gitster.dls.corp.google.com>
	<20141101040932.GC8307@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Nov 03 19:41:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlMZg-0007pu-Gd
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 19:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbaKCSlw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 13:41:52 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:60227 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751906AbaKCSlv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 13:41:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D80AC1B7AA;
	Mon,  3 Nov 2014 13:41:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ej4+Z7flNT5Syizzh2GgObg4lvY=; b=JMcsxb
	1z2rFQ5m3URhVXFa0QrNqaEGrosmT8yzJAf3AdylIW5T8aRhYK5NmNJvwOYPg9DQ
	DnFaU7Rxkw+B6sr5yTqlccElA1ui0U/0VaLBalkjxbx6Qr+RbVEbj//evN2DLwz7
	Dhyd+ny4+GVZpm3PHpgEy7Q2yQAfSdnXt1nVA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mNzBMyRUUck6P40/UYz7OCJDICLtC8yo
	+uLCjtCVhxE1SEkwvRyicz198sa7s0SE2f5dUintJTFkUaG6LAxuXAzTR/f3OxMi
	O3O0iZeLGvarQfK9Je8IytU03O94C9UUE64EuLjVfE/0xequrFxIleqrOEqYZVBj
	qlAc3rh3MwY=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CF16A1B7A9;
	Mon,  3 Nov 2014 13:41:50 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 608F01B7A6;
	Mon,  3 Nov 2014 13:41:49 -0500 (EST)
In-Reply-To: <20141101040932.GC8307@peff.net> (Jeff King's message of "Sat, 1
	Nov 2014 00:09:32 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 12BD9450-6389-11E4-B257-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Fri, Oct 31, 2014 at 01:59:20PM -0700, Junio C Hamano wrote:
>
>> --------------------------------------------------
>> [Discarded]
>> 
>> * jk/tag-contains (2014-06-30) 8 commits
>>  . perf: add tests for tag --contains
>>  . tag: use commit_contains
>>  . commit: provide a fast multi-tip contains function
>>  . string-list: add pos to iterator callback
>>  . add functions for memory-efficient bitmaps
>>  . paint_down_to_common: use prio_queue
>>  . tag: factor out decision to stream tags
>>  . tag: allow --sort with -n
>> 
>>  Expecting a reroll.
>
> Seems reasonable.  I am still planning to re-roll this eventually, but I
> do not think there is a deep need to carry it in your tree for the time
> being.

I started to think about how to consolidate the various "reachable"
and "contains" traversal machinery (and that was one reason why I
had a small clean-up patches in the merge-base machinery) but
haven't managed to allocate enough concentration on the issue (yet).

>> * jk/makefile (2014-02-05) 16 commits
>>  . FIXUP
>>  . move LESS/LV pager environment to Makefile
>>  . Makefile: teach scripts to include make variables
>>  . FIXUP
>>  . Makefile: auto-build C strings from make variables
>>  . Makefile: drop *_SQ variables
>>  . FIXUP
>>  . Makefile: add c-quote helper function
>>  . Makefile: introduce sq function for shell-quoting
>>  . Makefile: always create files via make-var
>>  . Makefile: store GIT-* sentinel files in MAKE/
>>  . Makefile: prefer printf to echo for GIT-*
>>  . Makefile: use tempfile/mv strategy for GIT-*
>>  . Makefile: introduce make-var helper function
>>  . Makefile: fix git-instaweb dependency on gitweb
>>  . Makefile: drop USE_GETTEXT_SCHEME from GIT-CFLAGS
>> 
>>  Simplify the Makefile rules and macros that exist primarily for
>>  quoting purposes, and make it easier to robustly express the
>>  dependency rules.
>> 
>>  Expecting a reroll.
>
> I was surprised you carried this in your tree for so long. I do like the
> direction it was going, but I was not 100% convinced that it was
> something _other_ people liked, and I never really prioritized getting
> back to it. Did you actually like it and really wanted to see it
> finished, or did just kind of hang around because you had never bothered
> to drop it?

I liked most of them (especially the LESS/LV one and a few ones on SQ).
I am not sure if I had major issues with any parts of them other
than those small FIXUPs (yeah, I no longer recall the details ;-).
