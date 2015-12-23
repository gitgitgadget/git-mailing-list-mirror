From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 08/16] refs: add methods to init refs backend and db
Date: Wed, 23 Dec 2015 01:54:57 -0500
Organization: Twitter
Message-ID: <1450853697.3892.21.camel@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	 <1449102921-7707-9-git-send-email-dturner@twopensource.com>
	 <567A3228.2060407@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 07:55:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBdKL-0003rM-C5
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 07:55:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933346AbbLWGzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 01:55:03 -0500
Received: from mail-qk0-f174.google.com ([209.85.220.174]:36835 "EHLO
	mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933084AbbLWGzA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 01:55:00 -0500
Received: by mail-qk0-f174.google.com with SMTP id t125so157428704qkh.3
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 22:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=xxWTee5E9/Oacu3ajRMWu7WN+MsBMwAcmzQhIJmCZns=;
        b=WAIrMC0AMCjT9xkj+UNT64Al99Ex1Ci66BnpBPKDWx8nqNJKrNDgrlmotZD7dlHz1p
         gQSJC78WSX+R6rNeLlnnLPm+gbPVJnIn40GGiTgVh21v0DLqlJN2qL5vPU/uuWd5XKbh
         GQLzu/44nYuOEn7k4NgEh4jHE+yju2NJfc72HUI4uyNcefWmADlUAoOee7R8TDs6LslR
         hErLEV7QsT2+wNe4gAKMFCRT6MtgVjCJnIp9RU8/ACq6U8KmZ9iZzRGu2/u+frwjAd6N
         zppgPjdQonkriJ96ZygBdyoY3n1mtD59X/ua6EnsqcCKxOu5fOc7Gtd3K5k2s9TH4uNF
         Pi4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=xxWTee5E9/Oacu3ajRMWu7WN+MsBMwAcmzQhIJmCZns=;
        b=KDqp9WPmjo39SUar5909BUW83xPIbcmMt9z0ez+lGTfwW7MLMll+Av0cM3o9pFVFq4
         6mRzsB9kkpSsHFDiw2qgrHIamnVZOW6Sx1w2DSNd+hcguAnF/LQ+Thoc15KJii6PDLYp
         al71twvS6dl7AspDzoLOEpugeTBOf6oA2xd+45V7qeY5Fxj8Dh7DNNrhTeZYR1wq2RjI
         2AZNfdPgDlxy8brTvw4mQrtyPiCoT3QI83zsX1C+p8HctZSgwjDzbReef7A6iQwo9k8q
         dOVEKFpTRHhK27vjKBomKO8bF3TWRwOFVugJ8WnR95rqdgbrew7JtZNdRFCG8tT0y6Mb
         b3PA==
X-Gm-Message-State: ALoCoQmk/2ge8VnI18ENDioKrK17LWUQQIYDq7f/zvSmJRSxaVYAC9+G7mC7/OKCttLluWENj0N6elJH0bEW6EYzrozoA45EfQ==
X-Received: by 10.55.77.206 with SMTP id a197mr37462765qkb.43.1450853699543;
        Tue, 22 Dec 2015 22:54:59 -0800 (PST)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id f193sm17494370qhe.6.2015.12.22.22.54.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 22 Dec 2015 22:54:58 -0800 (PST)
In-Reply-To: <567A3228.2060407@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282925>

On Wed, 2015-12-23 at 06:33 +0100, Michael Haggerty wrote:
> On 12/03/2015 01:35 AM, David Turner wrote:
> > Alternate refs backends might not need the refs/heads directory and
> > so
> > on, so we make ref db initialization part of the backend.  We also
> > might need to initialize ref backends themselves, so we'll add a
> > method for that as well.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  builtin/init-db.c    | 14 ++++----------
> >  refs.c               |  8 +++++++-
> >  refs.h               |  4 +++-
> >  refs/files-backend.c | 23 +++++++++++++++++++++++
> >  refs/refs-internal.h |  4 ++++
> >  5 files changed, 41 insertions(+), 12 deletions(-)
> > 
> > [...]
> > diff --git a/refs.c b/refs.c
> > index 9a2fed7..bdeb276 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -22,13 +22,14 @@ struct ref_be *refs_backends = &refs_be_files;
> >  /*
> >   * This function is used to switch to an alternate backend.
> >   */
> > -int set_refs_backend(const char *name)
> > +int set_refs_backend(const char *name, void *data)
> 
> The purpose of the data argument is rather mysterious at this point,
> especially since set_refs_backend() still doesn't have any callers. I
> hope that will become clearer later in the series. Nevertheless, it
> would be nice for its use to be described in the docstring (which
> should
> preferably be moved to the header file).

Will fix.

> >  struct ref_be {
> >  	struct ref_be *next;
> >  	const char *name;
> > +	ref_backend_init_fn *init_backend;
> > +	ref_backend_init_db_fn *init_db;
> >  	ref_transaction_commit_fn *transaction_commit;
> >  	ref_transaction_commit_fn *initial_transaction_commit;
> >  
> > 
> 
> Your naming seems inconsistent here. I would have expected a
> "files_init_backend()" function to satisfy the typedef
> "ref_backend_init_backend_fn" or "ref_init_backend_fn", not
> "ref_backend_init_fn". Or, conversely, for the function implementing
> "ref_backend_init_fn" to be called "files_init()".
> 
> More generally, it would be nice to have a consistent naming pattern
> between (1) the name of the typedef, (2) the name of the member in
> "struct ref_be", (3) the names of concrete, backend-specific
> implementations of the functions.

I'll change this to "refs_init_backend_fn *init_backend" and
"refs_init_db_fn *init_db" (since we already have an init_db function),
and make any other similar changes I happen to notice.

On the naming in general, I am somewhat at the mercy of history here. 
 For example, git presently has functions named ref_transaction_commit
(object_verb) and create_reflog (verb_object).  So nothing I do will be
consistent with everything.  I could, of course, do some initial
commits to clean up the naming, but that would create code churn.
