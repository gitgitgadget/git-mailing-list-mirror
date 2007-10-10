From: Frank Lichtenheld <frank@lichtenheld.de>
Subject: Re: [PATCH] git-cvsserver: added support for update -p
Date: Wed, 10 Oct 2007 22:00:30 +0200
Message-ID: <20071010200029.GK31659@planck.djpig.de>
References: <200710101316.03633.jan@swi-prolog.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Jan Wielemaker <jan@swi-prolog.org>
X-From: git-owner@vger.kernel.org Wed Oct 10 22:01:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ifhjg-0006oS-24
	for gcvg-git-2@gmane.org; Wed, 10 Oct 2007 22:00:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012AbXJJUAn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2007 16:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755147AbXJJUAn
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Oct 2007 16:00:43 -0400
Received: from planck.djpig.de ([85.10.192.180]:3096 "EHLO planck.djpig.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754970AbXJJUAm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2007 16:00:42 -0400
Received: from localhost (localhost [127.0.0.1])
	by planck.djpig.de (Postfix) with ESMTP id 89D9488231;
	Wed, 10 Oct 2007 22:00:40 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at planck.djpig.de
Received: from planck.djpig.de ([127.0.0.1])
	by localhost (planck.djpig.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 477CgP7-raOs; Wed, 10 Oct 2007 22:00:30 +0200 (CEST)
Received: by planck.djpig.de (Postfix, from userid 1000)
	id 9826688232; Wed, 10 Oct 2007 22:00:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200710101316.03633.jan@swi-prolog.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60536>

On Wed, Oct 10, 2007 at 01:16:03PM +0200, Jan Wielemaker wrote:
> +	# if we have a -p we should just send the file
> +        if ( exists ( $state->{opt}{p} ) )
> +	{
> +	    if ( open my $fh, '-|', "git-cat-file", "blob", $meta->{filehash} )
> +	    {   while ( <$fh> )
> +		{ print "M " . $_;
> +		}
> +		close $fh or die ("Couldn't close filehandle for transmitfile(): $!");
> +	    } else
> +	    { die("Couldn't execute git-cat-file");
> +	    }
> +
> +	    next;
> +	}


There seems to be inconsistent whitespace in the patch.
And please never do that else\n{ again, it hurts my eye ;)

Will try to test (and write a testcase for) it tomorrow. 

Gruesse,
-- 
Frank Lichtenheld <frank@lichtenheld.de>
www: http://www.djpig.de/
