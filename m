From: Steven Drake <sdrake@xnet.co.nz>
Subject: Re: [PATCH] Add 'git format-patch --to=' option and 'format.to'
 configuration variable.
Date: Wed, 17 Feb 2010 20:33:38 +1300 (NZDT)
Message-ID: <alpine.LNX.2.00.1002171706290.5479@vqena.qenxr.bet.am>
References: <alpine.LNX.2.00.1002171238310.2477@vqena.qenxr.bet.am> <7vhbpgpsto.fsf@alter.siamese.dyndns.org> <alpine.LNX.2.00.1002171516520.3414@vqena.qenxr.bet.am> <7vhbpgfrqj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 17 09:03:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhesC-00038e-V7
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 09:03:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934108Ab0BQIC6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 03:02:58 -0500
Received: from ananke.wxnz.net ([58.28.4.122]:49668 "EHLO ananke.wxnz.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934099Ab0BQIC6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 03:02:58 -0500
Received: from idran.drake.org.nz (ip-118-90-92-203.xdsl.xnet.co.nz [118.90.92.203])
	by ananke.wxnz.net (Postfix) with ESMTP id E768D5049A;
	Wed, 17 Feb 2010 20:41:26 +1300 (NZDT)
In-Reply-To: <7vhbpgfrqj.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140214>

On Tue, 16 Feb 2010, Junio C Hamano wrote:
> I tried to ask you (apparently in a garbled grammar, sorry) what
> your workflow of sending the format-patch output to the outside world is.
 
$ ./git-format-patch --stdout master~5..master~1 >>~/mail/postponed-msgs
$ alpine -I cp

Only problem with doing that is that alpine changes the Date: and
 Message-Id: header (the later being a pain if I used --threaded).

I don't know about other MUA (or how Daniel or Miklos work) but someone
could use a command like:

$ git-format-patch --stdout master~5..master~1 | sendmail -bm -t

But in all honesty I don't think it matters whether the headers are set by
format-patch or send-email and I would understand if you wanted to
deprecate '--cc' from format-patch and 'format.cc' (maybe keep it for 
backwards compat).

-- 
Steven
