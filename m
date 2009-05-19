From: Jens Kilian <jjk@acm.org>
Subject: Re: [PATCH 4/3] Introduce =?utf-8?b?J2NvbnZlcnRfcGF0aF90b19naXQoKSc=?=
Date: Tue, 19 May 2009 12:20:54 +0000 (UTC)
Message-ID: <loom.20090519T120452-71@post.gmane.org>
References: <alpine.LFD.2.01.0905141341470.3343@localhost.localdomain> <alpine.LFD.2.01.0905141342520.3343@localhost.localdomain> <alpine.LFD.2.01.0905141346440.3343@localhost.localdomain> <alpine.LFD.2.01.0905151156090.3343@localhost.localdomain> <7vy6sxpn2q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 19 14:25:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6ONf-000734-AX
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 14:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbZESMZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 08:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752339AbZESMZF
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 08:25:05 -0400
Received: from main.gmane.org ([80.91.229.2]:40306 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752116AbZESMZE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 08:25:04 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1M6ONS-0006YO-Gx
	for git@vger.kernel.org; Tue, 19 May 2009 12:25:02 +0000
Received: from 192.25.10.8 ([192.25.10.8])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 May 2009 12:25:02 +0000
Received: from jjk by 192.25.10.8 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Tue, 19 May 2009 12:25:02 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 192.25.10.8 (Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.0.5) Gecko/2008120908 Red Hat/3.0.5-1.el5_2 Firefox/3.0.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119522>

Junio C Hamano <gitster <at> pobox.com> writes:
> "Ugly" is not quite the word I am looking for.  "My gut feels that there
> has to be a way to write this more cleanly, but I am frustrated that I
> cannot come up with one" might be the word...

How about this:

#include <stdio.h>

#define MAGIC(type)  ((~(type)0 / (type)0xff) << 7)
#define TEST(type) printf(#type " %llx\n", (unsigned long long)MAGIC(type))

int
main(void)
{
/*TEST(unsigned char);  Doesn't work, and I'm too lazy to find out why. */
  TEST(unsigned int);
  TEST(unsigned long);
  TEST(unsigned long long);
  return 0;
}

HTH,
    Jens.
