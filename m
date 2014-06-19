From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: Re: [PATCH v3 0/5] cleanup duplicate name_compare() functions
Date: Thu, 19 Jun 2014 01:04:32 -0700
Message-ID: <20140619080432.GB15698@hudson.localdomain>
References: <1403117117-10384-1-git-send-email-jmmahler@gmail.com>
 <20140618191407.GX8557@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 10:04:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxXKs-0000iA-QF
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 10:04:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757562AbaFSIEi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2014 04:04:38 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:45594 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757362AbaFSIEg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2014 04:04:36 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so1648287pac.19
        for <git@vger.kernel.org>; Thu, 19 Jun 2014 01:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=NWRgs+yUz2q39/1EiVAT7wmErWrUe8KG3T9feZnx7Es=;
        b=ZehRfyaX3tZIZfXnaOsvugb7HgPumID26R5xQAxngVRPqeyCfF2WrqoEWbxym/+K/O
         /wEgJEWZBw21Hm+N+1VkgAzCAv4pKxS75FmGqwYsnI4EOSgNR+17nidohk29Ux8WeDWi
         NnouoCFDn/wSxvodyhWN4JXVz93fxCk1dIKzOZld89mkvEApG+sMXhw2FTAdwJXc8P7S
         2MAYXr5IgiJOhp1trP0ypJiAHxDC0oQ1eNm30/lFv3sYfLxVvtBasjeQ9I2kHNBeI1pO
         GxxfbllPfcAlNppJjk8v5F3piQOiR/1op0J5JCKFRfskhh5uWl+M0RNfhKgFZF73cNYB
         EAlQ==
X-Received: by 10.66.254.68 with SMTP id ag4mr3595662pad.83.1403165075817;
        Thu, 19 Jun 2014 01:04:35 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id pq3sm7153640pbb.57.2014.06.19.01.04.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jun 2014 01:04:34 -0700 (PDT)
Mail-Followup-To: Jeremiah Mahler <jmmahler@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20140618191407.GX8557@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252100>

Jonathan,

On Wed, Jun 18, 2014 at 12:14:07PM -0700, Jonathan Nieder wrote:
> Jeremiah Mahler wrote:
> 
> > Jeremiah Mahler (5):
> >   cache: rename cache_name_compare() to name_compare()
> >   tree-walk.c: remove name_compare() function
> >   unpack-trees.c: remove name_compare() function
> >   dir.c: rename to name_compare()
> >   name-hash.c: rename to name_compare()
> >
> >  cache.h        |  2 +-
> >  dir.c          |  3 +--
> >  name-hash.c    |  2 +-
> >  read-cache.c   | 23 +++++++++++++----------
> >  tree-walk.c    | 10 ----------
> >  unpack-trees.c | 11 -----------
> >  6 files changed, 16 insertions(+), 35 deletions(-)
> 
> After looking at the patches I suspect this should be a single patch.
> That way it's bisectable, and the changes outside of read-cache.c are
> small enough that it's not too much of a burden to review as a single
> patch.
> 
That would be a pain to bisect if the partial application of the patch
set left the system in a broken state.  Good suggestion.

> The code change looked good.
> 
> Thanks and hope that helps,
> Jonathan

Thanks,
-- 
Jeremiah Mahler
jmmahler@gmail.com
http://github.com/jmahler
