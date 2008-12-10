From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 1/3] gitweb: Move 'lineno' id from link to row element in git_blame
Date: Tue, 9 Dec 2008 21:55:18 -0800 (PST)
Message-ID: <661413.30278.qm@web31807.mail.mud.yahoo.com>
References: <20081209224330.28106.18301.stgit@localhost.localdomain>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 10 07:03:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LAIAS-0000wX-9K
	for gcvg-git-2@gmane.org; Wed, 10 Dec 2008 07:03:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751801AbYLJGCA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2008 01:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752970AbYLJGCA
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Dec 2008 01:02:00 -0500
Received: from web31807.mail.mud.yahoo.com ([68.142.207.70]:20942 "HELO
	web31807.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751730AbYLJGCA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2008 01:02:00 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 Dec 2008 01:01:59 EST
Received: (qmail 30322 invoked by uid 60001); 10 Dec 2008 05:55:18 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:X-Mailer:Date:From:Reply-To:Subject:To:In-Reply-To:MIME-Version:Content-Type;
  b=b0xPPoDfidgaCy4rPDtMtTy0QiUQMHkjSbR43h/FV+NjSgou/Wgq9r5lxB3m9ndJr+YgxUjk1OT2AAtzFohdIfx672A3AwFbC+W6kk13zknRWgUw7c5k/8aAC6qL+xVKa2omjNYJmQ/8D4yrGogR3ewmGQplRI9N1n9tfuFNnw0=  ;
Received: from [71.132.209.19] by web31807.mail.mud.yahoo.com via HTTP; Tue, 09 Dec 2008 21:55:18 PST
X-Mailer: YahooMailWebService/0.7.260.1
In-Reply-To: <20081209224330.28106.18301.stgit@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102666>


--- On Tue, 12/9/08, Jakub Narebski <jnareb@gmail.com> wrote:
> From: Jakub Narebski <jnareb@gmail.com>
> Subject: [PATCH 1/3] gitweb: Move 'lineno' id from link to row element in git_blame
> To: git@vger.kernel.org
> Cc: "Luben Tuikov" <ltuikov@yahoo.com>, "Jakub Narebski" <jnareb@gmail.com>
> Date: Tuesday, December 9, 2008, 2:46 PM
> Move l<line number> ID from <a> link element
> inside table row (inside
> cell element for column with line numbers), to encompassing
> <tr> table
> row element.  It was done to make it easier to manipulate
> result HTML
> with DOM, and to be able write 'blame_incremental'
> view with the same,
> or nearly the same result.
> 
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Acked-by: Luben Tuikov <ltuikov@yahoo.com>

   Luben

> ---
> For blame_incremental I need easy way to manipulate rows of
> blame
> table, to add information about blamed commits as it
> arrives.
> 
> So there it is.
> 
>  gitweb/gitweb.perl |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 6eb370d..1b800f4 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -4645,7 +4645,7 @@ HTML
>  		if ($group_size) {
>  			$current_color = ++$current_color % $num_colors;
>  		}
> -		print "<tr
> class=\"$rev_color[$current_color]\">\n";
> +		print "<tr id=\"l$lineno\"
> class=\"$rev_color[$current_color]\">\n";
>  		if ($group_size) {
>  			print "<td
> class=\"sha1\"";
>  			print " title=\"". esc_html($author)
> . ", $date\"";
> @@ -4667,7 +4667,6 @@ HTML
>  		                  hash_base => $parent_commit);
>  		print "<td
> class=\"linenr\">";
>  		print $cgi->a({ -href =>
> "$blamed#l$orig_lineno",
> -		                -id => "l$lineno",
>  		                -class => "linenr" },
>  		              esc_html($lineno));
>  		print "</td>";
