From: Dan Libby <danda@osc.co.cr>
Subject: Re: [PATCH] git-svnimport: Use separate arguments in the pipe for git-rev-parse
Date: Thu, 20 Sep 2007 13:07:01 -0600
Message-ID: <200709201307.01922.danda@osc.co.cr>
References: <200709161857.06065.danda@osc.co.cr> <200709171333.48331.danda@osc.co.cr> <20070918074753.GQ31176@kiste.smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthias Urlichs <smurf@smurf.noris.de>
X-From: git-owner@vger.kernel.org Thu Sep 20 21:29:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYRi9-000887-Mi
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 21:29:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752935AbXITT3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 15:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752261AbXITT3M
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 15:29:12 -0400
Received: from 207-36-180-175.ptr.primarydns.com ([207.36.180.175]:46329 "EHLO
	mail.osc.co.cr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751960AbXITT3L (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 15:29:11 -0400
X-Greylist: delayed 1325 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Sep 2007 15:29:11 EDT
Received: from [192.168.0.11] (unknown [200.122.156.92])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.osc.co.cr (Postfix) with ESMTP id B68C6D0B95;
	Thu, 20 Sep 2007 12:07:04 -0700 (PDT)
User-Agent: KMail/1.9.4
In-Reply-To: <20070918074753.GQ31176@kiste.smurf.noris.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58801>

Hi, it worked for the small test case.  I am trying it on the large repo now, 
and will let you know how it turns out.  thanks!

On Tuesday 18 September 2007 01:47, Matthias Urlichs wrote:
> Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>
> ---
> Please tell me whether that works for you.
>
> Somebody else, preferably its author, can fix git-svn. ;-)
>
> diff --git a/git-svnimport.perl b/git-svnimport.perl
> index d3ad5b9..aa5b3b2 100755
> --- a/git-svnimport.perl
> +++ b/git-svnimport.perl
> @@ -633,7 +633,7 @@ sub commit {
>
>  	my $rev;
>  	if($revision > $opt_s and defined $parent) {
> -		open(H,"git-rev-parse --verify $parent |");
> +		open(H,'-|',"git-rev-parse","--verify",$parent);
>  		$rev = <H>;
>  		close(H) or do {
>  			print STDERR "$revision: cannot find commit '$parent'!\n";
> --
> 1.5.2.5

-- 
Dan Libby

Open Source Consulting
San Jose, Costa Rica
http://osc.co.cr
phone: 011 506 223 7382
Fax: 011 506 223 7359
