From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] Teach Solaris that _XOPEN_SOURCE=600 really menas XPG6
Date: Thu, 11 Jun 2009 08:58:46 -0700
Message-ID: <7vmy8eiwy1.fsf@alter.siamese.dyndns.org>
References: <1243106697-6424-1-git-send-email-gitster@pobox.com>
	<1243106697-6424-2-git-send-email-gitster@pobox.com>
	<B96700A1-EC8C-4DDE-A158-CE298FCCA09F@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 17:59:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEmgc-0005bw-7M
	for gcvg-git-2@gmane.org; Thu, 11 Jun 2009 17:59:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757415AbZFKP6p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2009 11:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756968AbZFKP6p
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jun 2009 11:58:45 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:64559 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751972AbZFKP6o (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2009 11:58:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090611155847.NYZM20430.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jun 2009 11:58:47 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 2fym1c0054aMwMQ03fymVw; Thu, 11 Jun 2009 11:58:46 -0400
X-VR-Score: 0.00
X-Authority-Analysis: v=1.0 c=1 a=UYOYdknvHTQA:10 a=aXQZQtK9SsAA:10
 a=bsX3JSduAAAA:8 a=O-ILPTpbCTr_fC8KXhcA:9 a=pK8KfMk50myrLOfS_i0LQbETZRgA:4
 a=2yHT65ZCHLwA:10
X-CM-Score: 0.00
In-Reply-To: <B96700A1-EC8C-4DDE-A158-CE298FCCA09F@dbservice.com> (Tomas Carnecky's message of "Thu\, 11 Jun 2009 17\:06\:00 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121346>

Tomas Carnecky <tom@dbservice.com> writes:

> Until this commit a simple 'make prefix=...' worked just fine. Now I
> have to explicitly add '-std=c99' to the gcc commandline. Is there a
> reason why the makefile doesn't add this switch automatically?

An extended "Solaris updates" series has been cooking in 'next' branch, I
think, and does things a bit differently.

4cb18a4 (git-compat-util.h: tweak the way _XOPEN_SOURCE is set on Solaris,
2009-06-05) sets _XOPEN_SOURCE to 500 if you are not compiling with c99.
