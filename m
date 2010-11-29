From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] [RFC] Use --find- instead of --detect- as prefix for
 long forms of -M and -C.
Date: Mon, 29 Nov 2010 14:42:35 -0800
Message-ID: <7vmxorzr8k.fsf@alter.siamese.dyndns.org>
References: <1289420833-20602-1-git-send-email-ydirson@altern.org>
 <1289420833-20602-2-git-send-email-ydirson@altern.org>
 <7884E3F5-D622-49E2-BEBE-12936F388C30@sb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Yann Dirson <ydirson@altern.org>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Nov 29 23:42:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PNCQu-0003wM-CF
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 23:42:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754315Ab0K2Wmr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 17:42:47 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:53783 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751790Ab0K2Wmq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 17:42:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 00D283C01;
	Mon, 29 Nov 2010 17:43:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=MUXZ1vCevm1KQzQz84FFkziESU8=; b=nN3lor
	46wXonT7P9kxrHh3ExRT3ZRrl3EhWNpQrQn1kuQFMNEQYuGvS7yQxV18rJkmghw1
	CZsQz70hsSsQC5lMgi+PpOmZgYnew8lDCMA8y80jw2zYcxZbC7xu/RyuQFaneOhA
	EQJ7khpE5pzyRECXsO6RZOpaazaxWzHiCIDno=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=p1Tcm5G33LkrhGXJlatXguzskTipQLeV
	ygIDVXsMCsL+6MS5JHrfMtiAgl4iHMIi5ZSc/Z2f/OkyhfRWfLMSoS35vspTFVpa
	E1Bx4NfL5743mdvrbia65aL21fnHJ7YCqSp9RjKrU5XsXyJPnitBjXyAIUlxYUbC
	A8Crlz+j+TU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B1B923BFE;
	Mon, 29 Nov 2010 17:42:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 436483BFD; Mon, 29 Nov 2010
 17:42:53 -0500 (EST)
In-Reply-To: <7884E3F5-D622-49E2-BEBE-12936F388C30@sb.org> (Kevin Ballard's
 message of "Thu\, 11 Nov 2010 19\:00\:05 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 03B9A4AC-FC0A-11DF-9A2E-CDEAE6EC64FC-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162435>

Kevin Ballard <kevin@sb.org> writes:

> On Nov 10, 2010, at 12:27 PM, Yann Dirson wrote:
>
>> -M[<n>]::
>> ---detect-renames[=<n>]::
>> +--find-renames[=<n>]::
>> ifndef::git-log[]
>> 	Detect renames.
>> endif::git-log[]
>> @@ -246,7 +246,7 @@ endif::git-log[]
>> 	hasn't changed.
>> 
>> -C[<n>]::
>> ---detect-copies[=<n>]::
>> +--find-copies[=<n>]::
>> 	Detect copies as well as renames.  See also `--find-copies-harder`.
>> 	If `n` is specified, it has the same meaning as for `-M<n>`.
>
> I'm not sure I like the wording --find-copies and --find-renames. Maybe I'm
> just being silly, but it sounds like those are directives, saying "I want you
> to find copies/renames", as opposed to just saying "while you're working you
> should also detect copies/renames". The original flag --find-copies-harder
> is a bit different, because it's modifying the action of finding copies
> rather than making finding copies the prime directive.
>
> On the other hand, --detect-copies and --detect-renames sounds to me like
> you're just telling it that it should, well, detect copies/renames as it goes
> about its business.

Hmm, but your "harder is different" comes from the knowledge of how it
works (namely, the set of paths the frontend feeds to diffcore is made
larger), which does not concern the end user.  Also the same logic of
yours can be applied to argue for renaming "detect renames" to "find
renames", as it _does_ tell diffcore to activate the rename finding
machinery, i.e. it is modifying the action of computing the differences.

So I think using the same verb would make sense, either by introducing a
new synonym "detect-copies-harder", or by giving longer "find-copies" and
"find-renames" options to not-so-hard ones.
