From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Git's inconsistent command line options
Date: Tue, 01 Sep 2015 09:42:31 -0700
Message-ID: <xmqq37yyt7k8.fsf@gitster.mtv.corp.google.com>
References: <mrh7ck$r0g$1@ger.gmane.org>
	<CAPc5daUdVQSAhrig046qGopVuxCDagZg3v9bwXOaC3SvC2MRnw@mail.gmail.com>
	<CA+P7+xrYugueYYrrJV0pduAHCg7CLknE_0QYcU8mO6idntz=VA@mail.gmail.com>
	<CAGZ79kZ6KK0qVtzrxmmsBQqmz-dgamC4f6W0zVTQLcuYi==0fw@mail.gmail.com>
	<xmqqa8tfvsr9.fsf@gitster.dls.corp.google.com>
	<CACsJy8D3J6RhtPPtSvtWfOb8BapaX2-52M5_fE36psQPB_oQsQ@mail.gmail.com>
	<20150831102558.1514e5f7@anarchist.wooz.org>
	<20150901092834.GA10706@gmail.com>
	<20150901101924.6c350012@anarchist.wooz.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Aguilar <davvid@gmail.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Philip Oakley <philipoakley@iee.org>,
	Hilco Wijbenga <hilco.wijbenga@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Graeme Geldenhuys <graemeg@gmail.com>
To: Barry Warsaw <barry@python.org>
X-From: git-owner@vger.kernel.org Tue Sep 01 18:42:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWodq-00056X-K9
	for gcvg-git-2@plane.gmane.org; Tue, 01 Sep 2015 18:42:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbbIAQme (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2015 12:42:34 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33325 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbbIAQmd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Sep 2015 12:42:33 -0400
Received: by padan5 with SMTP id an5so1182846pad.0
        for <git@vger.kernel.org>; Tue, 01 Sep 2015 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=0j/+uf/neuWxlwG4Bh0yGsNjvItkSKNOZZrHQcJWDu0=;
        b=WBX4EVAwwW7f7WUdDF1Ltb8qE2cMRd8QCIWxtvcbcOQvD5Al9jfFhXm07Ts2f3vGjD
         ltnw2//osPFqir9uEna8BSFSJYdM2vBfNKRkM7jX1G7KumESKnE0G8OU4fYZlHrZ79pf
         OcSSI3pHPDTltSjEr7guo5aJ9lzx9NCTeU0TjDxiSHK/DCORWb/MNKyMR+6NghpbwjrM
         uAyzjyW+qs3uiazTZ3PfalQbYd1dol/3QrgYN2eiUJjz0NW9XJkFQQvu+C0zIiI8heJ1
         7vIWB/lKtGpNwycf9y2sed/txR2FSeKmgFTRunJIUDfQXewARCmEQ4n75l5U3Y66a9yy
         q9Sg==
X-Received: by 10.68.196.233 with SMTP id ip9mr48235945pbc.139.1441125752793;
        Tue, 01 Sep 2015 09:42:32 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:c585:9fe7:e0d8:e718])
        by smtp.gmail.com with ESMTPSA id p3sm18751389pdf.3.2015.09.01.09.42.31
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 01 Sep 2015 09:42:32 -0700 (PDT)
In-Reply-To: <20150901101924.6c350012@anarchist.wooz.org> (Barry Warsaw's
	message of "Tue, 1 Sep 2015 10:19:24 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276990>

(Administrivia) please do not cull CC list when replying.

Barry Warsaw <barry@python.org> writes:

> On Sep 01, 2015, at 02:28 AM, David Aguilar wrote:
>
>>While a script writer could write, "git -c core.cliversion=1 ...",
>>no one does that, no one wants to do that, and it just seems
>>like a bad idea that's best left unexplored.
>
> Sure, no one will do that from the command line, but I don't think people
> generally change their preferences that often.  Much more likely is that
> they'll `git config` a more permanent choice for their shell usage and then
> just use straight up "git" with the new ui.  -c would be reserved for scripts
> which hard code a particular ui.

That way, you are forcing all the existing scripts to be updated to
say "git -c ..." for _all_ invocations of Git they have, aren't you?

That is simply unworkable.

By the way, you can review what has already been said in this
discussion here:

  http://thread.gmane.org/gmane.comp.version-control.git/276509/focus=276589
