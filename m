From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH/RFC/GSoC 03/17] builtin-rebase: implement skeletal builtin
 rebase
Date: Tue, 15 Mar 2016 09:01:46 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603150900440.4690@virtualbox>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com> <1457779597-6918-4-git-send-email-pyokagan@gmail.com> <CAGZ79ka64xBABfsWtX6GmK+sdy=VziZeGBKz9A3V=jX9ZcyfyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>, sam.halliday@gmail.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 09:02:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afjvU-0002nz-Mj
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 09:02:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753444AbcCOIB5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 04:01:57 -0400
Received: from mout.gmx.net ([212.227.15.19]:64560 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbcCOIBz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 04:01:55 -0400
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MYg42-1aJAxV3HYA-00VSO3; Tue, 15 Mar 2016 09:01:47
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <CAGZ79ka64xBABfsWtX6GmK+sdy=VziZeGBKz9A3V=jX9ZcyfyA@mail.gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:7uBa8ln09/4Wf8V27xsNAiBOik/LkrtmAgPsa1MbjyGlfeQ+nXe
 Oksv6N4FTxTFQIP9ETWLcpbn2kDxqUJvUe8+H7eFyJv5YiMEk/jMsDi/SM0LhdF9ueSFgXO
 wZCcSZQjr3f93ETN0VFV2pCsc3WCmNYD9pSOBIewX5A1eZFNgd9rbN8BOwb/nAf7W/4IK5J
 s2z6ELq54sr9hJijeJTjg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:oOcQAK4ZKtk=:na+695USLMYbcfrXlqoct8
 cUGiR+lMfVz31LDZz6t+0bzcF9UNn0t+F99EYuzmgxvuT4o3t4akXVr4xK6AXDXoklQvParNR
 zrnWMoCle4vZ/hYU0seFHX790BFd6L9MLv3IUkGEFBLXI5WPAXm2/ZH9RK3LgZf5lJKHhr7DZ
 /NZQHJNzFYXtDdcABo8X92BClkwR3wHwY9QmM1mPQIfpZWeVf7rF1G7YTEpZrEW6sMIXdITuh
 kdCUslV7AOvWZRFTktRcwOSpNaJQFrmHErpELB7pvdKooxyeroAfgGHdTKm2NCZABEKXsByLT
 Sr501fqaSeqZZe3hTGPjGgBErnj0ke4O9NMT7MPcX/2ASs4L9IYxG/DpWJck0sVNeqk1fEVj6
 2TRt8KeyVaeqib16F0M8aJJVMhZf9FtpvDOKH836ZKjWcK4xGawdF/W2DPxHAB29pLdjt9lMs
 zKMHt3VHJLBNRgx5LGKX5OWpewgpeT9KHbsAgexdqHM2lOrbECQKfcIEtX/zXE1iCPt98MZbo
 v497GCsVnAU0XUoDWagaakVsYsDYU7+m49gs0Y5TP+PWGxvj9n4m5JZ6IC8wnCq9Izu/kQGv5
 jnrw9zV/UmexLRnIYvWcPGaYFYxABCsMJcgRihEDz58Tai5+L1Fb36HbN/ktVDkaW8Hhg0H1r
 4ldWz+5KQOHvV3gxmE+R8oPi7jrnWmswRf9x4cr4zouwDMJ/Qzea6FrzDZ7RF1T+yIzMUspVm
 MuQs84nEzvb6QXAhTzUbKuC3LazX4dgDFFHZl1ziJtBJBmH1jPVyTcIb9xoI40BwLxRhVPsz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288841>

Hi Stefan,

On Mon, 14 Mar 2016, Stefan Beller wrote:

> #TIL you cannot run rebase in a bare repository(, yet). I would have
> assumed you could.

Every rebase bears the chance of merge conflicts. You need a working
directory to resolve those.

Ciao,
Dscho
