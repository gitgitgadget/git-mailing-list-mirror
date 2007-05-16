From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Smart fetch via HTTP?
Date: Thu, 17 May 2007 09:26:44 +1200
Message-ID: <46a038f90705161426n3b928086t2d3e68749557f866@mail.gmail.com>
References: <20070515201006.GD3653@efreet.light.src>
	 <46a038f90705152225y529c9db3x8615822e876c25a8@mail.gmail.com>
	 <Pine.LNX.4.64.0705161232120.6410@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Jan Hudec" <bulb@ucw.cz>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 16 23:26:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoR1H-00079i-UP
	for gcvg-git@gmane.org; Wed, 16 May 2007 23:26:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783AbXEPV0q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 16 May 2007 17:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757979AbXEPV0q
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 17:26:46 -0400
Received: from ag-out-0708.google.com ([72.14.246.250]:35415 "EHLO
	ag-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754783AbXEPV0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 17:26:45 -0400
Received: by ag-out-0708.google.com with SMTP id 23so386458agd
        for <git@vger.kernel.org>; Wed, 16 May 2007 14:26:45 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=g4ciSOVYMeZ84BjH3jzZU4wPGkZAYOWeix4nwBILCskCLg7drNNjXT7lpxiDTjV1OjztMCa4Hjdo0UDoYFKyVXb29ksy81NXcDEn3ugvbrRFmsbACQ8xX8pv8aWjmIFJxpi2ArRUpmGcyJvho6cYGC+xNpOQj7bsAftApZYDl2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ho8GVGAr2gx4siT57nvSEB+zdlTTkbhl3Y9iz7uPr13Gs6ASJjYHJxyM6x08hgd07rmao2g1LHVK5/vN2O6Qhy4vZ0vJm/wY2BqIn71TtqAfJ6Q57pO0kBWZC+TNrj5tTxMDG3UaqOewLa8g0/oClqWlCWZXlgpRjZxLYILkE24=
Received: by 10.90.75.10 with SMTP id x10mr8889729aga.1179350804659;
        Wed, 16 May 2007 14:26:44 -0700 (PDT)
Received: by 10.90.53.18 with HTTP; Wed, 16 May 2007 14:26:44 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705161232120.6410@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47457>

On 5/16/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 16 May 2007, Martin Langhoff wrote:
> > Do the indexes have enough info to use them with http ranges? It'd be
> > chunkier than a smart protocol, but it'd still work with dumb servers.
> It would not be really performant, would it? Besides, not all Web servers
> speak HTTP/1.1...

Performant compared to downloading a huge packfile to get 10% of it?
Sure! It'd probably take a few trips, and you'd end up fetching 20% of
the file, still better than 100%.

> Besides, not all Web servers speak HTTP/1.1...

Are there any interesting webservers out there that don't? Hand-rolled
purpose-built webservers often don't but those don't serve files, they
serve web apps. When it comes to serving files, any webserver that is
supported (security-wise) these days is HTTP/1.1.

And for services like SF.net it'd be a safe low-cpu way of serving git
files. 'cause the git protocol is quite expensive server-side (io+cpu)
as we've seen with kernel.org. Being really smart with a cgi is
probably going to be expensive too.

cheers,


m
