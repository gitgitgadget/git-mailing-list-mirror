From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/4] gitweb: blame table row no highlight fix
Date: Fri, 04 Aug 2006 16:58:42 -0700
Message-ID: <7v4pwshx3h.fsf@assigned-by-dhcp.cox.net>
References: <20060804220959.8423.qmail@web31810.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 01:58:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G99Z1-0001eB-GS
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 01:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161591AbWHDX6o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 19:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161592AbWHDX6o
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 19:58:44 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:5780 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1161591AbWHDX6n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 19:58:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060804235843.QLUW27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Aug 2006 19:58:43 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060804220959.8423.qmail@web31810.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Fri, 4 Aug 2006 15:09:59 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24865>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Until now blame just used the commit/tree/tags/etc style of
> highlight-able table rows, which have strictly alternating
> light/dark rows. This is very annoying in blame, since the
> text is static and it interferes with the per-revision block
> highlight.
>
> Signed-off-by: Luben Tuikov <ltuikov@yahoo.com>
> ---
>  gitweb/gitweb.css  |    4 ++++
>  gitweb/gitweb.perl |    2 +-
>  2 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
> index 460e728..47c1ade 100644
> --- a/gitweb/gitweb.css
> +++ b/gitweb/gitweb.css
> @@ -171,6 +171,10 @@ tr.dark {
>  	background-color: #f6f6f0;
>  }
>  
> +tr.dark2 {
> +	background-color: #f6f6f0;
> +}
> +
>  tr.dark:hover {
>  	background-color: #edece6;
>  }
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 58eb5b1..049f27e 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1493,7 +1493,7 @@ sub git_blame2 {
>  	git_page_nav('','', $hash_base,$co{'tree'},$hash_base, $formats_nav);
>  	git_header_div('commit', esc_html($co{'title'}), $hash_base);
>  	git_print_page_path($file_name, $ftype);
> -	my @rev_color = (qw(light dark));
> +	my @rev_color = (qw(light2 dark2));
>  	my $num_colors = scalar(@rev_color);
>  	my $current_color = 0;
>  	my $last_rev;

I do not see "tr.light" but "tr.light:hover" in the original
CSS.  That is kind of understandable (unhovered light ones just
use default), but this patch completely lost me.  You use light2
class but nothing affects that class in the CSS.

Maybe it is the commit log message that is misleading?  I guess
what you are trying to achieve is to disable the color change
that follows the pointer?
