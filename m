From: "Stefan Karpinski" <stefan.karpinski@gmail.com>
Subject: Re: builtin conversion between tabs and spaces
Date: Wed, 15 Oct 2008 16:02:28 -0700
Message-ID: <d4bc1a2a0810151602j56550c3di2f59f92039fa8243@mail.gmail.com>
References: <d4bc1a2a0810141839r547a770j3a8e56312afa6a53@mail.gmail.com>
	 <d4bc1a2a0810141842q1e50c85au7d813f2e5e37a84c@mail.gmail.com>
	 <d4bc1a2a0810141844x76223e76xf04e07ece834fc61@mail.gmail.com>
	 <20081015062539.GB3775@blimp.localdomain>
	 <d4bc1a2a0810151352s6c963e32jc4f492a7c84841dc@mail.gmail.com>
	 <57518fd10810151402p4ea3283anf4b3d175c4e82425@mail.gmail.com>
	 <d4bc1a2a0810151418r3bf21ddaj498017e8e178f579@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Alex Riesen" <raa.lkml@gmail.com>,
	"Git Mailing List" <git@vger.kernel.org>,
	"Johannes Sixt" <j.sixt@viscovery.net>
To: "Jonathan del Strother" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 01:03:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqFP3-0002A8-KT
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 01:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753440AbYJOXCa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 19:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753432AbYJOXCa
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 19:02:30 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:19058 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753427AbYJOXC3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 19:02:29 -0400
Received: by yx-out-2324.google.com with SMTP id 8so674311yxm.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2008 16:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=G00H5ZTMVfqg4Yxs9eIWbe0ZbQZealxUx9creFCChjI=;
        b=oxyCB3o6sltzwSlMLuf5Rr+aeDovJuNzlSgFFL8k+C7EnLXygoo4Filzta24zwb9Vt
         Ed8CYAMlIaXcva/zzzKlicsnUFqFuQODVZMKx0l/y6DhAqn1K4XtJmwvtxetdpg/p42Y
         n4s6AVGkz9/FQ/Yc/KSPMvC1hw4EJQH9kwgEw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=SlPKCitCH0SbaasNrKJidwWGen2TDZF+3nbqARH54njvRxQAWl3gn/xtHqrH1mHaw8
         DHkky9xATgSIfEBTxJvVsuxsNHhcQlVbiyetzqLzz08tTFMwCBCsg2vazZcaHcU9Y4Zo
         BXV0hXP4CyOmsv6bnkivHv+2VwEmGmj2aKt68=
Received: by 10.100.46.10 with SMTP id t10mr1945547ant.136.1224111748080;
        Wed, 15 Oct 2008 16:02:28 -0700 (PDT)
Received: by 10.100.197.16 with HTTP; Wed, 15 Oct 2008 16:02:28 -0700 (PDT)
In-Reply-To: <d4bc1a2a0810151418r3bf21ddaj498017e8e178f579@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98337>

Any further comments? I'm more than willing to implement this, but I
won't bother if there's no chance of getting it accepted as a patch.
Does no one else feel like at least having the option to enforce
whitespace consistency in git is a good thing? If not, I guess I'll
just muddle along without this feature instead of implementing it.

On Wed, Oct 15, 2008 at 2:18 PM, Stefan Karpinski
<stefan.karpinski@gmail.com> wrote:
> That's not what I would call a "crazy" mix of tabs and spaces, but
> rather a *sane* mix of tabs and spaces. That can consistently be
> reproduced, and is in fact what the spaces_to_tabs function included
> above produces. The sane consistent formats as I see it are:
>
>  1) use spaces for everything
>  2) use tabs for indentation, spaces for everything else
>  3) use tabs for indentation and alignment
>
> If you know the tab size, you can reproduce any of these from the
> others, except that #3 is a little tricky since there's places where
> the tab/space issue can be ambiguous. I actually think that keeping
> the repo version with tab-based indentation is a very sane thing to
> do. However, I'd still like to be able to edit the files using soft
> tabs, largely because any program that doesn't know what my tab size
> should be applies its own interpretation and makes the code look
> terrible (think terminal output for diff, cat, less, etc.)
>
> On the other hand, a *crazy* mix of tabs and spaces is where some
> indentation is done with spaces while other indentation is done with
> tabs. Even crazier is a single line where the indentation is a mixture
> of tabs and spaces. I think that just about everyone can agree that
> this is not only crazy, but evil and is the kind of thing one really
> wants to avoid in a code base. Unfortunately, when developers disagree
> on their standard settings, it's very, very hard to avoid precisely
> this kind of mess. My idea is to enable git to prevent this sort of
> insanity if configured to do so.
