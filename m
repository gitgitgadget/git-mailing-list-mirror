From: "Anatoly Yakovenko" <aeyakovenko@gmail.com>
Subject: Re: cant get git to work over http
Date: Tue, 19 Feb 2008 13:05:00 -0800
Message-ID: <e26d18e40802191305y5f7b8fdfr3113c84612c53189@mail.gmail.com>
References: <e26d18e40802181649l3c03df82l4eb91c88bec47bf4@mail.gmail.com>
	 <alpine.LSU.1.00.0802191115440.30505@racer.site>
	 <e26d18e40802191019j48a1ceadk4887ffc35100ab0a@mail.gmail.com>
	 <47BB1EC0.601@freescale.com>
	 <e26d18e40802191106v51c907bdn6aa51acef5f530a3@mail.gmail.com>
	 <alpine.LSU.1.00.0802191916020.7797@racer.site>
	 <e26d18e40802191127v7cc9f051l7002b56b41dc9f86@mail.gmail.com>
	 <alpine.LSU.1.00.0802191940260.7826@racer.site>
	 <e26d18e40802191153w691ac5fcl3fa972ca6503b9fb@mail.gmail.com>
	 <47BB3691.9040809@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Mike Hommey" <mh@glandium.org>, git@vger.kernel.org
To: "Jon Loeliger" <jdl@freescale.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 22:06:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRZet-0000MT-TE
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 22:05:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757854AbYBSVFF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 16:05:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755296AbYBSVFE
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 16:05:04 -0500
Received: from wa-out-1112.google.com ([209.85.146.180]:27093 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759985AbYBSVFB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 16:05:01 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3688757wah.23
        for <git@vger.kernel.org>; Tue, 19 Feb 2008 13:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=cXS0d3HE4hwYYVZD1STBPceGmIiCyo3PiPqLCU3gkIE=;
        b=fC1OYw6OnT1NqbNIVEsUMMp/K6qgcH+UerBeK36443TyWnFCf+GSsgMMgstusmIny9PoyjxXi0tRzZZtU3aw4IXFmtq6NRuQaWp81ia3boar7mi7ErcSswBfYrgVyfJuh6K58fpd6bHeUKD5pUyfaIu5os+Z+7Hx750z1gAggqc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oQMLgPcbOv/yUyBgrObQwiTwBFOGi+N7db0sJkHpBL7VmiTIzfw1KPMTnZVy5xmepjQ+UU5pgAoaF2XARDZMMWsNQjjMj7aYquny9jnjsMqfrnbokOVnw7Ua7tKKOyCFShjzPHtE6DPR6npVa3OHH1CkzZdwmTYfQDFzEnvevHM=
Received: by 10.114.166.1 with SMTP id o1mr3567541wae.71.1203455100614;
        Tue, 19 Feb 2008 13:05:00 -0800 (PST)
Received: by 10.114.167.5 with HTTP; Tue, 19 Feb 2008 13:05:00 -0800 (PST)
In-Reply-To: <47BB3691.9040809@freescale.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74453>

> > but for the life of me i cant do this:
> >
> > $ git-clone http://aeyakovenko@localhost/var/www/localhost/htdocs/git/repo/ repo
> > Initialized empty Git repository in /home/aeyakovenko/projects/repo/.git/
> > Cannot get remote repository information.
> > Perhaps git-update-server-info needs to be run there?
>
> Ponder the Doc Root for an HTTP request.  Remember that your httpd
> will likely be striping or rewriting that base directory path and
> so it won't be needed on your git http:// requests.
>
> Since my repository was outside of the basic Doc Root, and I wanted
> to present similar path names to both git: and http: protocols, I
> ended up rewriting some URL paths.  Also, if you have some form of
> virtual hosting going on, you might need to do a virtualization
> rewriting using --interpolated-path=pathtemplate.

so, basically i need to append a .git to the repository root?  I am
getting these http requests in the access log:

72.192.162.186 - aeyakovenko [19/Feb/2008:12:58:13 -0800] "GET
/var/www/localhost/htdocs/git/repo/info/refs HTTP/1.1" 404 313

/var/www/localhost/htdocs/git/repo/info/refs doesn't exist, although
this exists:

/var/www/localhost/htdocs/git/repo/.git/info/refs

So why doesn't the http protocol handle this?  I can access
http://localhost/git/repo/.git/info/refs  through the browser without
a problem.  Is there any way to configure http protocol to just treat
the repository the same way ssh and fs does?

Thanks,
Anatoly
