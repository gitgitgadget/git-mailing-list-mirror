From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv6 1/4] wt-status.*: better advices for git status added
Date: Mon, 04 Jun 2012 07:54:01 -0700
Message-ID: <7vfwabunzq.fsf@alter.siamese.dyndns.org>
References: <1338477344-15940-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1338748217-16440-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <7v7gvoyuk4.fsf@alter.siamese.dyndns.org>
 <20120604115110.Horde.CoZeVXwdC4BPzIUOb8j18yA@webmail.minatec.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kong Lucien <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Duperray Valentin <Valentin.Duperray@ensimag.imag.fr>,
	Jonas Franck <Franck.Jonas@ensimag.imag.fr>,
	Nguy Thomas <Thomas.Nguy@ensimag.imag.fr>,
	Nguyen Huynh Khoi Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Moy Matthieu <Matthieu.Moy@grenoble-inp.fr>
To: konglu@minatec.inpg.fr
X-From: git-owner@vger.kernel.org Mon Jun 04 16:54:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbYfg-0006y6-Uh
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 16:54:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755656Ab2FDOyG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 4 Jun 2012 10:54:06 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:63116 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755009Ab2FDOyF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 4 Jun 2012 10:54:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CA796630;
	Mon,  4 Jun 2012 10:54:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yZyC0BM3G/FY
	FJYijErnQ6x8FEE=; b=XZogabD5Cm5s08jnNpWQ+1y8t6eR0PThGl9dDTT9L/K1
	8eJVbLMDULjIJOocPsf9cp0dkJzKLMk7r9kBBKYLuFVBcw19Z4uAp6lP61bDkyz5
	RA0MIt3WY9tLQy+z1aBdX1v0TsNw6KTH2u1B0/oXBYqNYeaJxIiMdI1SiAAB3KY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=NgTcoN
	uRhpP7ytVqmFKTBdanj05tYcb+SPozlcHJnXURoRf4szXehY96th5iS1/LIdy5DI
	hfeQ6UgZO/1Isi8PfUOyu1YEBg+iVMkr3BwtDpipVzMNif6WrX0Ti4LJOk9142mn
	oyKoHL7b6O8U3VheMlkzQ36FIQsPaLmXJeaGU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80922662F;
	Mon,  4 Jun 2012 10:54:03 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 01368662A; Mon,  4 Jun 2012
 10:54:02 -0400 (EDT)
In-Reply-To: <20120604115110.Horde.CoZeVXwdC4BPzIUOb8j18yA@webmail.minatec.grenoble-inp.fr> (konglu@minatec.inpg.fr's message of "Mon, 04 Jun 2012 11:51:10 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2008B0A4-AE55-11E1-BF07-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199140>

konglu@minatec.inpg.fr writes:

> Junio C Hamano <gitster@pobox.com> a =C3=A9crit:
> ...
>>
>> Also when you are in the middle of "git am -3", there may be
>> unmerged entries in the index; do we want to suggest "add/rm" to
>> resolve to fill in the missing detail of "fix" in your "when you
>> have fixed this problem" message?
>>
>> We may want to decide how detailed we want to make the help texts;
>> the same fuzziness exists in "fix conflicts and then" at the
>> beginning of show_rebase_in_progress().
>
> In fact, to detail more "fix" in this case by suggesting "add/rm"
> would be repetitive, as this advice is already given under the block
> "unmerged paths":

OK, then I agree that "resolve and do X" is a sufficient level of
detail for these messages.

>> This last "else" block is taken when running "rebase -i" and there
>> is no longer any unmerged index entry.  I wonder if the message from
>> the first printf_ln needs to be clarified further depending on the
>> context.
>>
>> Specifically, in this sequence:
>>
>> 	- the user marked a commit as "pick";
>>         - replaying of that commit resulted in conflicts;
>>         - the user edited files and used add/rm to resolve conflicts=
;
>>         - the user did one of these:
>> 	  1. "git status"
>>           2. "git commit" without "--amend"
>>           3. "git commit --amend"
>>
>> can this message come up?
>>
>> In such a case, "You are currently editing a commit" is actively
>> wrong.  The user has finished resolving the conflict and are about
>> to record the result.  Also, "git status" and "git commit" without
>> "--amend" are both sensible commands in this situation, but running
>> "git commit --amend" is likely to be a mistake, no?
>
> True, the last "else" block is not supposed to be taken. The correct
> message that should be displayed is the first "else if" block, saying
> just that all conflicts are fixed and to run rebase --continue.

OK, so this part still needs a bit more work, then.

Thanks.
