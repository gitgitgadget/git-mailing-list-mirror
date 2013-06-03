From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 FIXUP 22/25] fixup! string_list_add_refs_by_glob(): add a comment about memory management
Date: Mon, 03 Jun 2013 08:31:33 -0700
Message-ID: <7vfvwzjjmy.fsf@alter.siamese.dyndns.org>
References: <87ppwaurfy.fsf@linux-k42r.v.cablecom.net>
	<1369951551-25662-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Jun 03 17:31:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjWjV-0003x7-AK
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 17:31:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758231Ab3FCPbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 11:31:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42646 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756139Ab3FCPbg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 11:31:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E59232405E;
	Mon,  3 Jun 2013 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=12/QByJHtVLcQGoU8T2SBRdAJWI=; b=RUJT+i
	C1FlD4A6f096DorqzcDiXfeOsCoSGa8OaharkzcW4t0swQRSFsB5dlOiq/sd3/3A
	n92nL8fXpoa3DxM1WEscdDYcncJNGQtYx/jHQSbcj9LtgHCFZylvZvtW/Xc85fr0
	cgV+CEocIvHCyiVx6n8UkhKVXwvTj+MBWGhdI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=lfX/TyF+HNpjR/vouXmcrkhyabB1OdVw
	qG3jrD9fVvWruCB9FHiHmZU+tOWvJVT/RbG+iKbhed4XXcBH6d1zKamcUTah7Ihu
	gOXAiTieuk1Wx0o9mZpF5mr5jD8r3VF2lQmhKxd/MURao9YAULVettEkQYIi9pCW
	FHYRPK3hyds=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D9F742405D;
	Mon,  3 Jun 2013 15:31:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5BDD22405A;
	Mon,  3 Jun 2013 15:31:35 +0000 (UTC)
In-Reply-To: <1369951551-25662-1-git-send-email-mhagger@alum.mit.edu> (Michael
	Haggerty's message of "Fri, 31 May 2013 00:05:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: ACE20652-CC62-11E2-8725-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226224>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> ---
> Junio, would you mind squashing this patch onto mh/reflife 22/25?

Done.  Thanks.

>
>  notes.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/notes.c b/notes.c
> index 602d956..b69c0b8 100644
> --- a/notes.c
> +++ b/notes.c
> @@ -932,6 +932,7 @@ static int string_list_add_one_ref(const char *refname, const unsigned char *sha
>   */
>  void string_list_add_refs_by_glob(struct string_list *list, const char *glob)
>  {
> +	assert(list->strdup_strings);
>  	if (has_glob_specials(glob)) {
>  		for_each_glob_ref(string_list_add_one_ref, glob, list);
>  	} else {
