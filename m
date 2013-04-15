From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH master] convert: The native line-ending is \r\n on MinGW
Date: Mon, 15 Apr 2013 14:43:24 -0700
Message-ID: <7vsj2rpj0j.fsf@alter.siamese.dyndns.org>
References: <1275679748-7214-1-git-send-email-eyvind.bernhardsen@gmail.com>
 <20100904082509.GC10140@burratino> <7vbp8aqtuz.fsf@alter.siamese.dyndns.org>
 <7v4nf7qzkd.fsf@alter.siamese.dyndns.org>
 <CABPQNSaA7Qdt5eCZR3rs87gL730Y_xMrg6S-++YuaXdC2k45jg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>,
	git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Mon Apr 15 23:43:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URrBT-0007jD-IA
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 23:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934918Ab3DOVn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 17:43:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54874 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934043Ab3DOVn1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 17:43:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7ECB5167B3;
	Mon, 15 Apr 2013 21:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=zuyj5fPOaoY+IMxhuCYIB90aXKs=; b=L+uceD
	mbg3SnTdgUb96DZFrkF2ViAD/jlVA9yssdwXwbQLhs3Br4yDB+GZsyc4sCIw+57x
	8fCTuaMs64zLyJKcZWPe4Yyv/a2iMLzZ7VzgqpmVlVWiwktogXiw0yvafFhVDOi2
	60FKG2H9/sc6zTvEmkaTS/AEjzhBZ2tCf4h4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BQyXaH6wBu21H0Ijjd60QuGPhNJSRkht
	hFqIplTEnDAxRn5bHSUlXwdwoLIEhioRzPh2qCOc3b2RJNzhrnUdcWp1X1ADbdj8
	HvKK1IS1VgTcslthb48k2j+0B3bk1L1uVDZ0ztFG0Rx78e8n5BKyPCRPE28hX+nc
	vJm329RClE0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 75930167B2;
	Mon, 15 Apr 2013 21:43:26 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AA9C1167B0; Mon, 15 Apr
 2013 21:43:25 +0000 (UTC)
In-Reply-To: <CABPQNSaA7Qdt5eCZR3rs87gL730Y_xMrg6S-++YuaXdC2k45jg@mail.gmail.com> (Erik
 Faye-Lund's message of "Mon, 15 Apr 2013 23:20:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 80AD0780-A615-11E2-B657-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221320>

Erik Faye-Lund <kusmabite@gmail.com> writes:

> This is absolutely the right thing to do. However, stuff have changed
> a bit since the patch was written; this change now needs to go in
> config.mak.uname instead of config.mak.

Thanks for a quick response.

What's your preference?  I could just ignore a patch I won't be able
to test myself and have you guys carry it in your tree forever, but
I do not think that is necessary for something small like this.

I think this is low impact enough that it can directly go to
'master' or even 'maint' if I were to apply to my tree.

Thanks.

-- >8 --
From: Jonathan Nieder <jrnieder@gmail.com>
Date: Sat, 4 Sep 2010 03:25:09 -0500
Subject: [PATCH] convert: The native line-ending is \r\n on MinGW

If you try this:

 1. Install Git for Windows (from the msysgit project)

 2. Put

	[core]
		autocrlf = false
		eol = native

    in your .gitconfig.

 3. Clone a project with

	*.txt text

    in its .gitattributes.

Then with current git, any text files checked out have LF line
endings, instead of the expected CRLF.

Cc: Johannes Schindelin <johannes.schindelin@gmx.de>
Cc: Johannes Sixt <j6t@kdbg.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 9080054..d78fd3d 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -507,6 +507,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 		compat/win32/dirent.o
 	EXTLIBS += -lws2_32
 	PTHREAD_LIBS =
+	NATIVE_CRLF = YesPlease
 	X = .exe
 	SPARSE_FLAGS = -Wno-one-bit-signed-bitfield
 ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
-- 
1.8.2.1-542-g3613165
