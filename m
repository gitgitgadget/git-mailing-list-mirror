From: Jeff King <peff@peff.net>
Subject: Re: bug report
Date: Tue, 27 Jan 2015 09:50:23 -0500
Message-ID: <20150127145022.GB30027@peff.net>
References: <OF166CC5C9.21C21E8C-ON80257DDA.005038FD-80257DDA.0050E350@ie.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Albert Akhriev <albert_akhriev@ie.ibm.com>
X-From: git-owner@vger.kernel.org Tue Jan 27 15:50:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YG7TJ-0007sT-TZ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Jan 2015 15:50:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758275AbbA0Ou0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Jan 2015 09:50:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:39027 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754685AbbA0OuY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jan 2015 09:50:24 -0500
Received: (qmail 4726 invoked by uid 102); 27 Jan 2015 14:50:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Jan 2015 08:50:24 -0600
Received: (qmail 12132 invoked by uid 107); 27 Jan 2015 14:50:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Jan 2015 09:50:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Jan 2015 09:50:23 -0500
Content-Disposition: inline
In-Reply-To: <OF166CC5C9.21C21E8C-ON80257DDA.005038FD-80257DDA.0050E350@ie.ibm.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263067>

On Tue, Jan 27, 2015 at 02:43:31PM +0000, Albert Akhriev wrote:

> My system:                      RedHat 6.5/64-bit (gcc 4.4.7)
> My configuration options:  ./configure --prefix=/home/albert/soft
> 
> Compilation of git 2.2.2 itself was fine, but some tests failed.
> I presume, there might be some network communication restrictions here in
> the lab
> (gitweb had failed as can be seen in the listing below):

The gitweb tests should run locally and not need to touch the network.
It looks like gitweb cannot run at all. Are you sure you have a working
perl (with CGI and other base modules)?

Try running:

  cd t
  ./t9500-gitweb-standaloneno-errors.sh -v -i

which should give more output. Also check the contents of gitweb.log in
"t/trash directory/t9500-...".

-Peff
