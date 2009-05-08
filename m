From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v3] To make GIT-VERSION-FILE, search for git more widely
Date: Fri, 08 May 2009 10:52:56 +0200
Message-ID: <4A03F2E8.2020907@viscovery.net>
References: <1241688129-31613-1-git-send-email-matthias.andree@gmx.de> <7v7i0scvcf.fsf@alter.siamese.dyndns.org> <op.utlq3vgx1e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 08 10:53:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2LpU-0006Qv-9s
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 10:53:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255AbZEHIxD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 04:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbZEHIxB
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 04:53:01 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:9353 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756255AbZEHIxA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 04:53:00 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1M2Lp7-00061b-AI; Fri, 08 May 2009 10:52:58 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 82E2A4E4; Fri,  8 May 2009 10:52:52 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <op.utlq3vgx1e62zd@merlin.emma.line.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118590>

Matthias Andree schrieb:
> Am 08.05.2009, 02:05 Uhr, schrieb Junio C Hamano <gitster@pobox.com>:
>> Interesting.  I wonder if you need the change to the Makefile.
>>
>> As long as GIT-VERSION-GEN notices that you have a freshly built git
>> available (test -x) and uses it, falling back to whatever on the PATH, it
>> would not have to touch GIT-VERSION-FILE, no?
> 
> Hi Junio,
> 
> Makefile (+ GNU make) is the actual culprit and introduces this cycle,
> why do we want to leave Makefile - of all things - alone?

Because it is not necessary to change it?

With Junio's proposed change the following:

   $ make && PATH=/bin:/usr/bin make

builds only once[*], whereas previously it built twice.

[*] It still builds twice in git-gui, but I think that your original patch
wouldn't fix that, either.

-- Hannes
