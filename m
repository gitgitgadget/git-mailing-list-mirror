From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: A few "linked checkout" niggles
Date: Fri, 17 Jul 2015 13:07:14 -0400
Message-ID: <CAPig+cSLs4-uKicVMBSKnEro_FYD722Hs1_U6qzTriM8Ciok2Q@mail.gmail.com>
References: <xmqqoajdui8w.fsf@gitster.dls.corp.google.com>
	<55A8F4B1.9060304@drmicha.warpmail.net>
	<CACsJy8BZEhMJPdw4K_kihA1kTPBVsAt=zW-cemzO7V+xfDih8Q@mail.gmail.com>
	<xmqqzj2u3j7m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 19:07:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZG96Y-0003Uk-Br
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 19:07:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464AbbGQRHQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 13:07:16 -0400
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34732 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752076AbbGQRHP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 13:07:15 -0400
Received: by ykax123 with SMTP id x123so94679872yka.1
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 10:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=nqe6DCZTxGPCnAQe4CJ+lDonlIBh9WGiC+nfLEmjGBw=;
        b=IqdTe9b9D3tLanHYGd/9xULAhbNAKpAK3jTztm5IvdR8YDIfT6oMg7qRS5+0d1j01B
         +C1FCbqXUUNbHhUOZJVcuXoViVMK4Nt+w9ESprexYeYFxxYMs3HSOQjzALsuuvdetRw5
         SdKyeMLW6kq6fcVs22PLQ9TRZ8DNpc4cutePAiMsML8FVvB8tagIhBkXXpR9BzrF95Mv
         5InsUqrEEzWhm8RFR/kdIvdKNFkvszW5zz5lbHfNtag6uU7kZ1cmNmU/dVuZ8QUwBJLZ
         m6f8Z7r8+9HvJEucPCqES3TPtBLL57RQQemE6er5Odr/5/yJ29NSDXd+hBAVx8uTU9zj
         /NJA==
X-Received: by 10.129.50.140 with SMTP id y134mr16401863ywy.39.1437152834822;
 Fri, 17 Jul 2015 10:07:14 -0700 (PDT)
Received: by 10.37.12.129 with HTTP; Fri, 17 Jul 2015 10:07:14 -0700 (PDT)
In-Reply-To: <xmqqzj2u3j7m.fsf@gitster.dls.corp.google.com>
X-Google-Sender-Auth: w-LnTtJn2itVPl_-AIU4JoO2csU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274085>

On Fri, Jul 17, 2015 at 11:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
>
>> On Fri, Jul 17, 2015 at 7:27 PM, Michael J Gruber
>> <git@drmicha.warpmail.net> wrote:
>>> Two more observations:
>>>
>>> $ git worktree add /tmp/gitwt
>>> Enter /tmp/gitwt (identifier gitwt)
>>> Switched to a new branch 'gitwt'
>>>
>>> Now I'm in /tmp/gitwt at branch gitwt. Right? No. I'm in the original wd
>>> at the original branch.
>>>
>>> So either we cd to the new location or quelch these messages or add a
>>> message that we're actually back.
>>
>> s/Enter/Preparing/ ?
>
> Hmm, do we even need that message?  I assumed it was a leftover
> debugging stuff ;-)

It helps give context to messages which follow it, such as "Checking
out files:..." and "HEAD is now at...", letting the user know that
those messages apply to the new worktree rather than the current one.
In this case, s/Enter/Preparing/ makes sense.

("Switched to a new branch..." is gone in 'pu'.)
