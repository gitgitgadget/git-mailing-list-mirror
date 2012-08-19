From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v4 01/16] GSOC remote-svn
Date: Sat, 18 Aug 2012 23:35:38 -0700
Message-ID: <7v1uj3qthh.fsf@alter.siamese.dyndns.org>
References: <1345235157-702-1-git-send-email-florian.achleitner.2.6.31@gmail.com>
 <7v4no0u950.fsf@alter.siamese.dyndns.org> <8572000.QUVXl8yetS@flobuntu>
 <7vzk5srm9w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Michael Barr <b@rr-dav.id.au>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 19 08:35:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2z6z-0001Gt-6v
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 08:35:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752108Ab2HSGfo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Aug 2012 02:35:44 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61963 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751786Ab2HSGfm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Aug 2012 02:35:42 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C0EC69804;
	Sun, 19 Aug 2012 02:35:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iG+TEIohWvp0fZWC0oz1lqMN3zE=; b=XD4rPU
	XoIxCPIkWWdRTh4pymip9O9nQQ2i/ZILrElYtkZNehvU/5u2FKvQqgDwXAiCtDq8
	BX5Cmo15BoMYLRbdEvnvUBML0itFEJTLVpvVxr87MyfCpH7tkqbgcAN0aF5eSM7M
	j/KZ+i+ciO+1YDCuoSphNEBY7eyQGd/r6HAxI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Uyt8njf9umWw7m0QuY1CFIhdgqs/u9wV
	RWJuU43TsZ1zQZdQB1gGDcdcOdOjrpV2tTDgvOdoM0Z4hsHyfnxPnyKrZo66D2cW
	c3pQ7g/0AxZnjDoaRGFQ6XepqBGtwpdUpTzl1ZgiPgG7AmZPhmJrp6rMOAIxJtkO
	GqtE6i5nU78=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD8BA9803;
	Sun, 19 Aug 2012 02:35:41 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EB20E9802; Sun, 19 Aug 2012
 02:35:40 -0400 (EDT)
In-Reply-To: <7vzk5srm9w.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 18 Aug 2012 13:13:47 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 186359EA-E9C8-11E1-AF33-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203710>

Junio C Hamano <gitster@pobox.com> writes:

> Florian Achleitner <florian.achleitner.2.6.31@gmail.com> writes:
>
>> On Friday 17 August 2012 21:16:59 Junio C Hamano wrote:
>>> Comments from mentors and people interested in remote helpers?
>>> 
>>> I did minimum line wrapping, typofix and small compilation fixes
>>> and queued these on 'pu'; I think I saw one commit whose message
>>> I didn't quite get what it was trying to say, and another that was
>>> missing S-o-b (I left them untouched).
>>
>> Should I provide a better version? I found the commit that I forgot to sign-
>> off, but I'm not sure which message you mean.
>
> There was a one with "E.g:" followed by an incomplete sentence that
> did not parse for me.  Can you fetch 'pu', run format-patch on your
> topic and compare the output with what you sent to the list?

Just to show how, here is what I did just now.

  (0) Store your 16-patch series and 5-patch series in a mbox;

  (1) Check where the tip of fa/vcs-svn topic is at.

      $ git log --oneline --first-parent master..pu | grep fa/
      2ce959b Merge branch 'fa/vcs-svn' into pu
      574ffe1 Merge branch 'fa/remote-svn' into pu

  (2) Check where the topic was based on.

      $ git log --oneline --first-parent master..2ce959b^2
      ...
      1385a48 Implement a remote helper for svn in C

  (3) Detach at the same base and apply the mbox from step (0).

      $ git checkout 1385a48^
      $ git am --whitespace=nowarn mbox

  (4) Format them (i.e. as the way you sent them, without my fixup)

      $ git format-patch --stdout master >./+fa-0

  (5) Format with my fixup

      $ git format-patch --stdout master..2ce959b^2 >./+fa-1

  (6) Compare them.  The differences are my fixups.

      $ diff -u ./+fa-0 ./+fa-1 | less

Patch #17 "vcs-svn: Add sha1 calculation to fast_export ..." was the
one with a sentence whose purpose was unclear to me.

By the time you see this message, the tip of "pu" may have been
updated with further updates, so please do not trust 2ce959b above.

Thanks.
