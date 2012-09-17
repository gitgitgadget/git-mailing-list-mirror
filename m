From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/8] Doc: Improve shallow depth wording
Date: Sun, 16 Sep 2012 22:46:24 -0700
Message-ID: <7vlig9w6a7.fsf@alter.siamese.dyndns.org>
References: <1347793083-4136-4-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitList <git@vger.kernel.org>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Sep 17 07:46:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDUAF-0003PM-V8
	for gcvg-git-2@plane.gmane.org; Mon, 17 Sep 2012 07:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751736Ab2IQFq2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 01:46:28 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45093 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750864Ab2IQFq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 01:46:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B58AC6374;
	Mon, 17 Sep 2012 01:46:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CFbXStdcVTQy+UxqaZWzVjf39Ug=; b=YZTu7T
	ZHe9e5uaKddmTePxcvBqo0XwN54tGYWU3MIfF+K7StKZTIm3DiLClkj48sqtbOsi
	mH0n/goeO7tyHSi3BgLEHar/dE5ijNoo85LMi5sGtKSxYiIedPKyzNTGsP48Ym6r
	zLOFyLEQYStxhOFvGUdGPUUpfhX57IRKcaRtQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wzEOM+qqNxSw6cB2Wzsx0bL3L3x0sNI6
	K4TPQceqAQp7dBe6GWsCml67hfcX7O1DGdpGqMXiD4Qo93PH2nwBBPumm/L6/uOu
	MhuvApYNCiprnKsKW2ScwFH9Ue9D2m0jobwMZ5LZrJSiA4PjLitbBDJxAI3QN6m6
	cJzQFtrC5Sg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A24AF6373;
	Mon, 17 Sep 2012 01:46:26 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F11CD6370; Mon, 17 Sep 2012
 01:46:25 -0400 (EDT)
In-Reply-To: <1347793083-4136-4-git-send-email-philipoakley@iee.org> (Philip
 Oakley's message of "Sun, 16 Sep 2012 11:57:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 05106E08-008B-11E2-A7A0-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205650>

Philip Oakley <philipoakley@iee.org> writes:

> Avoid confusion in compound sentence about the start of the commit set
> and the depth measure. Use two sentences.

Dropping the first ',' after "positive depth" does not seem to make
it any easier to read (I personally think it makes it a lot harder
to read).  Splitting the tail-end of the sentence into a separate
sentence does make it easier to read, though.

>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
>
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
> index 49cdc57..fa4acab 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -258,9 +258,11 @@ a positive depth, this step is skipped.
>    unshallow-line   =  PKT-LINE("unshallow" SP obj-id)
>  ----
>  
> -If the client has requested a positive depth, the server will compute
> -the set of commits which are no deeper than the desired depth, starting
> -at the client's wants. The server writes 'shallow' lines for each
> +If the client has requested a positive depth the server will compute
> +the set of commits which are no deeper than the desired depth. The set
> +of commits start at the client's wants.
> +
> +The server writes 'shallow' lines for each
>  commit whose parents will not be sent as a result. The server writes
>  an 'unshallow' line for each commit which the client has indicated is
>  shallow, but is no longer shallow at the currently requested depth
