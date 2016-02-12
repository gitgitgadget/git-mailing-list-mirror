From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 02/21] refs: add methods for misc ref operations
Date: Thu, 11 Feb 2016 20:09:03 -0500
Organization: Twitter
Message-ID: <1455239343.29013.19.camel@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
	 <1454701462-3817-3-git-send-email-dturner@twopensource.com>
	 <56BC3C08.2080003@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 02:09:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU2ER-0001Su-Tl
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 02:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751035AbcBLBJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 20:09:07 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:32842 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976AbcBLBJF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 20:09:05 -0500
Received: by mail-qg0-f48.google.com with SMTP id b35so52211554qge.0
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 17:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=YezgYzmkqGcW/UdkrgTDMcQNiFLeOCyslBvM/ls6h4k=;
        b=xqIyWuq7rGHD1zh2QkbvMlfhxS8N3FbOUFnI5fiwuQnUYex4WbWnEWdRBX56AkZ1TU
         iOSQhtWw0t0kO34R9qywtp5HD1CwyCx/FEIxZcXwiBRLJt9EMj2yJRXw+I4WKcTK5Qaz
         UcbZt0AJVig+lo9fM6qsXDmqndntVzg4nl6xgTm5QmhBgu8FacfUk+LJUFajkXIvMpQ3
         8LlORk3KquqnYZpDUC0fGXWfFbRZxEYlEtivLavn9ljFkCAJ7GD6CD2BhAzvaxUaPgxL
         SNHqWUhKMj08zbeEkdK+zdoGM7jAjidTEkcnjOnsAaeeh1avztc2qfGhwsKGyok/2uO3
         htnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=YezgYzmkqGcW/UdkrgTDMcQNiFLeOCyslBvM/ls6h4k=;
        b=JGGXF/5fDYhobHnTTjQxBtCnThgepMxQX3DHipZCA5V1MD9V20ksOaaqXRyYhE6w8g
         we2Z8xwMji8Ln5glJ6my6A8dr9ENDXhP3rLIPA0Cs3SWQ8hHULuDjUDP99AcSSDjWRu/
         g72h3GVC74ay16TRd0TxhMcCSlyaToNVbG81lZ67oavaIgtT0qnrABS90spRh8M2cQkr
         ArpGJyMW7V0loqABrkPU/+uD4PajuEC7qS3DNJjhd6uPV3MfDLhdnxku9FrXJDcwlUQz
         BiR17vG09jdmfjFccWao7ZHJbHYChOXZbkJuuwGdE6cESbNLTd2erLwcYQaC/9KOSc7u
         mB2Q==
X-Gm-Message-State: AG10YOTjIIGaU6tkmMnMiM0LDQVu5XRk5DdV5kHElY7OOPUURZzCLQkndFFLbkhMGY+fqA==
X-Received: by 10.140.105.198 with SMTP id c64mr60128536qgf.94.1455239344740;
        Thu, 11 Feb 2016 17:09:04 -0800 (PST)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id n83sm4505758qhn.20.2016.02.11.17.09.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Feb 2016 17:09:03 -0800 (PST)
In-Reply-To: <56BC3C08.2080003@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286026>

On Thu, 2016-02-11 at 08:45 +0100, Michael Haggerty wrote:
> On 02/05/2016 08:44 PM, David Turner wrote:
> > From: Ronnie Sahlberg <sahlberg@google.com>
> > 
> > Add ref backend methods for:
> > resolve_ref_unsafe, verify_refname_available, pack_refs, peel_ref,
> > create_symref, resolve_gitlink_ref.
> > 
> > Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  builtin/init-db.c    |  1 +
> >  refs.c               | 36 ++++++++++++++++++++++++++++++++++++
> >  refs/files-backend.c | 33 +++++++++++++++++++++++----------
> >  refs/refs-internal.h | 23 +++++++++++++++++++++++
> >  4 files changed, 83 insertions(+), 10 deletions(-)
> > 
> > diff --git a/builtin/init-db.c b/builtin/init-db.c
> > index 07229d6..26e1cc3 100644
> > --- a/builtin/init-db.c
> > +++ b/builtin/init-db.c
> > @@ -8,6 +8,7 @@
> >  #include "builtin.h"
> >  #include "exec_cmd.h"
> >  #include "parse-options.h"
> > +#include "refs.h"
> 
> You can't see it in this diff's context, but there is already an
> '#include "refs.h"' in this file.

Fixed this.

I think that's all of your comments so far, but I'm going to wait for
your second batch to reroll, to avoid unnecessary churn.
