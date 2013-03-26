From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git ate my home directory :-(
Date: Tue, 26 Mar 2013 09:32:10 -0700
Message-ID: <7vr4j2t94l.fsf@alter.siamese.dyndns.org>
References: <5150C3EC.6010608@nod.at> <20130325214343.GF1414@google.com>
 <7vboa7w2vm.fsf@alter.siamese.dyndns.org>
 <384BCFE976364F1EA6E56306566D003A@PhilipOakley>
 <20130326094844.GA32583@duynguyen-vnpc.dek-tpc.internal>
 <20130326150428.GA3847@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Richard Weinberger <richard@nod.at>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 17:32:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKWni-0006FO-Ku
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 17:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934662Ab3CZQcO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Mar 2013 12:32:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60091 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934635Ab3CZQcN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Mar 2013 12:32:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8DEECAEC9;
	Tue, 26 Mar 2013 12:32:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=RAQKTzuHNpAN
	TnDp3Mp7UXXRdv8=; b=j/9/bSivVogXuMHNI8tAOK90sX9c+KW27kMq5F/MLVK0
	Nuhv195pMW5W+7lI+K6jXvInsDUvgjeBhWxe2pXpm2wZLRzITUJEHRxqXfYe8GEC
	cQUOSLv5JjOJDIFiBzqnRQMNOLum6JZtU6mnkKttBI2rm6oaBuf3ME1QSr4q17w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=gBG18e
	TnG+v8+SH736bnlkilME8JuJTcZlobtTQdVHP+MIzwwfo3p4TnXV/skLFOeR4kGp
	xK70QzqNTMPlomSBCscMgzZ/jFW9d6oY9ZlKJcUrzHcWb0P3sq8z5d+m6wkXxbAI
	s183QpjOACSPyu6pNMVY8yBRJKRcb54M+O5vM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7E5C8AEC8;
	Tue, 26 Mar 2013 12:32:12 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id DC46DAEC6; Tue, 26 Mar 2013
 12:32:11 -0400 (EDT)
In-Reply-To: <20130326150428.GA3847@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 26 Mar 2013 11:04:28 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B5EABFAC-9632-11E2-8D8A-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219166>

Jeff King <peff@peff.net> writes:

> On Tue, Mar 26, 2013 at 04:48:44PM +0700, Nguyen Thai Ngoc Duy wrote:
>
>> Something like this, maybe?
>>=20
>> -- 8< --
>> Subject: [PATCH] git.txt: document the implicit working tree setting=
 with GIT_DIR
>>=20
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  Documentation/git.txt | 2 ++
>>  1 file changed, 2 insertions(+)
>>=20
>> diff --git a/Documentation/git.txt b/Documentation/git.txt
>> index 7efaa59..ce55abf 100644
>> --- a/Documentation/git.txt
>> +++ b/Documentation/git.txt
>> @@ -671,6 +671,8 @@ Git so take care if using Cogito etc.
>>  	specifies a path to use instead of the default `.git`
>>  	for the base of the repository.
>>  	The '--git-dir' command-line option also sets this value.
>> +	If neither GIT_WORK_TREE nor '--work-tree' is set, the
>> +	current directory will become the working tree.
>
> I think this is a good thing to mention, but a few nits:
>
>   1. core.worktree is another way of setting it
>
>   2. This can also be overridden by --bare (at least in "next").
>
>   3. I think having core.bare set will also override this

Yeah.  And sorry I kept typing alias. I obviously meant "bare"; the
user visible symptom is closely linked to the use of alias, but the
most important aspect of the change in 2cd83d10bb6b (setup: suppress
implicit "." work-tree for bare repos, 2013-03-08) is about being in
a bare repository where by definition working tree does not exist.
