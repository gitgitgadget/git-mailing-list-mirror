From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: git-p4 clone @all error
Date: Tue, 6 Nov 2012 00:25:15 +0000
Message-ID: <20121106002515.5b7eba50@fenix.utopia.dhis.org>
References: <1351593879401-7570219.post@n2.nabble.com>
	<CABYiQp=1HEW=53U2Rck5vckhq0PB3C9iuanoXeVvNG6Xv5+oHg@mail.gmail.com>
	<20121103231305.GB11267@padd.com>
	<1352109747598-7570575.post@n2.nabble.com>
	<20121105221212.GA12003@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Arthur <a.foulon@amesys.fr>
X-From: git-owner@vger.kernel.org Tue Nov 06 01:25:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TVWzI-000400-PC
	for gcvg-git-2@plane.gmane.org; Tue, 06 Nov 2012 01:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932358Ab2KFAZk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2012 19:25:40 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:57345 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271Ab2KFAZj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2012 19:25:39 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr13so4327578wgb.1
        for <git@vger.kernel.org>; Mon, 05 Nov 2012 16:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=W5huT7EWy7cvF6VN2/ayMqMug+ml+ee4RI/0QvDE5Fg=;
        b=fcY+68tLpzwgXmvCZjKyyP9vtNzU1jx/4N0a3l38dYG6OSargl9Pv6UokP2CC8oaY7
         3ylTsHOAxz7YyQXkCthFdP080vtlF2I10BqIn3pFBu3zdauvNBeXEyfWHn26hEkm5wGK
         abrLNk3jj31Rv7ZXj1LGDc4NK0VLpeUeHSvZcoCd35/JftN/aVBTY9e31O5ecB4L7tkF
         3LVQweawqwdAJOmqFFtVbLTbljmAturfZ9OxjTRLX1wodDUJtcKwWO4DzC7xVaf1WDob
         xqv6JRZ42m27uAuM+tQ9z4qBqXCNmLULM1VU6U7tD/uoA3RnDPNAvCPBw7n34PfAmsqE
         aBpQ==
Received: by 10.216.209.224 with SMTP id s74mr4259518weo.63.1352161537310;
        Mon, 05 Nov 2012 16:25:37 -0800 (PST)
Received: from fenix.utopia.dhis.org (111.216.54.77.rev.vodafone.pt. [77.54.216.111])
        by mx.google.com with ESMTPS id r10sm11122200wiz.0.2012.11.05.16.25.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 05 Nov 2012 16:25:36 -0800 (PST)
In-Reply-To: <20121105221212.GA12003@padd.com>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.13; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209094>

On Mon, 5 Nov 2012 17:12:12 -0500
Pete Wyckoff <pw@padd.com> wrote:

> Thanks, that is interesting output.
> 
> Adding Vitor who knows his way around the branch detection
> code.  The first mail by Arthur is here, which focuses more
> on the backtrace from "p4 describe" errors, but also suggests
> something is dodgy in branch detection:
> 
>     http://thread.gmane.org/gmane.comp.version-control.git/208693
> 
> I'm not sure if this is a --verbose run, though, as I don't see
> any chatter like "branch is xxx".  So I'm not sure if the
> auto-parent detection code got run.
> 
> The "unable to resolve reference" comes from refs.c, which is
> when fast-import calls update_branch() on each of the changed
> branches as it is finishing.
> 
> Vitor, what could git-p4 have done to create a branch name called
> "refs/remotes/p4/depot/MAINLINE/02_SubSystem/10_ARINC_429"?
> Any other questions for Arthur?
> 

Hi Arthur,

Could you please share with us your git-p4.branchList configuration?
Would it also be possible to describe a bit more on your depot
structure? I'm particularly concerned about its integration history.

I suspect the error you are experiencing is connected to a wrong
configuration. Please take into account that each entry must be in the
form of origin:destination, where "origin" is the folder used as the
source of the integration to "destination" when first created.

Vitor
