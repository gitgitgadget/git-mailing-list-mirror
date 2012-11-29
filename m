From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Millisecond precision in timestamps?
Date: Thu, 29 Nov 2012 08:42:40 -0800
Message-ID: <7vtxs8qs1r.fsf@alter.siamese.dyndns.org>
References: <CAMP44s3hpuxbo7mfKAD2trOkezPrV3nKYpNAzXOs3sQym102LQ@mail.gmail.com>
 <CAJo=hJuskvYaNTtCcTSqvU8YwEU=HwRpb_sqW-BSxfSr7xE57A@mail.gmail.com>
 <20121128011750.GA23498@sigill.intra.peff.net>
 <7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
 <CABYiQpmEpdf3L56NYSvPWovNOs_ifqj5QctuPSMoygHyMrz8+g@mail.gmail.com>
 <CAMP44s3MPMySnwjWjzo4aRX05u05xratgiyiYJUYPmnV2WK6kQ@mail.gmail.com>
 <CABYiQpnEZECU5Vj5JzMimtw-CAJQz2d=3rii4gM6d37wCnO5AA@mail.gmail.com>
 <E4C993F4-B7A4-4CB6-A9EA-BFE98BE3A381@gmail.com>
 <7va9u0sx26.fsf@alter.siamese.dyndns.org>
 <CAMP44s3ShoR7iR5QLYn_u+u_nNGnS1jumpt+iseWYKx0PX9UEA@mail.gmail.com>
 <20121129103847.GA9264@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Steven Michalske <smichalske@gmail.com>,
	Thomas Berg <merlin66b@gmail.com>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: esr@thyrsus.com
X-From: git-owner@vger.kernel.org Thu Nov 29 17:42:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te7CU-0004n9-Mo
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 17:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752441Ab2K2Qmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 11:42:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42414 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750846Ab2K2Qmm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 11:42:42 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3731B9986;
	Thu, 29 Nov 2012 11:42:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VA2JMK/TqIQyvWAeXdp1cg8nXYA=; b=JolZ1/
	jeXW9dLCC43KJD+igyyXdomXXPBocmXrM3TC4tXd0OGnOitn4DaNyxSZFsOZijIC
	BiI3VxHO0AWvPp8mHieGB79Gx95m+E5TwvGRijgXemt6J1mK9TTGeJhWbG0Zz/KZ
	1Vsktnwfo7W4M8GaYJh+HoH2WArWp9zGWYVYg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hyAr+t0P/nfno5f1QkPkJFKlP2RmGV1w
	opIfzMz2/nOy2eg+HkHVNugvajf/kLrmvKMV53/NlvIPZO81iPKZH7e/AWoClRux
	KPQkv83liZ/WbPMbld3b89Zz9vfcmZUhbNzguT6s7Aq81lfNxiIS5C8a+1XSVxXt
	WO7bVGn/QaM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1FC869984;
	Thu, 29 Nov 2012 11:42:42 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 84E95997D; Thu, 29 Nov 2012
 11:42:41 -0500 (EST)
In-Reply-To: <20121129103847.GA9264@thyrsus.com> (Eric S. Raymond's message
 of "Thu, 29 Nov 2012 05:38:47 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CAE60CC2-3A43-11E2-8B3C-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210844>

"Eric S. Raymond" <esr@thyrsus.com> writes:

> Felipe Contreras <felipe.contreras@gmail.com>:
>> On Thu, Nov 29, 2012 at 8:11 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> > Steven Michalske <smichalske@gmail.com> writes:
>> >
>> >> Would having arbitrary key value pairs be useful in the git data
>> >> model?
>> >
>> > My answer to the question is that it is harmful to the data model,
>> > but the benefit of going against the data model _may_ outweigh the
>> > downside.  It is all relative.
>
> My use case for a capability like this is one of the more common ones.
> I want to be able to store a fossil commit-ID inherited from another
> VCS outside the commit comment.

That is exactly why I said it is all relative.  If it helps your
application, you can weigh the pros-and-cons yourself and choose to
throw "junk" extended header fields in the commit objects you
create, using hash-object (or commit-tree).  You can read it out
using cat-file and do whatever you want to do with it, and modern
Git (v1.5.0 was from early 2007) and tools that are designed to work
with Git know to ignore such "junk" field.

> The absence of a key/value store forces me into some annoying
> kludges.

Do not do annoying kludge, then.  Come up with a method to encode
your list of (key,value) tuples into a single string, throw a
custom extra header after all the standard header fields in, perhaps
like this:

    tree 0664b9c82d87269b335ff78f32d0e4a504f58cfc
    author A U Thor <author@example.xz> 1355999999 +0900
    committer C O Mitter <committer@example.xz> 1355999999 +0900
    encoding iso-2022-jp
    reposurgeon-metadata your-serialized-list-of-key-value-tuples
     second-line-of-such-serialization
     third-line-of-such-serialization

    My first commit

    Signed-off-by: A U Thor <author@example.xz>
    Signed-off-by: C O Mitter <committer@example.xz>
