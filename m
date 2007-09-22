From: David Kastrup <dak@gnu.org>
Subject: Re: [PATCH] Allow shell scripts to run with non-Bash /bin/sh
Date: Sat, 22 Sep 2007 02:05:32 +0200
Message-ID: <86abrfy377.fsf@lola.quinscape.zz>
References: <20070921214346.GF97288@void.codelabs.ru> <7v8x6zinjf.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 22 02:06:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYsVR-0003El-TT
	for gcvg-git-2@gmane.org; Sat, 22 Sep 2007 02:05:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753069AbXIVAFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Sep 2007 20:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753025AbXIVAFu
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Sep 2007 20:05:50 -0400
Received: from main.gmane.org ([80.91.229.2]:57605 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752095AbXIVAFt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Sep 2007 20:05:49 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IYsV8-00044P-Nr
	for git@vger.kernel.org; Sat, 22 Sep 2007 00:05:38 +0000
Received: from pd95b0fdb.dip0.t-ipconnect.de ([217.91.15.219])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 Sep 2007 00:05:38 +0000
Received: from dak by pd95b0fdb.dip0.t-ipconnect.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 22 Sep 2007 00:05:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd95b0fdb.dip0.t-ipconnect.de
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.50 (gnu/linux)
Cancel-Lock: sha1:drMXymAIxM3Gk7gWe88t6v+dF9k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58898>

Junio C Hamano <gitster@pobox.com> writes:

> I do not doubt that "while case $# in 0) break ;; esac" does not
> work for your shell.  But I think the above comment is grossly
> misleading.

Personally, I find this idiom distasteful.

I'd do either
while case $# in 0) false ;; *) true esac

or, more likely 
while : do case $# in 0) break;; esac

But doing a break inside of the while _condition_ rather than the body
just feels wrong to me.

-- 
David Kastrup
