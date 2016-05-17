From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC-PATCHv6 4/4] pathspec: allow querying for attributes
Date: Tue, 17 May 2016 11:29:34 -0700
Message-ID: <xmqqeg90wnap.fsf@gitster.mtv.corp.google.com>
References: <20160517031353.23707-1-sbeller@google.com>
	<20160517031353.23707-5-sbeller@google.com>
	<xmqqvb2dxomo.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbYB_4KO+XpYa0OhAcU63Q2M2kLWa03HcxeYS1HJOgfZw@mail.gmail.com>
	<xmqq37pgy4fn.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kYbUTC7m-5kdTbvxmSkq__5BVz5x1UeieHhB4TVSqssHw@mail.gmail.com>
	<xmqqposkwofd.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kasg6zQjNLbESrP0vG5OpZ=yqMJhXqGUDtuEFdDS6=W-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue May 17 20:29:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2jkV-0001HY-6a
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 20:29:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751775AbcEQS3j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2016 14:29:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751179AbcEQS3i (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2016 14:29:38 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0FDE01A809;
	Tue, 17 May 2016 14:29:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=c8BYeFmZQVVxBECzukyP2T+VMHE=; b=Z1IWns
	oaj3XfuxtSE9TkBk7cdu3YW3eU7cKwumup6sH2c1xnJVHjDOGRu73Odjom7yv0ux
	oFQzctyuw3WHYFkmHzDRV8FsLgGB9/tOhQzIUwbGdWK++w7LhjsACxLsdIpJHqQW
	22m/5XhO5luNCxjxyZL8I9Njj0VDMwjGJmnxA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xp7/v7472O2o7M72QhAQeTj4hLrdneU4
	qsgGOJd4/7EsmWO9+YS50t5KIml+9stzraYxRSDQe6jl84vi8vhi5Sv/XuWCoV6w
	UsAHxSIP6IbdNuesW03PRKsT1S5wXFFEBAJPtQ6/Pagn27xLQl3pWJVf9rPDEsHd
	qr3brrKQYo4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 066101A808;
	Tue, 17 May 2016 14:29:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7D2BB1A807;
	Tue, 17 May 2016 14:29:36 -0400 (EDT)
In-Reply-To: <CAGZ79kasg6zQjNLbESrP0vG5OpZ=yqMJhXqGUDtuEFdDS6=W-w@mail.gmail.com>
	(Stefan Beller's message of "Tue, 17 May 2016 11:10:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 4F0E6DB0-1C5D-11E6-BF02-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294893>

Stefan Beller <sbeller@google.com> writes:

> I'll just drop support for values
> in the first series.

I do not think an exact string match to support :(attr:eol=crlf) is
so bad.  The "crazy stuff" aka over-engineering is when it goes
beyond that, e.g. 'eol is set to one of these values"
