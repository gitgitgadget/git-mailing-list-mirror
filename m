From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 3/5] sha1_name.c: simplify @-parsing in get_sha1_basic()
Date: Thu, 2 May 2013 03:36:07 +0530
Message-ID: <CALkWK0kCcaQHFjR_j+=SK=ni5ZkXua6akJDYw_U9teS1u22HkQ@mail.gmail.com>
References: <1367425235-14998-1-git-send-email-artagnon@gmail.com> <1367425235-14998-4-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 02 00:06:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXfAq-0005Fy-NH
	for gcvg-git-2@plane.gmane.org; Thu, 02 May 2013 00:06:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758025Ab3EAWGt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 18:06:49 -0400
Received: from mail-ie0-f174.google.com ([209.85.223.174]:35641 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757580Ab3EAWGs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 18:06:48 -0400
Received: by mail-ie0-f174.google.com with SMTP id b11so27610iee.19
        for <git@vger.kernel.org>; Wed, 01 May 2013 15:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=99iOzJpXxYG1+0wWmLeekvCPpz3f4h2Azf+eZ+nFKjc=;
        b=Sckp6u41qHHYMB+lHTu8ZdpyELxRatD6l86S0B39Hx6MBIMLBHvfgFQDYckv6dIECp
         TLOG6CAdbHU5FPKssRscyr6/0tr+Z0EL0LZUAWcVOhPfwfkgCIGFXRm1yymhr1efxwLl
         wGb+s7R/TrJJuakqJ2SVadOXkR153FM13JyKuBQXiUkxCMVGAhuaOg7AFWy4NFrFcxxv
         GY4ONUyoqEGXS9C7NGxC2sZaty7HVV18Ycrm2khxOzWrJSiSOrLEsWmKoo+DpzKTTZ5V
         /KOGN9I9/5crz4cUexUK5GcP578ICIXETc00Dgk3F7Vzz0/MyvWlv3nDrIMrZF+m0bQd
         inlw==
X-Received: by 10.50.3.38 with SMTP id 6mr2728258igz.44.1367446007597; Wed, 01
 May 2013 15:06:47 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 1 May 2013 15:06:07 -0700 (PDT)
In-Reply-To: <1367425235-14998-4-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223152>

Ramkumar Ramachandra wrote:
> +               if (!len)
> +                       /* In the @{N} case where there's nothing
> +                        * before the @.
> +                        */
> +                       refs_found = dwim_log("HEAD", 4, sha1, &real_ref);


Minor mistake here: it should be dwim_ref, not dwim_log.  Thanks to
Junio/ Jeff for poking.
