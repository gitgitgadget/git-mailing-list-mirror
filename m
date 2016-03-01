From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 29/33] setup: configure ref storage on setup
Date: Tue, 01 Mar 2016 14:16:31 -0500
Organization: Twitter
Message-ID: <1456859791.18017.78.camel@twopensource.com>
References: <1456793586-22082-1-git-send-email-dturner@twopensource.com>
	 <1456793586-22082-30-git-send-email-dturner@twopensource.com>
	 <56D5CECD.6020301@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Ramsay Jones <ramsay@ramsayjones.plus.com>, git@vger.kernel.org,
	peff@peff.net, mhagger@alum.mit.edu, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 01 20:16:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aapmh-0006Ge-JW
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 20:16:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753192AbcCATQf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2016 14:16:35 -0500
Received: from mail-qg0-f54.google.com ([209.85.192.54]:35840 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753177AbcCATQe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2016 14:16:34 -0500
Received: by mail-qg0-f54.google.com with SMTP id u110so21107860qge.3
        for <git@vger.kernel.org>; Tue, 01 Mar 2016 11:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=GJdXcd3dqKG4y3o/VQq1qIz99w6yA1cWbZ1emA6vkd8=;
        b=nMgOq1p34BZa7boSaR6ZullmtPJLCOScy1kNLIrK+eXkx/H/6k421vThC6HxGrKclr
         Vh4MTq/zo5T+eT/qlCUJ5BgE/TVHOjuFxesmKXloKZQbkVEfdBYfTrOgnEe2Piqnnndh
         FdAs3DKUnmH7FePMF3tRx91UjthWm14IrUcggkXK2D0XpXFYK/KKwh2yBPa2EONR1lmc
         62BK78sZAbqeZgsH6IYmnXVqEKFhNE6XpUVeFIY1kir01hw9EwoF7sGsNb3SuBsTN8A5
         h2avyaWyVk16nwmL2A3jhKqko2yjNgm8RBYF3TASxdVPFslFa8u+xAHl+qdNuJWF1pPt
         ECEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=GJdXcd3dqKG4y3o/VQq1qIz99w6yA1cWbZ1emA6vkd8=;
        b=datbL5+aCTxxMkNB7fcS1AK+Llypl83fw4qG9k4gCymcHp8GRIznbQY5Bb2R4PlU3M
         9ZymF5ncFd11oR86D+iw2ahvYk7eqU1vC8IZp9JJYMGOpOMYBxoB/M2Z+obbWe3lOyoq
         J4ltcND6VJe5Yqg+vpajdtQ58RajTzAYofros0CDmdsehojOD3ODf50zQQY2ARThDP84
         RczWEuWalCEik+8H0VEPHyvUPIjjxGmViv4TL7MIpKHERds8s12fKWftP1/M8+3JhIl3
         yBp1+uPcdrW/SAIhO+Ht3JJ8BqMiImIgdeF0YRZ08HfEzM8s2lZhYMoE9RKPE7C+Fr1A
         D0Sw==
X-Gm-Message-State: AD7BkJKze11Mzf5VHP5vjBY1N++OH0SncE7sCSROIFyw1lzJxSmKHOI/vmWCs4Fd+3720g==
X-Received: by 10.140.92.23 with SMTP id a23mr2961067qge.92.1456859793136;
        Tue, 01 Mar 2016 11:16:33 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id p67sm13454324qhb.7.2016.03.01.11.16.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Mar 2016 11:16:32 -0800 (PST)
In-Reply-To: <56D5CECD.6020301@ramsayjones.plus.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288055>

On Tue, 2016-03-01 at 17:18 +0000, Ramsay Jones wrote:
> 
> On 01/03/16 00:53, David Turner wrote:
> > This sets up the existing backend early, so that other code which
> > reads refs is reading from the right place.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > Signed-off-by: Junio C Hamano <gitster@pobox.com>
> > ---
> >  config.c | 1 +
> >  setup.c  | 4 ++++
> >  2 files changed, 5 insertions(+)
> > 
> > diff --git a/config.c b/config.c
> > index 9ba40bc..cca7e28 100644
> > --- a/config.c
> > +++ b/config.c
> > @@ -11,6 +11,7 @@
> >  #include "strbuf.h"
> >  #include "quote.h"
> >  #include "hashmap.h"
> > +#include "refs.h"
> >  #include "string-list.h"
> >  #include "utf8.h"
> >  
> 
> I was just skimming these patches as they passed by, and this
> caught my eye. If this include is required (eg. to fix a compiler
> warning), then it should probably be in an earlier patch.
> Otherwise, it should be in a later patch, no?

Actually, it's cruft from the previous version of this series :(.  I
looked at the patch and didn't notice that it was in config.c instead
of setup.c.  Oops.  Will remove.
