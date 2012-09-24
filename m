From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git archive --format zip utf-8 issues
Date: Mon, 24 Sep 2012 11:13:04 -0700
Message-ID: <7vtxunz3v3.fsf@alter.siamese.dyndns.org>
References: <502583F4.8030308@tu-clausthal.de>
 <7vtxwagy9f.fsf@alter.siamese.dyndns.org> <5026C649.2090700@lsrfire.ath.cx>
 <5026D081.2040906@tu-clausthal.de>
 <20120830222603.GA20289@sigill.intra.peff.net>
 <5046634A.4020608@lsrfire.ath.cx> <7vehmh8prt.fsf@alter.siamese.dyndns.org>
 <5047A9C0.9020200@lsrfire.ath.cx> <5058CE49.3070108@lsrfire.ath.cx>
 <7v1uhzkpcc.fsf@alter.siamese.dyndns.org> <505B91E9.7060208@lsrfire.ath.cx>
 <506082C9.6050604@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Mon Sep 24 20:13:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGD9m-0006OT-2Q
	for gcvg-git-2@plane.gmane.org; Mon, 24 Sep 2012 20:13:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757518Ab2IXSNJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Sep 2012 14:13:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:65353 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757174Ab2IXSNH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Sep 2012 14:13:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C9C4A93F5;
	Mon, 24 Sep 2012 14:13:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Lhx8zol8FZFZ
	EM4K3hdM7Ktx/fY=; b=Y9skvwS92EjZkXMOUxNgyyK5nEwFBJU/n6d1jJzGhNzX
	nn4zwpocT00Wpi3vinhFkwHZAdkrfGudmwDuB0FQRG2NT2Sti58zxr0Tcsulq5/R
	Q1/usY4Mlr4w09vSyj5dl+n78TkIZxTesUEWbA75Q52v12gtpWyasbtn8WjtUio=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tPDDdk
	HHfWQIl1xiMF7qU9/g8EJFKvwQCStD2EJCeLf3jUuTZpgU+tPrFbQ8Vv0LNoZ4/G
	VM9XVmA/IBgi6D8VmjsNAZ+6lZJrEV30vHngYJZ2p8mMAoDNsAYJPErff4mDOKGh
	46qZ25q2ZBeryavcQOS0Q89uwgTCMddzFqqtI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B561193F4;
	Mon, 24 Sep 2012 14:13:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20AA793F1; Mon, 24 Sep 2012
 14:13:06 -0400 (EDT)
In-Reply-To: <506082C9.6050604@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Mon, 24 Sep 2012 17:56:57 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7CECB84E-0673-11E2-9A09-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206302>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> "git 1" is the patch "archive-zip: support UTF-8 paths" added, which
> let's archive-zip make use of the UTF-8 flag.  "git 2" is "git 1" plu=
s
> the patch "archive-zip: declare creator to be Unix for UTF-8
> paths". Both have been posted before.  "git 3" is "git 1" plus the ne=
w
> patch "archive-zip: write extended timestamp".
>
> Let's drop patch 2 (Unix as creator) and keep patches 1 (UTF-8 flag)
> and 3 (mtime field) to make archive-zip record non-ASCII filenames in
> a portable way.  It's not perfect, but I don't know how to do any
> better given that Windows' built-in ZIP functionality expects
> filenames in the local code page and with an international audience
> for projects distributing ZIP files.

Thanks.
