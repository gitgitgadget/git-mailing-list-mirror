From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v5 20/35] api-lockfile: document edge cases
Date: Tue, 16 Sep 2014 15:23:44 -0700
Message-ID: <20140916222344.GT29050@google.com>
References: <1410896036-12750-1-git-send-email-mhagger@alum.mit.edu>
 <1410896036-12750-21-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Sep 17 00:23:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XU1A7-0000zB-La
	for gcvg-git-2@plane.gmane.org; Wed, 17 Sep 2014 00:23:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753488AbaIPWXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2014 18:23:48 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:53639 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753046AbaIPWXr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2014 18:23:47 -0400
Received: by mail-pa0-f51.google.com with SMTP id kx10so690879pab.38
        for <git@vger.kernel.org>; Tue, 16 Sep 2014 15:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=1rzJp2n+g3FWqTfHnS0PxN/aIEm6K5FWb7WOAthj2Js=;
        b=wxbMhbVJIlFkmAZ0wkufkjLyZ0VM2KPjO1uhN2a2Wzuq3Bq30U2w6W7YKCqMNAqKZw
         ln5bBlu0aqkTPUg/+6iaC5/YVgO6ycfnRguufZeRSTufgRP33xa2dvGMF49/p163xoEB
         Ls3RKN2zK45Ap5ryXwzv2s/u0fdKiNiLyQywFVO/Az4BxAKTG8P5OMkbEfAvWVkRxGkQ
         J2GJnSYBAsHtZFV7yoj+lmViP/wGxZpVU8U7m1Ao12hrJm1iE9M966zvgldLvL0rtIU1
         srUzLP6GRA77NDtTi4MY4FQy3BeCE1rZIVGV7PWeJqYv7m99qTkjYzjv70HL9w03xzIF
         Wx8g==
X-Received: by 10.70.129.72 with SMTP id nu8mr9804494pdb.91.1410906226893;
        Tue, 16 Sep 2014 15:23:46 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id i9sm15075110pbq.17.2014.09.16.15.23.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 16 Sep 2014 15:23:46 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1410896036-12750-21-git-send-email-mhagger@alum.mit.edu>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257204>

Michael Haggerty wrote:

> * Document the behavior of commit_lock_file() when it fails, namely
>   that it rolls back the lock_file object and sets errno
>   appropriately.
>
> * Document the behavior of rollback_lock_file() when called for a
>   lock_file object that has already been committed or rolled back,
>   namely that it is a NOOP.

I think this would be easier to read in a separate error handling
section.  That way, when writing new code using the lockfile API,
I can quickly find what functions to use and quickly find out what
the error handling conventions are --- each use of the documentation
wouldn't interfere with the other.

Jonathan
