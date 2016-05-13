From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/94] libify apply and use lib in am
Date: Fri, 13 May 2016 08:32:35 +0200 (CEST)
Message-ID: <alpine.DEB.2.20.1605130820160.4092@virtualbox>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 13 08:33:10 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b16er-0004d7-Dc
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 08:33:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbcEMGdE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 02:33:04 -0400
Received: from mout.gmx.net ([212.227.17.20]:63290 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751148AbcEMGdD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 02:33:03 -0400
Received: from virtualbox ([37.24.143.84]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0LlYrb-1bZc7X10lj-00bLce; Fri, 13 May 2016 08:32:36
 +0200
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:Cub4aghSjcTZrMoSzTe+bz9W1s6EfwqyfG2on8bpzns6PD+9aFo
 fk3l2l0Rx+Sy5vNCKZ9Ey3Lut+z3RBm8w543cmwzujmBFGKzc/0MJA8tbTBVpjNdHDnTWYK
 z9R5cLcbIijwldNVEHtl4izzBPnxTgMoo+4hdxY5UcnYEZ37yfmE4CYWN76CZSi+Qi745t+
 b+Tv5g1mIh3IaBvDNTozQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Id9A8FqxXXo=:sqR4WGROhZdyePj+nJ5Je/
 ZJ51FnsKUJwTTZiztBs+1krb/vOJgynFhm+kmXyEHcif0abIJNx1Yl2ZOMLN+3+6GK2oMJ2UD
 mJfOGAPZ0FiT/5ulTh8q368mYZvXyJO244afXXfC6qXNxbWU6DGiJiffmgY2PtivMLwjcKFFM
 84LxawM6VujaTl44MCZJk320TMExGyeUeDqDETD3EJ5dmqxNOCVszq4Ypji51x5Sb+gCTQ4zz
 s4nlYpUCO8TEwvTU20kKMCZuKAyn0D8WxTcjVgISGhnWfcy4yzEIq9XbbweHdpFfF/mRaqb1E
 zmFQKIi1xunN2RmAAcHbhyrtkwrWF3FoJmepseOrzrHbi/kmsYRJW6cjhodHCxXsJWdL5MY4v
 ++CnkWEE85ttY64gjOGTK+bOV8IFIYXvJ51/71FDUypFudVXalqsJatXwS9Za964BDNUZRZl4
 5bnEmt/PL2S2JnXH2q0l6FhTpeReJ95Iwq1oibYhWdt3ui92LJU21IXqSMaj15/0bf7EWQeZL
 BAB8uVQnqic9b8S1MkIj6uG+PLh6OOfaf+phtX62e/Ln4F7d2nyzxMxZ9If9LJs5X48ijTQZA
 bKelWcYileabpCvJFKsUJujpyGUfEhWX92WFNeHUbrlRjc6hM4EXnrSPQCCfPddqRHmyTXTpy
 UASDQRwIhW+smV702kDTUS1pTR3Upf9Xqwiq9tYg2ai/ijKP6soezIgGtxwtVJnces71HYlbv
 rZhAE1HOkdT8Pc+/YFVVaAgsckNgkJwKhE8nByyXsnmIqAmMxPhTD7Xie1J1y+D/fg5bPF8F 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294508>

Hi Chris,

On Wed, 11 May 2016, Christian Couder wrote:

> I consider that the apply functionality is properly libified before
> these patches, and that they should be in a separate series, but
> unfortunately using the libified apply in "git am" unmasks the fact that
> "git am", since it was a shell script, has been silencing the apply
> functionality by "futzing with file descriptors". And unfortunately this
> makes some reviewers unhappy.

It is a misrepresentation to claim that this makes some reviewers unhappy.
Speaking for myself, I am very happy. Despite having had to point out
that the previous iteration of this patch series had a serious flaw.

It is also incorrect to say that the shell script had been "futzing with
the file descriptors". You see, the shell script's *own* file descriptors
had been left completely unaffected by the redirection of the spawned
process' output. That was perfectly fine a thing to do, even if it
possibly hid fatal errors. Shell scripts are simply very limiting. The
problem was introduced by v1 of this patch series, which changed *the
caller's file descriptors* back and forth simply because the called code
no longer runs in a separate process. And *that* was, and is, improper.

> By the way there are no tests yet for this new feature, and I am not
> sure at all that "--silent" and "be_silent" are good names.

If you want to follow existing code's example, we typically call this
option "quiet".

> Sorry if this patch series is long. I can split it into two or more
> series if it is prefered.

It is preferred. Much.

Ciao,
Dscho

P.S.: Even two ~40-strong patch series are *really* painful to review. I
believe you can do a much better job at cutting this monster down into
palatable chunks, each with its own sweet little story.
