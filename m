From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv5] rebase [-i --exec | -ix] <CMD>...
Date: Wed, 13 Jun 2012 15:25:19 -0700
Message-ID: <7vvciug88g.fsf@alter.siamese.dyndns.org>
References: <1339325076-474-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <1339488312-6349-1-git-send-email-Lucien.Kong@ensimag.imag.fr>
 <4FD70A8E.7050502@in.waw.pl> <7vk3zc4mgz.fsf@alter.siamese.dyndns.org>
 <4FD89DD6.1070705@in.waw.pl>
 <20120613200552.Horde.JHFYfHwdC4BP2NaA39-wrmA@webmail.minatec.grenoble-inp.fr> <7vipevgjhp.fsf@alter.siamese.dyndns.org> <20120613213836.Horde.qI8GQnwdC4BP2Ow8uCTQqgA@webmail.minatec.grenoble-inp.fr> <4FD8FF25.6030908@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: konglu@minatec.inpg.fr,
	Zbigniew J?drzejewski-Szmek <zbyszek@in.waw.pl>,
	Lucien Kong <Lucien.Kong@ensimag.imag.fr>, git@vger.kernel.org,
	Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Thu Jun 14 00:25:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sew0I-0005nG-Ee
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jun 2012 00:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911Ab2FMWZY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jun 2012 18:25:24 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56458 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754663Ab2FMWZV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2012 18:25:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 009068B26;
	Wed, 13 Jun 2012 18:25:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XtjvxQ2oPO+oyLnIXIpg+Pxp5UU=; b=Gttq43
	Ue+Zt6SVKiBxBMLluKLqWj0GudmL/XeBMU5Apx/3VXrfxGNZO5RzF6rzxxMDGrIi
	DwtfN3n+84AZKWf8CEsbqJHqGbII6/v1P3XtuiftqKgEGd7QI9wmmVBzfou++9PS
	M2D1JJxXfU+V3r2roDThN4G3s/nufz4FRFqD0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=jy4QbP9LGVpfk+LnM5knmhZG9x3da4Ts
	WrR26Cf7pimjHomOdIio79iOqcuhUaO3MgnpQCOiDYSTCjMSmVEzVdqSs6f+c6I+
	GwXrnpnojk/iaVKXZrOUe1gPn0gw5U0lVk680g6mJVYDSjVAbhfAaPUH6MxuuO67
	jmPS+Xgpf2c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EAE4C8B24;
	Wed, 13 Jun 2012 18:25:20 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6A5468B23; Wed, 13 Jun 2012
 18:25:20 -0400 (EDT)
In-Reply-To: <4FD8FF25.6030908@kdbg.org> (Johannes Sixt's message of "Wed, 13
 Jun 2012 22:59:17 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A924E058-B5A6-11E1-953D-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199952>

Johannes Sixt <j6t@kdbg.org> writes:

> Not so fast.
>
> 	exec cmd1 && cmd2
> and
> 	exec cmd1
> 	exec cmd2
>
> are far from equivalent: If cmd1 fails, the first version never runs
> cmd2, but the second version runs cmd2 upon rebase --continue.
>
> The updated documentation should not say that the two are "equivalent".

Fair'nuf.  Thansk.

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 179ab77..2d71e4b 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -358,7 +358,7 @@ with several commands:
 +
 	git rebase -i --exec "cmd1 && cmd2 && ..."
 +
-or equivalently by giving more than one `--exec`:
+or by giving more than one `--exec`:
 +
 	git rebase -i --exec "cmd1" --exec "cmd2" --exec ...
 +
