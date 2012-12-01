From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC] remove/deprecate 'submodule init' and 'sync'
Date: Sat, 01 Dec 2012 19:04:05 +0100
Message-ID: <50BA4695.7030008@web.de>
References: <20121201163004.GB4823@odin.tremily.us> <50BA3D7D.8040707@web.de> <20121201174920.GE4823@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Phil Hord <phil.hord@gmail.com>, Git <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Sat Dec 01 19:04:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TerQV-0005uh-UK
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 19:04:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab2LASEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 13:04:16 -0500
Received: from mout.web.de ([212.227.17.11]:56053 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752675Ab2LASEP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 13:04:15 -0500
Received: from [192.168.1.4] ([88.74.133.139]) by smtp.web.de (mrweb003) with
 ESMTPA (Nemesis) id 0MBkKF-1TWuo53NvL-00Aa74; Sat, 01 Dec 2012 19:04:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <20121201174920.GE4823@odin.tremily.us>
X-Enigmail-Version: 1.4.6
X-Provags-ID: V02:K0:qhBndhMbcGowbNTsPKQjASHgy0x1XIp8OjrQCLT9G+T
 DCXjf545+psjInVnJGyhBfFR9X4FxAptbER2c/NrXzii/OBa65
 +bCULzaApX7uj1++u0ulpU4xPkQ98m7AesMXNzhMR4iFHsqnME
 WpJFaWAUE/qPdFe/otSn7/HJwC6AQnv6cOJFEPLnFOZNwriAGU
 noU/Fb9N6ANcFGfjci/Dg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210984>

Am 01.12.2012 18:49, schrieb W. Trevor King:
> I think removing `init` will cause some compatibility issues anyway,
> so I was re-imaging how you do it.  I don't think update='none' and
> "don't populate my submodule" are distinct ideas, while a locally
> configured url="somwhere" and "please populate my submodule" are (with
> the blank-url case defaulting to the superproject itself).

Why would we want to remove "init"? It still has to copy the "url"
setting (and it would be a compatibility nightmare if we would change
that, imagine different git versions used on the same work tree).

>> What real world problems do we have with the current init/sync that
>> this approach would solve?
> 
> I don't have any, but in my `update --remote` series I'm adding two
> new config options that are handled differently (define in
> .gitmodules, override in superproject .git/config) than existing
> submodules options.

No, they're not. They are just handled differently than "url" and
"update", but will behave just like "fetchRecurseSubmodules" and
"ignore" do since day one. And as I explained in another mail I
think "url" is special and "update" should be change to behave like
the other two some day.
