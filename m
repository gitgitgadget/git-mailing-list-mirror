From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Millisecond precision in timestamps?
Date: Wed, 28 Nov 2012 23:11:29 -0800
Message-ID: <7va9u0sx26.fsf@alter.siamese.dyndns.org>
References: <20121127204828.577264065F@snark.thyrsus.com>
 <CAJo=hJtZ+n+D4pOmeNApDeLNyZYeqnEDDYJWwSj_wLauQ+w4hQ@mail.gmail.com>
 <7vzk22lmz9.fsf@alter.siamese.dyndns.org>
 <20121127230419.GA26080@thyrsus.com>
 <CAJo=hJtOqRHcjWH1F71Qc5zvPkUAe+u1RrcC2pt_xQwLSUY0yg@mail.gmail.com>
 <20121128001231.GA27971@thyrsus.com>
 <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
 <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
 <20121128011750.GA23498@sigill.intra.peff.net>
 <7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
 <CABYiQpmEpdf3L56NYSvPWovNOs_ifqj5QctuPSMoygHyMrz8+g@mail.gmail.com>
 <CAMP44s3MPMySnwjWjzo4aRX05u05xratgiyiYJUYPmnV2WK6kQ@mail.gmail.com>
 <CABYiQpnEZECU5Vj5JzMimtw-CAJQz2d=3rii4gM6d37wCnO5AA@mail.gmail.com>
 <E4C993F4-B7A4-4CB6-A9EA-BFE98BE3A381@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Berg <merlin66b@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Eric Raymond <esr@thyrsus.com>, git <git@vger.kernel.org>
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 08:11:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TdyHk-0007mr-9V
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 08:11:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369Ab2K2HLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 02:11:33 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40839 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751100Ab2K2HLc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 02:11:32 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C59E76018;
	Thu, 29 Nov 2012 02:11:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=W1YLhJtbq4/Gy+aogq2nSmVXLWY=; b=ANV3RP
	ulM34m4SabkC49rJfL63FLps549NIWzzv16WodPPH2cd9/vTLxOdy75QhYkQpFz+
	sJ5iUWaqBotLJnqB/WIfM6xPs5R5iNdPEHQ/72p8LAeIKv8w9XnSrH/2mgbECe7c
	yFxP+rjP9oMjP6TpXP5zjUZznvtj9mE8/gDJc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=d/9EX2GO4J6GTxrD74RfSEeBT/IPTuPp
	bJ1djaDqmKnYyT4Lo1t+K6my2kYmX6HITdVE/YDwMX8bFJSfT3oZ6ko/8hCdNCs/
	1zjsQmr4NI/FqHgMtUW8yPUTUl3mt7O00mDUnxMRl70ytgyp77WXYGCtlYQ6jbi8
	amH8H6zz5qg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B216A6017;
	Thu, 29 Nov 2012 02:11:31 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 173EA6015; Thu, 29 Nov 2012
 02:11:30 -0500 (EST)
In-Reply-To: <E4C993F4-B7A4-4CB6-A9EA-BFE98BE3A381@gmail.com> (Steven
 Michalske's message of "Wed, 28 Nov 2012 19:29:21 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0019EC6A-39F4-11E2-8662-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210815>

Steven Michalske <smichalske@gmail.com> writes:

> Would having arbitrary key value pairs be useful in the git data
> model?

My answer to the question is that it is harmful to the data model,
but the benefit of going against the data model _may_ outweigh the
downside.  It is all relative.

The first of very small number of principles of the git data model
is that the object name is derived solely from the contents, hence
we can tell two different things apart with object names without
looking at object contents.

This is actively broken by adding "junk" fields left and right.
Adding arbitrary pieces of data that are optional (and largely
ignored by core operations) means you can record objects with
essentially the same contents under different object names, so
object names no longer help us telling two moral-equivalent objects
apart.

But "if two objects have different names, they are not the same"
does not have to be the only and the absolute truth in all contexts;
the world is not so black and white.  Depending on the application
and the context, you may want to treat two things that are not the
same as equivalents.

For example, at the blob level, two blob objects that store the same
text (say, one original and the other typed in double-space) would
be different objects and have different object names, but you may
want to treat them as "equivalents" (not same but interchangeable),
by applying textconv filter to normalize their contents when
comparing them.  We still keep the "two objects with different names
are different" principle, but at the same time, allow users to treat
them as equivalent in specific contexts.

Introducing a hack to exclude selective "junk" fields from hashing
done for object name computation is not a solution and is out of the
question, but that does not necessarily mean that commit objects
should never be extended with new types of header fields.  When a
commit object is made with a "junk" field, it will have a name that
is different from the one it would get without the "junk" field, but
the benefit of the ability to store extra data _may_ outweigh the
downside of having to always compare the contents of two objects
with different names to find out that they are different but
equivalent.
