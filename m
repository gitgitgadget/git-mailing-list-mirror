From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 39/43] refs: break out a ref conflict check
Date: Mon, 05 Oct 2015 20:28:34 -0400
Organization: Twitter
Message-ID: <1444091314.7739.5.camel@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	 <1443477738-32023-40-git-send-email-dturner@twopensource.com>
	 <56123DAD.9010204@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 06 02:33:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjG7V-0000MV-FB
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 02:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751900AbbJFA2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 20:28:37 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:35831 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751248AbbJFA2g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 20:28:36 -0400
Received: by qkap81 with SMTP id p81so76667005qka.2
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 17:28:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=CXzbF/hxhQrRG1gLtIxF1ENvJLGqfkFIgFpmSq2qp/Q=;
        b=PbaEYDQMECkfcZFGEbGAE+R6OOdc4XCYcxBtUKH0nYc9D/simRqQ9X/nAPuP+uRAlk
         Wt2JEynhNvbeu5xSOXhPYdLVUM3CFAgqaJeTWjQYFJO+P/ks8zH6IbfINlrLppzBXiSr
         wS+IYd1rRo6Dcj5WgYIVDARvT+/r2bYExCl/USZGnr2FHax1oPOQairUDeCwY3MO9Sjs
         d+BzGINzY2Dzdev8Hmz8wrwZYcOhPjQd9hfV4xY3lFDbXJ0yLfkz038JvXADWcxjZoRQ
         /4MJOgZAa63WvrcVpDC0IfUVbKa3QjPjtIMl5TZJijZCZyggGKYit3c2GjuOzd7ulxw6
         Vu6g==
X-Gm-Message-State: ALoCoQkH8iaKSHWVO4Dt8YHN6M85cun1T/7ARV3gcz7z2tHrKMH4WBFuw3fPcaaucd1gkvHOPJl/
X-Received: by 10.55.195.198 with SMTP id r67mr32935758qkl.10.1444091315880;
        Mon, 05 Oct 2015 17:28:35 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id 82sm12500583qhs.8.2015.10.05.17.28.35
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2015 17:28:35 -0700 (PDT)
In-Reply-To: <56123DAD.9010204@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279108>

On Mon, 2015-10-05 at 11:06 +0200, Michael Haggerty wrote:
> > +	/*
> > +	 * Check for entries in extras that start with "$refname/". We
> > +	 * do that by looking for the place where "$refname/" would be
> > +	 * inserted in extras. If there is an entry at that position
> > +	 * that starts with "$refname/" and is not in skip, then we
> > +	 * have a conflict.
> > +	 */
> 
> Would you please turn this comment (or something like it) into a
> docstring for this function in refs.h?

Yes, thanks.
