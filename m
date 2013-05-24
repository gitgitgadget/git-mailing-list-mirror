From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] diffcore-pickaxe doc: document -S and -G properly
Date: Fri, 24 May 2013 09:54:19 -0700
Message-ID: <7v8v34b9ok.fsf@alter.siamese.dyndns.org>
References: <1368793403-4642-1-git-send-email-artagnon@gmail.com>
	<1368793403-4642-3-git-send-email-artagnon@gmail.com>
	<7vfvxlw055.fsf@alter.siamese.dyndns.org>
	<7vsj1jzao7.fsf@alter.siamese.dyndns.org>
	<CALkWK0n+NTnO0_4jNuR3Z5qmA_=-Dux+gq8kNzAT4YLC12Z8uQ@mail.gmail.com>
	<CABURp0qCOMJnQ=+p81eXLtj6+zujO=MsYODx8zR_cXjVXwV=HA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 18:54:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfvG7-0001Uz-EP
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 18:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756719Ab3EXQyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 12:54:23 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41796 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756709Ab3EXQyW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 12:54:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B63D51F1E3;
	Fri, 24 May 2013 16:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qQiORHWriJmZ5B3hkpWXNY78n5c=; b=WG2rEN
	EskXSR51+g/3NWxWnvw/FyD8jlGyIgNsfytT/xafBPikkT/mDDzXlHGp7/H6jc08
	85DrxP5o6lZ7/fs33STboX2/bnsPJmN/0YdupKEnjVZObNrus5cvWtidp/d+U/Mm
	+JgmyCbOQqlNrATPBF02uG5geNIyrwG/x90PI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hEmcNa9JwQwLMen6eaklbVAOQVCjSYCs
	+QoasPj6hYy6GHxaB20p0A6RJ8HiG2i+N5xmZVWCxZcjoYrODJUF4/DPzZRcth2Z
	m8Z/M2jvpOR4Ma9W+D6bgmQ8dqukz7m/rBiUkwq/VvbhWYlu7YFpzaM3dms0A2Ho
	D6AZxCxZW1U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AA2AC1F1E2;
	Fri, 24 May 2013 16:54:21 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0C0D21F1E0;
	Fri, 24 May 2013 16:54:20 +0000 (UTC)
In-Reply-To: <CABURp0qCOMJnQ=+p81eXLtj6+zujO=MsYODx8zR_cXjVXwV=HA@mail.gmail.com>
	(Phil Hord's message of "Fri, 24 May 2013 10:58:29 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 948544CA-C492-11E2-9F09-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225381>

Phil Hord <phil.hord@gmail.com> writes:

> On Fri, May 24, 2013 at 5:37 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> Junio C Hamano wrote:
>>> [...]
>>
>> I agree with the other comments, and have made suitable changes.
>> Let's review your block now.
>>
>>>         This transformation is used to find filepairs that represent
>>>         two kinds of changes, and is controlled by the -S, -G and
>>>         --pickaxe-all options.
>>
>> Why do you call this a "transformation"?  Is git log --author="foo" a
>> transformation on the git-log output?  Then how is git log -Sfoo a
>> transformation?
>>
>> Two kinds of changes controlled by three different options?  Isn't the
>> original much clearer?
>
> They are all three filters.  They transform the output by limiting it
> to commits which meet specific conditions.  Transformation is used in
> the network-graphs sense of the word.  It fits the beginning of the
> document where it says this:
>
>   The diffcore mechanism is fed a list of such comparison results
>   (each of which is called "filepair", although at this point each
>   of them talks about a single file), and transforms such a list
>   into another list.  There are currently 5 such transformations:
>
>   - diffcore-break
>   - diffcore-rename
>   - diffcore-merge-broken
>   - diffcore-pickaxe
>   - diffcore-order

Thanks.
