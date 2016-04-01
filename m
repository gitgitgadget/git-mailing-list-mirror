From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH 00/21] replacement for dt/refs-backend-lmdb v7 patch
 04/33
Date: Fri, 01 Apr 2016 13:55:14 -0400
Organization: Twitter
Message-ID: <1459533314.2976.40.camel@twopensource.com>
References: <cover.1458723959.git.mhagger@alum.mit.edu>
	 <1458802034.28595.8.camel@twopensource.com> <56F76E2C.5030700@alum.mit.edu>
	 <1459282370.2976.7.camel@twopensource.com> <56FB743C.3020902@alum.mit.edu>
	 <1459368315.2976.27.camel@twopensource.com>
	 <CAGZ79katAVbd6mMSu2Kt1SnH2f3Ujn0L4-bH82bwLudzboCyTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 19:55:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am3I3-0002Ms-7w
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 19:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751972AbcDARzT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 13:55:19 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34223 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751732AbcDARzR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 13:55:17 -0400
Received: by mail-qg0-f46.google.com with SMTP id n34so94467950qge.1
        for <git@vger.kernel.org>; Fri, 01 Apr 2016 10:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=pCKSpp4z7ph/+e+kP4/CwJwFa/00JTNZohHPFZ6sPqE=;
        b=pJQCpKfNhIC+GO7/5rb4CAWFMeqDJwwlgPSIAgf5RnrBI/qkUO9wZJxAdw2WC9ahHl
         Ry8QgtzJmGefVcFJCRUZ2KgJZxEwCNtTuuT7vnwVSwq1DVNidbJSWZKwarn6ke8BkzGf
         HRecg0TXfqn8krGSWsxO9fAmlrP58VWX4bVycF9wqAIdjJqVnd4dJe5j8zrQqImxnS6Z
         GaNheOiTLVBql3ed37T/4D9xbG4YwmJQDdMkOqjwRZYcFDL7rXH4hgL2RJFMLyM+QyTs
         2pESsfRurIQXtevr9lb8wwqC0LTzQp4fW1vVbxDx4sL0hlNIfGZArp0QSGBiEgoaH5Gs
         s1Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=pCKSpp4z7ph/+e+kP4/CwJwFa/00JTNZohHPFZ6sPqE=;
        b=BhltpIF1tlc9kOMt00upxCT8PeIRrWFw3e6QThDEZRbmj6qId8s40G6G37SoqSZHal
         ZIqV3JM/S3URBaL6nzCVuGNFlvFA0CgXrAP32SgMbbxTFA+3sook/wL9JsSeDV9GsENm
         PQ2N+37J1MG6Ui6IoVxI2Kn6fN0rYOdiOmq+qx7oYkzSxPIFfhkumSOiEwWUNpSJAIky
         IQEIYO9hbSojzIRRJCw/VGNPcLBynRNirR9JRKZwkPgblaYC/Ic5j2OIF6U8mTYpTnWU
         eJCFMQzdoPDCPTNJtwVu9plW/DKO2N2hn5SCL08UQ13L0MlqFQBlcfvim+cvkr1gXuW4
         zV7w==
X-Gm-Message-State: AD7BkJIrTWyJaSWskhcDHWBOlHngrx+Zd3RHiY1XaGWK9tyaN4DIHdekBdkjRJE0fYANLQ==
X-Received: by 10.140.173.133 with SMTP id t127mr8826828qht.23.1459533316303;
        Fri, 01 Apr 2016 10:55:16 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id z65sm6532857qhb.36.2016.04.01.10.55.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Apr 2016 10:55:15 -0700 (PDT)
In-Reply-To: <CAGZ79katAVbd6mMSu2Kt1SnH2f3Ujn0L4-bH82bwLudzboCyTg@mail.gmail.com>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290569>

On Thu, 2016-03-31 at 18:37 -0700, Stefan Beller wrote:
> On Wed, Mar 30, 2016 at 1:05 PM, David Turner <
> dturner@twopensource.com> wrote:
> > On Wed, 2016-03-30 at 08:37 +0200, Michael Haggerty wrote:
> > > On 03/29/2016 10:12 PM, David Turner wrote:
> > > > On Sun, 2016-03-27 at 07:22 +0200, Michael Haggerty wrote:
> > > > > On 03/24/2016 07:47 AM, David Turner wrote:
> > > > > > [...]
> > > > > > I incorporated your changes into the lmdb backend.  To make
> > > > > > merging
> > > > > > later more convenient, I rebased on top of pu -- I think
> > > > > > this
> > > > > > mainly
> > > > > > depends on jk/check-repository-format, but I also included
> > > > > > some
> > > > > > fixes
> > > > > > for a couple of tests that had been changed by other
> > > > > > patches.
> > > > > 
> > > > > I think rebasing changes on top of pu is counterproductive. I
> > > > > believe
> > > > > that Junio had extra work rebasing your earlier series onto a
> > > > > merge
> > > > > of
> > > > > the minimum number of topics that it really depended on.
> > > > > There is
> > > > > no
> > > > > way
> > > > > that he could merge the branch in this form because it would
> > > > > imply
> > > > > merging all of pu.
> > > > > 
> > > > > See the zeroth section of SubmittingPatches [1] for the
> > > > > guidelines.
> > > > 
> > > > I'm a bit confused because
> > > > [PATCH 18/21] get_default_remote(): remove unneeded flag
> > > > variable
> > > > 
> > > > doesn't do anything on master -- it depends on some patch in
> > > > pu.
> > > >  And
> > > > we definitely want to pick up jk/check-repository-format (which
> > > > doesn't
> > > > include whatever 18/21 depends on).
> > > > 
> > > > So what do you think our base should be?
> > > 
> > > I think the preference is to base a patch series on the merge of
> > > master
> > > plus the minimum number of topics in pu (ideally, none) that are
> > > "essential" prerequisites of the changes in the patch series. For
> > > example, the version of this patch series that Junio has in his
> > > tree
> > > was
> > > based on master + sb/submodule-parallel-update.
> > > 
> > > Even if there are minor
> > > conflicts with another in-flight topic, it is easier for Junio to
> > > resolve the conflicts when merging the topics together than to
> > > rebase
> > > the patch series over and over as the other patch series evolves.
> > > The
> > > goal of this practice is of course to allow patch series to
> > > evolve
> > > independently of each other as much as possible.
> > > 
> > > Of course if you have insights into nontrivial conflicts between
> > > your
> > > patch series and others, it would be helpful to discuss these in
> > > your
> > > cover letter.
> > 
> > If I am reading this correctly, it looks like your series also has
> > a
> > few more sb submodule patches, e.g. sb/submodule-init, which is
> > responsible for the code that 18/21 depends on.
> > 
> > I think jk/check-repository-format is also  good to get in first,
> > because it changes the startup sequence a bit and it's a bit tricky
> > to
> > figure out what needs to change in dt/refs-backend-lmdb as a result
> > of
> > it.
> > 
> > But I can't just merge jk/check-repository-format on top of
> > 71defe0047
> > -- some function signatures have changed in the run-command stuff
> > and
> > it seems kind of annoying to fix up.
> > 
> > So I propose instead that we just drop 18/21 for now, and use just
> > jk/check-repository-format as the base.
> 
> By 18/21 you mean
> [PATCH 18/21] get_default_remote(): remove unneeded flag variable
> in builtin/submodule--helper.c?
> You could drop that and I'll pick it up in one of the submodule
> series',
> if that is more convenient for you.
> 


Yes, thanks.
