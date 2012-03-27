From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v4 0/3] Isolate If-Modified-Since handling in gitweb
Date: Tue, 27 Mar 2012 20:24:22 +0100
Message-ID: <201203272124.23145.jnareb@gmail.com>
References: <7v62dy4zhf.fsf@alter.siamese.dyndns.org> <201203221346.35295.jnareb@gmail.com> <20120326110943.GA2951@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "W. Trevor King" <wking@drexel.edu>
X-From: git-owner@vger.kernel.org Tue Mar 27 21:24:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCc0o-0005uF-DQ
	for gcvg-git-2@plane.gmane.org; Tue, 27 Mar 2012 21:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755544Ab2C0TYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Mar 2012 15:24:25 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:38933 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497Ab2C0TYY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Mar 2012 15:24:24 -0400
Received: by wgbdr13 with SMTP id dr13so237274wgb.1
        for <git@vger.kernel.org>; Tue, 27 Mar 2012 12:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=QqqFDaRoSgVMwdKQJDz5J3QX5263Hhdkb3m8kQhsF3g=;
        b=kzclwmToA+Iq4r5T7DRYIb4N4KTZSdveq762vhxdO6N9JMjJzcidB8tsRYSL1A4bZs
         MPEQaByLYyE23kmzHLxoslM8XU+hSizucjM5LNhcANTqfv5/6ZMDIfq0iXRlqAsBhlGA
         Qmm+fSEFWfq6aga64fF73Yp+Mo67Zb+oa/4kQoG9t9VPkAGYVDm7b/2ed5vgjixqrjV8
         fIWet5xH/2+o3RYoauyuxmjPLGXgc13X7irFm35g5XEgRgO27HKbrb2cjrN5bQvHgmHa
         KopcMBCuU19VQPFsRGwprCx3vbXs9NVLTtrg+pxy1VItvo5fdoKalU/MXv3y/lOYeWiC
         oaWg==
Received: by 10.180.24.35 with SMTP id r3mr551729wif.7.1332876263178;
        Tue, 27 Mar 2012 12:24:23 -0700 (PDT)
Received: from [192.168.1.13] (adhb238.neoplus.adsl.tpnet.pl. [79.184.157.238])
        by mx.google.com with ESMTPS id 9sm2890360wid.2.2012.03.27.12.24.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 27 Mar 2012 12:24:22 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20120326110943.GA2951@odin.tremily.us>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194078>

On Mon, 26 Mar 2012, W. Trevor King wrote:

> Sorry for the delay since my last message, it's been a busy week ;).

Thanks for working on this topic.  

BTW. we are in feature freeze currently, before release of v1.7.10.
 
> I'll be sending along three patches.  [...]
> [...] The first is a teensy patch to add `Status` 
> output to non-304 calls to git_feed().  Without it you'd have to get a
> bit more creative in the test suite.  If the status lines were left
> out intentionally, let me know, and I'll come up with another
> condition for those tests.

No, the status line was omitted unintentionally, thanks for fixing this.
I guess that web server (at least Apache) adds it if it is missing.

Though I am not sure how lack of "Status:" header is different from
incorrect "Status:" header for 'grep "Status: 304" gitweb.headers'...
 
> The second patch refactors and tests git_feed(), and the third patch
> adds i-m-s support to git_snapshot() with associated tests.
> 
> Changes since v3:
> * Patch 1/3 is completely new.
> * Split previous patch into 2/3 and 3/3.
> * Conditionals in 3/3 to avoid 404-ing on non-commits like v1.7.6^{tree}.
> * Added testing to both 2/3 and 3/3.
> * Reworked commit messages.

Good.

-- 
Jakub Narebski
Poland
