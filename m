From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: storing cover letter of a patch series?
Date: Thu, 10 Sep 2015 11:32:35 -0700
Message-ID: <CA+P7+xq9P2NHqQe-y+2n38ZvbR74UxR0Rik=btgy=JtEoZbX2A@mail.gmail.com>
References: <CA+P7+xpHDGY5RTR8ntrABdxqM6b4V9dndS68=kV1+1Ym1N6YKw@mail.gmail.com>
 <xmqqh9n241el.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 10 20:33:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za6ee-0005BT-Km
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 20:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752780AbbIJSc4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 14:32:56 -0400
Received: from mail-io0-f179.google.com ([209.85.223.179]:35102 "EHLO
	mail-io0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbbIJScz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 14:32:55 -0400
Received: by ioiz6 with SMTP id z6so71220695ioi.2
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 11:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=VPn4EAhNrUzcQNRwUEVsLC0xdpq55BAlGIVIAzG4Q4g=;
        b=E3/pQ9n8JXkn50BhpOGCpLfFacdGfjZRY0qIhup8smK0Na4Ppiai9uJR274sFCeVMv
         yioETaN6L0lYvDd/ic3mdk8gTtEtvxhTLgE/+4CTahfUFaKaQzRRW89Q5aLxPSFdexit
         jyzKr6doIu2tG0DpTIxJOgBC+L0jrKXE4qOt0b6oV9eY22zV9EcdTuppH5+ICQsI7uCy
         Ez5HvcQVvr7Sg7b6qj1DH3R8yfdVCls7dZX1ZKsfyQBWT+sGos8rFdGx9rG0ahh7uX1f
         Ro4yK/BUZIcmQU1mhtJljalyHo0IhV5ARuWLJggth0lANJjhdY8HSupSCYVqSo95x0rD
         CrOw==
X-Received: by 10.107.14.202 with SMTP id 193mr63682015ioo.146.1441909974430;
 Thu, 10 Sep 2015 11:32:54 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Thu, 10 Sep 2015 11:32:35 -0700 (PDT)
In-Reply-To: <xmqqh9n241el.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277622>

On Thu, Sep 10, 2015 at 10:41 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>> Is there some other way? Would others be interested in such a feature?
>
> Not me.
>
>> I get very annoyed when I've written a nice long patch cover letter in
>> vim before an email and then realize I should fix something else up,
>> or accidentally cancel it because I didn't use the write "To:" address
>> or something..
>
> I smell a fallout of encouraging a suboptimal workflow made by
> git-send-email here.  If you did not know that the command can drive
> format-patch itself, your workflow would have been:
>
>     $ git format-patch -o my-topic --cover master..my-topic
>     $ vi my-topic/*.txt
>
> and only after you gain confidence with the edited result
>
>     $ git send-email $args my-topic/*.txt
>

I hadn't thought of separating the cover letter from git-send-email.
That would be suitable for me.

> which has no room for your grief/complaint to come into the
> picture.  While rerolling, you can do the same
>
>     $ git format-patch -o my-topic --cover -v2 master..my-topic
>
> and reuse major parts of cover letter from the original round.
>
>> I really think it should be possible to store something somehow as a
>> blob that could be looked up later.
>
> I think "should" is too strong here.  Yes, you could implement that
> way.  It is debatable if it is better, or a flat file kept in a
> directory (my-topic/ in the example above) across rerolls is more
> flexible, lightweight and with less mental burden to the users.

This seems reasonable from an email point of view. Thanks for the insight.

Regards,
Jake
