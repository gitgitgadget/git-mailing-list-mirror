From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Ambiguous sha-1 during a rebase
Date: Thu, 14 Apr 2016 17:55:34 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604141754371.2967@virtualbox>
References: <20160413222919.GA10474@glandium.org> <xmqqr3e9i10b.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 17:56:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqjcd-0001F5-Nv
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 17:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbcDNPzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 11:55:55 -0400
Received: from mout.gmx.net ([212.227.17.20]:49545 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932243AbcDNPzy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 11:55:54 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0Lcjdr-1bWdGa3A6Z-00k7DT; Thu, 14 Apr 2016 17:55:35
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqr3e9i10b.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:28VD4YwXhur43KknVrFLRPKMJIFO2iqYyAgnTgHP/VEPBt8Z6GY
 yX2GzXXWCQTxfujR18UZ9h5POu+1UWyzK3cN46GvQRrRfzRboZYhC+13OOkmgmYxDCjf5xv
 OqLFHNz+pEviDVv6M0G4D5CSJqZQptVQvIiUHkcVraZdei7S1sNQLvvGVu21Sbz9dqH14CJ
 y1MmwHZN/J3nJG1O1A0QA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6MDLEx/OAO8=:iq59Bwp8I6Kh1lNNLCBZWk
 N/y0lbQkBD5XC6n00uKfZlfS/G4zWJ0c2weJA1P04VpBJT3YF/rHDqm1WxHvfFaEwL8cxiXx2
 9pa9U7uiQxCx81aTvne+B52naUZwqjiNN+9zhNxTt6QLTWHCbHO31FGdBeuTrB1E2Y06em/W3
 1Mn8ClUC5Us5o2qoQ2l1VaGGYnNtptXdLnRHYWK8pz+b0EP7PZa2n8I4EZQi4ib1RzQmZ5Wpk
 9aNSqspl15aPztbISAMavXXPJXl24Aco5yMRUh6jXHpO1YuOQCRSpSaguS1+wYa8x1M/70T24
 57ParFKMxo0FV3BA5udb1XNYVW5L8/zAw/3g/t6B3PGamnRWp7NquYjULkMPuKAro8LA1ctYD
 JIfuv2gh5/kEn4/lkYBbaVZmqnB3DLsVXvUDdwtqKt64ogBNLBD4a+leKCJPt6ofAzMP726vt
 m+McVVMiJjmhSYyJF4IJW+jz2gDmEqRNieZ+24Dqh9YtaFD2Ol4sm9OiSb8yuixSHZA0hQAWL
 wH5e4zcq58a6ii8IxYPe7/eB9KeY96lc0Ki/jnEXGrpJgjBbMj10Y/mjD4z+LfWDhiPdmi8oB
 MZ7K1kjIFd6R8+Sya5welwXD1v9r5riAkB/17aNilqWH1Klh8K+s06LXl2GNpHH8n52nXon5E
 b8zrbzXjAQx0b4tm+DgRDzWq0NY0RgL7II3NBHM4WY2cTcv7ZwDIiBh2CTFkj1o0gtBvFRjgg
 8+K1xYUfZAtaX7+VycngxdJ2iAabOwjt94KjOi2RSPuXsSt0e37iav3YbvseNr1kxo/tPgh9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291528>

Hi Junio,

On Wed, 13 Apr 2016, Junio C Hamano wrote:

> Mike Hommey <mh@glandium.org> writes:
> 
> > Should git-rebase use full sha-1s under the hood to avoid these type of
> > races?
> 
> It already should be doing so since Aug 2013, IIRC.

Indeed. It is one of the things that makes interactive rebases so
unbearably slow on Windows (because that transformation results in tons of
spawned processes, which is slow on Windows, and even worse: tons of
POSIX-emulated processes, which is even slower).

Ciao,
Dscho
