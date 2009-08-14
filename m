From: Karl Wiberg <kha@virtutech.com>
Subject: Re: [PATCH] Work around performance bug in
	subprocess.Popen.communicate()
Date: Fri, 14 Aug 2009 10:12:20 +0200
Message-ID: <20090814081220.GA24722@lux.e.vtech>
References: <20090731093632.7018.24435.stgit@october.e.vtech> <b0943d9e0907310427r7e59aa5fi5e5ff5e3f3c03819@mail.gmail.com> <20090804085125.GB27452@lux.e.vtech> <b0943d9e0908131518i3ac18331leb4c0c76313b0780@mail.gmail.com> <20090814062149.GA23179@lux.e.vtech> <e87cdfda0908140026x21b8aad3x82417d4b1c8016f4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Erik Sandberg <mandolaerik@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 14 10:12:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mbrts-0005eb-SX
	for gcvg-git-2@gmane.org; Fri, 14 Aug 2009 10:12:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756559AbZHNIMZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Aug 2009 04:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756554AbZHNIMZ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Aug 2009 04:12:25 -0400
Received: from [62.20.90.206] ([62.20.90.206]:48091 "EHLO lux.e.vtech"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755353AbZHNIMY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2009 04:12:24 -0400
Received: from lux.e.vtech (lux.e.vtech [127.0.0.1])
	by lux.e.vtech (8.14.2/8.14.2) with ESMTP id n7E8CKpv024750;
	Fri, 14 Aug 2009 10:12:20 +0200
Received: (from kha@localhost)
	by lux.e.vtech (8.14.2/8.14.2/Submit) id n7E8CKFm024748;
	Fri, 14 Aug 2009 10:12:20 +0200
X-Authentication-Warning: lux.e.vtech: kha set sender to kha@virtutech.com using -f
Content-Disposition: inline
In-Reply-To: <e87cdfda0908140026x21b8aad3x82417d4b1c8016f4@mail.gmail.com>
X-Manual-Spam-Check: kha@virtutech.com, clean
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125918>

On 2009-08-14 09:26:06 +0200, Erik Sandberg wrote:

> Wouldn't it be better to only use the write() workaround when
> sys.version indicates that the Python bug may be present, and use
> communicate() properly otherwise?

In my opinion: no. The workaround has no negative effect (since we
know that git is well-behaved). Making it conditional would only make
the code more complex, without gaining us anything.

-- 
Karl Wiberg, Virtutech
