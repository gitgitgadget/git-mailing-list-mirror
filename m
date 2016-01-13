From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH 0/5] Fix compile errors with MSys2
Date: Wed, 13 Jan 2016 14:30:45 +0100 (CET)
Message-ID: <cover.1452691805.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 13 14:30:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJLVp-0002KV-BC
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jan 2016 14:30:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758867AbcAMNax (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jan 2016 08:30:53 -0500
Received: from mout.gmx.net ([212.227.17.20]:50585 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756487AbcAMNaw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jan 2016 08:30:52 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0MeLKt-1aXIYz3mmN-00QCrs; Wed, 13 Jan 2016 14:30:46
 +0100
X-X-Sender: virtualbox@virtualbox
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:VRYTTQONLGGPhqfITFhLSxAb6el3XrA4OqvSQ/l7fz+ZYYheux7
 oTdwVIwWCHASbDPbTgL2IDyZ7QIP9pDzFDyC0zb+AjXmhH1fy37a5Achq8sc2ZxAhQvK6/2
 GPAsRpc80diMtaro3UpVHDmT4po1A3rhfTgzQrc+T3PnX+nFo/I2z3D+tyZju9g+Z6oNPBu
 UAEzdv3X4FdMP78EzleYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:l72ToE6xljA=:+W83yRZCpQy1KjoDo/xeJV
 fhZsWpwUQYofj0dYequRc4+A1ZJjCmmZH/HOx0G0XjMTiaJnYwsFuvB18CXj1ryk1omskriqE
 /b4qYsrZBASVZbyJNrkZ5oMBE0roZC9jSRpG90bRpmJ1sXvjYlaYPDmySRZd5olp2lqXtiHnX
 /EHi2QdEQuXNk66QZ2MBM9V5x82qXIc2KNTHnR3bgl1EjjlRttCYURcTLkWDhOl/k6id35fAr
 psPfz8nTejN0yANzUO/6XpML/V5QXGG97BdEBReFFS95pAaGAiD7kBUcvLQpp/odRiLt+OXMx
 6oTI551bZ+fdQ438h8pxUg2wbpV1n+kdRrncYS949MMaNcWF/f66NTBD/VuFFkJoTZRd7sYqP
 R+wcH4+GQLlaO7MjCpIHjO2GpPxHZlUhVE8kqxSGpbC+XpshsnsckvYwMFy/MY52yHXRefZRC
 Afwfm0vPmbTKUWyl7xbiut0/cfyHvq8QeZyAGXiXIbUZvYZeXsOsglXJoi6D/dif2DJkvdUX4
 x6gb6osoUIC/Xi+c2Zb/h+v8GcKXv2OKQym0hvNh1PJTwUGROSvSFgEQpnS5f/0ViaI1n7b0E
 eRjbDG3mQl/aIaah8/R/8tWFuWIZcdzcwVFi2PCJKI7oEb2kni9oQsOq/nLsH9+wOYjj16K2p
 ybdoE+WSyoc6NeW+Uy7kZ0uvaCtlD0kA6qHjYlPuYr8SzxG5AgoaLLc9aH1ni++v4DDRq3mO7
 H082cMhjeukoJ+XE8OMuTUJMQ+ZET6bWQxePc1gucUscI/HoArLCFKO1uuE2IXuW7OWHiuG9 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283915>

Git for Windows 2.x is based on MSys2, and its first official version
was released already almost half a year ago, yet it is still impossible
even to compile Git from the official, platform-independent Git source
code.

This patch series merely fixes the compile errors, and will be followed
by other patch series that fix the compile warnings and test failures.
The idea is to move all Windows-specific patches of Git for Windows'
fork to upstream Git proper.


Johannes Schindelin (5):
  config.mak.uname: support MSys2
  config.mak.uname: supporting 64-bit MSys2
  nedmalloc: allow compiling with MSys2's compiler
  compat/mingw: support MSys2-based MinGW build
  compat/winansi: support compiling with MSys2

 compat/mingw.h              | 24 +++++++++++++++++++++++-
 compat/nedmalloc/malloc.c.h |  6 ++++++
 compat/winansi.c            |  2 ++
 config.mak.uname            | 31 ++++++++++++++++++++++++++++---
 4 files changed, 59 insertions(+), 4 deletions(-)

-- 
2.6.3.windows.1.300.g1c25e49
