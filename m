From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] Windows: Skip fstat/lstat optimization in 	write_entry()
Date: Mon, 20 Apr 2009 16:19:09 +0200
Message-ID: <49EC845D.6020107@viscovery.net>
References: <49EC2F7C.8070209@viscovery.net>	 <20090420110302.GB25059@dpotapov.dyndns.org>	 <81b0412b0904200558w2d506f18i675d5dfb990005ce@mail.gmail.com>	 <20090420133305.GE25059@dpotapov.dyndns.org> <81b0412b0904200654w1606a31fu227fa535cc14e10d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 16:21:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvuMd-0002s6-NP
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 16:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647AbZDTOTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 10:19:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755579AbZDTOTR
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 10:19:17 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:23293 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755558AbZDTOTR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 10:19:17 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LvuL1-0000XS-Bf; Mon, 20 Apr 2009 16:19:11 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 1A3AE4E4; Mon, 20 Apr 2009 16:19:11 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <81b0412b0904200654w1606a31fu227fa535cc14e10d@mail.gmail.com>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116989>

Alex Riesen schrieb:
> 2009/4/20 Dmitry Potapov <dpotapov@gmail.com>:
>> If the time passed between the creating file and end of writing to it is
>> small (less than timestamp resolution), you may not notice the problem.
>> The following program demonstrates the problem with fstat on Windows.
>> (I compiled it using Cygwin). If you remove 'sleep' then you may not
>> notice the problem for a long time.
> 
> And the Windows being as slow as it is, the problem can stay undetected for
> a long time in a real working code.

You got that wrong: If Windows were slow, the error would have been
triggered more often and it would have been detected earlier. There you
have the proof: Windows is fast ... enough :-P

-- Hannes
