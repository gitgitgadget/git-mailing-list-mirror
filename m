From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v7 07/11] refs/refs-internal.h: new header file
Date: Mon, 09 Nov 2015 16:23:55 -0500
Organization: Twitter
Message-ID: <1447104235.20147.1.camel@twopensource.com>
References: <cover.1447085798.git.mhagger@alum.mit.edu>
	 <5f62351689318a4ef9feeb3639e6a7a00b354a02.1447085798.git.mhagger@alum.mit.edu>
	 <5640F823.5010902@ramsayjones.plus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Mon Nov 09 22:24:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvtv7-0007QK-JX
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 22:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbbKIVX6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 16:23:58 -0500
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33063 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521AbbKIVX5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 16:23:57 -0500
Received: by qgea14 with SMTP id a14so74006138qge.0
        for <git@vger.kernel.org>; Mon, 09 Nov 2015 13:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=06PqYoPZNO/fKxbaETVfREMkB8J6oNd6tfdVWyE8BuY=;
        b=STuLZpC5uLkeyAE5o+9Fgp3dv0CNeTZEQd0nWlaTkueGJXkyj0Eh5tTvbL2dV7MEjJ
         LyuvrVr1/m0FRXVls0Y5u6QnsDDb/qz7iqiBDvJSNjlFU2E9LA7fb6cVLPSuapvto0iX
         sv1U0TgKWcZueZTlNXDD7ZATMuHRdw2ALWNQYlGMVR0ofHn7THqS6XEjlPnfgkTMYITZ
         eF2lWV7qMdeyHAdFCocLHFx3UaLWLZcJXYXtQ43+58yY58ucyC0nxjxZ0L1t6s1xurjB
         katHKLK5Yo9uweYal6WVzQ30Gj4AGzOks8KwyyKYPoO7os3KheY9KRJWulMe2GsoYraG
         zgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=06PqYoPZNO/fKxbaETVfREMkB8J6oNd6tfdVWyE8BuY=;
        b=AsB6JsxPJWoKItUdqIVwtKQPS3onGiRVUefJxn6An7gFWBNPqaXXVtayO0k/vvIMwr
         iQ4vpf5Y3Y79oM3EqPX/q/NOJ9kY0ZH2dUV/h5Ctoj9VLsRKISwmQty8uP2kmO6d+6A4
         gF4qrS6ATQVGoURAkwkSVxsNzKVyeeK9BULDKulPR8XWhIa6ZvTfJ6lwDe4vvM6ZAB3I
         UGJ1hgKi+s1/rKXtTia5L2XAGhYT/5P7d7fWJvPeH0XKipQ9zbkqpMC5qhaWLwp4wmhY
         aquKIBi4kIFj5vvo56uAjc3oHOgjQWTmeD5iirGZXikJdnmkJHfOYtbdAyRd2HQvZFMJ
         i7gg==
X-Gm-Message-State: ALoCoQl8oPjoIbbxHI/+DUIZsVNIX0uFNEkywpOyyj7/AcUH8GsXdj6cTlmZneItnGHX4Qr5rldD
X-Received: by 10.140.148.74 with SMTP id 71mr51803qhu.26.1447104236752;
        Mon, 09 Nov 2015 13:23:56 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id e80sm5684704qka.38.2015.11.09.13.23.55
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Nov 2015 13:23:55 -0800 (PST)
In-Reply-To: <5640F823.5010902@ramsayjones.plus.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281083>

On Mon, 2015-11-09 at 19:46 +0000, Ramsay Jones wrote:
> 
> On 09/11/15 17:03, Michael Haggerty wrote:
> > There are a number of constants, structs, and static functions defined
> > in refs.c and treated as private to the references module. But we want
> > to support multiple reference backends within the reference module,
> > and those backends will need access to some heretofore private
> > declarations.
> > 
> > We don't want those declarations to be visible to non-refs code, so we
> > don't want to move them to refs.h. Instead, add a new header file,
> > refs/refs-internal.h, that is intended to be included only from within
> > the refs module. Make some functions non-static and move some
> > declarations (and their corresponding docstrings) from refs.c to this
> > file.
> > 
> > In a moment we will add more content to the "refs" subdirectory.
> > 
> > Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> > ---
> >  refs.c               | 175 +++----------------------------------------------
> >  refs/refs-internal.h | 182 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 191 insertions(+), 166 deletions(-)
> >  create mode 100644 refs/refs-internal.h
> > 
> > diff --git a/refs.c b/refs.c
> > index f48c58a..9aff0c8 100644
> > --- a/refs.c
> > +++ b/refs.c
> > @@ -1,6 +1,6 @@
> >  #include "cache.h"
> > +#include "refs/refs-internal.h"
> >  #include "lockfile.h"
> > -#include "refs.h"
> 
> This looked wrong to me, until I had read the remainder of the
> patch and noticed that the 'internal' header #included the
> 'public' interface header.
> 
> Unfortunately, this still feels wrong to me! I would rather that
> the internal header _not_ include the public header (so, include
> them _both_ when necessary). Just my opinion, which you can simply
> ignore. :-D

+1 on this.
