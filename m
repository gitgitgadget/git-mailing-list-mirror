From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCHv4] gitweb: parse project/action/hash_base:filename
	PATH_INFO
Date: Fri, 3 Oct 2008 00:04:39 +0200
Message-ID: <20081002220439.GX10360@machine.or.cz>
References: <1222906234-8182-1-git-send-email-giuseppe.bilotta@gmail.com> <1222906234-8182-2-git-send-email-giuseppe.bilotta@gmail.com> <20081002153403.GQ10360@machine.or.cz> <cb7bb73a0810021230u2ec512c0l577b3146cffccb3e@mail.gmail.com> <20081002205603.GW10360@machine.or.cz> <cb7bb73a0810021405j68b0a164i9469e64afc543ebf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 03 00:05:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlWIz-000584-Hw
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 00:05:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754632AbYJBWEm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Oct 2008 18:04:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754615AbYJBWEm
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Oct 2008 18:04:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48578 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754598AbYJBWEl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Oct 2008 18:04:41 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id EF50B3939B43; Fri,  3 Oct 2008 00:04:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <cb7bb73a0810021405j68b0a164i9469e64afc543ebf@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97378>

On Thu, Oct 02, 2008 at 11:05:18PM +0200, Giuseppe Bilotta wrote:
> In preparing the new patchset, I've put a big comment block explaining
> why we need to set both $hash and $hash_base in this code-path:
> 
> # we got "project.git/[action/]branch". in this case
> # we set both $hash and $hash_base because different actions
> # need one or the other to be set to behave correctly.
> #
> # For example, if $hash_base is not set then the blob and
> # history links on the page project.git/tree/somebranch will
> # assume a $hash_base of HEAD instead of the correct
> # somebranch.
> # Conversely, not setting $hash will make URLs such as
> # project.git/shortlog/somebranch display the wrong page.
> #
> # Since it also turns out that the unused one is properly
> # overwritten as needed, setting both is quite safe.

  Ok, but is this related to the pathinfo changes? Or is this fixing a
separate bug? (Not that I would want to bother you with splitting this,
but you should at least mention it in the commit message... and it's
fairly isolated anyway.)

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism, but they have
cold baths.
