From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/6] remote-http(s): Support SOCKS proxies
Date: Fri, 30 Oct 2015 19:38:59 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1510301931450.31610@s15462909.onlinehome-server.info>
References: <cover.1445865176.git.johannes.schindelin@gmx.de> <bf218d020e24216f55d1514c4459e645b13ec075.1445865176.git.johannes.schindelin@gmx.de> <xmqq7fm9gze2.fsf@gitster.mtv.corp.google.com> <20151027012336.GK31271@freya.jamessan.com>
 <xmqqvb9tdr7v.fsf@gitster.mtv.corp.google.com> <alpine.DEB.1.00.1510271649430.31610@s15462909.onlinehome-server.info> <alpine.DEB.1.00.1510271651420.31610@s15462909.onlinehome-server.info> <xmqq8u6odxxx.fsf@gitster.mtv.corp.google.com>
 <xmqqbnbkp0e8.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	James McCoy <vega.james@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 30 19:39:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsEaF-0000gC-J1
	for gcvg-git-2@plane.gmane.org; Fri, 30 Oct 2015 19:39:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760229AbbJ3SjX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2015 14:39:23 -0400
Received: from mout.gmx.net ([212.227.15.18]:52646 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751509AbbJ3SjW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2015 14:39:22 -0400
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx001) with ESMTPSA (Nemesis) id 0MgszY-1a5U6n0WO0-00M7qY;
 Fri, 30 Oct 2015 19:39:01 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqbnbkp0e8.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:tpPCVMcP636B0s4dXZgKWpJz/zkbDTWU0mECfJkpK2kWf7+Oujz
 4XgSAzl+tGVXDTcBK+1i7L49zwqGW0CYN6yoFP71EYfaWRbaoW1XjUW6q3Bg2/RqbHtK2iJ
 WPL+xXbXkmZ95raB+eGco3IVT6fWxYdJ7swUY9SkuwIDiDpZb24qB6aggTCGK1ErJdrgUBx
 KqCrw7aiDKxaDlQdwoKxw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tQtttGOT5sA=:NiuVDlrjewnA+O0qZkhYqg
 IznaoBMPyUDle/jE6Ehs3IbrNKNnR8JIGN7i14JAdOmmJ9upk2PZS0j4qiYoCP291eWT0VmjM
 5mRtDxpoTpZH37VqZMyhk+SddwEKei+2Yo7x10ByEk2/DC+8waDd3uvFB+cCpw12LipfuvEOH
 l4G96AIGPlw5Jg27mgf/M67AMNQH4awJ5FSQ2JIzwa1HC1vktYqccdM25hJXpcGMI01UJbz+t
 MtxAtYbWZ0EFMMvCt4228ro0HwlI2WzTISfOhmilYR90hCnkDXjVhaBaZk5pMXccJ3VOuNprK
 Oj6a5cJhR3lyC1JS8gUgOPa95Qt81ZLZOs8l9lymcgok6lPRbQtYGrnm1TPRoknYe/JyaXoPv
 Rzoa7IvpvxnGfpNLSgPgS1OCbkG8zwHmVvIBwzR0+s1+Ycs0hllm/USJeQg625mQHXw/Iksfc
 BVcfGq62LT0kpA0HjAK70cktVJlgjQFGKgF3+cgXpCsqsxz8/TROqbva811QcWFx4262bLsa3
 wZH4etfVdzpDJxGwHUKeKSsJHmMqCZbLw4MB6rX7jggp3bb9dKAfQ8il4ukyodhQPQubYZdfq
 2y6p52OuaB7svCRRbKczMq6qzp3OyGggUP9BOl871IbnWj5X0n8L9IWN2Ykl8oeqMeUCrWfCy
 1t3/7uESoQMsQ6IE7O88aD1b5uXL18hTAc82Nl1DE0e3xC3aLQZFTmC4n9iHO87jTdfd1Lycc
 DcHO2i8cK4UCAxNo58mr1tdoKvl76snzgMXr+4cxpye/qEm6rosQALWAdDNeg5wbOrYnPQsg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280517>

Hi Junio,

On Tue, 27 Oct 2015, Junio C Hamano wrote:

> We are very lucky that the original was posted to SO by our friend
> Pat, and you did the right thing to ask Pat to relicense.

I suspect Pat is on a six month trip around the globe or something,
judging from the feedback I got here:

	https://github.com/patthoyts/git-gui/pull/1

Ciao,
Dscho
