From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [RFC 0/16] Introduce index file format version 5
Date: Fri, 3 Aug 2012 14:46:32 +0200
Message-ID: <20120803124632.GD3226@tgummerer.unibz.it>
References: <1343905326-23790-1-git-send-email-t.gummerer@gmail.com>
 <CACsJy8AQUwb8noutwdcN-6Piyo1rrj7_EUMjrXB-83J9AtM6kQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	gitster@pobox.com, robin.rosenberg@dewire.com
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 14:46:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SxHH7-0002s6-5h
	for gcvg-git-2@plane.gmane.org; Fri, 03 Aug 2012 14:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753892Ab2HCMqg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Aug 2012 08:46:36 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62538 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753842Ab2HCMqf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2012 08:46:35 -0400
Received: by wgbdr13 with SMTP id dr13so619815wgb.1
        for <git@vger.kernel.org>; Fri, 03 Aug 2012 05:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DVXdHz+P+ee5ZoE4c2nduZcmIH8pP3ow7YVw2BnSLZw=;
        b=msBSrgPKQqmWWBVYidAVXlY/7sUIXui85rbyuV42UVSB1ut+AmBqdOIJjZ7eMU8FaU
         SLYUpbBNb8sGPkVo4X/bP1AYQbQKdDf22TGAgt3/5Ek7qtLvtsslgSAo9L2JWbWpvMwH
         22VwSFpF+0tQYtSqAsGmTnJOp/2ubWc1jqVvlhYmEU5sq2AOs29Q6/YvUQdgb5OUiEKI
         yLGYs9+CsJl5rPyuJKFnRbBOYx2aJ/UU2X/JYn/3M82hy5n5oDlfxnLhWoL0KSIFU+YJ
         7/zTZ2W3fmAYqdysqViOuuQh7cg25QmQlHgVsmIceh4cUWqVHRHnj4Zk3jaSze/cDIh8
         ocZw==
Received: by 10.180.81.66 with SMTP id y2mr4096560wix.22.1343997994398;
        Fri, 03 Aug 2012 05:46:34 -0700 (PDT)
Received: from localhost ([46.18.27.126])
        by mx.google.com with ESMTPS id t8sm39323575wiy.3.2012.08.03.05.46.33
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 03 Aug 2012 05:46:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CACsJy8AQUwb8noutwdcN-6Piyo1rrj7_EUMjrXB-83J9AtM6kQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202836>

On 08/03, Nguyen Thai Ngoc Duy wrote:
> On Thu, Aug 2, 2012 at 6:01 PM, Thomas Gummerer <t.gummerer@gmail.com> wrote:
> > Series of patches to introduce the index version 5 file format. This
> > series does not include any fancy stuff like partial loading or partial
> > writing yet, though it's possible to do that with the new format.
> 
> I applied the series on top of master. I had to manually resolve
> 09/16. You may want to rebase the series on master for the reroll
> (less work for Junio) and remove trailing whitespaces in the patches.

Thanks, I'll do that for the reroll.

> All tests passed (with v5 by default (*), I notice it now), which is
> wonderful. I'll have a closer look on the following days. Thank you
> for working on this.
> 
> (*) while it's good to run tests with v5 by default. I'm not sure if
> we should make it by default in the next git release that comes with
> v5. For one thing it'll stop older gits from using shared repos. And
> we're not sure whether v5 introduces significant overhead in common
> use cases.

I didn't intent to make index v5 the format, I just oversaw the hunk
that was changing it. I completely agree that v5 should not be default
yet to avoid any surprises, also for users of jgit, libgit2 etc.
