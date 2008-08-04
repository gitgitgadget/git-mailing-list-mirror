From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 1/1] Add "git" link to the end of project line on the
	project_list page.
Date: Mon, 4 Aug 2008 04:26:56 +0200
Message-ID: <20080804022656.GA32184@machine.or.cz>
References: <1217815217-11329-1-git-send-email-warthog19@eaglescrag.net> <1217815217-11329-2-git-send-email-warthog19@eaglescrag.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	John 'Warthog9' Hawley <warthog9@eaglescrag.net>
To: warthog19@eaglescrag.net
X-From: git-owner@vger.kernel.org Mon Aug 04 04:28:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPpnq-0001MP-P7
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 04:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754115AbYHDC1A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 22:27:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753946AbYHDC1A
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 22:27:00 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58357 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754102AbYHDC07 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 22:26:59 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id CB21E393B308; Mon,  4 Aug 2008 04:26:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1217815217-11329-2-git-send-email-warthog19@eaglescrag.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91306>

On Sun, Aug 03, 2008 at 07:00:17PM -0700, warthog19@eaglescrag.net wrote:
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 90cd99b..c33f4ed 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -108,6 +108,14 @@ our $mimetypes_file = undef;
>  # could be even 'utf-8' for the old behavior)
>  our $fallback_encoding = 'latin1';
>  
> +# enable / disable a final link on the project list page
> +# that will be the location of that actuall git url
> +# it will output this in the format:
> +# git://hostname/path/to/tree.git
> +# disabled = blank or undef
> +# enable = url to prefix before filling in the trailing path to the git repo
> +our $projectlist_gitlinkurl = undef;
> +
>  # rename detection options for git-diff and git-diff-tree
>  # - default is '-M', with the cost proportional to
>  #   (number of removed files) * (number of new files).

Note that I will soon submit a generic patch that lets you extend
the link lists with custom entries - you could easily use that for
the git links (I'm personally not convinced how useful they really are
on the project list page), I will use them for the graphiclog, edit and
fork links at repo.or.cz.

> +                        print " | ". $cgi->a({-href => "git://projectlist_gitlinkurl/".esc_html($pr->{'path'})}, "git");

You meant $projectlist_gitlinkurl.


-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
