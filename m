From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Fri, 07 Jun 2013 08:57:11 -0700
Message-ID: <7v1u8dvrqg.fsf@alter.siamese.dyndns.org>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
	<20130607000006.GA25731@goldbirke>
	<7vli6mwx07.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 07 17:57:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukz2d-00014x-0L
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 17:57:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755934Ab3FGP5R convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Jun 2013 11:57:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35536 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755893Ab3FGP5N convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 7 Jun 2013 11:57:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5493E2523D;
	Fri,  7 Jun 2013 15:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=yT7uKVVl0GJq
	9onxUhka5lbRGPM=; b=O0LLNvr0txCqzWpyAAnYnclPCfNHzKDpTYb6VzVLEPGe
	fj6vwDCgw6I2dXII6kPdV681XVPa+R5HaCRh8d0X6DstW/VhInfH9oo9cWtSfqEg
	gG2Vbf6/4knSbAFGHwPgqtAGxZ5UteRcKnj3BUSFR6ZCNEdHiJW9bLkKftaJYYk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Nhw3zg
	/oBc870R1qbyOPcdmbsTT8ES1RdGmjbm5dwQiOAFxxDlPCMxpLi0+Upy8as0Aks9
	Ult7O/eQW45V8fSnXXSoQwTcIMzWHkntZnppHchgk1myqIa5/nBgJr4NyUBdYxS8
	kC0PdAF4TFZ7WeqiIJM+0oZBg/GrXgC+1x3Vo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 477062523B;
	Fri,  7 Jun 2013 15:57:13 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BA2C22523A;
	Fri,  7 Jun 2013 15:57:12 +0000 (UTC)
In-Reply-To: <7vli6mwx07.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 06 Jun 2013 18:05:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: EAE31998-CF8A-11E2-BFA5-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226642>

=46orgot to cc; sorry about that.

Junio C Hamano <gitster@pobox.com> writes:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> On Thu, Jun 06, 2013 at 03:41:08PM -0700, Junio C Hamano wrote:
>>> * rr/complete-difftool (2013-06-03) 2 commits
>>>   (merged to 'next' on 2013-06-04 at 01c7611)
>>>  + completion: clarify ls-tree, archive, show completion
>>>  + completion: difftool takes both revs and files
>>>=20
>>>  Update command line completion (in contrib/) to use a better named
>>>  completion helper function for commands that take revisions and
>>>  paths.
>>>=20
>>>  Will merge to 'master'.
>>
>> This should not be merged to master as is; the one at the top becaus=
e
>> of the reasons given in $gmane/226272, the one at the bottom because
>> of the misleading commit message (__git_complete_file() always
>> completed refs first as part of the ref:file notation, so it worked
>> just fine except for the ref1...ref2 notation; the real reason for
>> calling __git_complete_revlist_file() for difftool is to make clear
>> that difftool takes ref1...ref2:file, too).
>
> Oops.
>
> It is too late to amend the log messages now, but at least a follow-u=
p
> patch can fix the breakage by adding __git_complete_file() back.  Wou=
ld
> you mind doing that?
>
> Thanks.
