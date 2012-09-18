From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH/RFC 5/5] Git::SVN: rename private path field
Date: Tue, 18 Sep 2012 00:07:37 +0000
Message-ID: <20120918000737.GA17939@dcvr.yhbt.net>
References: <1343419252-9447-1-git-send-email-schwern@pobox.com>
 <1343419252-9447-2-git-send-email-schwern@pobox.com>
 <20120917090435.GA358@elie.Belkin>
 <20120917091331.GF358@elie.Belkin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com, robbat2@gentoo.org,
	bwalton@artsci.utoronto.ca,
	"Michael G. Schwern" <schwern@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 02:07:53 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDlLw-0004xD-D6
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 02:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755601Ab2IRAHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2012 20:07:39 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:40081 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754084Ab2IRAHi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2012 20:07:38 -0400
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 892741F546;
	Tue, 18 Sep 2012 00:07:37 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20120917091331.GF358@elie.Belkin>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205771>

Jonathan Nieder <jrnieder@gmail.com> wrote:
> All users of $gs->{path} should have been converted to use the
> accessor by now.  Check our work by renaming the underlying variable
> to break callers that try to use it directly.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>

I think this is a good patch for master, too.  Thanks.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

> ---
>  perl/Git/SVN.pm |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> -- 

I'll apply the following (on top of a patch which fixes some
{path} usages):

diff --git a/perl/Git/SVN.pm b/perl/Git/SVN.pm
index 88b9164..59215fa 100644
--- a/perl/Git/SVN.pm
+++ b/perl/Git/SVN.pm
@@ -2331,11 +2331,11 @@ sub path {
 
 	if (@_) {
 		my $path = shift;
-		$self->{path} = canonicalize_path($path);
+		$self->{_path} = canonicalize_path($path);
 		return;
 	}
 
-	return $self->{path};
+	return $self->{_path};
 }
 
 sub url {
