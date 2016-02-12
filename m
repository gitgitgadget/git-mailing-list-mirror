From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 03/21] refs: add methods for the ref iterators
Date: Thu, 11 Feb 2016 20:08:18 -0500
Organization: Twitter
Message-ID: <1455239298.29013.18.camel@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
	 <1454701462-3817-4-git-send-email-dturner@twopensource.com>
	 <56BC4985.5070707@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>,
	git mailing list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 12 02:08:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU2Dh-0000nq-QH
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 02:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbcBLBIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 20:08:22 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:34772 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750770AbcBLBIV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 20:08:21 -0500
Received: by mail-qg0-f48.google.com with SMTP id b67so52307143qgb.1
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 17:08:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=wkIRGPDLqCO+HIZxCLHiWUQCuJzQ1BgHFBaY9HJYnxg=;
        b=DCPKrDY7rl6BfcBDD/3WwQG+s/45unvM9or5c0NswU2NwcDBr9nRt9Tu4hGwWAokDS
         2Z7ve6yQyWYH+Q3hOwkcaE7VByOKJtsQSmM/PIkH/3PaXCXG6hiJGfcE+oADAHZdJ9XF
         NEtXBAuZHseFeXqwNKP2vP3C4r+IlZuP+z+losFLaiVxVW55WdYQ1w4jfFlRgCVWabMe
         sAkz5CuHjRj0yFdwy6FX32ZigDc1sgd6qcMEyuu1peLzXEbCUeE9/DfSykAOwW1sRNbT
         +fP3fUSEf6gZLtXAW3ppdC/jpz88ZqEAqkmQ98XVPEG4ARIuilsgg/0a8ZzlAwL8bal9
         6wwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=wkIRGPDLqCO+HIZxCLHiWUQCuJzQ1BgHFBaY9HJYnxg=;
        b=hxBaa/fwsd9y2S5NqpI1248gIg/+wMfHUp1O3L/09tvtGJfHf3DSDL5hsemfeVKxUZ
         s9zczG9kV6qe9I6sJaMLSFkVH/RXqjR6/kIXMDbEDFmHGPwnYtL3y2Gkjfi3IqpzVYJb
         q87fAMJNys0IkehRInenw2SG1i4ADwEQbeMjmm8VgF6woZBSt6u3SgWbM2Gd5bbvBv9L
         BsNlvJMTQ7rhxtWt9tUWvHKnSMMRBOgkK82GrPwcvk4D0EmltQzYO6NFfa/R1RH4+5ZI
         3DuDzICGlSo/wbTKPcXRF6yPlzMN2bzWVYQyMzeQfuNCoACZSaWNtg99wHN31ZZFDjdE
         E94A==
X-Gm-Message-State: AG10YOSwUmrcx9tp9wBiPeYvtbpbgmHjNHXTUhqtXldk6bcLtA2eGU19cmg8LadY9Ze9Pw==
X-Received: by 10.140.91.109 with SMTP id y100mr59290295qgd.42.1455239300579;
        Thu, 11 Feb 2016 17:08:20 -0800 (PST)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id w75sm4523081qka.49.2016.02.11.17.08.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Feb 2016 17:08:19 -0800 (PST)
In-Reply-To: <56BC4985.5070707@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286025>

On Thu, 2016-02-11 at 09:42 +0100, Michael Haggerty wrote:
> On 02/05/2016 08:44 PM, David Turner wrote:
> > From: Ronnie Sahlberg <sahlberg@google.com>
> > 
> > Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  refs.c               | 54
> > ++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  refs/files-backend.c | 41 +++++++++++++++++++++++++++------------
> >  refs/refs-internal.h | 29 ++++++++++++++++++++++++++++
> >  3 files changed, 112 insertions(+), 12 deletions(-)
> > 
> > diff --git a/refs.c b/refs.c
> > index afdde7d..e598b73 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1158,3 +1158,57 @@ int resolve_gitlink_ref(const char *path,
> > const char *refname,
> >  {
> >  	return the_refs_backend->resolve_gitlink_ref(path,
> > refname, sha1);
> >  }
> > +
> > +int head_ref(each_ref_fn fn, void *cb_data)
> > +{
> > +	return the_refs_backend->head_ref(fn, cb_data);
> > +}
> > +
> > +int head_ref_submodule(const char *submodule, each_ref_fn fn, void
> > *cb_data)
> > +{
> > +	return the_refs_backend->head_ref_submodule(submodule, fn,
> > cb_data);
> > +}
> > +
> 
> I think it is unnecessary to have so many virtual functions. For
> example, here you have made head_ref_submodule() virtual. But the
> files
> and lmdb implementations of this function are identical. They both
> call
> do_head_ref(), which are (confusingly) two independent static
> functions.
> But those functions are *also* defined identically, namely
> 
> After all, what else would they possibly want to do? And both
> resolve_gitlink_ref() and read_ref_full() are already virtual
> functions
> (actually read_ref_full() only has a single definition but it calls
> the
> virtualized resolve_ref_unsafe()).
> 
> So it seems to me that it is unnecessary for head_ref_submodule() to
> be
> virtual, and that there only needs to be one definition of
> do_head_ref().
> 
> (Off-topic: for that matter, do_head_ref() is itself almost
> pointless.
> It could easily be inlined if we were sure that nobody passes it
> submodule==NULL.)

Added a commit to move these to common code and inline do_head_ref.

> Similarly, I bet that if do_for_each_ref() were just a little bit
> more
> capable, then the following functions could also remain non-virtual
> (i.e., one definition could be shared across all backend
> implementations):
> 
> * for_each_ref()
> ...

Yeah, that makes sense.  I think we've grown a few more of those funcs
since Ronnie's version, so virtualizing do_for_each_ref makes more
sense.
