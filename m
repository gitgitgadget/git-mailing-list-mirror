From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 13/16] init: allow alternate backends to be set for new
 repos
Date: Thu, 10 Dec 2015 14:36:01 -0500
Organization: Twitter
Message-ID: <1449776161.21906.1.camel@twopensource.com>
References: <1449102921-7707-1-git-send-email-dturner@twopensource.com>
	 <1449102921-7707-14-git-send-email-dturner@twopensource.com>
	 <20151210180213.GA27152@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 10 20:36:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a770d-0004He-Nx
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 20:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545AbbLJTgH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2015 14:36:07 -0500
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34940 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbbLJTgF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2015 14:36:05 -0500
Received: by padhk6 with SMTP id hk6so12068172pad.2
        for <git@vger.kernel.org>; Thu, 10 Dec 2015 11:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:content-type:mime-version:content-transfer-encoding;
        bh=eKIAywgNhAVID7Mm01SjFc59W3ZuTPUCOPlXX4Ybp+w=;
        b=P8v2hAVPfV8mZML1b7UJ5PtZ7nfQqbK/LSU3EmqC4P0jCNOnYQu+O3Mt4vaI8KPRYf
         aBwm8Mrstu6nFxT6oHIfy1HELi4WeIP9lGSwKLrEwFZNoJG8B/IYYmeTcrzjkIBt46Xn
         xdfP+8+e+HGGsepDxgWJOLRYPxTHUvr7QunhYAtSMS0eoKIFT89Upna1LkJbWmgzvd1Q
         JcEsXERsBJEbG8jPL7QuU9YLC5fvX495Uy4WbnZjbNZbbPbVgeiTdVU6N3TwVJZJMWTy
         wjpYAX5R9wL64uNAbP2NcGcZcd5rTq5xeEpA5AZPzRyCgAiTZyN/8jTKz6ljept/wqyu
         2u3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=eKIAywgNhAVID7Mm01SjFc59W3ZuTPUCOPlXX4Ybp+w=;
        b=Ryblo26E80y2QyVMmtk++Qfww2TFFew5jzcr4AhVMI7UsE9/Uz7hcarIkwn0K8K7Yj
         HFsbEW+0WVmsk5XAvp62FkYJ+hms68lA28/C2mAxOD125dKgkpfzOknkjAWntDmXx30b
         qnH7bs/YPayv48nMWmlEYKNbdhXrR5BOIoN63xf8SQa74z5V3fR5JrcqDCpnjRu1u5Et
         4m5EOsWc/ti+Gst55+aaYAxT4HVXQ5XEr0TdFVmwXKkDM/y7jd/gBPXelEDX0lnbJ01S
         QS/GKgpMTHTk23EbAIJxY5CtG1fTRAa8A68gblMYGEZTXwK+2b8lYAVmcIAPd0fjUy/k
         eUnA==
X-Gm-Message-State: ALoCoQkCuAkHTz0sqKSj0lenFzzm4NcVEINrSS8YPQRbvFZyXJcpRTZEQ/YuRUOTZvEd2o3uY+/qktyuFDZ3cYJft0hs5KFtxA==
X-Received: by 10.66.154.161 with SMTP id vp1mr19007603pab.25.1449776164357;
        Thu, 10 Dec 2015 11:36:04 -0800 (PST)
Received: from ubuntu ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id p26sm20141547pfi.94.2015.12.10.11.36.02
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Dec 2015 11:36:03 -0800 (PST)
In-Reply-To: <20151210180213.GA27152@sigill.intra.peff.net>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282227>

On Thu, 2015-12-10 at 13:02 -0500, Jeff King wrote:
> On Wed, Dec 02, 2015 at 07:35:18PM -0500, David Turner wrote:
> 
> > @@ -510,9 +511,36 @@ int validate_headref(const char *path)
> >  	unsigned char sha1[20];
> >  	int fd;
> >  	ssize_t len;
> > +	struct refdb_config_data refdb_data = {NULL, NULL};
> > +
> > +	if (lstat(path, &st) < 0) {
> > +		int backend_type_set;
> > +		struct strbuf config_path = STRBUF_INIT;
> > +		if (path) {
> > +			char *pathdup = xstrdup(path);
> > +			char *git_dir = dirname(pathdup);
> > +			strbuf_addf(&config_path, "%s/%s", git_dir, "config");
> > +			free(pathdup);
> > +		} else {
> > +			strbuf_addstr(&config_path, "config");
> > +		}
> 
> Can we ever follow this "else" branch? It would mean feeding NULL to
> lstat.

Probably cruft from an old version of the patch.  Removed if/else.
Thanks.
