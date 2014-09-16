From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 09/35] lockfile.c: document the various states of
 lock_file objects
Date: Tue, 16 Sep 2014 14:03:17 -0700
Message-ID: <20140916210317.GJ29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-10-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 16 23:03:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTzuH-0002wu-Gt
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 23:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753184AbaIPVDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 17:03:21 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:48932 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751687AbaIPVDU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 17:03:20 -0400
Received: by mail-pd0-f169.google.com with SMTP id fp1so577196pdb.28
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 14:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=55wNY/l53TD1U2f7eje5mL+AfQB1RyU72zOpIWm86dM=;
        b=t0wzehzIETxprGjPP4YJPiJhggjVPWaHI61qNwmA5AEPqZ985WsoqZrPIKBV3ButD6
         4ED2Isyx9/Sa5BQBByXLg9uJL/POLimMfQQNYFV56SWpMhNAcpO0lhoLYkIsY4y1E/vr
         Khv5KMrCbGglGWuEBgU2AqK/PSsrTLI32rRKW6wYbR8z407/I827PqK+LiguM+jg/EmQ
         rT03ib1HZFeSvDa3Kj5m5MDS+dBAbT1DoUC+rVYG0CCtVaKYp3XLXDKbMMfXtoSJZIA0
         NmpsvKnSL3zsaOZ/dT4GnFv/hZNKqGLbDbwAyRt3l14LIL0m8E6gLZBd+vS58Y2MHesz
         sEbw==
X-Received: by 10.66.222.74 with SMTP id qk10mr53117425pac.70.1410901400617;
        Tue, 16 Sep 2014 14:03:20 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id bq17sm15436136pac.47.2014.09.16.14.03.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 14:03:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-10-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257193>

Michael Haggerty wrote:

> --- a/lockfile.c
> +++ b/lockfile.c
> @@ -4,6 +4,63 @@
>  #include "cache.h"
>  #include "sigchain.h"
>
> +/*
> + * File write-locks as used by Git.
> + *
> + * When a file at $FILENAME needs to be written, it is done as
> + * follows:

This overlaps a lot with the API doc, which makes me worry a little
about it going out of date.  Would improving the API doc help, or if
aspects are especially relevant here, is there a way to summarize them
more quickly to avoid some of the redundancy?

[...]
> + * A lock_file object can be in several states:

Would it make sense for this information to go near the definition of
'struct lock_file'?  That's where I'd start if I were looking for
information on what states a lock_file can be in.

My two cents,
Jonathan
