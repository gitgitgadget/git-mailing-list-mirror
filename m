From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Fix git-svn for SVN 1.7
Date: Mon, 20 Aug 2012 21:04:49 -0700
Message-ID: <7vehn0gaam.fsf@alter.siamese.dyndns.org>
References: <1343468872-72133-1-git-send-email-schwern@pobox.com>
 <20120802103122.GA24385@dcvr.yhbt.net> <20120802160753.GA17158@copier>
 <7vy5lxce9r.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	robbat2@gentoo.org, bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue Aug 21 06:05:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3fiL-0000bg-Bz
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 06:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835Ab2HUEE7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 00:04:59 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54397 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716Ab2HUEEw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Aug 2012 00:04:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 08FF78A93;
	Tue, 21 Aug 2012 00:04:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=I3DWL5ClbKIsyH4Sp9os39dfUU4=; b=X9RYLQ
	rY7spjDB4Ji6wYlIFzeQC+YmTOLWFXuMC9L6ARNhtDFl1B34JlqF+yciE2g2NMZJ
	WtCE+YyJBs5b+jnZfwnWFcl879yP8d+UbUT4mJ3NZsRGYGBI4Qsdkkxq4r/OZdKM
	RjGBg3ziLjAzKs0ZfF76sNAQcnRvgz4MErzjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PzuhzMj2EHEo4sgjlif3FJjcomepsEz7
	2qBJ4rlIu7B+sKFwl/T3H4Dj+fJ69ixsvjLPt4q4vrtcXdTDXyqpNX1qgfsINEei
	shRvBE0UQoSTQPG0AeKTnWaJdvPUqiqVzOnIOtArYQWPTivMRdo63d7F527MUBGV
	g6bKcE0yFws=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E9AEC8A92;
	Tue, 21 Aug 2012 00:04:51 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4E4F78A91; Tue, 21 Aug 2012
 00:04:51 -0400 (EDT)
In-Reply-To: <7vy5lxce9r.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 02 Aug 2012 11:58:08 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5B350060-EB45-11E1-B1FF-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203926>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Nieder <jrnieder@gmail.com> writes:
>
>> Hi,
>>
>> Eric Wong wrote:
>>> "Michael G. Schwern" <schwern@pobox.com> wrote:
>>
>>>> This patch series fixes git-svn for SVN 1.7 tested against SVN 1.7.5 and
>>>> 1.6.18.  Patch 7/8 is where SVN 1.7 starts passing.
>>>
>>> Thanks Michael.  I've made minor editorial changes (mostly rewording
>>> commit titles to fit the larger project).
>>
>> Thanks from me as well.  I'm still worried about whether the increased
>> use of canonicalize_url will introduce regressions for the existing
>> SVN 1.6 support, and I should have time to look it over this weekend.
>
> Likewise.  I'd prefer to see it cook during the feature freeze and
> not merge to 'master' until post 1.7.12 cycle opens.

So we had a chance to cook this late topic outside 'master' during
the feature freeze.  As you already queued and signed it off, I am
going to fast-track this down to 'master' as promised.

Unless you found a reason not to in the meantime, that is.  Is what
I have on 'pu' still good, or do you (Eric and/or Michael) have any
updates you'd rather have me pull instead?

Thanks.
