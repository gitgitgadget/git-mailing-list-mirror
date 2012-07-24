From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 4/7] Remove obsolete LONG_USAGE which breaks xgettext
Date: Tue, 24 Jul 2012 12:07:35 -0700
Message-ID: <7vpq7lf05k.fsf@alter.siamese.dyndns.org>
References: <cover.1343112786.git.worldhello.net@gmail.com>
 <e3481427da5efcb60053bb4cd5bcc7e4567100f0.1343112786.git.worldhello.net@gmail.com> <20120724180808.GG2939@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 21:07:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1StkSP-0002e3-4k
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jul 2012 21:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756204Ab2GXTHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jul 2012 15:07:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53188 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755990Ab2GXTHi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2012 15:07:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D8FA9878B;
	Tue, 24 Jul 2012 15:07:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=A0EXsj0vgZO77xNgNgzGmu8T+ss=; b=XttszL
	ryq5MKVktXWe4NgPZsgu8FrDV/VcyCs5wEJB8S8Lff8VfaY1MbOZMb4YVD/EFoqy
	Gu+gBmUOC9+ydhjRedMpjBmZAD3FaA56ZXrZ1uCpJlhdxH4KybVfr84AjQhByJXy
	WQZri5PUS98mKGOjZjMXm3ojCCO1IEZm+dOOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qBBY38W38KiSShkDUZcIiHu0kPvVGMTS
	L37F+28J7/CguM+ijd/L129XfJ3fwPn2GOqxU/ACn/yztcyUvmLUloBRzpsiVieL
	qCXKsPta2jBTwmKWOvADMiPYjKjjw/sI1bkLpZbJahX2JsRRZlwI5WGlqpYgu+MQ
	tHoMLUmoRZU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C62FE8789;
	Tue, 24 Jul 2012 15:07:37 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2BDF68787; Tue, 24 Jul 2012
 15:07:37 -0400 (EDT)
In-Reply-To: <20120724180808.GG2939@burratino> (Jonathan Nieder's message of
 "Tue, 24 Jul 2012 13:08:09 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D5022636-D5C2-11E1-836E-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202054>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Jiang Xin wrote:
>
>> The obsolete LONG_USAGE variable
> [...]
>
> It's a shame to lose the information that was in the LONG_USAGE
> message, though.  Maybe it could be incorporated into the OPTIONS_SPEC
> before the opening "--", or maybe it could be used to clarify the
> description in git-rebase(1).

I personally think the original long-usage was overkill to be part
of the help text, and I am happy to see it go.

I wouldn't mind seeing it incorporated in the documentation if there
is something in there that is missing, but I suspect that the first
part of the DESCRIPTION should be sufficiently clear already.

> [...]
>> --- a/git-rebase.sh
>> +++ b/git-rebase.sh
>> @@ -3,31 +3,6 @@
>>  # Copyright (c) 2005 Junio C Hamano.
>>  #
>>  
>> -USAGE='[--interactive | -i] [--exec | -x <cmd>] [-v] [--force-rebase | -f]
>> -       [--no-ff] [--onto <newbase>] [<upstream>|--root] [<branch>] [--quiet | -q]'
>> -LONG_USAGE='git-rebase replaces <branch> with a new branch of the
>> -same name.  When the --onto option is provided the new branch starts
>> -out with a HEAD equal to <newbase>, otherwise it is equal to <upstream>
>> -It then attempts to create a new commit for each commit from the original
>> -<branch> that does not exist in the <upstream> branch.
>> -
>> -It is possible that a merge failure will prevent this process from being
>> -completely automatic.  You will have to resolve any such merge failure
>> -and run git rebase --continue.  Another option is to bypass the commit
>> -that caused the merge failure with git rebase --skip.  To check out the
>> -original <branch> and remove the .git/rebase-apply working files, use the
>> -command git rebase --abort instead.
>> -
>> -Note that if <branch> is not specified on the command line, the
>> -currently checked out branch is used.
>> -
>> -Example:       git-rebase master~1 topic
>> -
>> -	A---B---C topic                   A'\''--B'\''--C'\'' topic
>> -       /                   -->           /
>> -  D---E---F---G master          D---E---F---G master
>> -'
>> -
>>  SUBDIRECTORY_OK=Yes
>>  OPTIONS_KEEPDASHDASH=
>>  OPTIONS_SPEC="\
>> -- 
>> 1.7.12.rc0.17.gcb766d3
>> 
