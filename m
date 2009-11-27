From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH/RFC 02/11] strbuf: add non-variadic function    strbuf_vaddf()
Date: Fri, 27 Nov 2009 08:09:40 +0100
Message-ID: <4B0F7B34.4090908@viscovery.net>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>	 <1259196260-3064-2-git-send-email-kusmabite@gmail.com>	 <1259196260-3064-3-git-send-email-kusmabite@gmail.com>	 <7vskc2ksnn.fsf@alter.siamese.dyndns.org>	 <40aa078e0911260238rd0c90cag126709d1de5f50de@mail.gmail.com>	 <7vbpip86q5.fsf@alter.siamese.dyndns.org> <40aa078e0911261537r40b19dffqf019848dcad23fef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,
	git@vger.kernel.org, dotzenlabs@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 27 08:09:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDuxe-0007XS-Qh
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 08:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbZK0HJf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 02:09:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752111AbZK0HJf
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 02:09:35 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:15356 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751045AbZK0HJf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 02:09:35 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NDuxY-0005Ki-Nn; Fri, 27 Nov 2009 08:09:40 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 7793F1660F;
	Fri, 27 Nov 2009 08:09:40 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <40aa078e0911261537r40b19dffqf019848dcad23fef@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133867>

Erik Faye-Lund schrieb:
> Perhaps I can do one better: use memcpy instead of standard
> assignment. The Autoconf manual[1] suggests that it's more portable.
> Something like this:
> 
> #ifndef va_copy
> # ifdef __va_copy
> #  define va_copy(a,b) __va_copy(a,b)
> # else
> #  define va_copy(a,b) memcpy(&a, &b, sizeof (va_list))
> # endif
> #endif
> 
> I'll add this to git-compat-util.h this for the next round unless
> someone yells really loud at me.

As I said elsewhere in the thread, I do not see enough reason to add
strbuf_vaddf() only for a syslog() emulation in the first place.

-- Hannes
