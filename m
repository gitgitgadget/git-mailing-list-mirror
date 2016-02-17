From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 19/21] refs: add register_ref_storage_backends()
Date: Wed, 17 Feb 2016 15:32:52 -0500
Organization: Twitter
Message-ID: <1455741172.7528.15.camel@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
	 <1454701462-3817-20-git-send-email-dturner@twopensource.com>
	 <56BDFD4C.3050809@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 21:33:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW8mS-00035g-1W
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 21:33:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965502AbcBQUc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 15:32:56 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:36295 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965253AbcBQUcz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 15:32:55 -0500
Received: by mail-qk0-f171.google.com with SMTP id s68so10712710qkh.3
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 12:32:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=S9r/fZkT/NV02KnoD6/PAjElekkNJYS8mgNVrBG4Wr0=;
        b=bp6v0pQLjWFWDESY1MGvVNjn5TRAk4lePOVCn27ohX2yse35Nh8btbJy68zNT9XUJr
         0Yq7ZBtqkMpa0NKfLko9FDPWHj5HSiZ7DYrOn9/C8iHgy09RctTHLb9FbWr1NMQsXjHX
         7bvSVSNbaJPhgr4endDwcdygXHcEq0AF1wggY0s3wlWBVhssLSE6AA1x5flVALNNLqBq
         FjRMcMFD6Bn9pP0iB30MrvKSbXYglz/OcysQKhVtcAtITXnCCn5xAH2pNTZzoJ1jb//b
         ElnKBPV5CdVmWl6uzvn4B2QQipIID7pPvS8rM1cqzdwsn8aj78XOeEq9oyHF/2cit1ek
         yQlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=S9r/fZkT/NV02KnoD6/PAjElekkNJYS8mgNVrBG4Wr0=;
        b=HYQz1MRC7lpUe/XOurKP9HQxUTIYiXCIHFkaBmcxQlyfdUzO+tQGjfJ+b/09XP2LCX
         yUB9lt3x6tKV1hnEayxz4WrkpXD/kRrmZql5Pt4VP061eDfQ4kvHQdvr0slgvqU49uqT
         /X5mWoZ4SBrp6M0HcxX98UiMlyRtqcDCzjr1PauFcbMkh1whnBWYbuicBR1aYAnqNELm
         gLuHasRnpXCkAA7p+HgHnkK/2FjtNrSSEOAX/2pPq+jKFIFOplRKRu5nV2pb/DB43JH8
         vwB1VHwlIcwKpM5bF9OjdUyulNVO9a0OP0VrbnVUuM6/LXEM7fAbEMbLFWQhHbusgg0j
         v7wQ==
X-Gm-Message-State: AG10YOQ8+0dBRihZinz1+trTh0vtijgpk3WeiQ6lJ8ZiRkd85vQt6pC/7V3KS/TVqiYN1g==
X-Received: by 10.55.76.11 with SMTP id z11mr4385526qka.83.1455741175065;
        Wed, 17 Feb 2016 12:32:55 -0800 (PST)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id b86sm1211760qkj.29.2016.02.17.12.32.53
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 17 Feb 2016 12:32:53 -0800 (PST)
In-Reply-To: <56BDFD4C.3050809@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286545>

On Fri, 2016-02-12 at 16:42 +0100, Michael Haggerty wrote:
> On 02/05/2016 08:44 PM, David Turner wrote:
> > This new function will register all known ref storage backends...
> > once
> > there are any other than the default.  For now, it's a no-op.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  builtin/init-db.c |  3 +++
> >  config.c          | 25 +++++++++++++++++++++++++
> >  refs.c            |  8 ++++++++
> >  refs.h            |  2 ++
> >  4 files changed, 38 insertions(+)
> > 
> > [...]
> > diff --git a/config.c b/config.c
> > index b95ac3a..b9ef223 100644
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
> > @@ -1207,6 +1208,30 @@ int git_config_early(config_fn_t fn, void
> > *data, const char *repo_config)
> >  	}
> >  
> >  	if (repo_config && !access_or_die(repo_config, R_OK, 0)) {
> > +		char *storage = NULL;
> > +
> > +		/*
> > +		 * make sure we always read the ref storage config
> > +		 * from the extensions section on startup
> > +		 */
> > +		ret +=
> > git_config_from_file(ref_storage_backend_config,
> > +					    repo_config,
> > &storage);
> > +
> > +		register_ref_storage_backends();
> > +		if (!storage)
> > +			storage = xstrdup("");
> > +
> > +		if ((!*storage) ||
> > +		    (!strcmp(storage, "files"))) {
> 
> Nit: you have some unnecessary parentheses here.

Fixed, thanks.

> > +			/* default backend, nothing to do */
> > +			free(storage);
> > +		} else {
> > +			ref_storage_backend = storage;
> > +			if
> > (set_ref_storage_backend(ref_storage_backend))
> > +				die(_("Unknown ref storage backend
> > %s"),
> > +				    ref_storage_backend);
> > +		}
> > +
> >  		ret += git_config_from_file(fn, repo_config,
> > data);
> >  		found += 1;
> >  	}
> > diff --git a/refs.c b/refs.c
> > index 715a492..e50cca0 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1554,3 +1554,11 @@ done:
> >  	string_list_clear(&affected_refnames, 0);
> >  	return ret;
> >  }
> > +
> > +void register_ref_storage_backends(void) {
> > +	/*
> > +	 * No need to register the files backend; it's registered
> > by
> > +	 * default. Add register_ref_storage_backend(ptr-to
> > -backend)
> > +	 * entries below when you add a new backend.
> > +	 */
> 
> This function must be called every run, right? So why not make it
> register the "files" backend explicitly? That would make it obvious
> really quick if this function fails to get called in some code path.
> Just a thought...

Good idea.
