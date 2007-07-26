From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: Windows support
Date: Thu, 26 Jul 2007 17:25:12 +0200
Organization: eudaptics software gmbh
Message-ID: <46A8BCD8.B925922@eudaptics.com>
References: <a1bbc6950707250335m3d37d4farceffc50945e31f6c@mail.gmail.com>
		 <fcaeb9bf0707250513v587d7a92lb688b52da3c28bb7@mail.gmail.com>
		 <Pine.LNX.4.64.0707251510130.14781@racer.site>
		 <fcaeb9bf0707250715p7c183a81vc78f641eef493777@mail.gmail.com>
		 <46d6db660707260600w6c3ca5d2ve6aaf06c7684789d@mail.gmail.com>
		 <fcaeb9bf0707260620i2ec1ab36ka470758edfd570d2@mail.gmail.com>
		 <46d6db660707260632q16f927a2r64f6b4588dd3cb48@mail.gmail.com> <fcaeb9bf0707260655v1dbbacfbta23e670713683963@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian MICHON <christian.michon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 17:25:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IE5Da-00022l-33
	for gcvg-git@gmane.org; Thu, 26 Jul 2007 17:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759514AbXGZPZS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 11:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756483AbXGZPZS
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 11:25:18 -0400
Received: from main.gmane.org ([80.91.229.2]:40893 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759039AbXGZPZQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 11:25:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IE5D8-0000hd-On
	for git@vger.kernel.org; Thu, 26 Jul 2007 17:25:06 +0200
Received: from cm56-163-160.liwest.at ([86.56.163.160])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 17:25:06 +0200
Received: from J.Sixt by cm56-163-160.liwest.at with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 26 Jul 2007 17:25:06 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cm56-163-160.liwest.at
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53839>

Nguyen Thai Ngoc Duy wrote:
> 
> On 7/26/07, Christian MICHON <christian.michon@gmail.com> wrote:
> > I can commit using "git commit -a -m ok", but then I get this kind of
> > error message (and ash dies, I go back to xp/cmd prompt)
> >
> > mv: cannot rename '.git/next-index4540': File exists
> 
> Baah.. something goes wrong again.

The problem is likely that rename() of MSCVRT.DLL is implemented in
terms of MoveFile(), which can't move over an existing file. A wrapper
is needed that uses MoveFileEx() instead.

We have the same problem also in git-apply: One of the tests fails for
this reason.

-- Hannes
