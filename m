From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: How to use git attributes to configure server-side checks?
Date: Mon, 26 Sep 2011 16:14:07 +0200
Message-ID: <201109261614.09315.jnareb@gmail.com>
References: <4E7AF1AE.5030005@alum.mit.edu> <4E7DB916.6010606@alum.mit.edu> <20110926110552.GA20796@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 26 16:14:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8Bwr-0003c9-4c
	for gcvg-git-2@lo.gmane.org; Mon, 26 Sep 2011 16:14:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750928Ab1IZOOQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 10:14:16 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:54411 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806Ab1IZOOQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 10:14:16 -0400
Received: by eya28 with SMTP id 28so3624711eya.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 07:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=/hsOiQL2ewo8m4sW5YVAA4136I3RU8Qu6g3nTlZk0Cs=;
        b=nE5rdqgd0QrHXwqUg36Zjcgo19FpjN+rtG3A8Sag6BDu+0X8b563LwlvckDwCa0h7L
         KPtIZNXtX8EKqBmq+JGmD+5ES/BnhxWokBiEa+PhHWcBFwFN2SzJxQImBH9tMgWun5eF
         koRkNPN73gj1y0aKsMgoFJ0DHjv6wyIu+PahA=
Received: by 10.213.8.6 with SMTP id f6mr1070378ebf.69.1317046454851;
        Mon, 26 Sep 2011 07:14:14 -0700 (PDT)
Received: from [192.168.1.13] (abwm119.neoplus.adsl.tpnet.pl. [83.8.236.119])
        by mx.google.com with ESMTPS id x45sm60685447eeh.11.2011.09.26.07.14.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Sep 2011 07:14:12 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20110926110552.GA20796@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182113>

Jeff King wrote:
> On Sat, Sep 24, 2011 at 01:03:50PM +0200, Michael Haggerty wrote:
 
> > While we are on the topic of config settings, I have often thought that
> > it would be nice for git's default settings to be set via a
> > well-commented config file, installed along with git, rather than via
> > values compiled into the code.  This file and Documentation/config.txt
> > could be generated from a single source file as part of the build
> > process.
> 
> I think that can be a nice piece of documentation, but there may be some
> complications.  I seem to recall that there may be one or two options
> whose builtin values cannot be replicated via config (i.e., the "unset"
> state means something). But I may be misremembering.
> 
> However, I'm not sure what you mean by "rather than via values compiled
> into the code".  Would you somehow generate code that sets the default
> according to your master file? Would git fail to start if the file is
> missing? Or if a specific config option is missing? How would you track
> that?

There is also problem that it would screw up Git deprecation policy.
 * new behavior is introduced, with a knob that defaults to off
 * after some time knob starts to default to on
 * git uses new feature by default

With Git creating config file with state of config variables frozen at
the state of repository creation this would be not possible.

-- 
Jakub Narebski
Poland
