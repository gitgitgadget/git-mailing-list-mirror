From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase.txt: Mention that --whitespace cannot be used
 with interactive rebase.
Date: Thu, 12 Feb 2009 16:50:13 -0800
Message-ID: <7vy6wbgny2.fsf@gitster.siamese.dyndns.org>
References: <20090212102119.1de19087@crow>
 <7veiy3i61g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Burton <markb@ordern.com>
X-From: git-owner@vger.kernel.org Fri Feb 13 01:51:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXmHZ-0003Zb-B4
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 01:51:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757084AbZBMAuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 19:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756176AbZBMAuU
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 19:50:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:46465 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754327AbZBMAuT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 19:50:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E06F79922A;
	Thu, 12 Feb 2009 19:50:18 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id C984C99229; Thu,
 12 Feb 2009 19:50:15 -0500 (EST)
In-Reply-To: <7veiy3i61g.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 12 Feb 2009 15:34:03 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 49142C62-F968-11DD-9A4C-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109697>

Junio C Hamano <gitster@pobox.com> writes:

> Mark Burton <markb@ordern.com> writes:
>
>> Signed-off-by: Mark Burton <markb@ordern.com>
>> ---
>>  Documentation/git-rebase.txt |    1 +
>>  1 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
>> index 3d6d429..60582a4 100644
>> --- a/Documentation/git-rebase.txt
>> +++ b/Documentation/git-rebase.txt
>> @@ -246,6 +246,7 @@ OPTIONS
>>  --whitespace=<nowarn|warn|error|error-all|strip>::
>>  	This flag is passed to the 'git-apply' program
>>  	(see linkgit:git-apply[1]) that applies the patch.
>> +	Not supported when using the --interactive option.
>
> So is it "not supported when using", or "incompatible with"?
>
> If the option is silently ignored, it is former, and we have a bug.  If
> the program refuses to work then it is the latter.

It appears it is the latter, so I've queued with a rewrite.  Hope it is Ok
with you.

Thanks.

-- >8 --
From: Mark Burton <markb@ordern.com>
Date: Thu, 12 Feb 2009 10:21:19 +0000
Subject: [PATCH] git-rebase.txt: --interactive does not work with --whitespace

Signed-off-by: Mark Burton <markb@ordern.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-rebase.txt |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 3d6d429..30487de 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -246,6 +246,7 @@ OPTIONS
 --whitespace=<nowarn|warn|error|error-all|strip>::
 	This flag is passed to the 'git-apply' program
 	(see linkgit:git-apply[1]) that applies the patch.
+	Incompatible with the --interactive option.
 
 -i::
 --interactive::
