From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2012, #01; Tue, 4)
Date: Fri, 7 Sep 2012 15:08:13 +0200
Message-ID: <20120907130813.GC25467@tommy-fedora.scientificnet.net>
References: <7v1uih8jck.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch,
	ramsay@ramsay1.demon.co.uk, pclouds@gmail.com,
	robin.rosenberg@dewire.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 07 15:08:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9yIM-0006eS-1b
	for gcvg-git-2@plane.gmane.org; Fri, 07 Sep 2012 15:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752223Ab2IGNIT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Sep 2012 09:08:19 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:54885 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751965Ab2IGNIS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Sep 2012 09:08:18 -0400
Received: by weyx8 with SMTP id x8so1764439wey.19
        for <git@vger.kernel.org>; Fri, 07 Sep 2012 06:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=s/1xOjE2Q3cD/6E01FowPQO+bYyZKQga8jWfPhyORUI=;
        b=qKxvUU7slzPk/ySaj37DdDQCKrEvwyoD+iOF2YPUhwKNuR57wETVBdegN9eEby9NO5
         XCykbonO7Ol35NpV+6TFH53jIRqUD2FaPIto34z8jzM+CEG3V9eXF+w8f7rJRv4qj7LN
         VGXlowzWEgj+DToCIs4EGHDJJOZvM/UELU6O7YRxFt2EZe4SWX/2l40dS6vxWAQyXRMd
         uHu1sJ4DmSFNVX7R3KMgKrQvPJT4LA/wHJZ3+3KQhdxhRsPtZXpcFFSIetU1k6HLBMaD
         F2LAMzDpHv82XI1CvkBi7l9kOA5Vmhal0c7PSGDhBTnfhwNGXKyUcxXUaoYg1/uBtlft
         wckA==
Received: by 10.180.97.33 with SMTP id dx1mr12186480wib.18.1347023296911;
        Fri, 07 Sep 2012 06:08:16 -0700 (PDT)
Received: from localhost ([46.18.27.15])
        by mx.google.com with ESMTPS id fp3sm9587271wib.7.2012.09.07.06.08.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 07 Sep 2012 06:08:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7v1uih8jck.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204965>

On 09/04, Junio C Hamano wrote:
> * tg/index-v5 (2012-08-17) 13 commits
>  . p0002-index.sh: add perf test for the index formats
>  . update-index.c: rewrite index when index-version is given
>  . Write resolve-undo data for index-v5
>  . Write index-v5 cache-tree data
>  . Write index-v5
>  . Read cache-tree in index-v5
>  . Read resolve-undo data
>  . Read index-v5
>  . Make in-memory format aware of stat_crc
>  . Add documentation of the index-v5 file format
>  . t2104: Don't fail for index versions other than [23]
>  . read-cache.c: Re-read index if index file changed
>  . Move index v2 specific functions to their own file
> 
> A GSoC project.  Was waiting for comments from mentors and
> stakeholders, but nothing seems to be happening, other than breakage
> fixes on Cygwin.  May discard.

I was planning on continuing to work on this topic as part of my Bachelor
Thesis.  I had a brief discussion with Thomas Rast on IRC about this
today.  Because I am planning to implement an api for partial loading
we decided it's probably best to hold off until that's implemented,
because parts of this series may change and it's going to take me a while
to implement the api.

As for the actual look of the api, I think something along the lines of
what was discussed at [1] would fit well.

The commands would then learn to use this api. (First the commands that
just read the index and later the commands that read and write the index,
but for that the api will have to support writing the index)

[1] http://thread.gmane.org/gmane.comp.version-control.git/198283/focus=198739 
