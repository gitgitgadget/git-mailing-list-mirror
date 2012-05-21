From: "Matt Seitz (matseitz)" <matseitz@cisco.com>
Subject: Re: [PATCH 2/2] git-sh-setup: work around Cygwin path handling gotchas
Date: Mon, 21 May 2012 16:51:04 -0700
Message-ID: <70952A932255A2489522275A628B97C31348C4AB@xmb-sjc-233.amer.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 22 01:52:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWcOT-0006Bw-32
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 01:52:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932709Ab2EUXvW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 19:51:22 -0400
Received: from mtv-iport-3.cisco.com ([173.36.130.14]:4792 "EHLO
	mtv-iport-3.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932726Ab2EUXvG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 May 2012 19:51:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=matseitz@cisco.com; l=683; q=dns/txt;
  s=iport; t=1337644266; x=1338853866;
  h=mime-version:content-transfer-encoding:subject:date:
   message-id:from:to;
  bh=SWhCz8F3krse6OLWFzDNGGqDcxSzE7M6lmvF+8XBXtc=;
  b=Zwq5+sP1cqeKAsfT6tgBHMUrWZtAiY1WqFw+bzx2OzBwZRoH6bmiD9Qh
   Dk6WXkLxaT+LVaWPjZH4DiNS6+mUrVP0rZLWNFrG1ZGbVwM0759LWKNDp
   oD3I15CGRYwmL9UzIIlBGon+O9E0jf7TIaj1ljOkIOPz/Z6yhjK/Gx0eI
   8=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Av4EAMLTuk+rRDoI/2dsb2JhbABEtBmBB4IXAQQSAR0KUQEIIgYYB0gBDgEEEwgSCIdeAwoBC51UgSiWLQmJVo0jgjxiA4hCjWiMfYFkgwk
X-IronPort-AV: E=Sophos;i="4.75,633,1330905600"; 
   d="scan'208";a="43216806"
Received: from mtv-core-3.cisco.com ([171.68.58.8])
  by mtv-iport-3.cisco.com with ESMTP; 21 May 2012 23:51:06 +0000
Received: from xbh-sjc-211.amer.cisco.com (xbh-sjc-211.cisco.com [171.70.151.144])
	by mtv-core-3.cisco.com (8.14.3/8.14.3) with ESMTP id q4LNp3tZ029247
	for <git@vger.kernel.org>; Mon, 21 May 2012 23:51:05 GMT
Received: from xmb-sjc-233.amer.cisco.com ([128.107.191.88]) by xbh-sjc-211.amer.cisco.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Mon, 21 May 2012 16:51:05 -0700
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2/2] git-sh-setup: work around Cygwin path handling gotchas
Thread-Index: Ac03rJOpPT++uXN1SYmVLLBAMYoQhA==
X-OriginalArrivalTime: 21 May 2012 23:51:05.0832 (UTC) FILETIME=[96406E80:01CD37AC]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198162>

"Junio C Hamano" <gitster@pobox.com> wrote in message
news:<7vaa116ulx.fsf@alter.siamese.dyndns.org>...
> 
> If you _only_ allow editors that understands windows style paths, your
> patch may make sense, but doesn't it break editors that wants only
POSIX
> style paths?

The Cygwin Users' Guide says "Using native Win32 paths in Cygwin, while
possible, is generally inadvisable."

http://cygwin.com/cygwin-ug-net/using.html#pathnames-win32

Is this similar to the problem of line ending (POSIX lf vs. Windows
cr-lf)?  Windows Notepad won't correctly display files with lf line
endings, either.
So maybe this should be a configuration option, as with line endings?
