X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Nguyen Thai Ngoc Duy" <pclouds@gmail.com>
Subject: Re: svn versus git
Date: Fri, 15 Dec 2006 22:26:09 +0700
Message-ID: <fcaeb9bf0612150726o40527552l8b3564ddcc3adb94@mail.gmail.com>
References: <200612132200.41420.andyparkins@gmail.com>
	 <20061213225627.GC32568@spearce.org>
	 <200612140908.36952.andyparkins@gmail.com>
	 <7vodq695ha.fsf@assigned-by-dhcp.cox.net>
	 <fcaeb9bf0612140708w6bc691f6k2e08fbab2a651421@mail.gmail.com>
	 <Pine.LNX.4.63.0612141630240.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	 <fcaeb9bf0612140832v1c80bf7dgd61897111292d31@mail.gmail.com>
	 <Pine.LNX.4.63.0612141754420.3635@wbgn013.biozentrum.uni-wuerzburg.de>
	 <fcaeb9bf0612140910t6aff44e1m9570b20850a41b87@mail.gmail.com>
	 <Pine.LNX.4.63.0612150118190.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Fri, 15 Dec 2006 15:26:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GJCDTefNUr0cilhvB/prLIxgln7kK/daZ733w1rLDlMlpFQ3iRqDKxDxO34RX5wfGo489hBolCEJ7OI6rcDc4KR9GKKp7VfCTzwH0kuDXwoJn8hTT34Rkj5P/jmfrQajbu+BM+HK1Uw8cadV9pp6q8/HnIBIA5yR6VKAG7BpBwM=
In-Reply-To: <Pine.LNX.4.63.0612150118190.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34516>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvEwx-00015j-HI for gcvg-git@gmane.org; Fri, 15 Dec
 2006 16:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752644AbWLOP0M (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 10:26:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752736AbWLOP0M
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 10:26:12 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:62613 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1752644AbWLOP0L (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec
 2006 10:26:11 -0500
Received: by ug-out-1314.google.com with SMTP id 44so837981uga for
 <git@vger.kernel.org>; Fri, 15 Dec 2006 07:26:10 -0800 (PST)
Received: by 10.49.13.19 with SMTP id q19mr143750nfi.1166196370068; Fri, 15
 Dec 2006 07:26:10 -0800 (PST)
Received: by 10.78.100.8 with HTTP; Fri, 15 Dec 2006 07:26:09 -0800 (PST)
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Hi,

On 12/15/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Hi,
>
> On Fri, 15 Dec 2006, Nguyen Thai Ngoc Duy wrote:
>
> > On 12/14/06, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > > - have you seen the patch for git-show today, which would include this
> > > > > functionality?
> > > >
> > > > I didn't. From the patch, it seems git-show can show the index via
> > > > ::file syntax. If so, I'd like withdraw my opinion. '::file' syntax is
> > > > not intuitive though. Perhaps you should mention that it can show
> > > > index (and how) in the git-show document
> > >
> > > Well, you can reference blobs that way, but not trees.
> >
> > Oh, yeah. Isn't this a good oppotunity to add --index option to git-show?
> > git-show --index will show the index. git-show --index file will show
> > the file content. This makes git-show a little unconsistent though as
> > it may or may not require argument <object>.
> >
> > Another option is treat '::' alone specially -- call git-ls-files.
>
> Hmm. I don't know... It would make the code rather messy. And are you
> really interested in the content stored in the index? In all cases I can
> think of, you are better off with a diff vs. working directory or ref.

When I worked with index the first time, I had difficulty knowing what
was in index. Index is, unlike working directory, intangible. I could
use git-diff (and actually did), but it was still better if I could
have seen what exactly was in index.

To me, index and object database are (to some extent) the same: both
are used to store files. If I can examine git object database, why not
index?

About adding index support to git-show, yes it's really messy. index
doesn't have tree objects. If a user wants to list a subdirectory in
index, git-show will have to do more work, I think. Perhaps we should
forget this for now.
-- 
