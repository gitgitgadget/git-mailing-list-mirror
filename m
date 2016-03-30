From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 00/21] replacement for dt/refs-backend-lmdb v7 patch
 04/33
Date: Wed, 30 Mar 2016 16:05:15 -0400
Organization: Twitter
Message-ID: <1459368315.2976.27.camel@twopensource.com>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
	 <1458802034.28595.8.camel@twopensource.com> <56F76E2C.5030700@alum.mit.edu>
	 <1459282370.2976.7.camel@twopensource.com> <56FB743C.3020902@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, peff@peff.net, pclouds@gmail.com,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 31 05:31:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alTKA-00089x-6t
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 05:31:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbcCaDbF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 23:31:05 -0400
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35929 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbcCaDbE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 23:31:04 -0400
Received: by mail-qg0-f45.google.com with SMTP id w104so50171599qge.3
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 20:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:in-reply-to:references:organization
         :date:mime-version:content-transfer-encoding;
        bh=qDnSw9e8XXzTxNpxETG1ONW4NV07lTLABEgYyhWG6Go=;
        b=VYjo+v9+TA38doT+Wa6CuGAE8/3ewN3toGuAotYeE44L9FaZlW/tldJnPgE3c/HVHy
         OemggtJan+yQqSL46P/sj7j+gmZ/gNYrLqcn94GNf8T22+2rOYbmXTQt/7OpqIR8BU+Z
         ofv8n69FhneTC/v666K2t/Bw70DDxQ3OxSGVHPMUG0Cb4o7eAWFTyQV9nMUIWjQqGy4I
         TbIbq3mEJ/Ra/QfEGEUN4T99j5jTsxKcJ4YztxYD93/PXx1l9tKM8PoG32Zn8l4WA6Z2
         2/XwoKesSPnsVAwXYjW1ntUlGQWMWBJEFMCNBF8d81R2cJS4bsuzu7wiR65YUJ9U95MG
         Dw3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:in-reply-to
         :references:organization:date:mime-version:content-transfer-encoding;
        bh=qDnSw9e8XXzTxNpxETG1ONW4NV07lTLABEgYyhWG6Go=;
        b=bPGq379hW6giX0BvA9z9iOOXBNrpcyXAGhf3CBUDlMgywFvRywGKWBoGPkuf1Buucl
         lT2Wsb3KVpATQsAsypEo7RlkA0LWMtEOcd9zICylSRYjnLA4IxjKEEMLsD+aMvk59cr9
         OdulnpJAfgzxG3HC36Bxg0cOSJPOGPO7CuKQnbRc7g9t0SXe5thVaTe/ZF9LBaNi2axD
         O9qNxDfjHxC3IqfJBC5Cj7bBe3sBjF87WZ2xuyeZqSCUjYgdqWbIkguiUR8uHztfXRVp
         MbshTwT8vE9EcWaL3qn6zyleMVJl5YmlbyY05mfl0/WPXEHFMBUESUyvZfDfJoY1aqsr
         MGZQ==
X-Gm-Message-State: AD7BkJKhcSHmg6UBVd5BdXlpUZM4+DHnMBFv5lzgemX7qIh8txHFzkGtr9MEA54LzmYAYg==
X-Received: by 10.140.20.183 with SMTP id 52mr13896366qgj.38.1459395063224;
        Wed, 30 Mar 2016 20:31:03 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id d71sm3166944qhd.18.2016.03.30.20.31.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Mar 2016 20:31:02 -0700 (PDT)
In-Reply-To: <56FB743C.3020902@alum.mit.edu>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290371>

On Wed, 2016-03-30 at 08:37 +0200, Michael Haggerty wrote:
> On 03/29/2016 10:12 PM, David Turner wrote:
> > On Sun, 2016-03-27 at 07:22 +0200, Michael Haggerty wrote:
> > > On 03/24/2016 07:47 AM, David Turner wrote:
> > > > [...]
> > > > I incorporated your changes into the lmdb backend.  To make
> > > > merging
> > > > later more convenient, I rebased on top of pu -- I think this
> > > > mainly
> > > > depends on jk/check-repository-format, but I also included some
> > > > fixes
> > > > for a couple of tests that had been changed by other patches.
> > > 
> > > I think rebasing changes on top of pu is counterproductive. I
> > > believe
> > > that Junio had extra work rebasing your earlier series onto a
> > > merge
> > > of
> > > the minimum number of topics that it really depended on. There is
> > > no
> > > way
> > > that he could merge the branch in this form because it would
> > > imply
> > > merging all of pu.
> > > 
> > > See the zeroth section of SubmittingPatches [1] for the
> > > guidelines.
> > 
> > I'm a bit confused because 
> > [PATCH 18/21] get_default_remote(): remove unneeded flag variable
> > 
> > doesn't do anything on master -- it depends on some patch in pu. 
> >  And
> > we definitely want to pick up jk/check-repository-format (which
> > doesn't
> > include whatever 18/21 depends on).
> > 
> > So what do you think our base should be?
> 
> I think the preference is to base a patch series on the merge of
> master
> plus the minimum number of topics in pu (ideally, none) that are
> "essential" prerequisites of the changes in the patch series. For
> example, the version of this patch series that Junio has in his tree
> was
> based on master + sb/submodule-parallel-update. 
>
> Even if there are minor
> conflicts with another in-flight topic, it is easier for Junio to
> resolve the conflicts when merging the topics together than to rebase
> the patch series over and over as the other patch series evolves. The
> goal of this practice is of course to allow patch series to evolve
> independently of each other as much as possible.
> 
> Of course if you have insights into nontrivial conflicts between your
> patch series and others, it would be helpful to discuss these in your
> cover letter.

If I am reading this correctly, it looks like your series also has a
few more sb submodule patches, e.g. sb/submodule-init, which is
responsible for the code that 18/21 depends on.  

I think jk/check-repository-format is also  good to get in first,
because it changes the startup sequence a bit and it's a bit tricky to
figure out what needs to change in dt/refs-backend-lmdb as a result of
it. 

But I can't just merge jk/check-repository-format on top of 71defe0047 
-- some function signatures have changed in the run-command stuff and
it seems kind of annoying to fix up.  

So I propose instead that we just drop 18/21 for now, and use just
jk/check-repository-format as the base.

Does this seem reasonable to you?
