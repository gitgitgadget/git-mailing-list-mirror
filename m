From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] Re: use "up-to-date" instead of "uptodate" for
 consistency
Date: Wed, 07 Jul 2010 00:18:04 -0700
Message-ID: <7vbpajzro3.fsf@alter.siamese.dyndns.org>
References: <AANLkTimvQ8_SKa_VSvQk1_c3aRVv1lZCMYNOVLXBuC4W@mail.gmail.com>
 <b49995cd151b36cfff5231b28f5e8ff3970c14a2.1278431239.git.nicolas.s.dev@gmx.fr> <7v8w5n2744.fsf@alter.siamese.dyndns.org> <20100707054621.GC13054@vidovic>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Wincent Colaiuta <win@wincent.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	git@vger.kernel.org
To: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>
X-From: git-owner@vger.kernel.org Wed Jul 07 09:18:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWOtp-0003vZ-80
	for gcvg-git-2@lo.gmane.org; Wed, 07 Jul 2010 09:18:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479Ab0GGHSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jul 2010 03:18:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:41761 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751464Ab0GGHSV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jul 2010 03:18:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C9C6C2DAE;
	Wed,  7 Jul 2010 03:18:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O40j3i6ml2KEmiKXjSDvlFM+p9s=; b=MXKhlp
	CHFL9x7UdCAGnSlIvOBf04jzK+JXF4KPfD/LXl3YliociEPQM3BlS8jFAGbZpOHi
	A/vgxLGRRuDct1N0EeVopJCMzZPrlevMixQl25iXTeZ05bHLZYo2OyhCekTttjwG
	UeMmZkrbyDVjQFbdgTaNy0TUyloI1bGzW6/X8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FN9MyHz/PXxdDWT3jFi+xGAMe4xlQsMa
	CcXQLLdmCPrQzP6dSjUwQ6CoGGwIw64Ft4hRkd8nmeOtNOOw4kYXx1ejsoU8OYqT
	10khpiYdKiAZso5YgQ7uHKNvbHTPPn58lyawTJuAHXXoAnwFyAV4AIrESY/rylHt
	hq6czwnEXmQ=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C70FBC2DA3;
	Wed,  7 Jul 2010 03:18:14 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B1135C2D97; Wed,  7 Jul
 2010 03:18:08 -0400 (EDT)
In-Reply-To: <20100707054621.GC13054@vidovic> (Nicolas Sebrecht's message of
 "Wed\, 7 Jul 2010 07\:46\:21 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: CED4D534-8997-11DF-9A24-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150455>

Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:

> The 06/07/10, Junio C Hamano wrote:
>> Nicolas Sebrecht <nicolas.s.dev@gmx.fr> writes:
>> 
>> > @@ -22,7 +22,7 @@ static struct unpack_trees_error_msgs unpack_plumbing_errors = {
>> 
>> What word do you see before "errors" on the hunk comment line?
>
> So you'd rather not touching it?

Well, "'d rather" is actually too weak a statement.

The "struct unpack_trees_error_msgs" mechanism was introduced so that we
can change the Porcelain level messages without breaking the plumbing API,
which these messages are part of.  Please see 8ccba00 (unpack-trees: allow
Porcelain to give different error messages, 2008-05-17) and fadd069
(merge-recursive: give less scary messages when merge did not start,
2009-09-07) for backstory.
