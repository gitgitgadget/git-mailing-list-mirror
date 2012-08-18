From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] git-config.txt: properly escape quotation marks in
 example
Date: Sat, 18 Aug 2012 16:39:27 -0700
Message-ID: <7vmx1rrcr4.fsf@alter.siamese.dyndns.org>
References: <1345311130-20426-1-git-send-email-mhagger@alum.mit.edu>
 <1345311130-20426-2-git-send-email-mhagger@alum.mit.edu>
 <7v7gswrkvm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Sun Aug 19 01:39:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2scD-0005Dh-22
	for gcvg-git-2@plane.gmane.org; Sun, 19 Aug 2012 01:39:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074Ab2HRXjb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Aug 2012 19:39:31 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48911 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751667Ab2HRXja (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Aug 2012 19:39:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E325F9C0A;
	Sat, 18 Aug 2012 19:39:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Vf4HRFAtkCZ/8sCozKZfVVBP8z0=; b=u4y1+K
	bQyGJVNLxrHDgQap56skZWnKjyOBjfAuUs5VuNo5RuLbSi/juOrCq8kux9UulTmt
	+iRP6VKwLSpqHBLnNKGEo/ExgFu5RJbJodW+et7xbfR5SO5NQUyiRxev6GTf7CQL
	ROOrF16ZwtiMjt+Q5MVcc0fsy7HSxUixfVT0c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dUwXg4QYrn1jVi8mn+UlzJiBj9WHBO/r
	hTMlbSllg9LZTce/avAxr7Zqm9DxWWqcQ77DJp/idDeuhv+N2MIZjbhjgelIqQHD
	Q4nvtbtmNT7c0Tig1JaRz4YfQrIpqLkwjjHha1X+0E+9id2s4GsVcM4wjHyjSuHi
	f/2FOnDHm7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0B019C08;
	Sat, 18 Aug 2012 19:39:29 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 384499C07; Sat, 18 Aug 2012
 19:39:29 -0400 (EDT)
In-Reply-To: <7v7gswrkvm.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sat, 18 Aug 2012 13:43:57 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F41312E0-E98D-11E1-9164-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203706>

Junio C Hamano <gitster@pobox.com> writes:

>> The bigger question is whether this example is improved by including
>> quotation marks, or whether they are just a distraction from the main
>> point.  I abstain.
>
> Thanks for spelling that bigger question out.  Given that the
> example is showing distinction between "X" vs "X for Y", I would say
> quotation is a distraction.
>
> If you spelled it as
>
> 	[core]
>         	gitproxy = sh -c 'proxy-command' for kernel.org
>
> does the do the right thing?  Or do we require the above to be
> spelled as
>
> 	[core]
>         	gitproxy = \"sh -c 'proxy-command'\" for kernel.org
>
> to work correctly?

I think the answer is "no", there is no way to specify anything
other than a "path to the command" for gitproxy.  So I think we
should do this instead:

-- >8 --
Subject: [PATCH] git-config doc: unconfuse an example

One fictitious command "proxy-command" is enclosed inside a double
quote pair, while another fictitious command "default-proxy" is not
in the example, but the quoting does not change anything in the pair
of examples.  Remove the quotes to avoid unnecessary confusion.

Noticed by Michael Haggerty.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-config.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 5382753..b24faa8 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -251,7 +251,7 @@ Given a .git/config like this:
 
 	; Proxy settings
 	[core]
-		gitproxy="proxy-command" for kernel.org
+		gitproxy=proxy-command for kernel.org
 		gitproxy=default-proxy ; for all the rest
 
 you can set the filemode to true with
-- 
1.7.12.rc3.96.g0dba3eb
