From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git config: do not create .git/ if it does not exist
 yet
Date: Wed, 24 Feb 2016 13:13:39 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602241309560.3152@virtualbox>
References: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de> <20160224082657.GD12511@sigill.intra.peff.net> <20160224101403.GN1766@serenity.lan> <20160224103152.GA21448@sigill.intra.peff.net>
 <alpine.DEB.2.20.1602241230120.3152@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: John Keeping <john@keeping.me.uk>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Karsten Blees <blees@dcon.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 13:14:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYYKU-00028M-F4
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 13:14:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753150AbcBXMOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 07:14:03 -0500
Received: from mout.gmx.net ([212.227.17.20]:64878 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751849AbcBXMOB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 07:14:01 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MMYZG-1aaAcF3ykY-008GSF; Wed, 24 Feb 2016 13:13:42
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <alpine.DEB.2.20.1602241230120.3152@virtualbox>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:j6KhfuN/38Hl1DoVIiUBW5dw6RqVchSjBGUwL+G7dHm5aeX15AO
 13qN4cwInSUO292oUhbHX1UNqGAk6wK7Yrk4HP7pajs4gFxG0LW58Tio8zt/TucbeahFtVl
 c4gnPbnrFVgucNGHW3gtmQ88gjk9vNzxqZ9myLrz89dIScngsB/kllL/foLjIuAgM2JkXxA
 FFwMM0oYKdWlML9DL74yQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GBQppv3J23M=:Cjzl00d70lhuUOwzLqk1hA
 yA1nJd5cVOqQKVtz0oJRQACgN1dzW7twM3wWqqz2AdD4UMah3nznm0fsUGdlYdb2BxIOvb39d
 iXX0giY8FAYLx2cwDSqtrMxzFhZ0JvwVyG6Ut3pvzOGLOOsB/17TZDkY6syNbIBAE5Y5PnIWe
 93uek4H6ETHNElz1Bz9qOZjKDxT8IGR9t1mEyjRJeASyo33PjP5ROjMqz85iHUVEnEDiClkbY
 I01UoZmrUqYPzWbZFKUZ4J4t/2JfxLqaN/5NLz7YK+KHeQpT9u83GKOAF4PndjcLT3TOWeDk0
 iWSO52UE5I3nsp3ZoCXAW1AEPREZZQTdRyKv3OSLiKEofqv0X/0rSwWSYSWOa9lyhbMpXz9HE
 pQ5taUcFM/5NRYN6Mz+wQqf43AxRRAHa/p9BP1zjkBTHTQvpecAbRJALRMdRjW19XUKM5F8hn
 gLz2NRetDoYv46prV5msDsGhmEUb+e6jVJRrF+/y/5OcyzrRzZFYW0YCg3E36OFQdwEb0uNTx
 llMTuBoUJ/IP2GjLslnroI5uN5X1dx1Bl7VFULk/56N0UfvHI4O/LUuYqHO8/heivcCDA/wNu
 Rwdq/Yta1jEiE5iPsdWBsxIjDm1Sd7/sgIVAWVBx5DYbEmahfvj1X11zUU75+dTUaEDSiw6rq
 4gqMknnaBxcm+rGYHG2CEXQWSJh0z8NovPIMYuQE8cpPqAen5/EPgexb/9SGcyjqhhRUkT+oX
 UuPIVC4Hv50SiFc9XPZ2XGn5pSLql4dIpxL6ezYS/QaUAvTNvSnKHAIZXLQbkn7Wqpv/3WBp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287202>

Hi,

On Wed, 24 Feb 2016, Johannes Schindelin wrote:

> I created a test and essentially duplicated Peff's finding: this is a
> Windows-only issue.

Indeed it is in our patches:

	https://github.com/git-for-windows/git/commit/3a4c37b22

(short version: we carry some patches that simplify locking the config
file before building on top of it, and somehow we agreed back in the days
when this patch was written that it would be a good idea if that code
created leading directories.)

I will fix this issue in Git for Windows, but I still think that my patch
brings a usability improvement: the error message is just so much more to
the point (will submit v2 in a moment).

Ciao,
Dscho
