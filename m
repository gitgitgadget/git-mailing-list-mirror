From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2] blame: add a range option to -L
Date: Tue, 04 May 2010 10:48:31 -0700 (PDT)
Message-ID: <m3bpcvftjk.fsf@localhost.localdomain>
References: <1272909995-3198-1-git-send-email-wfp5p@virginia.edu>
	<7vd3xbmv4w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Pemberton <wfp5p@virginia.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 04 19:48:41 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9MEb-0000gA-FU
	for gcvg-git-2@lo.gmane.org; Tue, 04 May 2010 19:48:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754321Ab0EDRsf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 May 2010 13:48:35 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:5482 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753330Ab0EDRse (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 May 2010 13:48:34 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1483156fgg.1
        for <git@vger.kernel.org>; Tue, 04 May 2010 10:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=lJ58r67K4GDzdlgmaZ3h3LauaazfBu6iN2XYVm6tpck=;
        b=oqPRrRYNul3deUWBnrV/tw9OAZCsqlRlccGO4Gh0TR5lWFR8xDsEEWqKCr0IJsFAdj
         gvu1ysY+gg81k0JitqqGOjd1mzLee85gNnbywXyK8W5eywG7erk8nCJVwzU7N+8/b+ru
         bYQGjwXcxLApVdD9sk8raDteZ20H5HYiNyHSg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=wxFP1YQoY5r2OIhk61UQHUPhKuE+jKtNEzMkQrv/3zmjdYji1+Q2YDomv89ceELoEN
         41XRU7ECBeaFzqTslg/g0B9fVGJHqqP0EukTUdqJ2XKUYGngLKawqVyqSNF5InZ9A6Ey
         tQI73co4qHD5R0PQHmE4nqkf8BkwNftOT6ESI=
Received: by 10.87.1.13 with SMTP id d13mr13284685fgi.29.1272995312744;
        Tue, 04 May 2010 10:48:32 -0700 (PDT)
Received: from localhost.localdomain (abvc145.neoplus.adsl.tpnet.pl [83.8.200.145])
        by mx.google.com with ESMTPS id d4sm14065111fga.15.2010.05.04.10.48.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 10:48:31 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o44HlnDJ029169;
	Tue, 4 May 2010 19:47:59 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o44HlRVk029155;
	Tue, 4 May 2010 19:47:27 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <7vd3xbmv4w.fsf@alter.siamese.dyndns.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146333>

Junio C Hamano <gitster@pobox.com> writes:

> I wonder if it makes the interface more consistent to rewrite the
> above comment like this:
> 
> 	/*
> 	 * Allow "-L <something>,+20" to mean starting at <something>
> 	 * for 20 lines; "-L <something>,-5" for 5 lines ending at
> 	 * <something>; and "-L <something>,+-5" for 5 lines around
>          * <something>.
> 	 */
> 
> and the match the code.

I like this.


The other approach would be to use -B <num> / -A <num> / -C [num], -<num>
convention from 'grep'... but git-blame uses -C and -<num> for other
things.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
