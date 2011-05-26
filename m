From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Whitespace and '&nbsp'
Date: Thu, 26 May 2011 14:12:31 -0700
Message-ID: <BANLkTik7eJ=BC9Bekqu-W1-r0cheCjC+wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 26 23:13:00 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPhrX-0007OI-37
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 23:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758210Ab1EZVMz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 17:12:55 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:59149 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754440Ab1EZVMy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 May 2011 17:12:54 -0400
Received: from mail-ew0-f46.google.com (mail-ew0-f46.google.com [209.85.215.46])
	(authenticated bits=0)
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id p4QLCqNZ021261
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=FAIL)
	for <git@vger.kernel.org>; Thu, 26 May 2011 14:12:53 -0700
Received: by ewy4 with SMTP id 4so407450ewy.19
        for <git@vger.kernel.org>; Thu, 26 May 2011 14:12:51 -0700 (PDT)
Received: by 10.14.16.16 with SMTP id g16mr281124eeg.193.1306444371647; Thu,
 26 May 2011 14:12:51 -0700 (PDT)
Received: by 10.14.127.70 with HTTP; Thu, 26 May 2011 14:12:31 -0700 (PDT)
X-Spam-Status: No, hits=-102.981 required=5 tests=AWL,BAYES_00,USER_IN_WHITELIST
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174571>

So I just got a patch that had a hidden &nbsp in it (unicode: u00a0,
utf-8: \0302\0240) and sad to say my terminal window shows no
indication of that what-so-ever. It looks exactly like a regular
space, except gcc won't actually accept it.

So I'm wondering whether git shouldn't be escaping things like that in
diffs, for example. Looking at binary noise (using "git diff --text"),
I notice we have other things that don't get escaped either, although
at least then "less" will escape it for us. Again, for &nbsp, less
doesn't show it any different than a regular space either.

Yeah, I'm sure there is some programming font out there that makes it
visible, but I do wonder whether git should help.

I even used "--whitespace=fix" to apply the patch, but git doesn't
even recognize the thing as whitespace, so that didn't make any real
difference.

                          Linus
