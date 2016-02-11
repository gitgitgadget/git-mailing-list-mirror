From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v4 12/21] refs: allow log-only updates
Date: Thu, 11 Feb 2016 16:23:23 -0500
Organization: Twitter
Message-ID: <1455225803.29013.13.camel@twopensource.com>
References: <1454701462-3817-1-git-send-email-dturner@twopensource.com>
	 <1454701462-3817-13-git-send-email-dturner@twopensource.com>
	 <56BC5C8C.8060201@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git mailing list <git@vger.kernel.org>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Feb 11 22:23:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTyi5-0005yw-FY
	for gcvg-git-2@plane.gmane.org; Thu, 11 Feb 2016 22:23:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbcBKVX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Feb 2016 16:23:28 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:35795 "EHLO
	mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbcBKVX0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Feb 2016 16:23:26 -0500
Received: by mail-qk0-f176.google.com with SMTP id o6so24395362qkc.2
        for <git@vger.kernel.org>; Thu, 11 Feb 2016 13:23:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=W9odTqJXWwONEYaNJJo+iXRFK7jTmYrsnG4nzwoZ8wQ=;
        b=GOi+wZXBa8hwkj95k8wsCLBjwzbdpbUfz0lRrZYVlr+cexlXTDO2hQN7nlsSMmA6JA
         mfsSNwdQt229XbRXT3OKLX+ZqfVGo00t/OpfjcGYPKSUTRny1zg1YyoJ6wnD/5DzTbI7
         H1P8oafkC1bPidlgJ6VSiNn3Hd7tdeCQvaUFqvCfHOdD6yDuFSCEiM9vyJsH3YIFXKR3
         hraiGVnSLAcOmsptf7d6pjvETgIcz6I6kfuIlWVzo8+Dn7NL1AbUp/0N9pErTMyzWhHr
         i8V6LL29eMa6GugIf+oZx6+qJ+tXgeL4F8dOxYJwE6jifesiw9bZ8Ggkf5PaQonJ6SCj
         Q5KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=W9odTqJXWwONEYaNJJo+iXRFK7jTmYrsnG4nzwoZ8wQ=;
        b=dcSIECZVLzvY6KImKLy8q4eWA34Wa90KDVb12Q2LVjFd3qp5D2DHI3icnqx/CCS6Wg
         ma46eH2ksqknxdmhyvEI+nkgMaF0YcHY7hrFCUyhsSAoEEYK4YLy/IxZOBepuCGy5UgN
         QuRTP3ldtPJApCktaYOyEwrdCBWVQDQQPjxXM78YxTOiE4MwXjo1q8WN6hrYWvpVlLZx
         iT1IatYcDtIjm3tHmVrGZQx9D2tpGsPk+AvR1wb+whV72N6mZgyZAqO9vMocdzOmEja+
         G9YVmd6CNmNscuUL/0taDODj5H5kbPniCXvxqdaGVI9VVxmGF7Xow1AKugReJnhAyYmW
         pWSA==
X-Gm-Message-State: AG10YORbsVb2kdOEaBUv15OYeufOJnIAYzbk8CI/zsgvwvcEgVTDFvRwg9tc5pNhJF56tQ==
X-Received: by 10.55.74.86 with SMTP id x83mr58373499qka.89.1455225805477;
        Thu, 11 Feb 2016 13:23:25 -0800 (PST)
Received: from ubuntu ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id t103sm4125804qgd.37.2016.02.11.13.23.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 11 Feb 2016 13:23:24 -0800 (PST)
In-Reply-To: <56BC5C8C.8060201@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286003>

On Thu, 2016-02-11 at 11:03 +0100, Michael Haggerty wrote:
> On 02/05/2016 08:44 PM, David Turner wrote:
> > The refs infrastructure learns about log-only ref updates, which
> > only
> > update the reflog.  Later, we will use this to separate symbolic
> > reference resolution from ref updating.
> 
> This looks good. I assume it will get some testing later in the
> series.

The existing tests cover this pretty well, I think.  It's not intended
to have user-visible results, so it's hard to specifically test. 

> > [...]
> > diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> > index fc5d1db..b5d0ab8 100644
> > --- a/refs/refs-internal.h
> > +++ b/refs/refs-internal.h
> > @@ -42,6 +42,8 @@
> >   * value to ref_update::flags
> >   */
> >  
> > +#define REF_LOG_ONLY 0x80
> > +
> 
> Please add a comment explaining the meaning/purpose of this flag.

Commented, thanks.
