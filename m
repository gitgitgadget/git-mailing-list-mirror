From: Daniel Stenberg <daniel@haxx.se>
Subject: Re: Building Git with HTTPS support: avoiding libcurl?
Date: Wed, 23 Dec 2015 11:17:35 +0100 (CET)
Message-ID: <alpine.DEB.2.11.1512231059380.23702@tvnag.unkk.fr>
References: <1450798780.11255.22.camel@mad-scientist.net>  <CAD0k6qT+s4e_7y1DxVTN63V0tO_xFv-9i-Fmq5O0SrpQAyAzVA@mail.gmail.com> <1450805416.11255.58.camel@mad-scientist.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Cc: git <git@vger.kernel.org>
To: Paul Smith <paul@mad-scientist.net>
X-From: git-owner@vger.kernel.org Wed Dec 23 11:17:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBgUT-0000oV-Mn
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 11:17:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934023AbbLWKRt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 05:17:49 -0500
Received: from giant.haxx.se ([80.67.6.50]:44559 "EHLO giant.haxx.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933814AbbLWKRr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 05:17:47 -0500
Received: from giant.haxx.se (localhost.localdomain [127.0.0.1])
	by giant.haxx.se (8.14.4/8.14.4/Debian-7) with ESMTP id tBNAHb3S013233
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Dec 2015 11:17:37 +0100
Received: from localhost (dast@localhost)
	by giant.haxx.se (8.14.4/8.14.4/Submit) with ESMTP id tBNAHZIn013226;
	Wed, 23 Dec 2015 11:17:36 +0100
X-Authentication-Warning: giant.haxx.se: dast owned process doing -bs
X-X-Sender: dast@giant.haxx.se
In-Reply-To: <1450805416.11255.58.camel@mad-scientist.net>
User-Agent: Alpine 2.11 (DEB 23 2013-08-11)
X-fromdanielhimself: yes
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282931>

On Tue, 22 Dec 2015, Paul Smith wrote:

> I grok that Git doesn't want to re-invent the wheel and that libcurl is 
> convenient.  I just wonder if anyone knows of another wheel, that doesn't 
> come attached to an entire tractor-trailer, that could be used instead :).

But if you would consider another lib, then you could just rebuild your own 
libcurl instead from source, entirely without any dependencies on other libs! 
That would be similar to finding another lib with less dependencies. (As 
already mentioned, you'd still need crypto and TLS support no doubt.)

That huge dependency collection is there much because your distro decided that 
having a libcurl with all that support is preferable. libcurl itself offers 
lots of customizability at build-time so you can strip out most of that if you 
wanted to.

But why do the distros build and provide a libcurl that can do all this?

I think you can look at this from a slightly higher altitude. By re-using a 
very widely used, well developed and properly documented library (yeah, I 
claim it is but you don't need to take my word for it) that is available 
everywhere - git benefits. By having many projects use the same lib, even if 
no two projects use the exact same feature set, we get more reliable software 
in the entire ecosystem - with less work.

I would guess that switching out libcurl in git would be a not insignificant 
amount of work, as no libcurl alternative I'm aware of is even close to this 
API.

-- 

  / daniel.haxx.se
