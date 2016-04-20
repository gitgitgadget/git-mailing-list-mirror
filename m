From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 16/15] Add tracing to measure where most of the time is
 spent
Date: Wed, 20 Apr 2016 14:28:24 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1604201427440.2826@virtualbox>
References: <1461108489-29376-16-git-send-email-dturner@twopensource.com> <1461146394-5135-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-979179825-1461155305=:2826"
Cc: git@vger.kernel.org, dturner@twopensource.com
To: =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 20 14:28:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1asrFD-0002Om-VA
	for gcvg-git-2@plane.gmane.org; Wed, 20 Apr 2016 14:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbcDTM2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2016 08:28:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:52350 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752066AbcDTM2a (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2016 08:28:30 -0400
Received: from virtualbox ([37.24.143.127]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MaE4a-1bCb0z3lF2-00JtTF; Wed, 20 Apr 2016 14:28:25
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <1461146394-5135-1-git-send-email-pclouds@gmail.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Qkj9Ae1eWx094L+ifSQU/YZlYcyqaKazNAfsGrZKCCMZkGvJBbT
 w2cOx8794fVDQoJGfruk3iwDZTFJzoa4RpXL8brgIR5Iib+5sAzsN6MBypbFfTS+bVx1ZWQ
 ohw7lC/7Lt1x3EDW/4l2mKdOKmfvJpWWbAgpOYrh3vA3NA0kHCuzmUJbYjVD7zdX6kijOL6
 WyUk+oxdSRnzk7e6uUsEQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:mKQeV6ktpqY=:bbtEfn5rTV6Ge3EpFJrWaC
 mZcXxJc4akzUXUUPv6M6aClkTpPI4Oi1Zu1ERHiATWYMWxnfk8BU9W2BVfRLbNzLEQnjaei4C
 4YsAdaJ0+6+9jxP44JfrC8AWrButv/90MZy+h1D8cK0IESv+q8N48s2tyQm1GqXqU7NDyrugh
 O7kKnfqltDXqCVfTOVUafffjdnX+E/nkHwtZDiOZ3Le83AqespZ09mxqzVrUyaIn9BdidwZYe
 yGfqF+JuLZHnT3giIPDoypeTdk1BJLht/KMS2OAHPgrpQwnW/7oPgW55a5u+R1iC6Dz2tvLoI
 msmeAeQWkCn7qOzYOYxWUgAjXMxTWFv1GgaMUYpGkRG13ZyGF5raDepWVlAs/wfxbKPwaOjR8
 tcOYN7DlIF7C8TVH6vwY/0mgcAdYGbbluYlTFCclN+GSwD+kdvr3uLAOkoiwLXXTUDWYRGrLS
 hz0/CWNQ1S8QEzE2giPT4vs38b9mXhwejptDgCba+SGN9EZiY6rWshXpq/1y/HFpGer63oYd4
 W/ok/kC7loUycdrhmWqkbVJbLeXvm2jMtP8oyPW+XccrvS4eFdTtknv3c3xOFcRApvcve39YJ
 MvA30dmiwmYB0J0JZ0c7murbJ20BR0ftC9F0F3B7TOfn5n0WE3YtpsBy3wSxPX0xZEJMoydZt
 qN1A7SJwyPyS/AW9xv1T4cXb9796yxNI6/NrOgKKdaQvIba9XIs2vUurKrcLRsDhfD/18U+CY
 oz1YHyBRK6EvCv54tQOGmZ9X+fv6rjeiAGnAYDRYFI6KCl8ytPFaE5n8qeekZvIcxBPpHj6S 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292006>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-979179825-1461155305=:2826
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Duy,

On Wed, 20 Apr 2016, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> All the known heavy code blocks are measured (except object database
> access). This should help identify if an optimization is effective or
> not. An unoptimized git-status would give something like below (92% of
> time is accounted). To sum up the effort of making git scale better:
>=20
>  - read cache line is being addressed by index-helper
>  - preload/refresh index by watchman
>  - read packed refs by lmdb backend
>  - diff-index by rebuilding cache-tree
>  - read directory by untracked cache and watchman
>  - write index by split index
>  - name hash potientially by index-helper
>=20
> read-cache.c:2075         performance: 0.004058570 s: read cache .../inde=
x
> preload-index.c:104       performance: 0.004419864 s: preload index
> read-cache.c:1265         performance: 0.000185224 s: refresh index
> refs/files-backend.c:1100 performance: 0.001935788 s: read packed refs
> diff-lib.c:240            performance: 0.000144132 s: diff-files
> diff-lib.c:506            performance: 0.013592000 s: diff-index
> name-hash.c:128           performance: 0.000614177 s: initialize name has=
h
> dir.c:2030                performance: 0.015814103 s: read directory
> read-cache.c:2565         performance: 0.004052343 s: write index, change=
d mask =3D 2
> trace.c:420               performance: 0.048365509 s: git command: './git=
' 'status'

Thank you for doing this! It will be *highly* valuable to get the
performance on Windows where I want it to be, too.

Ciao,
Dscho
--8323329-979179825-1461155305=:2826--
