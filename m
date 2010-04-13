From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 5/5] describe: Break annotated tag ties by tagger date
Date: Tue, 13 Apr 2010 12:26:05 -0700
Message-ID: <7vbpdnupbm.fsf@alter.siamese.dyndns.org>
References: <20100411024008.GC23075@spearce.org>
 <1271114729-18166-5-git-send-email-spearce@spearce.org>
 <201004131132.30186.trast@student.ethz.ch>
 <20100413140830.GA12635@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Apr 13 21:26:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1lkg-0007MC-Kx
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 21:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441Ab0DMT0T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 15:26:19 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:63505 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab0DMT0S (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 15:26:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 794A4AA752;
	Tue, 13 Apr 2010 15:26:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nxex539cqY2OvV1RNMg6568dBQ0=; b=aKFUpt
	pxTSQU90k2vZkhFd256yjCfxwowguDwpRPELovJ+5rC0D3mcvKgEmeQPyR/nHCDV
	YMGSsNV7pP7h1hWFICzzsVqXqhp8xoWMhzsqDr4wNcDm9Mo3IM+uw5FckMDWTQy6
	Oq/F7iSytHvTvY3z1uZR+ir+sjbdhSB4Qi/lQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dec/uEszI7mScGHOy2gbNh69xyjYVXOK
	rQIhPu1/JBTQmGONfUv1qNdRytEhzngYlLFQirSOxU6Vw6i+afiNYkdzJXEt15KO
	uWMKOvOHz/gTJ0RXCEl73ThAozh1QkYsCPzpxLsv9o3TXyx5OtPOeLdmThWbFVs4
	8bmoOimqCjs=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 47996AA74D;
	Tue, 13 Apr 2010 15:26:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 68AD8AA74C; Tue, 13 Apr
 2010 15:26:07 -0400 (EDT)
In-Reply-To: <20100413140830.GA12635@spearce.org> (Shawn O. Pearce's message
 of "Tue\, 13 Apr 2010 07\:08\:30 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6AEDFA34-4732-11DF-924A-D033EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144826>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Thomas Rast <trast@student.ethz.ch> wrote:
>> Shawn O. Pearce wrote:
>> > If the tag is an older-style annotated tag with no tagger date,
>> > we assume a date stamp of 1 second after the UNIX epoch.
>> 
>> This patch doesn't seem to actually set this, but as a minor nit: the
>> '1 second' contradicts the 0 mentioned in the last patch.
>> 
>> (The effect is the same for all practical purposes.)
>
> Whoops.  Old commit message from v1.  I skim read it knowing I
> needed to adjust something in the message before reusing it, but
> didn't see anything, so sent it as-is.
>
> Junio, it might make sense to drop the part Thomas quoted above
> before you apply this.

Surely I can, but I am curious as to the motivation behind '1 second' in
the original patch.  If you wanted to give these '1 second' ones slight
preference over the ones with 'date stamp at the UNIX epoch', that logic
is not there anymore in the re-rolled series, no?
