From: friedan@muon.rutgers.edu
Subject: Re: 'git commit --short' without touching index?
Date: Sat, 03 Jul 2010 10:08:32 +0000
Message-ID: <4C2F0C20.1020004@muon.rutgers.edu>
References: <loom.20100703T102242-536@post.gmane.org> <20100703091748.GA11714@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 03 12:34:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OV02u-0001Ii-7E
	for gcvg-git-2@lo.gmane.org; Sat, 03 Jul 2010 12:34:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075Ab0GCKdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jul 2010 06:33:50 -0400
Received: from whitelist-out.rutgers.edu ([128.6.68.238]:62882 "EHLO
	annwn41.rutgers.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754902Ab0GCKdu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jul 2010 06:33:50 -0400
X-Greylist: delayed 1512 seconds by postgrey-1.27 at vger.kernel.org; Sat, 03 Jul 2010 06:33:50 EDT
Received: from localhost (localhost [127.0.0.1])
	by annwn41.rutgers.edu (Postfix) with ESMTP id A2C03748009;
	Sat,  3 Jul 2010 06:08:36 -0400 (EDT)
X-Virus-Scanned: Virus Scanned by NBCS 
Received: from annwn41.rutgers.edu ([127.0.0.1])
	by localhost (annwn41.rutgers.edu [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d1QLx+K2ZxBj; Sat,  3 Jul 2010 06:08:36 -0400 (EDT)
Received: from MBP-2.local (194-144-14-254.du.xdsl.is [194.144.14.254])
	by annwn41.rutgers.edu (Postfix) with ESMTPSA id 1F79A748008;
	Sat,  3 Jul 2010 06:08:34 -0400 (EDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.4) Gecko/20100608 Thunderbird/3.1
In-Reply-To: <20100703091748.GA11714@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150186>

Thanks.  Your suggestion seems to work.  Much appreciated.

Daniel

On 2010.07.03 9:17 AM, Jeff King wrote:
> However, both "status" and "commit --dry-run" will opportunistically
> refresh the index. If you don't want to touch the index at all, you can
> use a combination of:
> 
>   # show changes between HEAD and index
>   git diff-index HEAD
> 
>   # show changes between index and working tree
>   git diff-files
> 
>   # show untracked files
>   git ls-files --exclude-standard -o
> 
