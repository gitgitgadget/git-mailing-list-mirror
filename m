From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: What's cooking in git.git (topics)
Date: Fri, 18 Jul 2008 13:55:50 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807181351370.3932@eeepc-johanness>
References: <7vr69r8sqk.fsf@gitster.siamese.dyndns.org> <7vlk01hqzz.fsf@gitster.siamese.dyndns.org> <20080718175040.6117@nanako3.lavabit.com> <20080718182010.6117@nanako3.lavabit.com> <7v63r38r4r.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 13:56:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJoZB-0003Nz-3x
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 13:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755445AbYGRLzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 07:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755418AbYGRLzH
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 07:55:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:47192 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755343AbYGRLzG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 07:55:06 -0400
Received: (qmail invoked by alias); 18 Jul 2008 11:55:04 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp052) with SMTP; 18 Jul 2008 13:55:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX195FeJKV4d5CeXauL7Cx6DQNsFjVtH6xXHlMJaiXI
	dKItOm6MEGclvQ
X-X-Sender: user@eeepc-johanness
In-Reply-To: <7v63r38r4r.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89032>

Hi,

On Fri, 18 Jul 2008, Junio C Hamano wrote:

> +The 'recursive' strategy can take the following options:
> +
> +ours;;

You still have not addressed the issue that you can specify multiple 
strategies, or even a single _wrong_ one.  So:

	$ git merge -s stupid -Xours

would not fail at all, but definitely not do the right thing either (it 
disobeys a direct command of the user).

Apart from having to choose different -X option names for the different 
backends, to avoid them from clashing when you specify multiple 
strategies, you also deprive the user from being able to try the _same_ 
backend with different options.

IOW all my objections to the -X option (even that it does not fit with our 
short option parsing paradigm) still apply.

We already have the "-S" wart, let's not add to that pile.

Ciao,
Dscho
