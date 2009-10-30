From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] mergetool--lib: add p4merge as a pre-configured
	mergetool option
Date: Fri, 30 Oct 2009 17:44:21 +0000
Message-ID: <20091030174421.GA21486@hashpling.org>
References: <d411cc4a0910271536u5817802at43f7477dd8ccabc7@mail.gmail.com> <20091027230043.GA11607@hashpling.org> <20091028090022.GA90780@gmail.com> <d411cc4a0910280837h52596089je9ab4d03383d43cc@mail.gmail.com> <d411cc4a0910281439v3388c243v42b3700f73744623@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>, David Aguilar <davvid@gmail.com>
To: Scott Chacon <schacon@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 18:44:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3vWY-0003Fg-Hr
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 18:44:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744AbZJ3RoU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 13:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932735AbZJ3RoT
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 13:44:19 -0400
Received: from relay.ptn-ipout01.plus.net ([212.159.7.35]:43657 "EHLO
	relay.ptn-ipout01.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932724AbZJ3RoT (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Oct 2009 13:44:19 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAIPC6krUnw4T/2dsb2JhbADhS4Q9BIJr
Received: from pih-relay06.plus.net ([212.159.14.19])
  by relay.ptn-ipout01.plus.net with ESMTP; 30 Oct 2009 17:44:23 +0000
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay06.plus.net with esmtp (Exim) id 1N3vWQ-0003Gd-Av; Fri, 30 Oct 2009 17:44:22 +0000
Received: from cayley.hashpling.org (cayley.hashpling.org [192.168.76.254])
	by hashpling.plus.com (8.14.2/8.14.2) with ESMTP id n9UHiLTj022158
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 30 Oct 2009 17:44:21 GMT
Received: (from charles@localhost)
	by cayley.hashpling.org (8.14.2/8.14.2/Submit) id n9UHiL7A022157;
	Fri, 30 Oct 2009 17:44:21 GMT
Content-Disposition: inline
In-Reply-To: <d411cc4a0910281439v3388c243v42b3700f73744623@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Plusnet-Relay: 49b011cfb135505e4df9937ab66f84b9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131720>

On Wed, Oct 28, 2009 at 02:39:32PM -0700, Scott Chacon wrote:
> p4merge is now a built-in diff/merge tool.
> This adds p4merge to git-completion and updates
> the documentation to mention p4merge.
> 
> Signed-Off-By: Scott Chacon <schacon@gmail.com>
> ---

Acked-by: Charles Bailey <charles@hashpling.org>

I'm aware that we haven't reached full agreement on the best way to
make p4merge + git as Mac OS X friendly as possible, but Jay said that
this patch is 'good enough' and I agree. If we go with this for now,
we're not closing the door to further improvements.

I confirmed a (perhaps very minor) issue with the abspath approach,
the parameters are used as the title of the pains in p4merge, so
(IMHO) short paths look neater, especially if you've cd'ed down to a
low  level and don't have a 1920 pixel wide monitor. p4merge does
truncate from the left so it's not a big thing.

The other thing which I confirmed is that p4merge on windows doesn't
like /dev/null as an explicit parameter (it gets convered to nul: by
msys, I believe, but it still doesn't like it).

p4merge does appear to do 'magic' when the base and left are the same
parameter (not just the same file - the magic doesn't work if you,
say, use a relative path and an absolute path to refer to the same
file. This means that it doesn't just take the right changes which is
what I feared it might do when I first saw the 'local' 'local'
'remote' pattern.

Charles.


-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
