From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] git config: report when trying to modify a non-existing
 repo config
Date: Wed, 24 Feb 2016 14:26:06 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602241425180.3152@virtualbox>
References: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de> <b225aec8c83a184f90dc6bfa821177b52ef4b3f4.1456318031.git.johannes.schindelin@gmx.de> <20160224125930.GA1422@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 24 14:26:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYZSW-0003bZ-Nf
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 14:26:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754671AbcBXN0Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 08:26:25 -0500
Received: from mout.gmx.net ([212.227.15.19]:53078 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752909AbcBXN0Y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 08:26:24 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0Mfn40-1aKLx604gO-00NAO0; Wed, 24 Feb 2016 14:26:08
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160224125930.GA1422@lanh>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:quf7xiQq0qy9Usorfl4XwyQRsn3UsIjvwr0sKqpFJiLq/wgbuVs
 AcZ68w9qkBucC+k1csKdw3uOChufwLNlw4WNnZeN/3uHn8gtLJgzEQph6Qie0Ltcs7ZLdO3
 O/sGTJf3/ugh7ZxwXlzaG6KqfdN3dv66wQB5/5Y/E/WLMnYT+RHoQwH7Bn6plxHIs/DhBt/
 D0QNAcAVnsYgM4RhKGktg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:ucBdvB7/PcQ=:Gi7oJ5mNPzOY3/Mb2MuCuC
 T2uHuXOJdermcmstLwR/ZlGz9SydqdTE8M9umLKhw/CJcRorbm/Nsqvf24bzKrZ8PqZtQMVo5
 5WrTXCABSOm2QheoYjmEfSS1pSf1f1c1ld6o0x9ScWheN6mbnEiBHZErvV+3zHHjWKwzxO6JL
 1WkfECnJg1co2BJm0cyHPZGvwfh+VwPehtM7nMCRM8Gvp5czdQBoPL8DkhKntECnXUYnRp1Bw
 YyiJH/lZPiettqxO81u5zpaffyZxt/UYJf5tz49LNRpSjykJZNWoCpYTV5+N5RPAYX04EhUTq
 tbDgLuLl2B9U2Qxo1q2IcusGIHJcpt+AP5UMEaEUc/6KWv4gtfwTcjRRx8RWtHCWHnE0mDRYM
 +0WOYA2+yFjIbwsOIYB9xqYlIveygb8mMa/MSWyS7EU+MsHoHBQDGS8nEciy+gfUImSink1rZ
 Y526DHmnLTrl8jyS4vyIuF9H8i4s2BhPTJqZ9vhnahxxPoIco7guK9D8M/6FlRtRbzJ+GeVHV
 lTC8e43PV++rj+KWG3PKiTyN+8RAGq+qt6tKYWQd/tAUBUb0ObhVKEuIVTDcHaj6/Hasq+Ag8
 2yyym7XhInKUErFUux5mrGvfV0d1+9kmytzYl2Fpzi9rTF3QsKSvueKJROuqx1aTi31WMFryX
 e+UDdcC9dXoHiDzJnYhmFiPvnfZRNt8VfA0/4QOl10JGQBxN1mkkH3I7hCu9IxPjqJC4u75Pi
 kyP+VvSobkI9Vj223YOiOZd0Q0uLB1PppSESh6nLRfyyDLQgroZjEbeyU7SczGfo1DznwBeO 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287208>

Hi Duy,

On Wed, 24 Feb 2016, Duy Nguyen wrote:

> On Wed, Feb 24, 2016 at 01:48:11PM +0100, Johannes Schindelin wrote:
> > +		die("not in a git directory");
> 
> Maybe wrap this string with _() for translation? Then we can pile this
> patch on top to fix the rest in builtin/config.c.

Given that the context lines contain die() calls *without* _(), I would
find it more logical if your patch patched also the line I introduced,
together with the other die() calls.

Ciao,
Dscho
