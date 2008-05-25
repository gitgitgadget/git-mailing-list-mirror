From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-fast-export: Only output a single parent per line
Date: Sat, 24 May 2008 18:38:47 -0700
Message-ID: <7vskw7jh7c.fsf@gitster.siamese.dyndns.org>
References: <1211671313-99006-1-git-send-email-pdebie@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Sun May 25 03:40:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K05DZ-0001aY-1U
	for gcvg-git-2@gmane.org; Sun, 25 May 2008 03:40:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbYEYBi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2008 21:38:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754380AbYEYBi5
	(ORCPT <rfc822;git-outgoing>); Sat, 24 May 2008 21:38:57 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46173 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751636AbYEYBi4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2008 21:38:56 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AFC2F3F8A;
	Sat, 24 May 2008 21:38:55 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 155583F87; Sat, 24 May 2008 21:38:50 -0400 (EDT)
In-Reply-To: <1211671313-99006-1-git-send-email-pdebie@ai.rug.nl> (Pieter de
 Bie's message of "Sun, 25 May 2008 01:21:53 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 56946330-29FB-11DD-8A0E-80001473D85F-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82847>

Pieter de Bie <pdebie@ai.rug.nl> writes:

> According to the git-fast-import man-page, you can only put a single
> committish per merge: line, like this:
>
>   merge :10
>   merge :11
>
> However, git-fast-export puts all parents on a single line, like this:
>
>   merge :10 :11
>
> This may be fine with git-fast-import,...

Is it fine for even git-fast-import?  fast-import.c: parse_merge() seems
to suggest that it also wants one parent per "merge " line.
