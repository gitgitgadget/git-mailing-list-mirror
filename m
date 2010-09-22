From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Restore annotated tag?
Date: Wed, 22 Sep 2010 11:23:53 -0700
Message-ID: <20100922182353.GO32601@spearce.org>
References: <AANLkTinafiikD0Lzgw2gw1ti2pCK6cSTk5bQZFcCRJnS@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Sep 22 20:24:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyTz9-0005xm-Mk
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 20:24:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754334Ab0IVSX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Sep 2010 14:23:56 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53812 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752187Ab0IVSX4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Sep 2010 14:23:56 -0400
Received: by iwn5 with SMTP id 5so704436iwn.19
        for <git@vger.kernel.org>; Wed, 22 Sep 2010 11:23:55 -0700 (PDT)
Received: by 10.231.151.135 with SMTP id c7mr404427ibw.184.1285179835450;
        Wed, 22 Sep 2010 11:23:55 -0700 (PDT)
Received: from localhost (yellowpostit.mtv.corp.google.com [172.18.104.34])
        by mx.google.com with ESMTPS id g31sm10722153ibh.16.2010.09.22.11.23.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 22 Sep 2010 11:23:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTinafiikD0Lzgw2gw1ti2pCK6cSTk5bQZFcCRJnS@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156819>

skillzero@gmail.com wrote:
> Is there a way to restore an annotated tag? One was accidentally
> deleted and pushed. I can restore normal tags by just using git tag
> again, but for an annotated tag, there's a tag object and I'm not sure
> how to restore it.

If the tag still exists, `git fsck --unreachable | grep tag` should
show you output listing the dangling tag objects.  Once you have that
list, use `git show SHA1` to view the object.  When you find the tag,
make a reference to it with `git update-ref refs/tags/NAME SHA1`.

-- 
Shawn.
