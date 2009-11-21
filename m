From: Christoph Bartoschek <bartoschek@gmx.de>
Subject: Re: [PATCH] submodule.c: Squelch a "use before assignment" warning
Date: Sat, 21 Nov 2009 19:46:36 +0100
Organization: =?UTF-8?B?VW5pdmVyc2l0w6R0?= Bonn
Message-ID: <c5plt6-5me.ln1@burns.bruehl.pontohonk.de>
References: <1258680785-42235-1-git-send-email-davvid@gmail.com> <7v8we17ha9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 21 22:09:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBx8A-0007Is-Qw
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 22:04:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343AbZKUVEE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 16:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753132AbZKUVEE
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 16:04:04 -0500
Received: from lo.gmane.org ([80.91.229.12]:46683 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111AbZKUVED (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 16:04:03 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NBx2U-0003Ih-L3
	for git@vger.kernel.org; Sat, 21 Nov 2009 21:58:38 +0100
Received: from p54bab13f.dip.t-dialin.net ([84.186.177.63])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Nov 2009 21:58:38 +0100
Received: from bartoschek by p54bab13f.dip.t-dialin.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Nov 2009 21:58:38 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: p54bab13f.dip.t-dialin.net
User-Agent: KNode/4.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133412>

Junio C Hamano wrote:

> David Aguilar <davvid@gmail.com> writes:
> 
>> i686-apple-darwin9-gcc-4.0.1 (GCC) 4.0.1 (Apple Inc. build 5493) compiler
>> (and probably others) mistakenly thinks variable 'right' is used
>> before assigned.  Work it around by giving it a fake initialization.
> 
> We see the same "fake initialization" of 'left' on the same line.  By
> initializing it to NULL, you are hinting that initializing 'right' to
> NULL actually means something.

Why is the compiler not complaining about the fake initalization? For 
initialization a value is used that is not initialized.

At least a static analyzer complains: 

"submodule.c", line 41: The variable `left' is used before its 
initialization 

Christoph
