From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fix formatting in git-config(1)
Date: Sat, 23 Jun 2012 01:12:13 -0700
Message-ID: <7vbokala5e.fsf@alter.siamese.dyndns.org>
References: <m2vcil4n0w.fsf@igel.home>
 <7v4nq5twwg.fsf@alter.siamese.dyndns.org>
 <7v62ainbub.fsf@alter.siamese.dyndns.org> <m2y5neqwwj.fsf@linux-m68k.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Jun 23 10:12:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SiLSP-0007sc-5M
	for gcvg-git-2@plane.gmane.org; Sat, 23 Jun 2012 10:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753706Ab2FWIM3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Jun 2012 04:12:29 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55693 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752818Ab2FWIMR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jun 2012 04:12:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 073CE666E;
	Sat, 23 Jun 2012 04:12:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=V8svXcIRe066
	H6zrLFj2+yFnBPc=; b=joKq+Gbl11g1BKF+9A2QmvLSmfqecl5WpeFCHpEenpfU
	i3XWkXqZVwhy+RGFrRnbnw53Rh4BJ4eK0U393oUfNsUTSmT3EHkE3KJpsnZMZqVy
	QAnGcqzdbJMjz1DRCn/78Fi6ByLm2A78QuDSoB5JzukhfIsc8qwWzPKV9IKaEhQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YDD3mT
	J22WX+2Z6hI1hldxNe6/bZuMXON9dpA2YjtOB1ru92X7tXpOHZ4jw+IWJqT1qKZZ
	Wkp/CM1oBmq5cpr5koPJPMpbwYgMSoDHOgPSQSloz3OXoNcGZHPlTHtRFWGn0W9t
	86duh+DYMjydT9hFnoVkBLznJmW5esxZtY5Bw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2DF8666D;
	Sat, 23 Jun 2012 04:12:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 16257666C; Sat, 23 Jun 2012
 04:12:14 -0400 (EDT)
In-Reply-To: <m2y5neqwwj.fsf@linux-m68k.org> (Andreas Schwab's message of
 "Sat, 23 Jun 2012 10:01:48 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 24698884-BD0B-11E1-AEAC-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200496>

Andreas Schwab <schwab@linux-m68k.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> Andreas Schwab <schwab@linux-m68k.org> writes:
>>>
>>>> Remove the open block markers from the status.showUntrackedFiles e=
ntry
>>>> as they cause all remaining entries to be indented one level too m=
uch.
>>>
>>> Hrm...
>>>
>>> I looked at http://git-htmldocs.googlecode.com/git/git-config.html
>>> and am unsure what "one level too much" you are referring to.  Also
>>> looking at the output from
>>>
>>> $ git config --help
>>>
>>> I see (RHS end truncated to avoid line wrapping in MUA):
>>>
>>>     status.showUntrackedFiles
>>>         By default, git-status(1) and git-commit(1) show files whi
>>>         tracked by Git. Directories which contain only untracked f
>>>         the directory name only. Showing untracked files means tha
>>>         lstat() all all the files in the whole repository, which m
>>>         systems. So, this variable controls how the commands displ
>>>         files. Possible values are:
>>>
>>>         =C2=B7    no - Show no untracked files.
>>>
>>>         =C2=B7    normal - Show untracked files and directories.
>>>
>>>         =C2=B7    all - Show also individual files in untracked dir=
ecto
>>>
>>>         If this variable is not specified, it defaults to normal.=20
>>>         overridden with the -u|--untracked-files option of git-sta
>>>         commit(1).
>>
>> Worse yet, with AsciiDoc 8.5.2, here is what I see with your patch
>> (again, RHS end truncated to avoid line wrapping in MUA):
>>
>>     status.showUntrackedFiles
>>
>>             By default, git-status(1) and git-commit(1) show files w
>>             Directories which contain only untracked files, are show
>>             Showing untracked files means that Git needs to lstat()=20
>>             repository, which might be slow on some systems. So, thi
>>             displays the untracked files. Possible values are:
>>
>>                * no - Show no untracked files.
>>
>>                * normal - Show untracked files and directories.
>>
>>                * all - Show also individual files in untracked direc
>>
>>                  If this variable is not specified, it defaults to n
>>                  with the -u|--untracked-files option of git-status(
>>
>> So...
>
> I get this layout no matter what, with and without the block markers,
> both with version 8.4.5 and 8.6.6.  But with the block markers the
> remaining entries are indented too much.
>
> So...

So with your patch, users of AsciiDoc 8.5.2 will be harmed by the
same breakage as you get with 8.4.5 and 8.6.6 with or without your
patch, and without your patch, users of AsciiDoc 8.5.2 gets a lot
more reasonable output than with your patch?

Can't we have a patch that makes everybody happier than what each is
currently seeing---that would be a progress without regression to
anybody.
