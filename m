From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 13/16] init: allow alternate backends to be set for new
 repos
Date: Tue, 05 Jan 2016 12:26:27 -0500
Organization: Twitter
Message-ID: <1452014787.3892.40.camel@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	 <1449102921-7707-14-git-send-email-dturner@twopensource.com>
	 <567AA2DF.1020408@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 18:26:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGVNX-0000dh-Re
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 18:26:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbcAER0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 12:26:37 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:36658 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbcAER0a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 12:26:30 -0500
Received: by mail-qg0-f47.google.com with SMTP id e32so193126413qgf.3
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 09:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=m/AhWXRLOUzIqIH7hIq2iRkTUsM0yryERuMh+BjhOog=;
        b=osgm7dWbsi9mydleFDw4T2MaAtU0EhPXxIZncdACKgfR5W9u/vLGEgwmdSVhTdF6ri
         tT3361FXsbYHatBiYNCSQWccTBWTCBETeeyKP78yrjdPKKuL7q7JvWjuJpKyJmm50C+u
         uISOEYyuiXT7oQaPadhq7v0Pz9TAWH24gZ9LC/j18W5p1XchaQzPsxIHNfMOT8Z4Hqgx
         gryypJMNqWzP7qALUobmZcZLq15hlzAvj3YKRN3gAWe5i/ckDCM28fx8F0tLLVVYfCLA
         Gnnqa2TCSnQknbyeBzneFjAcZaTRwjMiQ7IYLpOmtOtTOryvytA8aXoHaoMxGsRnNMna
         z/Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=m/AhWXRLOUzIqIH7hIq2iRkTUsM0yryERuMh+BjhOog=;
        b=bpDcgHqK4WsduBJQilbEwG3ykqUMhSGTAEEaFmY4CkxibC+5UwCMBxy7kRxjhQvcYK
         OP0sl1MKyZLknHOel9Gad9JTdoHf3ieIt+5C4cnI6wRtm8xDT7UnGam1959jsSETQRrD
         PdYX6eztsT98xfCY2Os70IQY0VPv3j5YNtMCXH+SVsNUQSazB7QQ1ngFG8xpZ9pxB3xp
         o8obi8jRYgBUpoCfEbcKpZz3DVzmhEs8Ndt/8NUOkDcAqEMKfrXNwL035uzG82IpF7TJ
         QVtFw/huX6uXBhSdEXmcBdM/hT/KHkw9pf6FcyFmLqF+s/NjllDHibK2MM0rVRVm+Kpj
         ZshA==
X-Gm-Message-State: ALoCoQlHz38i2uiTu+xOZsLwyI5BIFMaQw0t/4PrPnmQ8uLEd1mEvkd540ZvK5+ggMfqAUMSZhT4HvoEQyaUN3g8wStXWX/yOw==
X-Received: by 10.140.251.11 with SMTP id w11mr72462940qhc.7.1452014789768;
        Tue, 05 Jan 2016 09:26:29 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id n83sm16243272qhn.20.2016.01.05.09.26.28
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jan 2016 09:26:28 -0800 (PST)
In-Reply-To: <567AA2DF.1020408@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283387>

On Wed, 2015-12-23 at 14:34 +0100, Michael Haggerty wrote:
> On 12/03/2015 01:35 AM, David Turner wrote:
> > git init learns a new argument --refs-backend-type.  Presently,
> > only
> > "files" is supported, but later we will add other backends.
> > 
> > When this argument is used, the repository's core.refsBackendType
> > configuration value is set, and the refs backend's initdb function
> > is
> > used to set up the ref database.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  Documentation/git-init-db.txt |  2 +-
> >  Documentation/git-init.txt    |  6 +++++-
> >  builtin/init-db.c             | 10 ++++++++++
> >  cache.h                       |  2 ++
> >  config.c                      | 20 ++++++++++++++++++++
> >  environment.c                 |  1 +
> >  path.c                        | 32 ++++++++++++++++++++++++++++++-
> > -
> >  refs.c                        |  8 ++++++++
> >  refs.h                        | 12 ++++++++++++
> >  setup.c                       | 10 ++++++++++
> >  10 files changed, 99 insertions(+), 4 deletions(-)
> > 
> > diff --git a/Documentation/git-init-db.txt b/Documentation/git-init
> > -db.txt
> > index 648a6cd..72fbd71 100644
> > --- a/Documentation/git-init-db.txt
> > +++ b/Documentation/git-init-db.txt
> > @@ -9,7 +9,7 @@ git-init-db - Creates an empty Git repository
> >  SYNOPSIS
> >  --------
> >  [verse]
> > -'git init-db' [-q | --quiet] [--bare] [-
> > -template=<template_directory>] [--separate-git-dir <git dir>] [-
> > -shared[=<permissions>]]
> > +'git init-db' [-q | --quiet] [--bare] [-
> > -template=<template_directory>] [--separate-git-dir <git dir>] [-
> > -shared[=<permissions>]] [--refs-backend-type=<name>]
> >  
> >  
> >  DESCRIPTION
> > diff --git a/Documentation/git-init.txt b/Documentation/git
> > -init.txt
> > index 8174d27..9ea6753 100644
> > --- a/Documentation/git-init.txt
> > +++ b/Documentation/git-init.txt
> > @@ -12,7 +12,7 @@ SYNOPSIS
> >  'git init' [-q | --quiet] [--bare] [-
> > -template=<template_directory>]
> >  	  [--separate-git-dir <git dir>]
> >  	  [--shared[=<permissions>]] [directory]
> > -
> > +	  [--refs-backend-type=<name>]
> 
> ISTM that "backend" (used here in this option name, and in the
> manpage)
> is not such a meaningful term to users. Could we pick a less obscure
> term? E.g., maybe "--ref-storage=<name>"?

I'm working on the rest now, but wanted to comment on this first.  I
went ahead and made this change, but I'm not sure I like it.  In the
git codebase, the concept will continue to be called "backend"; there
are already-accepted patches using that terminology.  Having two
separate names for the same thing seems confusing to me.  We have this
problem already with the index ("cache" or "staging area"), which is a
little annoying when grepping the code. 

(For refs-backend-type, the name of the config variable is a third
separate thing, where we'll have to choose between the internal and the
external name).  

So I think maybe we should just go with refs-backend here.  What do
others think?
