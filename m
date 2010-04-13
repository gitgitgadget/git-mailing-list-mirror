From: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
Subject: Re: TODO: git should be able to init a remote repo
Date: Tue, 13 Apr 2010 22:58:26 +0300
Message-ID: <20100413195826.GA11597@LK-Perkele-V2.elisa-laajakaista.fi>
References: <i2i76718491004131030sc2f8ffa3u97a91aa9a57923b5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 13 21:59:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1mGo-0001Oe-Ak
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 21:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752529Ab0DMT7W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Apr 2010 15:59:22 -0400
Received: from emh05.mail.saunalahti.fi ([62.142.5.111]:55726 "EHLO
	emh05.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752837Ab0DMT7U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Apr 2010 15:59:20 -0400
Received: from saunalahti-vams (vs3-10.mail.saunalahti.fi [62.142.5.94])
	by emh05-2.mail.saunalahti.fi (Postfix) with SMTP id 3B70F8C49E;
	Tue, 13 Apr 2010 22:59:18 +0300 (EEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109])
	by vs3-10.mail.saunalahti.fi ([62.142.5.94])
	with SMTP (gateway) id A03CEE387FB; Tue, 13 Apr 2010 22:59:18 +0300
Received: from LK-Perkele-V2 (a88-112-50-174.elisa-laajakaista.fi [88.112.50.174])
	by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 27E29158A63;
	Tue, 13 Apr 2010 22:59:15 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <i2i76718491004131030sc2f8ffa3u97a91aa9a57923b5@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Antivirus: VAMS
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144828>

On Tue, Apr 13, 2010 at 01:30:44PM -0400, Jay Soffian wrote:
> [Mostly I'm sending this so I can add a "TODO" label to it in my gmail.] :-)
> 
> With modern git, setting up a remote bare repo that you can push to is
> finally down to a reasonable number of commands:
> 
> $ ssh remote git init --bare myproject.git
> $ git remote add -m master origin remote:myproject.git
> $ git push -u origin master
> 
> But we can do better. I was thinking something like:
> 
> $ git remote init [--push] [--mirror] <name> <ssh_url>
> 
> This would perform all of the steps above, except for the push itself,
> unless given --push (in which case, that too). This is meant to
> simplify what I believe is the common case of setting up remote repos.

Couple of concerns:

- That seems awfully ssh-specific[1]...
- How remote end could deny the operation, modify paths and/or 
get post-creation notification?
- How to handle systems that would autocreate the repository anyway
if push was attempted?

[1] Well, its not like one would want to do that with gits:// anyway,
since there's probably gitolite install on other end anyway...

-Ilari
