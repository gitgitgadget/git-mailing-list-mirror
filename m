From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/8] pack-objects: add --skip and --skip-hash
Date: Fri, 5 Feb 2016 10:20:47 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602051019580.2964@virtualbox>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com> <1454662677-15137-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-241332531-1454664048=:2964"
Cc: git@vger.kernel.org
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 05 10:21:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRcZw-0000aS-MY
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 10:21:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752410AbcBEJVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2016 04:21:20 -0500
Received: from mout.gmx.net ([212.227.15.15]:57829 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752422AbcBEJUu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 04:20:50 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Me8di-1agPra17Da-00Pv3K; Fri, 05 Feb 2016 10:20:48
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1454662677-15137-2-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:xJ7z9TLtyHslg5Z1OrIL/qvnKtHipCS4xp+SBA3f6r9k5KWRRWo
 HC3dq5aI8veOTUN6hwPhFGZkN7V4LIqhMCylr9gm8F4+RZS4eiLiqrDQcxUNAQU8j/kajpX
 NvONVlVMV5KKErIpe54xxTD7rRJW5cRyYS1uyjDVfIFGFy12Mac7p0rvEx86teuLo06k0uJ
 9kAqY1rpuOJcTH5hE2A+Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:+zH/JUXm3e0=:JkfQNH0yBIX6beJmD/mhVJ
 6cqHIrmcRlII/3F2L19pv/WBX9Xx8ONqjn2fHkS0KKkDqT1gz1gZCKg4vNqp7tbhqJvvxsgyB
 4Wy4skmSnsQDnzAGBcnnlQKRIfNAumU4gV/UjZtFcgPjqKwmcYZEJUU5IRzW00hsdysMQudS2
 2VEcf89QdaVgBeChhVq5YAIeRMcNSPsEFK2+yWGfk3YWxSI5Z7K/XA+d+oU9gEgoz52sC+u/S
 QtKyknuz2ou2mDPTbGjsare7b2LnRef86aMPiG9rtLIY6/auoh44PwHAFLIfmCA5Dqagcr2of
 UMMPXhgXv0X2etLkTnXclHfiBLT6b9drI8LfO7qa101LJVLNWYJTF38rVSpPnXq/ljalfWr06
 CkJLVU7sbjyDWdOZeXhAFKEE/csARHO5FbkbAdFMr022PweieYNH6FZsQui/dNhC4AGdgUz7K
 EsR3PDj5n9VxAsrXKZxa7t8C9lx8pbHja/39npIVYo3yJs8fdp+UZ5TEGoi98jnNRwNgsTI33
 fTb9qBNV1The0uCINgilQDO93cp+qcCa3PtHef6MMpsHPs3PS/4tvuvYxPCZzTu1kkb2j1YQ+
 WNerJKw3g3HutY6VNZXltjhIHQD7dymvAlnMMn8JEUXB1rPmbtdseHSsCpcKd04MoMowdIL3G
 GGxKOi/2dH8OBT/d8IuvvfhaYSp4ZRxKmYUgPxs4g5mIhh7mn0fxHISI8OIGP8O+2rSze2y6b
 QxheAQux1E1gFD1qQ0N3NvAsOvpuSiAavdnfwxEW+xl75mMFBj7BqDPGPbRi+dahbu91DQ1e 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285566>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-241332531-1454664048=:2964
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Fri, 5 Feb 2016, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> The idea is, a pack is requested the first time with --skip=3D0. If pack
> transfer is interrupted, the client will ask for the same pack again,
> but this time it asks the server not to send what it already has. The
> client hashes what it has and sends the SHA-1 to the server. If the
> server finds out the skipped part does not match, it can abort early.

Ah, here it is. This description should definitely go into Documentation/,
methinks. Maybe elaborate a little bit more on the "what it has" part?

Ciao,
Dscho
--8323329-241332531-1454664048=:2964--
