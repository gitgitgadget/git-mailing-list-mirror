From: "W. Trevor King" <wking@tremily.us>
Subject: Re: [PATCH v3 1/3] git-submodule add: Add -r/--record option
Date: Sat, 10 Nov 2012 14:11:11 -0500
Message-ID: <20121110191111.GE2739@mjolnir>
References: <20121029222759.GI20513@sigill.intra.peff.net>
 <cover.1352431674.git.wking@tremily.us>
 <fb2d915cf60160c200b84df88c6112c1c2d4eefd.1352431674.git.wking@tremily.us>
 <20121109104607.GC4406@ftbfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git <git@vger.kernel.org>
To: Matt Kraai <kraai@ftbfs.org>
X-From: git-owner@vger.kernel.org Sat Nov 10 20:12:51 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TXGU4-0003fe-H0
	for gcvg-git-2@plane.gmane.org; Sat, 10 Nov 2012 20:12:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751871Ab2KJTLu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2012 14:11:50 -0500
Received: from vms173001pub.verizon.net ([206.46.173.1]:48602 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab2KJTLu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2012 14:11:50 -0500
Received: from mjolnir.tremily.us ([unknown] [69.141.221.103])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MDA009RRDAUN300@vms173001.mailsrvcs.net> for
 git@vger.kernel.org; Sat, 10 Nov 2012 13:11:34 -0600 (CST)
Received: by mjolnir.tremily.us (Postfix, from userid 1000)
	id B86EA271EAF; Sat, 10 Nov 2012 14:11:11 -0500 (EST)
Content-disposition: inline
In-reply-to: <20121109104607.GC4406@ftbfs.org>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209292>

On Fri, Nov 09, 2012 at 02:46:07AM -0800, Matt Kraai wrote:
> On Thu, Nov 08, 2012 at 10:35:12PM -0500, W. Trevor King wrote:
> > @@ -366,6 +379,10 @@ Use -f if you really want to add it." >&2
> >  
> >  	git config -f .gitmodules submodule."$sm_path".path "$sm_path" &&
> >  	git config -f .gitmodules submodule."$sm_path".url "$repo" &&
> > +	if test -n "$branch"
> > +	then
> > +		git config -f .gitmodules submodule."$sm_path".branch "$record_branch"
> > +	fi &&
> >  	git add --force .gitmodules ||
> >  	die "$(eval_gettext "Failed to register submodule '\$sm_path'")"
> >  }
> 
> Should the if condition test that $record_branch is not the empty
> string instead of testing that $branch is not the empty string?  It
> seems like this will set submodule."$sm_path".branch to the empty
> string if -b is specified and no -r option is specified.

Oops, thanks for catching that.  Will fix with v4, once we figure out
what to do about the semantic-pull situation.

-- 
This email may be signed or encrypted with GnuPG (http://www.gnupg.org).
For more information, see http://en.wikipedia.org/wiki/Pretty_Good_Privacy
