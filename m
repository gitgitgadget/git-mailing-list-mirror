From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] Fix clone not to ignore depth when performing a local clone
Date: Tue, 11 Dec 2007 18:26:03 +0000
Message-ID: <20071211182603.GA4063@hashpling.org>
References: <20071211064731.GA30525@hashpling.org> <Pine.LNX.4.64.0712111154070.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 11 19:27:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J29ox-0003s7-Ea
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 19:27:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593AbXLKS0K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 13:26:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755558AbXLKS0I
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 13:26:08 -0500
Received: from pih-relay04.plus.net ([212.159.14.131]:33872 "EHLO
	pih-relay04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755058AbXLKS0G (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 13:26:06 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by pih-relay04.plus.net with esmtp (Exim) id 1J29nx-0003Tq-Gz; Tue, 11 Dec 2007 18:26:05 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id lBBIQ3I8004371;
	Tue, 11 Dec 2007 18:26:03 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id lBBIQ38v004369;
	Tue, 11 Dec 2007 18:26:03 GMT
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712111154070.27959@racer.site>
User-Agent: Mutt/1.4.2.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67899>

On Tue, Dec 11, 2007 at 11:54:54AM +0000, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 11 Dec 2007, Charles Bailey wrote:
> 
> > @@ -205,7 +205,10 @@ fi
> >  # it is local
> >  if base=$(get_repo_base "$repo"); then
> >  	repo="$base"
> > -	local=yes
> > +	if test -z "$depth"
> > +	then
> > +		local=yes
> > +	fi
> >  fi
> 
> Or shorter:
> 
> -	local=yes
> +	test -z "$depth" && local=yes
> 
> Ciao,
> Dscho
> 

Yes, I have no particular preference. I was just following the
'convention' of the -z "$origin" test a few lines above although
I could see uses of both alternatives as well as instances of [...]
instead of test ... .

Charles.
