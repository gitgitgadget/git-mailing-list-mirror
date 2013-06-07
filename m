From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git.git (Jun 2013, #03; Thu, 6)
Date: Thu, 06 Jun 2013 18:05:44 -0700
Message-ID: <7vli6mwx07.fsf@alter.siamese.dyndns.org>
References: <7vzjv2x3p7.fsf@alter.siamese.dyndns.org>
	<20130607000006.GA25731@goldbirke>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Fri Jun 07 03:05:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ukl7o-0004rw-Nf
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 03:05:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754744Ab3FGBFs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 6 Jun 2013 21:05:48 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59460 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754553Ab3FGBFr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jun 2013 21:05:47 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2458D1BD49;
	Fri,  7 Jun 2013 01:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1Nbjkh7M2gAx
	/UeNm7bL2azV+pk=; b=MBoEFPQmvu7alRT228vCyvpIIcvNv5UdI9JQ/APZMHJu
	6LxSghF/iK/4BFDK9iI9tN9hezg8n50mZU4VFMUkvEMePaw2A0j+D9aajsX/M5T7
	+28qAofzXrVjlR34B8RkiNWUQr6phrSnx0pIQ4GkQoe1kvlSVNr1AmESJtktXhE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=ISnGHo
	MUcE6mtZAdUh/XUvinat4JqDp+0DWq0Rd4iY7x3mMoCFiOL1zFrb5tIvkX5UdHOy
	N9LUX9S/9hgc/nxbu/vrZWngtK7XIAng9oTZo3lzWUtfoyUST56R+WWNNoXOlSD5
	X+ZPs/DDAcs5vPSs5aLQA40/DeIm6NUBtH88M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1ADAA1BD44;
	Fri,  7 Jun 2013 01:05:47 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8D9161BD40;
	Fri,  7 Jun 2013 01:05:46 +0000 (UTC)
In-Reply-To: <20130607000006.GA25731@goldbirke> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
	"Fri, 7 Jun 2013 02:00:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 62A343E0-CF0E-11E2-A55A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226574>

SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:

> On Thu, Jun 06, 2013 at 03:41:08PM -0700, Junio C Hamano wrote:
>> * rr/complete-difftool (2013-06-03) 2 commits
>>   (merged to 'next' on 2013-06-04 at 01c7611)
>>  + completion: clarify ls-tree, archive, show completion
>>  + completion: difftool takes both revs and files
>>=20
>>  Update command line completion (in contrib/) to use a better named
>>  completion helper function for commands that take revisions and
>>  paths.
>>=20
>>  Will merge to 'master'.
>
> This should not be merged to master as is; the one at the top because
> of the reasons given in $gmane/226272, the one at the bottom because
> of the misleading commit message (__git_complete_file() always
> completed refs first as part of the ref:file notation, so it worked
> just fine except for the ref1...ref2 notation; the real reason for
> calling __git_complete_revlist_file() for difftool is to make clear
> that difftool takes ref1...ref2:file, too).

Oops.

It is too late to amend the log messages now, but at least a follow-up
patch can fix the breakage by adding __git_complete_file() back.  Would
you mind doing that?

Thanks.
