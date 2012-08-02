From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 04/16] Modify write functions to prepare for other index
 formats
Date: Thu, 2 Aug 2012 16:11:43 +0200
Message-ID: <20120802141143.GD1000@tgummerer.unibz.it>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
 <1343905326-23790-5-git-send-email-t.gummerer@gmail.com>
 <CACsJy8Av_ODO--DAsznP8R6DnOP_GQXKxVQDKeVYg=E3mZUnEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 02 16:11:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sww80-0007UZ-2K
	for gcvg-git-2@plane.gmane.org; Thu, 02 Aug 2012 16:11:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721Ab2HBOLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Aug 2012 10:11:47 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:56100 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754707Ab2HBOLq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Aug 2012 10:11:46 -0400
Received: by weyx8 with SMTP id x8so5869580wey.19
        for <git@vger.kernel.org>; Thu, 02 Aug 2012 07:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PnYPX1+Z5Ll8piyZ/JfK98ah90Fet8HIvHjNb6U6KT8=;
        b=0Qk0jSpPc9L3Oh3RmrESsUH9W0goG74gT40J2lrl+YzdXMYtRkoMDNZf4BhH7+5tbC
         gE15tPBIJhXOX94oyn5ljtjKv86rbJWMc5X3EaVr84Lf+4daukQaSjeKgpGsUg65x1g2
         x/1vyOaTOGCuTSAIx88eyyfIe1LrENXEfXpeS69pc6KtSYfHX9d1Tl3yMfeRBwmFZ/w0
         6l//OVKiu1f7Q2m/YGJTnm3nDn9zJMbQRv387JN+sYi4OZAySUqr6CRAV/0ERZ5YHjxq
         5u0Q0/YrQjjzOwDNLlrInATHZg4u1Wg5uu56+j2MLmFIT2xeki60dhmxxzM280gJ9tQw
         v6zQ==
Received: by 10.216.131.135 with SMTP id m7mr11300704wei.72.1343916705468;
        Thu, 02 Aug 2012 07:11:45 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id ex20sm17517962wid.7.2012.08.02.07.11.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Aug 2012 07:11:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8Av_ODO--DAsznP8R6DnOP_GQXKxVQDKeVYg=E3mZUnEQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202779>


On 08/02, Nguyen Thai Ngoc Duy wrote:
> On Thu, Aug 2, 2012 at 6:01 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > @@ -1785,7 +1785,7 @@ void update_index_if_able(struct index_state *istate, struct lock_file *lockfile
> >                 rollback_lock_file(lockfile);
> >  }
> >
> > -int write_index(struct index_state *istate, int newfd)
> > +int write_index_v2(struct index_state *istate, int newfd)
> >  {
> >         git_SHA_CTX c;
> >         struct cache_version_header hdr;
> 
> make it static function too (and read_index_v2 too, I think)
> -- 
> Duy

Makes sense, thanks!
