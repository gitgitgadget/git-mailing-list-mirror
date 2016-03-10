From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Bug: git branch -D can be used to delete branch which is currently
 checked out - Part 2
Date: Thu, 10 Mar 2016 13:15:16 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1603101313220.4690@virtualbox>
References: <F6588CBF-D13E-475F-847F-6154370F4A2E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Marcus Kida <marcus.kida@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 13:15:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adzVA-0005y0-5A
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 13:15:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801AbcCJMP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 07:15:27 -0500
Received: from mout.gmx.net ([212.227.15.15]:52319 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752142AbcCJMPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 07:15:25 -0500
Received: from virtualbox ([37.24.143.87]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MUZKF-1aDlW20Inz-00RLLA; Thu, 10 Mar 2016 13:15:17
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <F6588CBF-D13E-475F-847F-6154370F4A2E@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:cmCA2/Q9kevs7vpYA1RnbvySj4C+GHa+g5imCjPL/bSimlS4RqW
 86UTH09JJbGYIm8C3ToxJqLzr44iZEn2B0VftXu/Il/gHPJZhWC7RGRigRGYbEVZU0gjZxI
 vILiBrDPxulEJZro8jYPNbrH8btWgzzQebVC9cLB01eq5S+QH7sYUjfcuSDVdCVQyApqcrr
 ql0CiGL+QjCqdqBx5a8YQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:WrPJRmscVp4=:xPwrhIBbNQ/BaVPThs3aTY
 CiiuO0J7L7usjp4UwuEOnJ3dmhhi/Yrcfq7p97ltagMSIyN5RYAh10YzsbbalHV7rKfotLAa+
 41XaaeGYSZrr4cQyR6dWsg7u97JgxiqYLcPVzTU9TL8+1Mx+N8uFi8I4G5BWLzsgs7ZsVYToU
 ygyv+KjqDvVwd/V4zdnMNnM9DUwcWsYvbzAuNh/fPzz96t88IBr+umbE21VvKrgY1TSOk7AMT
 PImYsIZ2bdSVpp2U/X7IDUcHuPU7B63RLavjlY1/rPKWQyNusJbZMX2vUs6oiNFrRgQvD2nT0
 jtyv5EMHdmWfEZM/JKkDMKvO/DO0csvfeqhhefjkmk4ubdmOeTmlktE0GIcj7h99ag1qD6uzd
 EG4XSsVADbKq465+5gsnUJcs4e3RCl4fY0pRE6iX8uccSldmXABlj4dTB00qhoZLN4Rr3VBSu
 OmRFZhtgxTBbmv0nJbEZ+ZXDUMBYC328VeWk+nP+dJNb14IvJU8ubsBb1f1NnE2SyxgY9AGVw
 sCqPoqgIsZ/ifChFqzyClj/TTCTP1OelrYubR4xXMrIkhr5zTIuQlT3jlugmjRuF0uAkDxt2K
 n9Gw/n1wmhPn6XWUX4xtuVVi1FVRdmWZHtrPmBTacCg32Qph4lTaxmnDOVIQ3DTn7IencgZec
 V3rGGVMCedPQu5ZOERrzoTUCFkLRlbD3wfSx/z0IzboDYTpyflYfGIONZAmER6p2HMQCt+ugG
 xawErCBgpoOwu+WrB8enETm4E6CivCHeTLraquUYGN7jQ+G3mAadLI97qAaaetkSg9aGnX+F 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288618>

Hi Marcus,

On Thu, 10 Mar 2016, Marcus Kida wrote:

> Proposed solution:
> 
> Use `strcasecmp`, `stricmp`, `strcmpi` here: https://github.com/git/git/blob/f02fbc4f9433937ee0463d0342d6d7d97e1f6f1e/builtin/branch.c#L218
> 
> Not sure if/which one of this will work on POSIX as well as MS too though.

This is not quite a solution (it is not a patch). And you *definitely*
want to make the use of strcasecmp() contingent on ignore_case. You are
not alone on this world, after all, and other people have case-sensitive
filesystems. It's totally doable, of course.

So, do you feel up to the task?

Ciao,
Johannes
