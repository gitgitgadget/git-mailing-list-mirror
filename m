From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH 2/2] gitweb: Show trailing slash when listing tree entry in tree listing
Date: Sat, 7 Oct 2006 11:44:18 -0700 (PDT)
Message-ID: <20061007184418.64881.qmail@web31812.mail.mud.yahoo.com>
References: <20061007141043.16912.73982.stgit@rover>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 20:44:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWH9q-0003Dr-Ci
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 20:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWJGSoT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 14:44:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWJGSoT
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 14:44:19 -0400
Received: from web31812.mail.mud.yahoo.com ([68.142.207.75]:8825 "HELO
	web31812.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751832AbWJGSoT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Oct 2006 14:44:19 -0400
Received: (qmail 64883 invoked by uid 60001); 7 Oct 2006 18:44:18 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=pP5kHXTO2g5PBrrCiKWgHJdHfZ8bNv7iiZbVBZKKsz2i5miXSypKTIrN6i6dXMjOEuQsv39n/4Uo4so9zvSYc6tvJ4a4Tbrgxw/q8Avgt8s8ZtI3XSzR6+Er3t9FMxvaeuZs20qAhSF49YK5VaGFwM7IrPLYbEfPNG84l77wggs=  ;
Received: from [71.80.233.118] by web31812.mail.mud.yahoo.com via HTTP; Sat, 07 Oct 2006 11:44:18 PDT
To: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>
In-Reply-To: <20061007141043.16912.73982.stgit@rover>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28494>

--- Petr Baudis <pasky@suse.cz> wrote:
> Signed-off-by: Petr Baudis <pasky@suse.cz>
> ---

First, this is a Unixism, and would confuse other OS users.
Second, "/" is after all _not part of the name_ of the tree/directory,
but part of the filesystem's path separator, let's not export it
to users of other OS's.
Third, directories/trees are already clearly 
  1) underlined, and
  2) differently colored,
which makes it overly obvious what it what.

In fact, my eyes only scan for the different color/underlined
entries when I'm searching for a directory in tree view.  I don't even
look at the left-most column.

NACK!

   Luben

> 
>  gitweb/gitweb.perl |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
> index 096a01b..c3d09a2 100755
> --- a/gitweb/gitweb.perl
> +++ b/gitweb/gitweb.perl
> @@ -1791,7 +1791,7 @@ sub git_print_tree_entry {
>  		print "<td class=\"list\">";
>  		print $cgi->a({-href => href(action=>"tree", hash=>$t->{'hash'},
>  		                             file_name=>"$basedir$t->{'name'}", %base_key)},
> -		              esc_html($t->{'name'}));
> +		              esc_html($t->{'name'} . '/'));
>  		print "</td>\n";
>  		print "<td class=\"link\">";
>  		if (defined $hash_base) {
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
