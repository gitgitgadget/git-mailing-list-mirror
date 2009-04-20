From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH 2/2] Windows: Skip fstat/lstat optimization in 
	write_entry()
Date: Mon, 20 Apr 2009 16:27:03 +0200
Message-ID: <81b0412b0904200727i169b9aa2od943349b9db0c6bb@mail.gmail.com>
References: <49EC2F7C.8070209@viscovery.net>
	 <20090420110302.GB25059@dpotapov.dyndns.org>
	 <81b0412b0904200558w2d506f18i675d5dfb990005ce@mail.gmail.com>
	 <20090420133305.GE25059@dpotapov.dyndns.org>
	 <81b0412b0904200654w1606a31fu227fa535cc14e10d@mail.gmail.com>
	 <49EC845D.6020107@viscovery.net>
	 <81b0412b0904200725j22de23cajfd4b1cf119e69721@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon Apr 20 16:28:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvuUC-0005ax-OO
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 16:28:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755737AbZDTO1I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Apr 2009 10:27:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755693AbZDTO1G
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 10:27:06 -0400
Received: from yx-out-2324.google.com ([74.125.44.28]:37670 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755268AbZDTO1F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Apr 2009 10:27:05 -0400
Received: by yx-out-2324.google.com with SMTP id 3so785346yxj.1
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 07:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=HWFi87tGOmHE5YupyMkLpD1i37EpJnViC/4H1pht6f0=;
        b=GqA3XrhstAdK34hxvXWrye7xs4GCFQhBUPGj8pPhO2OhHvrVkO76C1k7BSWVkrRmzq
         bmWrCAYDO2XkS7nt3+e2l8MvKtdKODycZWC6+N8tp1TNSIZ0wTbVLuEqC6xpdhi4uSGm
         mWPC8RFkxRL4E4PzrnZbvgyRfklKIzjyHgiuk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=LEB65p+ZlW/Ic99AA71d/9+GhK0ZtHRquqKn3WfQr5bf8EdLmqUqZqp/qBco22BcdX
         5LB3jqcbfZbl0Da29eNRgvJwr2SWzo19GNCHTvBD7ywzS713qnmFmL6ext1J5pb91fyz
         zX57wMI2ItFLH96RQBZdApdPi+Ot7BN+SPBEY=
Received: by 10.151.40.3 with SMTP id s3mr1352227ybj.158.1240237623481; Mon, 
	20 Apr 2009 07:27:03 -0700 (PDT)
In-Reply-To: <81b0412b0904200725j22de23cajfd4b1cf119e69721@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116992>

2009/4/20 Alex Riesen <raa.lkml@gmail.com>:
> 2009/4/20 Johannes Sixt <j.sixt@viscovery.net>:
>> You got that wrong: If Windows were slow, the error would have been
>> triggered more often and it would have been detected earlier. There you
>> have the proof: Windows is fast ... enough :-P
>
> Err, yes. Still a piece of cpp junk
>

Err, a _pile_.
