From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [RFC 0/16] Introduce index file format version 5
Date: Thu, 2 Aug 2012 15:47:19 +0200
Message-ID: <20120802134718.GA1000@tgummerer.unibz.it>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
 <CACsJy8De=1RR9yAQ79zzNM_iALF1OCB2L9A8pMK_v+ixZqgJug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 15:47:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwvkT-0002cn-46
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 15:47:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754769Ab2HBNrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 09:47:24 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35649 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449Ab2HBNrX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 09:47:23 -0400
Received: by bkwj10 with SMTP id j10so4259288bkw.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 06:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=zkTRqs030J/Y6OOXvmMN7FSAzQcHb9dHlzJ6wwpWO6U=;
        b=ZM5Gp751zExmmBEbpLFr2qnf7TQy2zPQp/kXoRexwzpz1krMg/T8UiixOykg/dMAz8
         SsGp/VLjjWKwt1gIMgqzvAXbLH2ejMvq5OW6uzVk7QXscyjCV68tMIS0450Dm/d4+/cg
         I9R0CSsv/hNHrd/Jw9ioqIkJQ5Q3dgTt/KXKHhOg115rKYA0BtxPzgLu+7CLgcKcTJ6/
         xY99xQ8OFpmgyJ+KSvOKn0d1i4yUROgv5mVCzofcdJzYjvUg36l7HjVNHzyCQHS0zaYj
         hHwVjvsNP1pFPAYqjEEzyEryT4pQqna4DWnphlCplopO7vFggIZ+TYsKdwoE1RNjWEmE
         Vv7g==
Received: by 10.204.154.74 with SMTP id n10mr8224784bkw.60.1343915241919;
        Thu, 02 Aug 2012 06:47:21 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id ht18sm3451922bkc.16.2012.08.02.06.47.20
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 06:47:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8De=1RR9yAQ79zzNM_iALF1OCB2L9A8pMK_v+ixZqgJug@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202775>

On 08/02, Nguyen Thai Ngoc Duy wrote:
> On Thu, Aug 2, 2012 at 6:01 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > Documentation/technical/index-file-format-v5.txt |  281 ++++++++++++++++++++++++++++++++++
> > builtin/update-index.c                           |    5 +-
> > cache-tree.c                                     |  145 ++++++++++++++++++
> > cache-tree.h                                     |    7 +
> > cache.h                                          |   96 +++++++++++-
> > read-cache.c                                     | 1519 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
> > resolve-undo.c                                   |  129 ++++++++++++++++
> > resolve-undo.h                                   |    3 +
> > t/perf/p0002-index.sh                            |   33 ++++
> > t/t2104-update-index-skip-worktree.sh            |   15 +-
> > t/t3700-add.sh                                   |    1 +
> > test-index-version.c                             |    2 +-
> > 12 files changed, 2082 insertions(+), 154 deletions(-)
> 
> This is not good (too many pluses in read-cache.c) if it comes from
> format-patch. Does it?

No this comes from git diff --stat. It's probably just my terminal
width then?
