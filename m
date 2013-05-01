From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/2] Better advice on merge
Date: Wed, 1 May 2013 11:27:26 -0700
Message-ID: <20130501182726.GL24467@google.com>
References: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Vikrant Varma <vikrant.varma94@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 01 20:27:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXbkd-0001yf-CG
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 20:27:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555Ab3EAS1c (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 14:27:32 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:54692 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703Ab3EAS1a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 14:27:30 -0400
Received: by mail-pa0-f50.google.com with SMTP id bg2so968788pad.23
        for <git@vger.kernel.org>; Wed, 01 May 2013 11:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=HKD77qabglRSf9/k5FXwwYEyj7iFDVq16q/bPtt3QNM=;
        b=0KkpZLQnmOeib50AVpllLo0wghp0z97GpruwWrKqHJy5nHqmJQDcMK84JkDu2zbhgw
         vaWTK/gsMeFCx4/ztto+Qtt90MKn77jixy/HSeHjxo747+MHov1e75PZ/zAEl35cySVr
         Pz5eEZtEMzdpAMQijcqICAWjCyEJ+A7iZ2P8yDyjeQa3YAL5C6KyG9+DgNTWXVTdJ1lB
         4AQu4JxHraNUWQDcV1R+RZD49wuiDE01yjkOCQTprlp/VP5mr3hE4Dq70wvRhDr1opOi
         5M/Y7bCOvuB+nXUD9gjkgPIdTpxW+zPzi+r7Qx70mhsHSyzGs3Zkli0N62mbPKsjAPQ2
         k2AQ==
X-Received: by 10.66.253.34 with SMTP id zx2mr6420602pac.35.1367432850411;
        Wed, 01 May 2013 11:27:30 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dg5sm3876140pbc.29.2013.05.01.11.27.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 May 2013 11:27:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1367407327-5216-1-git-send-email-vikrant.varma94@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223112>

Vikrant Varma wrote:

> If origin/foo exists, but foo doesn't:
>
>    $ git merge foo
>    fatal: foo - not something we can merge
>
> This patch series improves the error message. If a remote branch exists 
> with the same name, it now says:
>
>      $ git merge foo
>      fatal: foo - not something we can merge
>
>      Did you mean this?
>      	 origin/foo

Fun. :)

I haven't looked at the patches closely.  My only immediate thoughts
are:

 - It would be nice to add a test under t/, so we can be sure without
   manually testing it that this new feature doesn't break in the
   future.  See t/README if interested.  I guess it would be t7613.

 - Since the first patch isn't useful without or logically separate
   from the second, this would probably be easier to read as a single
   patch.

Thanks for your work, and hope that helps.

Sincerely,
Jonathan
