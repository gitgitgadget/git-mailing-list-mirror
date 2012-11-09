From: Tomas Carnecky <tomas.carnecky@gmail.com>
Subject: Re: orphan blob or what?
Date: Fri, 09 Nov 2012 21:41:15 +0000
Message-ID: <1352497275-ner-6808@calvin>
References: <87a9urlj23.fsf@intel.com> <1352423287-ner-8337@calvin>
	<87625elg9r.fsf@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: bruce <bruce.e.robertson@intel.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 22:43:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWwMI-0006jK-Gh
	for gcvg-git-2@plane.gmane.org; Fri, 09 Nov 2012 22:43:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756155Ab2KIVnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2012 16:43:12 -0500
Received: from mail-ea0-f174.google.com ([209.85.215.174]:37549 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755388Ab2KIVnI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2012 16:43:08 -0500
Received: by mail-ea0-f174.google.com with SMTP id c13so1637248eaa.19
        for <git@vger.kernel.org>; Fri, 09 Nov 2012 13:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:subject:to:cc:references:in-reply-to:mime-version:date
         :message-id:content-type;
        bh=Q1ZJJtHe79J7y4FhO0guiY23eoABIIpPPpSK9eXnf6c=;
        b=ZgE1oZfRfBWpDD1X2JgTyXvAUqw0W2x+SA4T6bWljt+YG/h6cOX/czuruWH/9IdKBu
         JBBTQms0BeGJ0nytjboO6pZBJgFWLMBwCXVRqq4L0nqzLZ5hyda5xTUzDSJS7YSawfbP
         7bKQxyL1ouS+vxstUUgO4+vIOme7s2ZjY0QQMOFM2F9WDyS3bL4to177dM4WFrNCp+zK
         vIR3BN4IJySL0wejp3fPlLi9OUsYueCuBfQHSDA5AAQMn6rhQ8h9iNqQV+urrMsAVacz
         pkB7f5RFHhetXsqGLfMzUZRDanqPAd2xrcsz1/0X0zn5kyAvnvK1OasC3y4IrRm3C+9e
         GqSg==
Received: by 10.14.205.3 with SMTP id i3mr40985178eeo.18.1352497386816;
        Fri, 09 Nov 2012 13:43:06 -0800 (PST)
Received: from calvin.caurea.org (pub082136067238.dh-hfc.datazug.ch. [82.136.67.238])
        by mx.google.com with ESMTPS id k2sm78915487eep.15.2012.11.09.13.43.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 09 Nov 2012 13:43:06 -0800 (PST)
Received: by calvin.caurea.org (Postfix, from userid 3301)
	id 47B00159D92; Fri,  9 Nov 2012 21:41:15 +0000 (UTC)
In-Reply-To: <87625elg9r.fsf@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209249>

On Fri, 09 Nov 2012 11:37:04 -0800, bruce <bruce.e.robertson@intel.com> wrote:
> Tomas Carnecky <tomas.carnecky@gmail.com> writes:
> 
> Just idiocy on my part. Thanks.
> 
> > On Thu, 08 Nov 2012 16:24:36 -0800, bruce <bruce.e.robertson@intel.com> wrote:
> >> In today's and older clones of https://github.com/mirrors/linux.git I
> >> find this object, 6fa98ea0ae40f9a38256f11e5dc270363f785aee, that I can't
> >> figure out how to eliminate^h^h^h^h^h^h^h^h^hget rid of. I don't see it
> >> in 'git fsck', 'git gc --aggressive --prune' doesn't seem to prune it,
> >> can't see it via 'git log'. And yet
> >> 
> >> linux/.git/objects/pack$ git verify-pack -v *.idx | grep 6fa98ea0ae40f9a38256f11e5dc270363f785aee
> >> 6fa98ea0ae40f9a38256f11e5dc270363f785aee blob   1519697 124840 515299673
> >> 8231eaa31ce1107c1463deb6ec33f61618aedbb9 blob   67 63 515424513 1 6fa98ea0ae40f9a38256f11e5dc270363f785aee
> >> f21a8c1b9d47736fa4e27def66f04b9fe2b4bc53 blob   90 83 515424576 1 6fa98ea0ae40f9a38256f11e5dc270363f785aee
> >
> > Commit dee0bb9 (ASoC: Mark WM8962 Additional Control 4 register as volatile,
> > 2010-09-29) references this blob.

It wasn't easy to find the commit. First I figured out at which path that file
was stored. Using git log -S'wm8962_reg[WM8962_MAX_REGISTER + 1]' I quickly
determined that the file was somewhere in sound/, more specifically
sound/soc/codecs/wm8962-tables.c. However a 'git log --
sound/soc/codecs/wm8962-tables.c' did not show any commit. That was strange,
because 'git log -S'WM8962_MAX_REGISTER + 1' --name-status --
sound/soc/codecs/' clearly shows that the file existed at some point in the
past. The commit is hidden from a simple 'git log' due to 'History
Simplification'. See the git-log man page. I added --full-history -p to the log
command, and searched in the pager for '6fa98e'. That revealed the commit which
references that blob:

    git log --full-history -p -- sound/soc/codecs/wm8962-tables.c
