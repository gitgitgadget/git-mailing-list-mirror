From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] Makefile: use -Wdeclaration-after-statement if
 supported
Date: Sun, 16 Dec 2012 20:18:33 -0800
Message-ID: <7v8v8xpazq.fsf@alter.siamese.dyndns.org>
References: <1355686561-1057-1-git-send-email-git@adamspiers.org>
 <1355686561-1057-4-git-send-email-git@adamspiers.org>
 <7vk3shphru.fsf@alter.siamese.dyndns.org> <20121217021501.GA13745@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git list <git@vger.kernel.org>
To: Adam Spiers <git@adamspiers.org>
X-From: git-owner@vger.kernel.org Mon Dec 17 05:19:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TkSAQ-0005PJ-Sp
	for gcvg-git-2@plane.gmane.org; Mon, 17 Dec 2012 05:19:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429Ab2LQESg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Dec 2012 23:18:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58335 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751026Ab2LQESg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Dec 2012 23:18:36 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 636CCA3D8;
	Sun, 16 Dec 2012 23:18:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=j5R//dHwl+iLF3UI3exSJYcboUo=; b=cS1HD8
	ZpoqFh5ldcDDWjqzRZfd6O92Jr+VUDeWoexdvoBuExSEwph5qyixqboC/OF6zbrO
	Epd707OSYBUUQ9Fp4BmDrtG/E70+6tpPGHubBnRLpS4hwe1PdOB7PI19QfUV2Q0K
	ogJ6q1n1m44KoxoiQemGQZNcaYO613lWHrMe4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B0QjMRGx6tyw8iZCF9//t6SF3PgeQxpm
	gVF8+s8TEITJ8OtiCA15buog0ksVDk5YXviH5w3a0rl+a+b/dAasjo1EqlDbuciC
	nPJM02iLsyAm7Zf0dzkF5R0Y3mxGxIKjMnfffnJL+uHW4rqlwowZHrdsFKOo41Ko
	NVhJ85bs5hU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 51785A3D7;
	Sun, 16 Dec 2012 23:18:35 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C55CAA3D6; Sun, 16 Dec 2012
 23:18:34 -0500 (EST)
In-Reply-To: <20121217021501.GA13745@gmail.com> (Adam Spiers's message of
 "Mon, 17 Dec 2012 02:15:01 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2C9A37A-4800-11E2-A3AE-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211625>

Adam Spiers <git@adamspiers.org> writes:

> OK; I expect these issues with the implementation are all
> surmountable.  I did not necessarily expect this to be the final
> implementation anyhow, as indicated by my comments below the divider
> line.  However it's not clear to me what you think about the idea in
> principle, and whether other compiler flags would merit inclusion.

As different versions of GCC behave differently, and the same GCC
(mis)detect issues differently depending on the optimization level,
I do not know if it will be a fruitful exercise to try to come up
with one expression to come up with the set of flags to suit
everybody.  One flag I prefer to use is -Werror, but that means the
other flags must have zero false positive rate.

If you are interested, the flags I personally use with the version
of GCC I happen to have is in the Make script on the 'todo' branch.
