From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv2] t4202-log.sh: Test git log --no-walk sort order
Date: Tue, 14 Jul 2009 16:13:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907141612350.4553@intel-tinevez-2-302>
References: <4A5C785C.6060706@viscovery.net> <1247575519-9629-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>,
	Paolo Bonzini <bonzini@gnu.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Jul 14 16:14:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQilu-000551-7b
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 16:14:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbZGNOOD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 10:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754631AbZGNOOD
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 10:14:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:55186 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754506AbZGNOOB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 10:14:01 -0400
Received: (qmail invoked by alias); 14 Jul 2009 14:13:59 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp011) with SMTP; 14 Jul 2009 16:13:59 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+16T4k8nu1UYLVxXSQDm7wRBUJ0c705+EcfQ1JHJ
	roslgHEkWPUHwX
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <1247575519-9629-1-git-send-email-git@drmicha.warpmail.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123248>

Hi,

On Tue, 14 Jul 2009, Michael J Gruber wrote:

> 'git log --no-walk' sorts commits by commit time whereas 'git show' does
> not (it leaves them as given on the command line). Document this by two
> tests so that we never forget why ba1d450 (Tentative built-in "git
> show", 2006-04-15) introduced it and 8e64006 (Teach revision machinery
> about --no-walk, 2007-07-24) exposed it as an option argument.

Thanks.

> +cat > expect << EOF
> +5d31159 fourth
> +ein
> +804a787 sixth
> +a/two
> +394ef78 fifth
> +a/two
> +EOF
> +test_expect_success 'git show <commits> leaves list of commits as given' '
> +	git show --oneline --name-only 5d31159 804a787 394ef78 > actual &&
> +	test_cmp expect actual
> +'

Just to hazard a guess: you probably used --name-only to avoid having the 
whole diff in the output, right?  In that case, you might want to use -s 
in the future (I do not think this needs fixing in this patch).

Ciao,
Dscho
