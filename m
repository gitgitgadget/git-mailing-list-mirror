From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [msysGit] [PATCH] compat/mingw: stubs for getpgid() and
 tcgetpgrp()
Date: Fri, 24 Apr 2015 08:25:12 +0200
Organization: gmx
Message-ID: <f96d3bd305941f06f634733ede93a482@www.dscho.org>
References: <20150413134850.GC23475@mewburn.net>
 <alpine.LFD.2.11.1504130954420.5619@knanqh.ubzr>
 <20150413144039.GD23475@mewburn.net>
 <alpine.LFD.2.11.1504131052090.5619@knanqh.ubzr>
 <20150414110312.GE23475@mewburn.net> <552EAE0A.3040208@kdbg.org>
 <CABPQNSZ-7FAgun8mxqXYWgy+Xc9xQMXKZonwujXb5WzLCKmNMw@mail.gmail.com>
 <fac9a525a2fb2b09d176243659cbf3a7@www.dscho.org>
 <cc79154d-4e18-41a4-938f-ca6e30b2e6d9@googlegroups.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: msysgit@googlegroups.com, nico@fluxnic.net,
	git-owner@vger.kernel.org, git@vger.kernel.org, j6t@kdbg.org,
	luke@mewburn.net, kusmabite@gmail.com
To: rupert thurner <rupert.thurner@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 24 08:25:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlX3G-0002tv-Uv
	for gcvg-git-2@plane.gmane.org; Fri, 24 Apr 2015 08:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbbDXGZV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2015 02:25:21 -0400
Received: from mout.gmx.net ([212.227.15.15]:58688 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754759AbbDXGZS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2015 02:25:18 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0M1Fe4-1ZZvk31tKS-00tGVd; Fri, 24 Apr 2015 08:25:15
 +0200
In-Reply-To: <cc79154d-4e18-41a4-938f-ca6e30b2e6d9@googlegroups.com>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:jisdGw6FFdaDOBjhJ7IJrle4FXu+tlekASXYceRyBMIdHAurXfb
 BWy4EN7L8Xwm4xmNBm98FP4QtbpW3q+vtctz4X/D4V9lqhS++fv43xlfv97a5GpO4tctuxO
 CCT4OytdT/gKdPh2LdgQdEXOSndzI3XLOFz0kq0tKBv5eO7ihEtym4uRoN/tmp5x65EeB7N
 2jooi++Afq9Eq7RDX3v7A==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267723>

Hi Rupert,

On 2015-04-23 21:25, rupert thurner wrote:
> On Thursday, April 16, 2015 at 2:45:11 PM UTC+2, Johannes Schindelin wrote:
>>
>> However, using this code for `getppid()` would be serious overkill (not to
>> mention an unbearable performance hit because you have to enumerate *all*
>> processes to get that information).
>>
>>
> is the windows "JobObject" similar to processgroup? at least killing the 
> parent process in a jobobject will kill all childs as well:
> https://msdn.microsoft.com/en-us/library/windows/desktop/ms681949%28v=vs.85%29.aspx

Reading this page carefully reveals that you have to construct JobObjects explicitly. So you cannot get from a process ID to a JobObject; there is probably none. Or there is one. Or many.

Ciao,
Johannes
