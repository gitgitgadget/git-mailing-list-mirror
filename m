From: Sven Verdoolaege <skimo@kotnet.org>
Subject: Re: Another gitweb wishlist
Date: Wed, 21 Sep 2005 22:54:16 +0200
Message-ID: <20050921205416.GU15165MdfPADPa@greensroom.kotnet.org>
References: <20050921201656.GA10575@pasky.or.cz>
Reply-To: skimo@liacs.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: kay.sievers@vrfy.org, ch@gierke.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 22:56:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIBbj-0001Ip-DV
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 22:54:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964826AbVIUUyV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 16:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbVIUUyV
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 16:54:21 -0400
Received: from smtp13.wxs.nl ([195.121.6.27]:40618 "EHLO smtp13.wxs.nl")
	by vger.kernel.org with ESMTP id S964826AbVIUUyU (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 16:54:20 -0400
Received: from greensroom.kotnet.org (ip54515aaa.direct-adsl.nl [84.81.90.170])
 by smtp13.wxs.nl (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with SMTP id <0IN600L85Q2GR1@smtp13.wxs.nl> for git@vger.kernel.org; Wed,
 21 Sep 2005 22:54:17 +0200 (CEST)
Received: (qmail 28808 invoked by uid 500); Wed, 21 Sep 2005 20:54:16 +0000
In-reply-to: <20050921201656.GA10575@pasky.or.cz>
To: Petr Baudis <pasky@suse.cz>
Mail-followup-to: Petr Baudis <pasky@suse.cz>, kay.sievers@vrfy.org,
 ch@gierke.de, git@vger.kernel.org
Content-disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9076>

On Wed, Sep 21, 2005 at 10:16:56PM +0200, Petr Baudis wrote:
>   (ii) I need persistent links to the latest version of <file>. Obvious
> 
> 	http://kernel.org/git/?p=cogito/cogito.git;a=blob;f=contrib/ciabot.pl
> 

Works for me:
http://www.liacs.nl/~sverdool/gitweb.cgi?p=barvinok.git;a=blob;f=README

It's probably this one:

diff --git a/gitweb.cgi b/gitweb.cgi
--- a/gitweb.cgi
+++ b/gitweb.cgi
@@ -1269,9 +1269,9 @@ sub git_get_hash_by_path {
 }
 
 sub git_blob {
+	$hash_base ||= git_read_hash("$project/HEAD");
 	if (!defined $hash && defined $file_name) {
-		my $base = $hash_base || git_read_hash("$project/HEAD");
-		$hash = git_get_hash_by_path($base, $file_name, "blob");
+		$hash = git_get_hash_by_path($hash_base, $file_name, "blob");
 	}
 	open my $fd, "-|", "$gitbin/git-cat-file blob $hash" or die_error(undef, "Open failed.");
 	my $base = $file_name || "";

skimo
