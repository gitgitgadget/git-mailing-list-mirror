From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 13/16] init: allow alternate backends to be set for new
 repos
Date: Tue, 05 Jan 2016 13:24:24 -0500
Organization: Twitter
Message-ID: <1452018264.3892.45.camel@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	 <1449102921-7707-14-git-send-email-dturner@twopensource.com>
	 <567AA2DF.1020408@alum.mit.edu> <1452014787.3892.40.camel@twopensource.com>
	 <xmqqk2nnkio4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 05 19:24:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGWHY-00049k-He
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jan 2016 19:24:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751857AbcAESY3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2016 13:24:29 -0500
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35827 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751631AbcAESY1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2016 13:24:27 -0500
Received: by mail-qg0-f48.google.com with SMTP id o11so284771781qge.2
        for <git@vger.kernel.org>; Tue, 05 Jan 2016 10:24:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=85zQG9tJ2fycnX+YBdTX4MXi9SnsX181Y8z9UWm3IQU=;
        b=HPzSfKe6DD3M9g9vL5Mdh6ZJOGqJbrE1NsfN3yaXY3A5Cc02s295dIEM+5m823u8W5
         joBU7+AsJdPnD0K8XZNMgKfBrSjQumy10PLXGMQ2daQ3bCSGVSOxzeEKbVjpmKbeTyq6
         biPovMIViY4mFAO8hop2kTLqJhpiVoVckn805DjFTXFNcegZhXHiBpLSbBVSp9NTvPZL
         +JkubMpgQrGu1V/Ll8vI9znH6k2VrmPaUaGtNFXmcx8VwWM453+3Pd4KdYgUEzV4YI8a
         2iEgkamRLLU+XgZ6sTmfkHojNFHpGe7qsxQTU3u6qgVdOBG+1jNbpH7QuhxhdtpHuDo3
         MwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=85zQG9tJ2fycnX+YBdTX4MXi9SnsX181Y8z9UWm3IQU=;
        b=j3xipV1rthxJqABclyNk5rDn88Azaoh1vu8/d/XOcKu+e5htkFEl+PO40JMeLnRu9J
         asb30AtFflUm8kmwru5lya84Kr7u4pcUXrp3626Fb9QsFCPPb3o5MR2dYuZwJcGU/sMh
         5WnNzWuFndrDEftlXbfw3iRAERHyUek0lH1AKU/UQKtVPSmMkZQ/C5OUcR2Hl6VWw9Lr
         53aW5mFu/iNr63FJ4KESc7RaH+oeI6BQGayDrbmeRrxok+8S13N+7kKADB2d+9AScxm/
         m4Y/yluZ8t/bz19977jWWkE7vCyOcMSOHrPnfU0U/EQrxxAJ1sdWlKubTk7MTMlD0kjp
         VF4g==
X-Gm-Message-State: ALoCoQmJcfSLOv0svx9IeLlxku6uIUTuwPuc16vuwGq442uEcDRy2C/3VChLKJeibCyDUFrz7Py2VQmEyS+Q8cIO5MGnALKW2w==
X-Received: by 10.140.29.202 with SMTP id b68mr65763774qgb.100.1452018266460;
        Tue, 05 Jan 2016 10:24:26 -0800 (PST)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id p19sm42515435qgp.9.2016.01.05.10.24.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 05 Jan 2016 10:24:25 -0800 (PST)
In-Reply-To: <xmqqk2nnkio4.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283392>

On Tue, 2016-01-05 at 10:03 -0800, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > I'm working on the rest now, but wanted to comment on this first. 
> >  I
> > went ahead and made this change, but I'm not sure I like it.  In
> > the
> > git codebase, the concept will continue to be called "backend";
> > there
> > are already-accepted patches using that terminology.  Having two
> > separate names for the same thing seems confusing to me.
> 
> We have the option to update whatever "are already-accepted" [*1*].
> That would allow us to uniformly call it "ref storage", if we wanted
> to.
> 
> In any case, we shouldn't be using an unqualified "backend" (or
> "storage" for that matter); we should always say "ref", i.e. either
> "ref backend" or "ref storage", in the name.
> 
> Between "backend" and "storage", I am slightly in favor of the
> latter, but I am not good at naming things so...
> 
> 
> [Footnote]
> 
> *1* Output from
> 
>     $ git grep backend master --
> 
> seems to show me only 
> 
>     master:refs.c: * The backend-independent part of the reference
> module.
> 
> and all others are other kinds of backends, e.g. "merge backend",
> "http-backend", etc. so that may not be too bad.

There's refs/files-backend.c in master.

I guess the argument for "backend" is that it is a better description
of the struct.  That is, "a storage" sounds funny.  Usually "storage"
is a mass noun.  I guess we could call them "storage backends" (with
"ref-storage" in the UI), which would split the difference.  I guess
I'll go with that, and we can decide later whether to rename those
files.
