From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [RFC 0/16] Introduce index file format version 5
Date: Fri, 3 Aug 2012 14:34:31 +0200
Message-ID: <20120803123431.GA3226@tgummerer.unibz.it>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
 <87pq785odw.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, gitster@pobox.com,
	pclouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 03 14:35:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxH5y-0006zh-NS
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 14:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715Ab2HCMeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 08:34:36 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:55556 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752922Ab2HCMef (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 08:34:35 -0400
Received: by weyx8 with SMTP id x8so376859wey.19
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=G/lw9pIEOpEc7J6QT92zBMUwWj9wHJuWqEfiIdFb+Zs=;
        b=HBXZTruMt5E7uKEuuluBCWV1haGRT7WfwnFWHJF/m9Y5YZjjfJ9lxRnh+Ry86Ri4DB
         nR811wQ8yfVEJEBYrvjHVwzN7jfIcODwffRlU3Wwl8WnSzMuPCLynXNLG/5lvakUn3o7
         +FimA4NyLw5dm94QcB4hZEqdQW9t1Ii9Wa3ogltRg57eM5uFM6BUdxnUsfYyWtwpwaBo
         lRTxHMegdozqa3kLhk4Rury/6lx00wRmtkkK8gFYpHBv2xl8bB8+zD08e9xt/91v4Mu1
         JtAflgjNDvQf2ZHQysLFAAcRuFTt+kKQeKfzYQ1onxy2YH8+DMdxgjp7hRUl8MdwfKRq
         u0KA==
Received: by 10.216.90.19 with SMTP id d19mr841186wef.113.1343997274634;
        Fri, 03 Aug 2012 05:34:34 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id z11sm25598728wiv.10.2012.08.03.05.34.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 05:34:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87pq785odw.fsf@thomas.inf.ethz.ch>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202833>

On 08/03, Thomas Rast wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
> 
> > [PATCH 01/16] Modify cache_header to prepare for other index formats
> > [PATCH 02/16] Modify read functions to prepare for other index
> > [PATCH 03/16] Modify match_stat_basic to prepare for other index
> > [PATCH 04/16] Modify write functions to prepare for other index
> > [PATCH 05/16] t2104: Don't fail when index version is 5
> > [PATCH 06/16] t3700: sleep for 1 second, to avoid interfering with
> > [PATCH 07/16] Add documentation of the index-v5 file format
> > [PATCH 08/16] Make in-memory format aware of stat_crc
> > [PATCH 09/16] Read index-v5
> > [PATCH 10/16] Read resolve-undo data
> > [PATCH 11/16] Read cache-tree in index-v5
> > [PATCH 12/16] Write index-v5
> > [PATCH 13/16] Write index-v5 cache-tree data
> > [PATCH 14/16] Write resolve-undo data for index-v5
> > [PATCH 15/16] update-index.c: add a force-rewrite option
> > [PATCH 16/16] p0002-index.sh: add perf test for the index formats
> 
> I haven't had time for more than a cursory look yet, but good job on the
> splits.  This is a large improvement over what you had in Zurich!

Thanks, it was easier when seeing the code, instead of just thinking
about them of the top of my head.

> One thing that you need to be more careful about is attribution of the
> source code.  Credit is very important because it's the only thing
> people get for their OSS work.  For some patches you received lots of
> input and help by many people.  For example, the documentation patch
> that casts the format in stone (or will, when it's finished), should
> have "Helped-by:" for *at least* Michael, Junio, and Duy.  You should
> dig in the ML archives for other people who may have contributed ideas.
> 
> Also, anything that contains nontrivial code from me needs my S-o-b; off
> the top of my head that's just 16/16, which AFAICS is even completely
> unchanged (!) and needs to come with a From (and my S-o-b).  (I'm not
> going to be anal about any of the work we did in Zurich, let's just
> classify that as "help" like above.)

My apologies, i forgot to add them. I'll make sure to include all
credits in the re-roll.
