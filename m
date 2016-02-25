From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] git config: report when trying to modify a non-existing
 repo config
Date: Thu, 25 Feb 2016 16:54:48 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1602251654160.3152@virtualbox>
References: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de> <b225aec8c83a184f90dc6bfa821177b52ef4b3f4.1456318031.git.johannes.schindelin@gmx.de> <xmqq60xduauv.fsf@gitster.mtv.corp.google.com>
 <xmqqlh69spt4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 25 16:55:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYyG2-0007cp-3K
	for gcvg-git-2@plane.gmane.org; Thu, 25 Feb 2016 16:55:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933135AbcBYPzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2016 10:55:09 -0500
Received: from mout.gmx.net ([212.227.15.18]:49482 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932998AbcBYPzH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2016 10:55:07 -0500
Received: from virtualbox ([37.24.143.82]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0LpKKr-1a2xI60Fcb-00f7JN; Thu, 25 Feb 2016 16:54:51
 +0100
X-X-Sender: virtualbox@virtualbox
In-Reply-To: <xmqqlh69spt4.fsf@gitster.mtv.corp.google.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
X-Provags-ID: V03:K0:LvYLGD2/Ai0Bl++EldaSgHaf9eT3VdLAieZMQcFok/C6mKEi8Wj
 gFoYxN2bJmTOY4F4ndLFin0gvgxWRJgJEGeCdB0w/2e5oGWuCa7CFmjzgamDAhfUxc9VNp2
 pk83ZD9kJvLl6Vsj87ZF2whivO0noIeynS9L1bXWzsyebsgDeO+cQKaLnCE/ofkY2WF6WNG
 KgRd7HKVH//P6HD572/TQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:iUrW1ldqXuw=:fiC+9TbVXx/eo3gA8X2USj
 OPPdHll8U2jT4i6wetbH9dSXKPkusMcJZ+V6A7wzz3ARnva7lC94ya+0/Mgk4AvbGRWwiPH7L
 t65dz52loeVM5l5gF6vSK+x37MQBNz2vf1uxAxSTG5o2bNu6m0uz2CcSJEDbdoY9IiSCDe7Xh
 bVeX8nDMX72mvQ6JYZmemvNnwsMFPYem1TX9W/6+aE3TsqsiQzFhl1mCVpSgU+96h3HO20gmh
 ebEmFJy0ddT7Qq38N467JkefuEf9CPcgYgewf7R7In8220ugXxWqORoNwE5s0CPpYFU4tX4zM
 5s1MsyN/Oqds746nEvSxOfGsXFbwmyIrMmhbCGgQW/H9LDmlRvSpE5T5JROB8RqYmalw22ASO
 Mck4O+up1pLIjViYTf/Kzv7hkNOp7PitiyZ4Ho0nBT6kfETWEQG/15I9Z9xvKd+xYsiPdsKwW
 4T3abd5NDm5FjxMRUNrqlaAO7x6ty0gNuixIMQHHWoqXWHCqgwnpehJ1xku5cOBVmF9mx8u4s
 eZQqRMarhXELVm9/lG67WlAcxlPhsLDXd7WB7NHmh03HhYfYKmhwQLZePCJpzBA/D5PlucGv0
 cRgWZCglGFaEszCf3bhzZfGnJkDyhdyDRI+bQjMNRVtyvkYSUTx6vCwbly/9UMhw3JXRrufL4
 egVzMGqG0x2KlvD1cgzNoqxVbgROwDhk3HBsl8YdcTvGrMXh5ZGTBesU+2FjNtHX8GGqKUEME
 J9DRkZFI+9//Es6XPyfNP6fu97W0gEVr1ygGky/wYoHGgz0Nyhpkz0XyvAHOBnvXJ19csJDx 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287395>

Hi Junio,

On Wed, 24 Feb 2016, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >
> >> diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
> >> index 91235b7..f62409e 100755
> >> --- a/t/t1308-config-set.sh
> >> +++ b/t/t1308-config-set.sh
> >> @@ -218,4 +218,13 @@ test_expect_success 'check line errors for malformed values' '
> >>  	test_i18ngrep "fatal: .*alias\.br.*\.git/config.*line 2" result
> >>  '
> >>  
> >> +test_expect_success 'error on modifying repo config without repo' '
> >> +	mkdir no-repo &&
> >> +	GIT_CEILING_DIRECTORIES=$(pwd) &&
> >> +	export GIT_CEILING_DIRECTORIES &&
> >> +	cd no-repo &&
> >> +	test_must_fail git config a.b c 2>err &&
> >> +	grep "not in a git directory" err
> >> +'
> >> +
> >>  test_done
> >
> > Please make it a habit to run tests that go up/down in the hierarchy
> > in a subshell.  It is not a good excuse that this new test happens
> > to be at the end _right now_.
> 
> I'd squash this in.

Please do, unless you want me to resend with the squashed commit (I picked
up the change from your 'pu' branch)?

Ciao,
Dscho
