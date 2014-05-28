From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v11 13/41] refs.c: change ref_transaction_create to do
 error checking and return status
Date: Wed, 28 May 2014 11:09:45 -0700
Message-ID: <20140528180945.GQ12314@google.com>
References: <1401222360-21175-1-git-send-email-sahlberg@google.com>
 <1401222360-21175-14-git-send-email-sahlberg@google.com>
 <20140528004200.GK12314@google.com>
 <CAL=YDWkQhq2oCkyBG0-ojUDwgApYj1qZt1vXa2gnYsJOEbnvxQ@mail.gmail.com>
 <20140528170700.GM12314@google.com>
 <CAL=YDWnZQajozAcjLi85xKgkRazScv0Q_5XoVvV47u7AumL2gg@mail.gmail.com>
 <20140528172507.GO12314@google.com>
 <CAL=YDW=-FFB=8u7TxMJf_bxeDF2L_AiqS6ST293ZGc6MO=Az_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Wed May 28 20:09:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WpiIT-0002rp-Ne
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 20:09:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751353AbaE1SJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2014 14:09:49 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:47474 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbaE1SJs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 14:09:48 -0400
Received: by mail-pa0-f45.google.com with SMTP id ey11so11413576pad.18
        for <git@vger.kernel.org>; Wed, 28 May 2014 11:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=S+VKVt6mHM6/cNnOFd//FQQfm2xCDL09qAfdvSrDGB0=;
        b=PV4SQgGmjrhaen0kL9YIx+3uq5dpZsStJAaAGWYwgJmex+gIO3V98eC8Aw9QyUZntK
         lSnoyHhBFm6kVV5pcTBtJ8hSRUfr9evPp2kzde3nlXkGSiKAmzzltiYVu2s4DZwl99CH
         UpsVaJsNW2RxgEn0h1eljaLDoeh+H8jaztrkloAEP0Mvgz6Ri1cy1qMlUb522/Of753O
         F+g39+e32YNVTjkgWEWPLTo3SrHatyE9xLMiX5R1UqqsfkanGPrVubCl0N06qniPrZbd
         i//rnAsfF9CM9t3ZC2yoD2V6dx6UAanBwR7rPWy9swBajlH5749Wdn5shPoF6XUunMHz
         UBEA==
X-Received: by 10.68.194.134 with SMTP id hw6mr1548443pbc.49.1401300588115;
        Wed, 28 May 2014 11:09:48 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id ry10sm91933203pab.38.2014.05.28.11.09.47
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 28 May 2014 11:09:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAL=YDW=-FFB=8u7TxMJf_bxeDF2L_AiqS6ST293ZGc6MO=Az_A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250304>

Ronnie Sahlberg wrote:

> Can you re-review these patches for me :
>
> please review
>
> 67b8fce refs.c: add an err argument to repack_without_refs
> 738ac43 refs.c: add an err argument to delete_ref_loose
> b78b0e0 refs.c: update ref_transaction_delete to check for error and
> return status
> e558f96 refs.c: add transaction.status and track OPEN/CLOSED/ERROR
> 5a7d9bf sequencer.c: use ref transactions for all ref updates
> 0ea69df fast-import.c: change update_branch to use ref transactions
> 57c92fb refs.c: change update_ref to use a transaction

The easiest way for me is if you send them to the list so I can
comment inline (and others can chime in with other comments, etc).
This works like a reroll of an entire series (using format-patch -v if
you use format-patch, etc) except that instead of sending as a new
thread the updated patch is just sent in response to some review
comments or the earlier version of that patch.

git send-email has an --in-reply-to option for this.  That involves
getting the Message-Id, which can be a little fussy.

Others who use send-email might know better tricks for this.  I never
ended up learning how to use git send-email (and I'm a little scared
of it) so I just hit "reply" in mutt and put the patch there.

Thanks and sorry for the fuss,
Jonathan
