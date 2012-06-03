From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fix many comment typos
Date: Sat, 02 Jun 2012 17:46:20 -0700
Message-ID: <7vipf9z0gz.fsf@alter.siamese.dyndns.org>
References: <8762baf8do.fsf@rho.meyering.net>
 <7vmx4lz5bm.fsf@alter.siamese.dyndns.org>
 <CAE1pOi0g1UCebpWGP6FpH0-RbUBxyoWMj_XT7=gNudHrztx0+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 03 02:47:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SayyC-000387-Nd
	for gcvg-git-2@plane.gmane.org; Sun, 03 Jun 2012 02:47:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901Ab2FCAqY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jun 2012 20:46:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61320 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964864Ab2FCAqX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jun 2012 20:46:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8732B9C8C;
	Sat,  2 Jun 2012 20:46:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ae9t4cmPH2wJ
	0jNmcVagPze8pC8=; b=KUJXUi/jpexkEst9Drvxvv4L9gseMI/Zyjyn5UHiRpcE
	fCV0gLGMVmZwImLLzlcDnLxm389R0aaIY1jjmn+TxOzGaRX/v8LPH0tTzfcew14z
	WcVFYchmDGJB3NuoBwwBVY4W+nXvYbAIHdzg/CfU4uf9sQZUXR71KGvIrILqxe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=okwy1P
	/f5E5NZ0QCk21V8GwFpODcRXYizTbfe6sTkwofbcFVAGqfCNNEs+PV0lzq0MxqIt
	rBiT5Z3aijuDRkI6ihOqkfdZwwlIsrQtGUbspoYqJt4xabMapb/oCkqsevyk5umJ
	1XaRMSvLGDtOQ4OLtj/GWuxKbFeVFtnMs79kM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7B5729C8B;
	Sat,  2 Jun 2012 20:46:22 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D33BD9C8A; Sat,  2 Jun 2012
 20:46:21 -0400 (EDT)
In-Reply-To: <CAE1pOi0g1UCebpWGP6FpH0-RbUBxyoWMj_XT7=gNudHrztx0+g@mail.gmail.com> (Hilco
 Wijbenga's message of "Sat, 2 Jun 2012 16:47:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 89FC4C32-AD15-11E1-A7D3-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199065>

Hilco Wijbenga <hilco.wijbenga@gmail.com> writes:

> On 2 June 2012 16:01, Junio C Hamano <gitster@pobox.com> wrote:
>> Jim Meyering <jim@meyering.net> writes:
>>
>>> Use http://github.com/lyda/misspell-check to identify many typos.
>>> Culprits identified and fixed automatically using these commands,
>>> converting diagnostics to single-quote-safe sed -i commands:
>>>
>>> git ls-files|misspellings -f -|perl -nl \
>>> =C2=A0 -e '/^(.*?)\[(\d+)\]: (\w+) -> "(.*?)"$/ or next;' \
>>> =C2=A0 -e '($file,$n,$l,$r)=3D($1,$2,$3,$4); $q=3D"'\''"; $r=3D~s/$=
q/$q\\$q$q/g;'\
>>> =C2=A0 -e 'print "sed -i $q${n}s!$l!$r!$q $file"' \
>>> =C2=A0| grep -vE '\.po$|pt_BR' > k
>>>
>>> Filter out s/seeked/sought/ false positives (they relate to cg-seek=
):
>>> =C2=A0 grep -vE 'seeked' k > j && mv j k
>>
>> ??
>>> diff --git a/Documentation/RelNotes/1.5.4.4.txt b/Documentation/Rel=
Notes/1.5.4.4.txt
>>> index 323c1a8..83453db 100644
>>> --- a/Documentation/RelNotes/1.5.4.4.txt
>>> +++ b/Documentation/RelNotes/1.5.4.4.txt
>>> @@ -21,7 +21,7 @@ Fixes since v1.5.4.3
>>>
>>> =C2=A0 * "git send-email" in 1.5.4.3 issued a bogus empty In-Reply-=
To: header.
>>>
>>> - * "git bisect" showed mysterious "won't bisect on seeked tree" er=
ror message.
>>> + * "git bisect" showed mysterious "won't bisect on sought tree" er=
ror message.
>>
>> ??
>
> http://en.wiktionary.org/wiki/seeked

Here is an advice to Hilco.  *THINK*

I hate people who try to be clever by just quoting without saying
anything, especially when it is very clear they didn't think the
issue.  It is irritating.

That description in the 1.5.4.4 release note is stating a HISTORICAL
=46ACT that the command in 1.5.4.3 gave that exact message.  What's
the point of changing it in the name of typofix?  It is irrelevant
if the word was misspelled; the whole point of the entry is report
what was the problem the release fixed.

What was strange to me, which is why I marked these two places with
"??", is that Jim specifically filtered out false "seeked" positives
in his procedure, but still the above somehow slipped in.

That discouraged me from applying the patch, as it means I have to
eyeball the whole thing to make sure that there aren't similar
unintended changes.
