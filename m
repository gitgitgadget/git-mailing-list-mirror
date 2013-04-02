From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/5] branch --set-upstream-to error-message
 improvements
Date: Tue, 02 Apr 2013 14:50:47 -0700
Message-ID: <7vmwtga9fs.fsf@alter.siamese.dyndns.org>
References: <F58991CB-9C83-4DA6-B82B-2E6C874C30EB@gmail.com>
 <20130402172333.GB24698@sigill.intra.peff.net>
 <A4C40BCB-85DD-4BCB-8BF0-79A75DE73211@gmail.com>
 <20130402175113.GD24698@sigill.intra.peff.net>
 <20130402190134.GA17784@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Garrett Cooper <yaneurabeya@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 02 23:51:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN96t-0007Is-Bj
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 23:51:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758462Ab3DBVuu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 17:50:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40151 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756703Ab3DBVut (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 17:50:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 24FAF1256F;
	Tue,  2 Apr 2013 21:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6leJl6clWTKMmkxuzBBPKcHl46A=; b=XEN4yi
	liSWpgiePnU1JHfZoIjlVB4FO2LfgegsB/56IFrQWJN+5p8C+j1Vw2KK9RUNW7BT
	/b+x/5kDH1d3WjkOFebaecO8q04V+0LXmS1pDNfPtXBCZ2t+kzS1xJ48htGjGXcC
	GT7VqLYAj/LH7AbdBnXEuFYPtnMRA9IOAvs64=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rNJnmXXpCH0xzPonR1S2MNpVUNpofRMZ
	1VQKjZTt5PWirc72NX5p1whyDD5ekQmDDUbF4va7/07IuWRRajk93+hTzulb6wiF
	aaGGK04XptU5Qp+OGZh1B07ZDKCbOkzTcjgJR9qXXgRRi1KUGsDwE73BwR1F9+om
	0E3djG5qB5U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CDEB1256E;
	Tue,  2 Apr 2013 21:50:49 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 97DFB1256D; Tue,  2 Apr
 2013 21:50:48 +0000 (UTC)
In-Reply-To: <20130402190134.GA17784@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 2 Apr 2013 15:01:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 6142C046-9BDF-11E2-BA43-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219891>

Jeff King <peff@peff.net> writes:

> On Tue, Apr 02, 2013 at 01:51:13PM -0400, Jeff King wrote:
>
>> Things slowly improve as people make suggestions. I think the thing that
>> might have helped here is better advice when "set-upstream-to" is
>> pointed to a ref that does not exist.
>> 
>> Patches coming in a minute.
>
> Or 60 minutes. :)
>
> I'm not decided on whether the last patch is overkill or not (or even if
> it is not, whether it may end up confusing people who do not fit into
> one of the slots it suggests).

Yeah, I am uneasy about 5/5 for the same reason.  
Also I feel a bit uneasy about 1/5 as well.

>> If the user requests to --set-upstream-to a branch that does
>> not exist, then either:
>> 
>>   1. It was a typo.
>> 
>>   2. They thought the branch should exist.

Could there be the third?

    3. She planned to create a branch after setting the
       configuration.

I think it is remote (no pun intended) possibility, and I may be
worried about people's existing workflow too much (as usual).
