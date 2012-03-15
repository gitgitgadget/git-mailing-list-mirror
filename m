From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] help: Add '--follow-alias' option
Date: Thu, 15 Mar 2012 00:09:08 -0700
Message-ID: <7vbonyl4rv.fsf@alter.siamese.dyndns.org>
References: <1331779969-8641-1-git-send-email-namhyung.kim@lge.com>
 <1331779969-8641-2-git-send-email-namhyung.kim@lge.com>
 <7vehsummit.fsf@alter.siamese.dyndns.org> <4F6188FB.7020406@lge.com>
 <7vvcm6l6w0.fsf@alter.siamese.dyndns.org> <4F619046.1050308@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Namhyung Kim <namhyung.kim@lge.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 08:09:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S84oG-0006Sn-Rw
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 08:09:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756482Ab2COHJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 03:09:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46278 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756450Ab2COHJK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 03:09:10 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3D6E4937;
	Thu, 15 Mar 2012 03:09:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WUmUl0zJ9oXeI4dowvVwwUtAScI=; b=sQlZTJ
	TWYKFn7ESD5aqPb6T+cmvq27hZ5rYFhUBAzAZVIKFbFWe28gpPY+7VgEK3z3hqOa
	Id4WyS6aeZGIKpyBzf/wfDOu4suWQuwPTbtJgswNYk8KOoXX29k1yY/MyG+gy9lk
	0tZlLJQqZxujrvD6C0nO8y89CmaiwRcf8fzPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O5kFDyH47y8tYLqmD8yoNaUtDZhrwZ3O
	NtfQruRQ2idTTfFZ5Vs7SpG6TA1V7YU3Hc0zKp8L/SeC6WN0u6GtMHV0Rs4lY4v6
	KKCCtiTj0HhSwWpIMuoN1moKZKNqpNQ3NKA4lQzX85NRoKiFjJBJIAr/2HylmtVX
	SJWisr1Sh90=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E999D4936;
	Thu, 15 Mar 2012 03:09:09 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7D8624935; Thu, 15 Mar 2012
 03:09:09 -0400 (EDT)
In-Reply-To: <4F619046.1050308@lge.com> (Namhyung Kim's message of "Thu, 15
 Mar 2012 15:46:30 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C2B96EC4-6E6D-11E1-943F-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193190>

Namhyung Kim <namhyung.kim@lge.com> writes:

>> You _somehow_ restict the output, or at least draw the user's attention,
>> to the description of --list mode in the resulting "git-branch" manual.
>>
>> I do not think that is feasible.
>
> Actually I was thinking about moving to an appropriate point in the
> document by checking second argument (if any) and searching it (using
> regexp?). But I coundn't be sure it'd be possible too.

I don't think it is feasible.
Think "[alias] lgf = log --oneline --first-parent".

>> But showing the whole manual page, without telling the user that "br" is
>> not aliased to a plain vanilla "branch" without any option, is not a
>> solution, especially if you are going to let the user set a configuration
>> variable to allow him to forget about this setting. Progressive revelation
>> would not have such a downside and I think it is more appropriate approach
>> for something like "help".
>
> OK. That makes sense to me too. This was just a quick thought hoping
> that can be helpful for someone who uses alias as a simple
> abbreviation.

Yeah, I would have been the first to cheer-lead an effort to make things
clever, cute and even dwim if this were about a real command that is an
integral part of people's everyday life. Once people understand what it is
doing, they will even appreciate the cleverness.

But help is the entry point for the understanding. It is safer to keep it
simple and predictable.
