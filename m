From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 4/4] t0060: verify that basename() and dirname() work
 as expected
Date: Thu, 14 Jan 2016 07:09:01 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601140702260.2964@virtualbox>
References: <25a2598e756959f55f06ae6b4dc6f448e3b6b127.1443624188.git.johannes.schindelin@gmx.de> <cover.1452270051.git.johannes.schindelin@gmx.de> <eca740dbf6271bd69f2ccb14163175996ef7c837.1452270051.git.johannes.schindelin@gmx.de>
 <CAO2U3QjYukb4mB414mVLX2=CxLPBnDaUyDRsfitE_bTZv8_zFQ@mail.gmail.com> <xmqqziw9mfil.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Michael Blume <blume.mike@gmail.com>,
	Git List <git@vger.kernel.org>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 07:09:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJb6Z-0004jd-9l
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 07:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750847AbcANGJT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 01:09:19 -0500
Received: from mout.gmx.net ([212.227.15.19]:49667 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750816AbcANGJS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 01:09:18 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0LkxLZ-1ZjALK3Fcj-00ajbq; Thu, 14 Jan 2016 07:09:03
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqziw9mfil.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:c8EglMSv9xk7IXPJ/sfLhIY3PeRd9SeI0FtpwqBG4KBhVNU1kKJ
 xUzBpdBSn/PZKUthI6SrD0XA9SHp4nUnGJp1Sxo7bBlLRlxQVdJezuV0YSWadI9QjFL0Di3
 zHwdCiOHRTkMqxQmTmjID2hMooAVI/diu8WkmDDWtENfYQWP0GSUC0jxVVPWRuYxqwzqT/H
 XObmIOAEaj4LMxgeDlx/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zTr3f5cmqW8=:T5gio6bqRlGUDUjZWHWhhw
 5PMjJzPg64lsT0GPNZA/vwuyRUH1TTQWuig3xyrVYyTXKv50vaGTOEXiz3bWNO1X8xKe0u44x
 vE+k6IlMx6cGK+5PMpj0ceiouVyNnAGRyEXeutxHQ2K5HVp6SQIQ3plfjRgGk/Tk+LANODPlf
 z2PjUGN9X47/mgwMC8l/YhTfvQeEt/v/EowoSnaDTTEyZB5FhDxHjFtCeoZ/44KSAs6/M56n3
 wI3jsx0l7Nu3O6nst/NHxE4A2E3we5/OFNUOzAcv/R7/7NnR4fMqU3WEgC/ur34+U/hzu+mH8
 QACyWio8mgQbJPvKLyArhXkytlwfX87Y7OKVlcpemXK5JcsdEUuVs356M22jhFidlYFr6snpZ
 0YgGbGF1RM4j36mb/Yq2L/d4wz6dg5dj29WoYXTnk5Uv/jDPAIftbRv/dgIFqDq3QWfgOnmcE
 7GcOBy0vs27eufMMuF0p7g7JBu3NfzkqCbLFTpmhHsR00Tn7xlYBnukp40Nkcv5wwrXMta9rv
 vSFQcEnGl5ktSbvfS1bYeXswzdIPY6z6xArR1o0tQizD/Ex14z4+D3t3hZ/HqyzYxg2JrmCqe
 1sz5wdM88Xx0uB8yGcH1WziUe2mbQcptaxFvtJ5qwnqWHR5yrmXifaYrdDkOtbtSJnvcDcEW2
 ObaP9m156DZNOOa5fCoxNmDyRePBirTysOe+xliu0kqKu2Mromn54UQj7D7NSe53D4yiq2NXd
 etqnBLHta8tnn1EDFZvzZhSxGrCfvS2FxP1Na7OhcTYfHfcNMlbR/aLYb9x/nWKHWmVMj6fJ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284018>

Hi,

[thanks, Junio, for culling the quoted text to the essential part]

On Wed, 13 Jan 2016, Junio C Hamano wrote:

> Michael Blume <blume.mike@gmail.com> writes:
> 
> > Test fails on my Mac:
> >
> > expecting success: test-path-utils dirname
> > error: FAIL: dirname(//) => '/' != '//'
> >
> > not ok 2 - dirname
> > #    test-path-utils dirname
> 
> Thanks for reporting.
> 
> Ramsay gave a nice analysis at
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/283928
> 
> and Dscho already is working on it, IIUC.

I already provided a hot fix:
http://article.gmane.org/gmane.comp.version-control.git/283893

And yes, I also work on a proper fix.

Ciao,
Dscho
