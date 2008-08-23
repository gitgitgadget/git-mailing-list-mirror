From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH RESEND] Do not override LESS
Date: Fri, 22 Aug 2008 22:35:40 -0700
Message-ID: <7vvdxs2t03.fsf@gitster.siamese.dyndns.org>
References: <1219407912-32085-1-git-send-email-mail@cup.kalibalik.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Anders Melchiorsen <mail@cup.kalibalik.dk>
X-From: git-owner@vger.kernel.org Sat Aug 23 07:36:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWlo1-0006Sz-6n
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 07:36:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbYHWFfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 01:35:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751883AbYHWFfw
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 01:35:52 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:59956 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751652AbYHWFfv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 01:35:51 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A92FB644E6;
	Sat, 23 Aug 2008 01:35:49 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 8F093644E4; Sat, 23 Aug 2008 01:35:45 -0400 (EDT)
In-Reply-To: <1219407912-32085-1-git-send-email-mail@cup.kalibalik.dk>
 (Anders Melchiorsen's message of "Fri, 22 Aug 2008 14:25:12 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 57EDD272-70D5-11DD-B3F4-3113EBD4C077-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93425>

Anders Melchiorsen <mail@cup.kalibalik.dk> writes:

> Passing options to "less" with the LESS environment variable can
> interfere with existing environment variables. There are at least two
> problems, as the following examples show:
>
> 1. Alice is using git with colors. Now she decides to set LESS=i for
> some reason. Suddenly, she sees codes in place of colors because LESS
> is no longer set automatically.
>
> 2. Bob sets GIT_PAGER="less -RS", but does not set LESS. Git sets
> LESS=FRSX before calling $GIT_PAGER. Now Bob wonders why his pager is
> not always paging, when he explicitly tried to clear the F option.

3. Christ has been happily using git with his PAGER set to "less".  He
   suddenly notices that output from git linewraps and the pager does not
   exit when showing a short output, and gets very unhappy.
