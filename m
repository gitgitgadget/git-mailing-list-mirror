From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v7 13/19] fsck: Optionally ignore specific fsck issues
 completely
Date: Mon, 22 Jun 2015 23:11:00 +0200
Organization: gmx
Message-ID: <572bb1fdc77e8eb2862558b86304d4f2@www.dscho.org>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
 <cover.1434986506.git.johannes.schindelin@gmx.de>
 <4ae672be6b7ca7727cadc3b94c5f731b7df7abaf.1434986506.git.johannes.schindelin@gmx.de>
 <xmqqegl3hb6m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 22 23:11:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z78zn-0002OB-Cf
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 23:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbbFVVLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 17:11:07 -0400
Received: from mout.gmx.net ([212.227.17.21]:58038 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751507AbbFVVLG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 17:11:06 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0M4o41-1YtAJk3DNl-00yzUz; Mon, 22 Jun 2015 23:11:01
 +0200
In-Reply-To: <xmqqegl3hb6m.fsf@gitster.dls.corp.google.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:BFSxIszeBOsK7OTtwx2OSIm6cvpfQBFa1+ZkWnJboCVCzE3z0lt
 LGM29ueiVDGAbn1Iu4RupnNlcDBJZqqeC2JmVRwzqllzd5ijBvwDh7fsowTd/Aw/kzKS/5h
 Yc9LBZaO6bENavXQ4VDZZdppds/g0rqqWpylQGbxz4K6sO+naa3JpZ7162hBKmXF/2zQOoW
 vfYp7LqRfMV4+5ZbPMp9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:0MKqzmFVDeQ=:ESBVqM3RAwGTsOuPR40bl/
 IsdbrALTevk+FwxKlV/TP7yXmDIyg6RJ8AsIxYs9RDJRgLU1B9uJMp/L4c92Sul1EzjPT8cgH
 zbDvtdrRB9RRbKw8GI0plQx7ko7PYkl3yWyqiovxRbEKIOJmpImxFrNp6eJdw3DQehOBPUPnW
 1XJedfFKYrp2n9CAZh1kzM9Sp4ftbVOhd/vURRkuUQ/D7j9HQY/pVlJvA+/Ft8ufBV5cy9H3D
 C6vMIJaVajI8kCAe4aJ18G59QAVyZ6/SGz9UMyHMXlpPrCQZ6lGXgvCygSLrt7OlA50l1+T24
 8K6ksAJsnL12FWRkK+Q9udC3wfZd4IK7dhpNnSHUjG4SLhkx1bhWYyc8jH/zkyi+PhEhAMqFV
 KlONcR7+eYXAcCWgC7B8fsylv1nNzi5FMcfmmH8loAUzREZBZO2CoQ/uGipSu2v+Qg6FjCVPg
 UOylp+PUCyUlVsGqq+oYKdA9QgWp4oPO76QxLkO2956pSePfPahxsYFITOVGAPBCGP4gemaod
 tlm7KoeIiwSEbr++SI2R5O0z84Wc7dfIQiOFvuuOFHas93MHz5qa3ctsunxR4sDnerp9RBY4q
 nE9kTS653H12nycZMOE7lYo/sCR17HrKrY1VO183Ph/PrYZEtEx5cKSK+p4yv4NRbJ3eamrwc
 yn/Vs9vaAQRsdC0KGul8w5gpebTW4kYkHV6DnElJDmdgGyjrF+zpmhiPol3lEP9IuKEM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272419>

Hi Junio,

On 2015-06-22 20:04, Junio C Hamano wrote:
> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
>> +	git --git-dir=dst/.git branch -D bogus &&
>> +	git  --git-dir=dst/.git config --add \
>> +		receive.fsck.missingEmail ignore &&
>> +	git  --git-dir=dst/.git config --add \
>> +		receive.fsck.badDate warn &&
> 
> Funny double-SP (will locally fix).
> 
> There are a few other minor style nits (not in this patch but in
> other patches in the series) like
> 
> 	s/free((char *) var)/free((char *)var)/;
> 
> that I locally added SQUASH,

I fixed all of this locally, ready to push out v8, but...

> and I may also have tweaked some log messages.  Please check what you will see in 'pu' when I push the day's integration out later.

... I did not see that yet.

For the record, my current state is available at

    https://github.com/dscho/git/compare/fsck-api~19...fsck-api

I could wait for tomorrow to adjust my commit messages... or what do you want me to do?

Ciao,
Dscho
