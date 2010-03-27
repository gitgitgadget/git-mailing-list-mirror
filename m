From: Francis Moreau <francis.moro@gmail.com>
Subject: Re: [PATCH 0/2] Teach 'git grep' about --open-files-in-pager=[<pager>]
Date: Sat, 27 Mar 2010 16:19:10 +0100
Message-ID: <m2r5n5vlld.fsf@gmail.com>
References: <alpine.DEB.1.00.1003261145500.7596@pacific.mpi-cbg.de>
	<20100326124650.GA12215@coredump.intra.peff.net>
	<7vwrwykhee.fsf@alter.siamese.dyndns.org> <m239zmdcz5.fsf@gmail.com>
	<7v39zm7epf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 27 16:19:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvXnT-0000qe-Kg
	for gcvg-git-2@lo.gmane.org; Sat, 27 Mar 2010 16:19:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493Ab0C0PTU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Mar 2010 11:19:20 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:51391 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753415Ab0C0PTT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Mar 2010 11:19:19 -0400
Received: by bwz1 with SMTP id 1so2514845bwz.21
        for <git@vger.kernel.org>; Sat, 27 Mar 2010 08:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:references
         :date:in-reply-to:message-id:user-agent:mime-version:content-type;
        bh=w17rq110etZ6dsVXSB0Nf3QpW2oEvBEeBw2x4HVKHKg=;
        b=BEeCr5SBi75KXeF7CFdFnpFoRRypocyjVhwvbUYXEmegpXRUPXfyUAgC3751kJQclS
         /LjtJLASGS/aEePHpVCLw2Qxxn74dE5A/ByfM28200R24rdvA3G6nmRG1u83W1m/cp5r
         Oo8oVve+I2C1ZIOLYSjNzQskx233KeROBYRS8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        b=HdR5v2S5qj6trhZ9tbvnlgFC1Y4qf7N2IdZN8iOf6xpwffvR7e5HGqxSrAPXp2b5wA
         dToHAm2mY/9g/QgERXrZRM9b0Lb3MTL6i/3bioIckPlq22Bjbd1tqoVx+y/xcaw08fxO
         MjNuG9WaoeL5o7kj2CX3vnxqRpHaJ4MQVFaN8=
Received: by 10.204.144.156 with SMTP id z28mr3110164bku.188.1269703158059;
        Sat, 27 Mar 2010 08:19:18 -0700 (PDT)
Received: from localhost (au213-1-82-235-205-153.fbx.proxad.net [82.235.205.153])
        by mx.google.com with ESMTPS id l1sm18517344bkl.20.2010.03.27.08.19.16
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Mar 2010 08:19:16 -0700 (PDT)
In-Reply-To: <7v39zm7epf.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Fri, 26 Mar 2010 18:09:32 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143338>

Junio C Hamano <gitster@pobox.com> writes:

> Francis Moreau <francis.moro@gmail.com> writes:
>
>>> and I often run "git grep -n" in that mode..
>>
>> I always need to pass the '--no-pager' switch: "git --no-pager grep -n"
>> since git doesn't detect that its output is sent to a 'dumb' terminal.
>
> Sorry, but as any self-respecting Emacs user would have PAGER set to cat

Well I do, but only for "M-x shell", probably because I usually start
all commands from that shell.

> (and EDITOR set to emacsclient), I thought nobody would need
> --no-pager ;-)

Indeed, I'll setup PAGER to cat when starting emacs.

That makes me think to one common operation I do which is not really
convenient when PAGER is set to cat: git-log. Piping the output of
git-log to a pager such as less(1) makes git-log to suspend when the
pipe is full. OTOH setting PAGER to cat, git-log never blocks and for
projects with a (very) long history such as git or the linux kernel,
git-log can show a lot of commits making the cpu really busy and the
emacs buffer really huge.

One way to workaround this is to pass -n10 for example to git-log, but
it's rather ugly.

Do you have any tricks for this case ?

Thanks
-- 
Francis
