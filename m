From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] man: git pull -r is a short for --rebase
Date: Thu, 16 Aug 2012 23:18:40 -0700
Message-ID: <7vk3wyvy67.fsf@alter.siamese.dyndns.org>
References: <20120816095018.GD5489@suse.cz>
 <7v1uj63iyx.fsf@alter.siamese.dyndns.org> <502D5D97.3020906@kdbg.org>
 <7v4no21raw.fsf@alter.siamese.dyndns.org>
 <7vzk5uzgqa.fsf@alter.siamese.dyndns.org> <20120817053826.GB22313@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Miklos Vajna <vmiklos@suse.cz>
X-From: git-owner@vger.kernel.org Fri Aug 17 08:19:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T2FuD-0002ar-RJ
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 08:19:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754123Ab2HQGT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Aug 2012 02:19:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61354 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751642Ab2HQGSo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Aug 2012 02:18:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 27EA29E74;
	Fri, 17 Aug 2012 02:18:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Cf1f0MmrGJgW6plP6JmLQ1+r37M=; b=sZGIJH
	rsdsEtvaGsb+x1+IAHhvZ4ZsOuTzpMqPJ+eAV8Alv+Dk9sGEtj3mVeCMI9JAH+jn
	VDXrseB0EFipDGT4ag3qqDzyVWNib3/pArC+hkBSuo6HKlLqfPf+SqeRD3wBEyCY
	d5kp0utusn3OqvkwPMa/Izcl6ioLhiraNfIa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=q2JIOFDFkA3ygiXu4TUCGjb2E836e6KV
	Btu/KCqmvTzUi+xAHRjdorwt6upHkGsvwcG+KRWovHZLNq5cdqlSNMqccfiIj+5u
	U0ZSEv2lBpqcV1QRRlGxp9RLDLNIEL0iBQLt5Zv7XTamxtjpVT2QaBPpEyf1pgQz
	ijuInWvlQ2o=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1651B9E73;
	Fri, 17 Aug 2012 02:18:43 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 684049E72; Fri, 17 Aug 2012
 02:18:42 -0400 (EDT)
In-Reply-To: <20120817053826.GB22313@suse.cz> (Miklos Vajna's message of
 "Fri, 17 Aug 2012 07:38:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 64776CA4-E833-11E1-B10D-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miklos Vajna <vmiklos@suse.cz> writes:

> I agree that it's a bit strange, but based on a quick search, it seems
> multiple projects already advertise git pull -r (i.e. not --rebase and
> not a configuration option):
>
> http://lilypond.org/doc/v2.15/Documentation/contributor/pulling-and-rebasing
> http://wiki.documentfoundation.org/Git_For_LibreOffice_Developers
> http://www.wiremod.com/forum/wiremod-general-chat/29517-git-introduction-incomplete-unformatted.html
>
> So it seems making -r refer to --recurse-submodules would already cause
> quite some pain to users.

Yuck. I could say it's not our problem that others spread something
we didn't document ;-) but I am too nice to say that.

Let's do this, then, but you have to sign off your patch.

Thanks for investigating.

-- >8 --
From: Miklos Vajna <vmiklos@suse.cz>
Date: Thu, 16 Aug 2012 11:50:18 +0200
Subject: [PATCH] man: git pull -r is a short for --rebase

Letting the "--rebase" option squat on the short-and-sweet single
letter option "-r" was an unintended accident and was not even
documented, but the short option seems to be already used in the
wild. Let's document it so that other options that begin with "r"
would not be tempted to steal it.
---
 Documentation/git-pull.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index defb544..67fa5ee 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -101,6 +101,7 @@ include::merge-options.txt[]
 
 :git-pull: 1
 
+-r::
 --rebase::
 	Rebase the current branch on top of the upstream branch after
 	fetching.  If there is a remote-tracking branch corresponding to
-- 
1.7.12.rc3.2.gbd120e3
