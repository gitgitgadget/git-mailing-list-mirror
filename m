From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH v2 1/2] Ensure consistent usage of mergetool.keepBackup
	in git
Date: Sat, 11 Apr 2009 13:04:35 +0100
Message-ID: <20090411120435.GB10381@hashpling.org>
References: <20090409153033.GN23604@spearce.org> <f6297e57a23dc3abac2fcedceb00cecde607de02.1239291673.git.ferry.huberts@pelagic.nl> <20090410032731.GA1545@gmail.com> <49DEEE22.5030500@pelagic.nl> <20090410074327.GA9369@gmail.com> <20090410081843.GB9369@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 11 14:06:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LsbyV-0000yf-Ew
	for gcvg-git-2@gmane.org; Sat, 11 Apr 2009 14:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755756AbZDKMEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Apr 2009 08:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753741AbZDKMEm
	(ORCPT <rfc822;git-outgoing>); Sat, 11 Apr 2009 08:04:42 -0400
Received: from relay.pcl-ipout01.plus.net ([212.159.7.99]:11830 "EHLO
	relay.pcl-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754500AbZDKMEl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 11 Apr 2009 08:04:41 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEANYj4EnUnw6S/2dsb2JhbADJZ4N8Bg
Received: from ptb-relay02.plus.net ([212.159.14.146])
  by relay.pcl-ipout01.plus.net with ESMTP; 11 Apr 2009 13:04:37 +0100
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1Lsbwr-0002DQ-1a; Sat, 11 Apr 2009 13:04:37 +0100
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n3BC4aJe011224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 11 Apr 2009 13:04:36 +0100
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n3BC4ZYX011223;
	Sat, 11 Apr 2009 13:04:35 +0100
Content-Disposition: inline
In-Reply-To: <20090410081843.GB9369@gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: a8fc8b4a2f4ecf37bf314a3294ac6d53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116295>

On Fri, Apr 10, 2009 at 01:18:44AM -0700, David Aguilar wrote:
> On  0, David Aguilar <davvid@gmail.com> wrote:
> > 
> > It /seems/ like the docs and completion should be updated.
> 
> Though my guess is as good as any....
> I'd rather hear someone else's opinion.
> 
> $ git log -p 44c36d1c
> commit 44c36d1ccc9a40bfb31910dfd7e18d59fa8be502
> Author: Charles Bailey <charles@hashpling.org>
> Date:   Thu Feb 21 23:30:02 2008 +0000
> 
>     Tidy up git mergetool's backup file behaviour
>     
>     Currently a backup pre-merge file with conflict markers is sometimes
>     kept with a .orig extenstion and sometimes removed depending on the
>     particular merge tool used.
>     
>     This patch makes the handling consistent across all merge tools and
>     configurable via a new mergetool.keepBackup config variable
>     
>     Signed-off-by: Charles Bailey <charles@hashpling.org>
>     Signed-off-by: Junio C Hamano <gitster@pobox.com>
> 
> 
> The commit comment says mergetool.keepBackup, even though the code always
> had it as merge.keepBackup.

Not going by the commit message, but rather by the documentation I do
believe that mergetool.keepBackup should have been the correct
variable to use. I'm not sure why I missed this at the time.

I seem to remember looking for existing consistency in this before.
Originally I was going on the premise that merge.* were things that
were general between merges and all mergetools whereas mergetool.*
were things that were merge tool specific. Subsequently, it was more
natural to have mergetool.$tool.* for things that were tool specifit
and to have mergetool.* as general mergetool specific settings,
leaving merge.* as merge specific settings with the exception of
merge.tool which is obviously specific to git mergetool, but is in the
merge.* section.

-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
