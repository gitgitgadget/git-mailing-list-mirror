From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Add support for uintmax_t type on FreeBSD 4.9
Date: Mon, 27 Oct 2008 21:14:24 -0700
Message-ID: <7v8ws9gxun.fsf@gitster.siamese.dyndns.org>
References: <1225021957-11880-1-git-send-email-david.syzdek@acsalaska.net>
 <7vy70aip06.fsf@gitster.siamese.dyndns.org>
 <9a0027270810262239r311074m51d382bdd95fd0dc@mail.gmail.com>
 <9a0027270810262246i56cf5515l5fa0875f91d90a7a@mail.gmail.com>
 <7v1vy2imt2.fsf@gitster.siamese.dyndns.org>
 <9a0027270810270623h4c0c34d0vcd92f61edff6da5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "David Syzdek" <syzdek@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 05:15:57 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kufzo-00059B-Ms
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 05:15:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbYJ1EOn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Oct 2008 00:14:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751344AbYJ1EOn
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 00:14:43 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43165 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750831AbYJ1EOn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 00:14:43 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 356EB745C6;
	Tue, 28 Oct 2008 00:14:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 01C37745C3; Tue, 28 Oct 2008 00:14:31 -0400 (EDT)
In-Reply-To: <9a0027270810270623h4c0c34d0vcd92f61edff6da5@mail.gmail.com>
 (David Syzdek's message of "Mon, 27 Oct 2008 05:23:15 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F1F7BD92-A4A6-11DD-8A3E-9CEDC82D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99275>

"David Syzdek" <syzdek@gmail.com> writes:

> The following should match against FreeBSD 4.x:
>
> 	FREEBSD_MAJOR := $(shell sh -c 'echo $(uname_R) |cut -d. -f1')
> 	ifeq ($(FREEBSD_MAJOR),4)
> 		NO_UINTMAX_T = YesPlease
> 		NO_STRTOUMAX = YesPlease
> 	endif
>
> Is the use of FREEBSD_MAJOR okay, or would another name be more appropriate?

Other parts of the Makefile seems to do something like this:

	ifeq ($(shell expr "$(uname_R)" : '4\.'),2)
        
