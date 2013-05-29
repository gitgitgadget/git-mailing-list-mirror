From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: [PATCH v2 22/25] string_list_add_refs_by_glob(): add a comment about memory management
Date: Wed, 29 May 2013 10:21:37 +0200
Message-ID: <87ppwaurfy.fsf@linux-k42r.v.cablecom.net>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu>
	<1369472904-12875-23-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"Johan Herland" <johan@herland.net>, <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed May 29 10:21:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhbdn-0002RH-Bi
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 10:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965158Ab3E2IVm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 May 2013 04:21:42 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:13905 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964992Ab3E2IVk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 May 2013 04:21:40 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Wed, 29 May
 2013 10:21:37 +0200
Received: from linux-k42r.v.cablecom.net.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Wed, 29 May 2013 10:21:37 +0200
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225775>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> Since string_list_add_one_ref() adds refname to the string list, but
> the lifetime of refname is limited, it is important that the
> string_list passed to string_list_add_one_ref() has strdup_strings
> set.  Document this fact.
>
> All current callers do the right thing.
[...]
> +/*
> + * The list argument must have strdup_strings set on it.
> + */
>  void string_list_add_refs_by_glob(struct string_list *list, const char *glob)
>  {
>  	if (has_glob_specials(glob)) {

Maybe add an assert() so that this is bulletproof?

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
