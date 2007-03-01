From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: Re: Git checkout preserve timestamp?
Date: Thu, 1 Mar 2007 22:48:39 +0100
Message-ID: <81b0412b0703011348q7f3e71f3qb1f207178c496668@mail.gmail.com>
References: <17895.18265.710811.536526@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Bill Lear" <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 22:49:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMt92-0002Ek-Qo
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 22:49:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbXCAVsm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 16:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbXCAVsm
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 16:48:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:21828 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030339AbXCAVsl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 16:48:41 -0500
Received: by ug-out-1314.google.com with SMTP id 44so489006uga
        for <git@vger.kernel.org>; Thu, 01 Mar 2007 13:48:40 -0800 (PST)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VClsbDx1BWUPjQbgMVTdMMrTY2hY7IpK20yuJf8FGsn82SUASn9afZe7/hq0dHTKSnrbCl7TqLuj+VwBPPxMkPJsRTjqonxNqdKnCGjuOYN9F6874I4zNGK5n+JZbf3VziFeyHfVsEO2QgSDSR/B0ayKIvGOdD0M/d8u6p85LX4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=moWEg3m3K7dPL10HCor/YiLygN4bD0Mkr+BTqeu/Ufa7CofQ7SCSUnP+tFgSceVpgbSL/J3wTn3RTna0fDtvpvzt7PGPBYk9YhPj8B8N0t2Kf9kSMSDb8g15CwHF/13Lpww5u20+BvynwVZQQWb2tNsmzLXQ8bc0VNbXugLPYZk=
Received: by 10.78.81.20 with SMTP id e20mr208231hub.1172785720009;
        Thu, 01 Mar 2007 13:48:40 -0800 (PST)
Received: by 10.78.139.9 with HTTP; Thu, 1 Mar 2007 13:48:39 -0800 (PST)
In-Reply-To: <17895.18265.710811.536526@lisa.zopyra.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41131>

On 3/1/07, Bill Lear <rael@zopyra.com> wrote:
> I wonder if it would be possible or desirable to have a config flag
> that told git to restore the timestamps across branch checkouts in
> order to prevent this perturbation.

Almost every SCM has such a flag. And every one of them warn
against using it.

> So, when git does a checkout of a branch, it would look to see which
> files in the current branch are changed, tuck away the timestamps for
> those, and switch to the new branch.  On return to the former, the
> same would be done for the new branch, then after the changed files
> were restored, the timestamps would be reset.

For instance, timestamp of which machine do you want to restore?
How do you know if they are synchronized?

> One thing this would enable is to be able to hold the compilation
> products of multiple branches at the same time in the same working
> tree, switch back and forth between branches, and only have to compile
> code that you actually modify.  Currently, we store compilation
> products in a directory that is composed of the architecture, compiler,
> compiler options, and so forth, among which also could be the branch
> name.

Usually, you will just screw up the build process beyond all repair.

> Anyway, just an idea I thought worth batting about.

Consider separating build and working repositories.
Merge things into build repo, switch the branches
freely in your working repo. Works just fine for me.
