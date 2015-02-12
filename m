From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v2 03/12] struct ref_update: move "have_old" into "flags"
Date: Thu, 12 Feb 2015 10:08:14 -0800
Message-ID: <CAGZ79kYqx8s8Cz29Qn1aBtCnDOkR-Guk4RM-_KQeO+nHWv=r8w@mail.gmail.com>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>
	<1423739543-1025-4-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 12 19:08:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLyBY-0000r6-6E
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 19:08:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751511AbbBLSIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2015 13:08:15 -0500
Received: from mail-ig0-f173.google.com ([209.85.213.173]:54751 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751160AbbBLSIP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2015 13:08:15 -0500
Received: by mail-ig0-f173.google.com with SMTP id a13so5479414igq.0
        for <git@vger.kernel.org>; Thu, 12 Feb 2015 10:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jnMSRxHYKAsO9/CpfH/AZIEUbIiC7uOE5WFlcTMjuOo=;
        b=opwqV3v9lxB0ir7zo4qZOjr2eQXnGWgdAfqpeT043wFOXuIY4kHv4jgql4i6e7Jzuf
         gww2hYQYAWltD6+VORUayZR+agDzqElOIFiPPVFavVOjbftOgu03arAyIMTVpQTMG0Gz
         O64hOLhnbWYTpO1461Qgm+0MQ2SRlY9fEF0JD5mICRYVR7Fd8VsZ4NjcVcWUB2EfF0Fm
         7wAHF8MCwKQaLoK69tpA7OEUVj9Z6AU7NVkS1r8WlJqwh/Tx3gs/f15TEASzbXP8BQPN
         UF69/H0HCM8WPxIgLGuKxfDCx5ogsF2GaTPCWNnqR1GNqlOp4NB1+e/ICBjz+UrXa/0s
         loBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=jnMSRxHYKAsO9/CpfH/AZIEUbIiC7uOE5WFlcTMjuOo=;
        b=gU47zASuzWpKOF6R1r5prmtbDdmn6/lZ8rG8QBfH0DNVfBnqQWWAQ//KstfYAX+wv7
         nwmlqy7Aftkq2ryY4G+Hrkx2KMMg9SFNn0Lwxd6fGvgOTgIaniYykxE/dbCi/c5ELEpg
         dWjN8U2HRQMQvmQIlGDiJTbDupPx8sheRqZEfvMHJiLIRszdRMzKCeSUKP+3Uc/ZYiib
         MsgjtKD7Q9rk+CFGfNPlkOLg8V26kmVUX9rUHugX8fuK9nCiHUI3XMhnOyF/Ge3jUms6
         qwyTeFTwJh/l7nivUopLXLFVda1D44IxhzKGapbDklIBkERyOqGJPwkNOz5XFrf2IUkA
         cMmA==
X-Gm-Message-State: ALoCoQndFXZs8MaQkzdbpgBkfQ7UV7Fagv50R1Jn8H6fXnVh4WcSDk9K24lJf1+W+WPhONiPYf14
X-Received: by 10.50.85.44 with SMTP id e12mr5526205igz.48.1423764494300; Thu,
 12 Feb 2015 10:08:14 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Thu, 12 Feb 2015 10:08:14 -0800 (PST)
In-Reply-To: <1423739543-1025-4-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263747>

On Thu, Feb 12, 2015 at 3:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> -       int flags; /* REF_NODEREF? */
> -       int have_old; /* 1 if old_sha1 is valid, 0 otherwise */
> +       /*
> +        * One or more of REF_HAVE_OLD, REF_NODEREF,
> +        * REF_DELETING, and REF_IS_PRUNING:
> +        */
> +       int flags;

Nit:
I'd find it more readable if it would be:
    /*
     * One or more of
     * REF_HAVE_OLD,
     * REF_NODEREF,
     * REF_DELETING,
     * REF_IS_PRUNING:
     * whose definition is found at the top of this file.
     */

With or without the nit:
Reviewed-by: Stefan Beller <sbeller@google.com>
