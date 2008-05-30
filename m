From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] perl/Git.pm: add parse_rev method
Date: Fri, 30 May 2008 15:19:13 -0700
Message-ID: <7vtzgfh1um.fsf@gitster.siamese.dyndns.org>
References: <20080530095047.GD18781@machine.or.cz>
 <1212179270-26170-1-git-send-email-LeWiemann@gmail.com>
 <20080530210531.GH18781@machine.or.cz>
 <7vd4n3iivt.fsf@gitster.siamese.dyndns.org>
 <86r6bjmpqc.fsf@blue.stonehenge.com> <484078C7.7020008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Randal L. Schwartz" <merlyn@stonehenge.com>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 31 00:20:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2CxR-0003LU-B4
	for gcvg-git-2@gmane.org; Sat, 31 May 2008 00:20:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752328AbYE3WT3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 18:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752174AbYE3WT3
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 18:19:29 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:40396 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751425AbYE3WT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 18:19:28 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 242553F84;
	Fri, 30 May 2008 18:19:27 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 35E583BEE; Fri, 30 May 2008 18:19:21 -0400 (EDT)
In-Reply-To: <484078C7.7020008@gmail.com> (Lea Wiemann's message of "Fri, 30
 May 2008 23:59:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 773BA824-2E96-11DD-BB4B-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83351>

Lea Wiemann <lewiemann@gmail.com> writes:

> I'm honestly not too keen on sacrificing time (or code prettiness) on
> 5.6 compatibility, so if there are no reasons besides the memory leak
> to move away from throw/catch, perhaps we can just keep using it?

If we aim for code prettyness, I would say try/catch should definitely go.
They are spelled as "eval" in properly written Perl, and not doing so
makes your program look ugly.
