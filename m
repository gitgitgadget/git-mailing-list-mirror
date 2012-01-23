From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] add a Makefile switch to avoid gettext translation
 in shell scripts
Date: Mon, 23 Jan 2012 14:23:25 -0800
Message-ID: <7vehuq6ote.fsf@alter.siamese.dyndns.org>
References: <CALxABCZME-g++HxMsD4Nrn1J6s27vN7M_KQSVT3PeLWBqP7qJg@mail.gmail.com>
 <CACBZZX4TsL-tj04PmUwGNWjXO+JY-8unAv-aRKOGvgB71qdYCg@mail.gmail.com>
 <CALxABCadHdvR02Br9e6STy0w+EPoycUKr62RiSUSP_EPF-TH3g@mail.gmail.com>
 <CACBZZX4tB6DGV-1tiuOamq7ACPk0a-=1Pb9Vk1SgyDqAq-EFOw@mail.gmail.com>
 <CALxABCbaBmP6k5TYrYLCYm8oiv=9cF=N7_opSTKUnbkz5b-cwg@mail.gmail.com>
 <20120119195222.GA5011@blimp.dmz> <7v1uqq84es.fsf@alter.siamese.dyndns.org>
 <7vwr8i6prk.fsf_-_@alter.siamese.dyndns.org>
 <7vr4yq6poy.fsf_-_@alter.siamese.dyndns.org>
 <20120123221256.GG20833@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 23 23:23:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RpSIe-0000cG-MX
	for gcvg-git-2@lo.gmane.org; Mon, 23 Jan 2012 23:23:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754539Ab2AWWXa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jan 2012 17:23:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39848 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752514Ab2AWWX2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2012 17:23:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0EF257A8C;
	Mon, 23 Jan 2012 17:23:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oWM78e1TLAR05dLjH6QkstUerR0=; b=ifMTuR
	f8M7JVLlDvYN/usfuS7/F06PeOBpguq7xBRWl9Y+Aib3cobYbonWjkNQbx8op3Sr
	yAS62dMNpJ8jv2Wab8jfJbU+M2gliEemo9P45OynjVAqZ22SHiLGfwhi2+fjNZbO
	+6EjnxOSFbB0SS2WGwU0BYwpgN3vTgvm4S2uI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=kVu1UbdSahX1S1aZUtRva4uafSOHvRlA
	CBE5qGjEtPstTGyFC7/JOl6SJZuXtvq0DLAPtHNxYAhXs0qRAeo3EUzcP36ur9XO
	7pRM5OsI/XWerpIe5dW1KQ8bIl2L/IIfK1L3lAU/vfSWkzVYA7TU57ko14B0i316
	E8S2/HVgtQ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0616F7A8B;
	Mon, 23 Jan 2012 17:23:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5DC257A8A; Mon, 23 Jan 2012
 17:23:27 -0500 (EST)
In-Reply-To: <20120123221256.GG20833@burratino> (Jonathan Nieder's message of
 "Mon, 23 Jan 2012 16:12:56 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: DF1520D4-4610-11E1-A1AF-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189019>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>>     make USE_GETTEXT_SCHEME=fallthrough
>>
>> This will replace the translation routines with fallthrough versions,
>> that does not use gettext from the platform.
>
> Nice implementation.  I still don't understand why NO_GETTEXT=YesPlease
> should not imply this.

Should be easy to do so, like this?

diff --git a/Makefile b/Makefile
index a782409..c4c1066 100644
--- a/Makefile
+++ b/Makefile
@@ -1521,6 +1521,7 @@ ifdef GETTEXT_POISON
 endif
 ifdef NO_GETTEXT
 	BASIC_CFLAGS += -DNO_GETTEXT
+	USE_GETTEXT_SCHEME = fallthrough
 endif
 ifdef NO_STRCASESTR
 	COMPAT_CFLAGS += -DNO_STRCASESTR
