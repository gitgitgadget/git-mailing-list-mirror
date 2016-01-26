From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 18/19] mingw: skip a couple of git-svn tests that cannot
 pass on Windows
Date: Tue, 26 Jan 2016 07:45:27 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1601260733290.2964@virtualbox>
References: <cover.1453650173.git.johannes.schindelin@gmx.de> <ff13c4125f268905baaa10a097ffdafe07eafb25.1453650173.git.johannes.schindelin@gmx.de> <xmqqwpqy9ze9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 07:45:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aNxNr-0007Ii-E6
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 07:45:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756077AbcAZGpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 01:45:45 -0500
Received: from mout.gmx.net ([212.227.15.19]:55992 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756036AbcAZGpk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 01:45:40 -0500
Received: from virtualbox ([37.24.143.74]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lu7a2-1Zw8xt47SY-011S64; Tue, 26 Jan 2016 07:45:28
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqwpqy9ze9.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:pjvhFkLyqR48wspkv1FoVJMxA6zBWa1EBE8y0YbVX/d9iWGOSid
 gbmucO9/8A5Xp/LiBqPOhvDSkrkjnX/zMMTclU6I4iWnmOK4Br7bwj/rcFcLuXDYq54nsWG
 k7fW/kgzwkJ4e9dq+OVfzkv9kNY84srWTK/Ax7XcVPGcVJZMr0UQlN25d3rKRKPq1Nnkave
 NfBlxliHFjZYc7OjBM4MQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6wlW/GVJBF0=:dOeWKnUd8K8NqvYpMslkHe
 lxB6nPmXs3bn63/7bweh02sNLYg/Z3j3tdUHTiWI6P/wBoRDAQVUVAGFp0u6Uuw3cyn7hjTwH
 KplyOp2nnU4Jb5ahfNyHLRtpcRN9RkpEysEPBnVwAjPPvsmU/tZlZcb/Ts1G+Lx2mdHD1kwJg
 PqY6ydYrSFAxsmJRK+E6yvWXn7ixr5p/La+GUByAt/GCcloW4+4rAAf2KBQ/Q09v7OcJZBzmg
 wCxxU+mnFTATt9eKGn7IdJNJ6OWesHEi1HfhCAn2t+wq22w/xuMdQMFekZ7Iibkr2nOCxPWy+
 Tuw97U9ecAvGwH09kCnh8M9cbiry/HbZseUuNknG3QMcUQIPuSWZLhjtB44dGYi8QiUfEOj14
 0QoJjEYWX11YWlSthF8KzEWxZa6+nyJOYUY692FyTeJpWx664atd2qQ3Zqr7rnnHeNPo9r6Hi
 f8q0gANbIwJPxeTQSD+6b1KTnPmvzVXpCMix8cENFJVxnBennpLzEh2PsmlYTbQ8FgLyOpSnX
 IZqO246yygrz5HKsMn/QI5DqjoaPo4QuwLT06JSN7qs/PLXyM/p94DGKZ3XMNvrWX5i0oGKxw
 kl+VMmEAQG7jEwNTJ2IFxwWVjd3fOHuRq06BK5r+MMgRjk6dNzrW+LfFZ22wB42RxNO5QxSS5
 WYRp1h+VzAZYK4nOlE7XJMbV1KXsCjzfvPuLSg4q99tLNwgu+jbBJCG+7PqCWINnwYKc5GTr/
 DA3IjPN9nrmVhYh459iEReHIfcdrgiR1XYbT1gR/MFg+2nXYDzFokbWBR3WEc6oV1niDuVfI 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284780>

Hi Junio,

On Sun, 24 Jan 2016, Junio C Hamano wrote:

> Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> 
> > Some of the tests expect that executable bits can be toggled, others
> > expect that paths are POSIX paths (but when they come through git.exe,
> > they are converted into Windows paths and necessarily differ), yet
> > others expect symbolic links to be available.
> 
> These skip the tests that cannot possibly pass in their entirety by
> protecting them with prerequisites, which feels the right thing to
> do.  The "executable bits" ones would need to become !POSIXPERM, and
> symlink ones !SYMLINKS, though.

I reworked this in the same batch as the previous git-svn patch.

Ciao,
Dscho
