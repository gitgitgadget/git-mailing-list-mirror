From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/4] Fix misuses of "nor" in comments
Date: Fri, 21 Mar 2014 10:58:00 -0700
Message-ID: <xmqqzjkjtown.fsf@gitster.dls.corp.google.com>
References: <1395353785-23611-1-git-send-email-jlebar@google.com>
	<1395353785-23611-4-git-send-email-jlebar@google.com>
	<CAEjxke_+=v8HOi9u5Bd_CxmnWcJmaFBSjrXJF8puEp7X84H_nQ@mail.gmail.com>
	<CAMuNMfov+Z0Hx_a-hZ2ZGRdkTtw1eqUn01gWEQ+caT3VcHZkVQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Jason St. John" <jstjohn@purdue.edu>, git <git@vger.kernel.org>,
	Richard Hansen <rhansen@bbn.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Justin Lebar <jlebar@gmail.com>
To: Justin Lebar <jlebar@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 21 18:58:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WR3iA-0006On-AK
	for gcvg-git-2@plane.gmane.org; Fri, 21 Mar 2014 18:58:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbaCUR6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2014 13:58:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52355 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706AbaCUR6F (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2014 13:58:05 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 414B574CDA;
	Fri, 21 Mar 2014 13:58:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=iJxprzMTvJ5Wl1ShS4z4M8QwJSM=; b=ykGGb/
	O72nM4bdEZSwg8vyK4sI4MK82oXzlio2+TL6Y4SkvKSKYUX3le09rTvjiTWI4ODM
	MCTXvYwW1nD/I5vBnNI3n09LjnNFjGnv5B8DccD3hpimMnYiFeKWzjgOLV2AtrZt
	C48fCQb0PWMExVEmSBayfsdJi+rLSer/KnlaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pHqUB4sHzUlppJez1+7rcuFtyysQsyDG
	yTuqw5W7UUJvMS4/hDqLeUytGCGuh+ton1YndD7NTpJg/mgIDyI51+LB6Uw+IKnb
	VUMbi7rk9f12pLh5cQ1SV87diDkv/k/pwKqoqemHuw0Eome7ywRvm0CKLAxt3bWP
	7wwU7J95qhw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1C58874CD9;
	Fri, 21 Mar 2014 13:58:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 2545274CD6;
	Fri, 21 Mar 2014 13:58:04 -0400 (EDT)
In-Reply-To: <CAMuNMfov+Z0Hx_a-hZ2ZGRdkTtw1eqUn01gWEQ+caT3VcHZkVQ@mail.gmail.com>
	(Justin Lebar's message of "Thu, 20 Mar 2014 16:13:45 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 59A690C0-B122-11E3-86D9-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244711>

Justin Lebar <jlebar@google.com> writes:

> Thanks for the quick reply.
>
> When I send a new patch, should I fold these changes into the original
> commit, or should I send them as a separate commit?

While a patch is still in an early discussion stage, consider their
earlier incarnation rejected and send them afresh with [PATCH v2]
(or v3, v4,...) when rerolling.

When you do this kind of tree-wide clean-up, please make sure that
your patch applies cleanly to 'maint', 'master', 'next' and 'pu'
branches, to check if you are touching some area that are undergoing
other changes.  If you find conflicts, please remove overlapping
parts from your main patch, make the removed parts into separate
patches that can be applied on top once these other topics that are
in flight are ready to be merged.

Thanks.
