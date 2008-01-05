From: Jeff Garzik <jeff@garzik.org>
Subject: Re: Trouble importing from public CVS repo
Date: Fri, 04 Jan 2008 19:40:26 -0500
Message-ID: <477ED1FA.1070102@garzik.org>
References: <477EA7F6.1010608@garzik.org> <BAYC1-PASMTP15EA2E9A1145CD66AF7C4DAE4C0@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Matthias Urlichs <smurf@smurf.noris.de>
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Sat Jan 05 01:41:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JAx6U-0000EY-W7
	for gcvg-git-2@gmane.org; Sat, 05 Jan 2008 01:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755230AbYAEAkf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Jan 2008 19:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755261AbYAEAkf
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Jan 2008 19:40:35 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:45564 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755230AbYAEAk3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Jan 2008 19:40:29 -0500
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.66 #1 (Red Hat Linux))
	id 1JAx5P-0006YA-J2; Sat, 05 Jan 2008 00:40:28 +0000
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
In-Reply-To: <BAYC1-PASMTP15EA2E9A1145CD66AF7C4DAE4C0@CEZ.ICE>
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.2.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69622>

Sean wrote:
> diff --git a/git-cvsimport.perl b/git-cvsimport.perl
> index 6d8ff93..357665d 100755
> --- a/git-cvsimport.perl
> +++ b/git-cvsimport.perl
> @@ -421,7 +421,7 @@ sub _line {
>  			$res += $self->_fetchfile($fh, $cnt);
>  		} else {
>  			chomp $line;
> -			if ($line eq "ok") {
> +			if ($line eq "ok" or $line =~ /^error/i) {
>  				# print STDERR "S: ok (".length($res).")\n";
>  				return $res;
>  			} elsif ($line =~ s/^E //) {

Kick ass, this local hack worked quite well.  Thanks :)

	Jeff
