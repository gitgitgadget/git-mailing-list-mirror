From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] imap-send: eliminate HMAC warnings on OS X 10.8
Date: Fri, 10 May 2013 23:27:36 -0700
Message-ID: <20130511062736.GE3394@elie>
References: <1368247406-10334-1-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>,
	Mike McCormack <mike@codeweavers.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 11 08:27:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ub3HW-0001rI-W9
	for gcvg-git-2@plane.gmane.org; Sat, 11 May 2013 08:27:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753460Ab3EKG1n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 May 2013 02:27:43 -0400
Received: from mail-ee0-f47.google.com ([74.125.83.47]:50152 "EHLO
	mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753380Ab3EKG1m (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 May 2013 02:27:42 -0400
Received: by mail-ee0-f47.google.com with SMTP id b47so2571870eek.6
        for <git@vger.kernel.org>; Fri, 10 May 2013 23:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=1jzMu2MSooY55wvxpdYDg821MYPJkGOok02az2NVfCE=;
        b=GdF8pSSjNfq4aMZMLW5NU9B9d6OceCG2UXrW2hLsAysjV+PPhM1LY2iKMu+cC1e4sH
         x9rZ8Gw2VcnU6qiEUYwAZPokIra8AIZF40Dmkd9cLTnpLDQ94FekBVcoPD46F4xDYgHL
         CBB00ni6BiBc52fs1ZIuCSiGQoJxOyQyvk/rESGtzYoeo36BKpPhYF5Ot6O9hdlyLhRX
         ww9b7xZYhuKoUMMaz3VaLVLHFEdf35INawRUUVKwgjkDhgFg1nmKtBoq2NQrGJCf+mHC
         nr4Va5NOhFpB5gdLHHMg9Ewpn+B2rBpyF7TmuRD0BYo7tkNEyieohuIHG2RhByBZ0bJD
         Y6eg==
X-Received: by 10.14.206.129 with SMTP id l1mr49708790eeo.30.1368253661419;
        Fri, 10 May 2013 23:27:41 -0700 (PDT)
Received: from elie ([213.221.117.228])
        by mx.google.com with ESMTPSA id e2sm7938875eem.16.2013.05.10.23.27.39
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 10 May 2013 23:27:40 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1368247406-10334-1-git-send-email-davvid@gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223933>

David Aguilar wrote:

> Mac OS X Mountain Lion warns that HMAC_Init() and friends are
> deprecated.  Use CommonCrypto's HMAC to eliminate the warnings.

Makes sense, and if the #define trick stops working some day
due to some conflicting macro in an openssl header some day, it
would just break the build, so this should be safe.  For what it's
worth,

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

[...]
> This builds upon the patch I sent earlier, so technically it's 2/2

I'm less sure about whether patch 1/2 is a good idea.  Luckily the
conflicts when trying to untangle the two are only textual.

Thanks,
Jonathan
