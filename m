From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Uses git-credential for git-imap-send
Date: Tue, 29 Apr 2014 10:19:05 -0700
Message-ID: <xmqqmwf4kq9i.fsf@gitster.dls.corp.google.com>
References: <20140428192349.GC25993@sigill.intra.peff.net>
	<c3bb0fb7f87e6ada5c73923b14d66c743a76caa6.1398739667.git.danalbert@google.com>
	<20140429030534.GA12118@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Albert <danalbert@google.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 29 19:19:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WfBga-0004HX-Lq
	for gcvg-git-2@plane.gmane.org; Tue, 29 Apr 2014 19:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758178AbaD2RTM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2014 13:19:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52910 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758094AbaD2RTL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2014 13:19:11 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A3DC981546;
	Tue, 29 Apr 2014 13:19:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9fl8wiY1yo+A6QyhS/WWc6Tz7SM=; b=VDUkax
	CNZpoam5cOysbZsJVJi6HBEDjh68J5msliOFQO/uUj+XRqAS0K3nXX9qDNmUzcOG
	JZoc18RD5lqdLYL0+GV5u/zvhJU+XqR8caaV/c10Q6jxLv885WMwr+RkuG9+DaD+
	rLkeKisL+p3CKMtn6ojKE0S2fPZpglKSO30rM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yp9Hf4ZDhSWhcKn7f0d9EQUWhLxMFyIf
	+OBRrjaRYyQoH4TtUe0IGnKvn8WOv06kTP8boCm4Bt7onky+esKtyDVNGfB1bfAl
	ER5mfXFPUlBSgeGytjQzv1xPajY8ndrII+Nlvt4MqkVFHw3KkxW/ElMAEySmKgTm
	CiGumeNMwd8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8387181545;
	Tue, 29 Apr 2014 13:19:10 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4653281543;
	Tue, 29 Apr 2014 13:19:07 -0400 (EDT)
In-Reply-To: <20140429030534.GA12118@sigill.intra.peff.net> (Jeff King's
	message of "Mon, 28 Apr 2014 23:05:34 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5EDD3D5A-CFC2-11E3-9956-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247594>

Jeff King <peff@peff.net> writes:

> On Mon, Apr 28, 2014 at 08:00:04PM -0700, Dan Albert wrote:
>
>> > I noticed that we are just filling in the password here, since we'll
>> > always fill cred.username from srvc->user. The lines directly above are:
>> > 
>> >         if (!srvc->user) {
>> >                 fprintf(stderr, "Skipping server %s, no user\n", srvc->host);
>> >                 goto bail;
>> >         }
>> > 
>> > That comes from the imap.user config variable. I wonder if we should
>> > just pass it off to credential_fill() in this case, too, which will fill
>> > in the username if necessary.
>> [...]
>> 
>> Yeah, doubtful anyone cares, but it's simple enough to do.
>
> Thanks, I think the result looks good.
>
> Acked-by: Jeff King <peff@peff.net>

OK, luckily I haven't merged the one from the yesterday yet, so I'll
replace ;-)

Thanks for working on this, Dan, and as always thanks for reviewing,
Peff.
