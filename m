From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] git-tag man: when to use lightweight or annotated tags
Date: Mon, 29 Jul 2013 08:04:13 -0700
Message-ID: <7v4nbd2ys2.fsf@alter.siamese.dyndns.org>
References: <51EFA9A9.4010103@gmail.com>
	<7vtxjj66kn.fsf@alter.siamese.dyndns.org> <51F12BE6.80606@gmail.com>
	<51F13A8F.9040400@xiplink.com> <51F23706.5040009@gmail.com>
	<51F2375E.1080003@gmail.com> <51F28D08.8050507@xiplink.com>
	<51F2AFBA.4020602@gmail.com> <51F2B2CD.1030004@gmail.com>
	<20130726190602.GC29799@sigill.intra.peff.net>
	<51F2E676.6080404@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Daniele Segato <daniele.segato@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 17:04:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3ozl-0004iM-CR
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 17:04:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487Ab3G2PER (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jul 2013 11:04:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55114 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486Ab3G2PEQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jul 2013 11:04:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27DCC34644;
	Mon, 29 Jul 2013 15:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IBlJELfRbn5/VlrYUn6IN0LV+eg=; b=xtDa1V
	8HHAkEqDBIC76wzJwAtff12ypKoWI3lr7KHJ1CECw6z4LYG9JWxSPOXsw0Y/pT4l
	GAPN8mHsW5WaCAxzhhH+MCvOQukwtWn8pjHaxbnh7ImYUzIM2aLfmmUoMV8aPCCW
	xrxgNXlj/DuKUW8Sl9JcbPo0pP84zMUxBRjCE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wmxEtI96FGRakkPvuANNwTRNIBHBh1+g
	n5y2J9qUdLGiAbJ80b/6qtaunANcO/af1dQj6duK/sWIgfoSTipkIKFrRqOqtKwE
	Zv6JeIH63gvGhW1TCtXKslXrS4mER1bqj1cALAsLrKZLMIQicUYpkL0RjfqC3eU4
	oeQboMpAtuw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D3AA34643;
	Mon, 29 Jul 2013 15:04:16 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 54B1234641;
	Mon, 29 Jul 2013 15:04:15 +0000 (UTC)
In-Reply-To: <51F2E676.6080404@xiplink.com> (Marc Branchaud's message of "Fri,
	26 Jul 2013 17:13:26 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 227B0958-F860-11E2-B1EC-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231286>

Marc Branchaud <marcnarc@xiplink.com> writes:

> On 13-07-26 03:06 PM, Jeff King wrote:
>> On Fri, Jul 26, 2013 at 07:33:01PM +0200, Daniele Segato wrote:
>> 
>>> stress the difference between the two with suggestion on when the user
>>> should use one in place of the other.
>>>
>>> Signed-off-by: Daniele Segato <daniele.segato@gmail.com>
>> 
>> The intent of your patch seems reasonable to me. There are a few minor
>> language and typographical mistakes, and the patch itself is
>> whitespace-damaged.
>> 
>> I also do not know that it is accurate to say "most git commands ignore
>> lightweight tags". It is really only "naming" ones like "git describe".
>> 
>> Here is a re-send of your patch with the fixups I would recommend.
>
> I'm happy with Peff's version.
>
> Reviewed-by: Marc Branchaud <marcnarc@xiplink.com>
>
> (Daniele, don't feel put off because Jonathan & I are accepting Peff's text.
>  If you think it still needs improving please speak up!)
>
> 		M.

Thank you all.  Will apply.

>
>> -- >8 --
>> From: Daniele Segato <daniele.segato@gmail.com>
>> Subject: [PATCH] docs/git-tag: explain lightweight versus annotated tags
>> 
>> Stress the difference between the two with a suggestion on
>> when the user should use one in place of the other.
>> 
>> Signed-off-by: Daniele Segato <daniele.segato@gmail.com>
>> Signed-off-by: Jeff King <peff@peff.net>
>> ---
>>  Documentation/git-tag.txt | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>> 
>> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
>> index 22894cb..c418c44 100644
>> --- a/Documentation/git-tag.txt
>> +++ b/Documentation/git-tag.txt
>> @@ -42,6 +42,17 @@ is used to specify custom GnuPG binary.
>>  GnuPG key for signing. 	The configuration variable `gpg.program`
>>  is used to specify custom GnuPG binary.
>>  
>> +Tag objects (created with `-a`, `s`, or `-u`) are called "annotated"
>> +tags; they contain a creation date, the tagger name and e-mail, a
>> +tagging message, and an optional GnuPG signature. Whereas a
>> +"lightweight" tag is simply a name for an object (usually a commit
>> +object).
>> +
>> +Annotated tags are meant for release while lightweight tags are meant
>> +for private or temporary object labels. For this reason, some git
>> +commands for naming objects (like `git describe`) will ignore
>> +lightweight tags by default.
>> +
>>  
>>  OPTIONS
>>  -------
>> 
