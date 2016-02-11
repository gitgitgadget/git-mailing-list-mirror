From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 09/21] refs: add method to rename refs
Date: Thu, 11 Feb 2016 16:12:42 -0500
Organization: Twitter
Message-ID: <1455225162.29013.10.camel@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
	 <1454701462-3817-10-git-send-email-dturner@twopensource.com>
	 <56BC4D94.4040003@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 11 22:12:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTyXh-0005ge-I9
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 22:12:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbcBKVMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 16:12:45 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:32909 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbcBKVMo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 16:12:44 -0500
Received: by mail-qg0-f50.google.com with SMTP id b35so48240463qge.0
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 13:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=1hBdcEGBnRkEbA9V4pALLF01R+l4ULrAlT+1uD/9mq0=;
        b=kFs/cAjexDeW3Q7uI/qR5HHe6a6CpFDQvOWuToewQ/0U2ob8HCIZtbMw9LUrdijJbv
         rI+Sf2Y/yweF0vbVtNOxeKf4PoMuY1w1WQj/mV9beCqD0rdX/8Z2pL7oDFcOS5kpcpqh
         1AmRciuMbpD5QvIP9IcVO0YEm96VC2r/fr9+S441iFR5ANR13B01dZ+D5ZCENkomUV17
         Rm0d04Kn+Y2QUdtffc5IZoEAxech05gUNZAQTHfxbXLvOeRdDZ9BG/cmdmB+LUuO0di6
         KOER59EW4qcysE9/Ffx/AZWBcnEzMm6pW1HVK67+7q96hFC9/ci7xDA+svtKb8lkYzTi
         oLqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=1hBdcEGBnRkEbA9V4pALLF01R+l4ULrAlT+1uD/9mq0=;
        b=e/rC8hc3jyqVGdnDv5VqPGlnckgx9iZ3VAt0chclvLuAscp72mkYvqi5OhF1H1g6I1
         jpiNGqqqDP3qo5N4BI3of/gY1a1M3W03EklKUICdSCUZdbBhcm3JBn82VG10V1kQPhJJ
         CP78Tpmf3vGJR7cTwlkNJdPyO4rY6qjKXINhaIdRUpXghYm0nUDNJL0PYuqtSm1WGFG0
         IhBmH5+a+T8+E//2ZGIog15+1VqwWAwcYAGMKKfG1CpYY77l+AdtqUcYv7jKsaIMqAPY
         mWFDmiecyykbY9pPm1xLY6xKS2C6SzWJZX4vmMgTy5sPRfMQ2l60Cs1CgMHqszVS+V6C
         IYzQ==
X-Gm-Message-State: AG10YOT2HYDZQCk57Et881PV8YtVFJt1KNFxB7DURsPq4KRxgd7lBUtzEEtIt85sEgmG+w==
X-Received: by 10.140.143.68 with SMTP id 65mr62862403qhp.25.1455225163713;
        Thu, 11 Feb 2016 13:12:43 -0800 (PST)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id 7sm4136465qkw.8.2016.02.11.13.12.42
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Feb 2016 13:12:42 -0800 (PST)
In-Reply-To: <56BC4D94.4040003@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285999>

On Thu, 2016-02-11 at 10:00 +0100, Michael Haggerty wrote:
> On 02/05/2016 08:44 PM, David Turner wrote:
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  refs.c               | 5 +++++
> >  refs/files-backend.c | 4 +++-
> >  refs/refs-internal.h | 9 +++++++++
> >  3 files changed, 17 insertions(+), 1 deletion(-)
> > 
> > [...]
> > diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> > index 5768fee..15fa99c 100644
> > --- a/refs/refs-internal.h
> > +++ b/refs/refs-internal.h
> > @@ -67,6 +67,13 @@ int do_for_each_per_worktree_ref(const char
> > *submodule, const char *base,
> >  				 each_ref_fn fn, int trim, int
> > flags,
> >  				 void *cb_data);
> >  
> > +/*
> > + * Check if the new name does not conflict with any existing refs
> > + * (other than possibly the old ref).  Return 0 if the ref can be
> > + * renamed to the new name.
> > + */
> > +int rename_ref_available(const char *oldname, const char
> > *newname);
> 
> Thanks for adding a docstring for this function. But this function
> already has a declaration later in the file so you should remove one
> or
> the other.

Fixed, thanks.
