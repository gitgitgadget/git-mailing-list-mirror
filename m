From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 0/5] Fix compile errors with MSys2
Date: Thu, 14 Jan 2016 17:51:14 +0100 (CET)
Message-ID: <cover.1452790142.git.johannes.schindelin@gmx.de>
References: <cover.1452691805.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 17:51:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJl7P-0004ZO-6G
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 17:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755066AbcANQvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 11:51:23 -0500
Received: from mout.gmx.net ([212.227.17.21]:60263 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752974AbcANQvW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 11:51:22 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LjN0F-1Zki9D0UGt-00dUP4; Thu, 14 Jan 2016 17:51:16
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <cover.1452691805.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:c604rPYD1c46HPc7aCC91HcvDJ0+qGNAWcIMZCmafWd2MqPycT+
 EDFmgvhAqfoEX3veajodC9pasxpvyPYTXMzgroekk5HFyDu9T3IZkokiUtJ3XArr8lmdrvc
 P7jAqSFSGIlVR7imnblqVrjDD5tXRZz7Gok2V+9dl/fUI6ujGz6KnwwOJs4ixAT8bQo01Wk
 JitBrIy5VQllEiQv1lo6Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:BK/BKRphCgY=:RXLrlh1qcQ6tGKUo/AERlR
 W7AUx0RYFhqbCL/vWv/99ru5ud5MGjrLmaZxMU5AdR8rLJhKGLGIX/tonG9uuNBKK7oDnAy7d
 NebT3G2HQ5iOV7h8bLS+bBq8blFLBGhzvI+VDCOG8pKtESI1rjyetzot33kuGgY9gW3yBpQLG
 8oe+HIMhF+BJZ6uiNXo+9AWaMJYm2rDRfhuMPrQYCOV9J77aqjs7CzbREc1T3gVKC3txrBShI
 qk9FpQ7eCQtEYBgZw3wcRHwTftOLZAHNoHmTaVLFZI9sDAK7IeHZQgGY59jECSaw7lKeZFJon
 IL3G+eCZRNA98mudebuNXA5R+ilEk/lOi86eUwYYEP5zzxUnv69JiEmY9rQGn3CK+4RTIVPk/
 qKyJxj97S9Om7gM89dR/1TbYL9D5RqSwBwvIZ5VAyoUee47e4D70xkK9vegYuPzjhFOSwVudM
 eO+go0qwGKpjwGWNwHg3iC5JlwZax2EJGqGoPuMU43Gtp3ROYCJURkfMvGMEQIbzRf91+VwXF
 SGPgZ8GLy+2euFKPdqBbvMcsru+V/eKJyGmJLtKTVwT/JiISPwesK1DNVF8ZiRW8MzYA9Qe8V
 SEa50pTFZdNaIIzOiZ7wRr8mgZzkmQr93sY1HxPZcIR9VEdp6jMOiS4IumUn+ZLjAxvkZECuN
 ISFWE8VfbdhNQy5fkxdN0CphO3xWPt6QJN3AhIEqLlw9JH+9WHTW9yRZlCFbKclz+atfLrLM4
 Op1Stn2cj6g52Qd/IoZsro2vFAQPB+W3VCxMxgSzC6PUMJnrBZzvrYgPId1wWq8c4EdcaXiN 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284059>

Git for Windows 2.x is based on MSys2, and its first official version
was released already almost half a year ago, yet it is still impossible
even to compile Git from the official, platform-independent Git source
code.

This patch series merely fixes the compile errors, and will be followed
by other patch series that fix the compile warnings and test failures.
The idea is to move all Windows-specific patches of Git for Windows'
fork to upstream Git proper.

Relative to v1, I only removed the guards about the "#undef
ReadWriteBarrier".

Johannes Schindelin (5):
  config.mak.uname: support MSys2
  config.mak.uname: supporting 64-bit MSys2
  nedmalloc: allow compiling with MSys2's compiler
  compat/mingw: support MSys2-based MinGW build
  compat/winansi: support compiling with MSys2

 compat/mingw.h              | 24 +++++++++++++++++++++++-
 compat/nedmalloc/malloc.c.h |  4 ++++
 compat/winansi.c            |  2 ++
 config.mak.uname            | 31 ++++++++++++++++++++++++++++---
 4 files changed, 57 insertions(+), 4 deletions(-)

Interdiff vs v1:

 diff --git a/compat/nedmalloc/malloc.c.h b/compat/nedmalloc/malloc.c.h
 index 18634e3..bf70037 100644
 --- a/compat/nedmalloc/malloc.c.h
 +++ b/compat/nedmalloc/malloc.c.h
 @@ -1385,9 +1385,7 @@ LONG __cdecl _InterlockedExchange(LONG volatile *Target, LONG Value);
  
    /*** Atomic operations ***/
    #if (__GNUC__ * 10000 + __GNUC_MINOR__ * 100 + __GNUC_PATCHLEVEL__) > 40100
 -    #ifdef __MINGW64_VERSION_MAJOR
 -      #undef _ReadWriteBarrier
 -    #endif
 +    #undef _ReadWriteBarrier
      #define _ReadWriteBarrier() __sync_synchronize()
    #else
      static __inline__ __attribute__((always_inline)) long __sync_lock_test_and_set(volatile long * const Target, const long Value)

-- 
2.7.0.windows.1.7.g55a05c8
