From: David Aguilar <davvid@gmail.com>
Subject: Re: [RFC PATCH v2 2/2] headers: include dependent headers
Date: Sun, 7 Sep 2014 13:30:51 -0700
Message-ID: <20140907203049.GA61326@gmail.com>
References: <1410049821-49861-1-git-send-email-davvid@gmail.com>
 <1410049821-49861-2-git-send-email-davvid@gmail.com>
 <20140907194917.GB1611@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 07 22:31:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQj78-0007MZ-9o
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 22:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbaIGUbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2014 16:31:05 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:62712 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbaIGUbE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2014 16:31:04 -0400
Received: by mail-pa0-f54.google.com with SMTP id lj1so2432564pab.41
        for <git@vger.kernel.org>; Sun, 07 Sep 2014 13:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=uduy3OWDA78jw1TQoibEi00Deg3RUtSlpnmcYyNyDwY=;
        b=UkYDYK59K/kJOEflknmY9Kp5athgQBmhdhL1e8suhIkLasfamoGXfF2b7z01at2Quh
         9tCYP5X4v5X2akRm/KBI9mGC/dy7351EFhIX8br12PSPJZ9SBzZ1QPqQDye/AtJuxY0C
         AFWbZaZ1Q6PPlqIG616InTZVyXat0ZH5ynEHXg9MGyaykdrM+kvq1q1N8QN03hOl2oom
         FHxDj42eBIaMZTXwXUKWQUvsQD4o8TdHK2XtmonPnqPQrKu1Bb+idelEMw3EjRT2IavY
         LH8zdOgM0LhleHWJ+p1O3EZja9kbcX09Rlo5Pj9u8P+uFN0ymC3vvnDd60Zg3dh9skUS
         xuZQ==
X-Received: by 10.70.89.165 with SMTP id bp5mr6600949pdb.142.1410121863669;
        Sun, 07 Sep 2014 13:31:03 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id xu4sm7554722pab.30.2014.09.07.13.31.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 07 Sep 2014 13:31:02 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140907194917.GB1611@google.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256627>

On Sun, Sep 07, 2014 at 12:49:18PM -0700, Jonathan Nieder wrote:
> David Aguilar wrote:
> 
> > Add dependent headers so that including a header does not
> > require including additional headers.
> 
> I agree with this goal, modulo the compat-util.h caveat.  Thanks
> for working on it.
> 
> [...]
> > --- a/archive.h
> > +++ b/archive.h
> > @@ -1,6 +1,7 @@
> >  #ifndef ARCHIVE_H
> >  #define ARCHIVE_H
> >  
> > +#include "cache.h"
> >  #include "pathspec.h"
> >  
> >  struct archiver_args {
> 
> I'm less happy about the way of achieving that goal.  Here's an
> alternative.  Advantages:
> 
>  * (fully expanded) headers stay small
> 
>  * fewer other headers included as a side-effect of including one
>    header, so callers are more likely to remember to #include the
>    headers defining things they need (which makes later refactoring
>    easier)
> 
>  * circular header dependencies are harder to produce
> 
> If this seems like a good direction to go in, I can finish the patch
> later today

Yes, please, that would be sweet.

Would you mind squashing in your sug to patch 1/2 as well when resending?
It seems like a nice improvement all around.

RE: pre-compiled headers -- that might be a nice follow-up to
this series. I'm not very familiar with Windows so I don't know
if it would be doable on mingw, cygwin, and msvc et al. but if
it helps other platforms then it could be a nice feature.

Thanks Jonathan,
-- 
David
