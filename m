From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH 0/4] pathspec labels [WAS: submodule groups]
Date: Mon, 16 May 2016 15:00:09 -0700
Message-ID: <CAGZ79kbJxf6qnj1vqkbFzXBU+6Cfh6RMvs2NqqeASZAPLFXu8Q@mail.gmail.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<CACsJy8BK-u2VV3kkq3ANHCanYqMwphqgxZmooQfewA_J7e8MPw@mail.gmail.com>
	<CAGZ79kacKnBjzVFSShRido4rKa3-Zg465d2320M6w1qXEkOZqw@mail.gmail.com>
	<xmqqh9dx3nsf.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZyPvAFG1TjSm76LuDLpch=7iuL_-8LYqysSESFQj-YjQ@mail.gmail.com>
	<xmqqlh391z2v.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZuMdWdw2kcfs_P-_Ax1zXpKNHqMjNL80hBj3=SSp2zSQ@mail.gmail.com>
	<xmqqh9dx1xku.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 00:00:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2QYs-0007AC-AE
	for gcvg-git-2@plane.gmane.org; Tue, 17 May 2016 00:00:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbcEPWAM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 18:00:12 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:34367 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750869AbcEPWAL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 18:00:11 -0400
Received: by mail-io0-f172.google.com with SMTP id 190so624016iow.1
        for <git@vger.kernel.org>; Mon, 16 May 2016 15:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=rLkWY5s0E21Lwe01bIr4jNiqVbzU71Kz8H2kFvCi41I=;
        b=l48nw6ZcwkQrJX8Lz1F+zeOOHn4fHLfL3r3okyKjFB6EB5JFcg2earz9PRucEXC7bg
         avCYp07vth4GBswgBXRLIdve9vwjeh3uOw4e/Nlg3uEgbOOFRf70WD28u+c+taXNQWxI
         CHmWFiWvFNroWX7aG9k85bnkWiDFzOkpXWU+CENIMmmoXoGijba9gHop1GmqzhO7CW6E
         6bjo/4lpCvaTA5RVL6uLPMehgZdrAoGn+xe3qfd6nO7LE+xQTMIxUgrJDxGwRPksw9iG
         Afma8hZ5d/voDuqJx4BgI4vzzAIpXUvIfEJhSRfqjxqi91NWIEEpqi1iHCcL7+AYH8HT
         INow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=rLkWY5s0E21Lwe01bIr4jNiqVbzU71Kz8H2kFvCi41I=;
        b=PX+nve247i1EF2bc068ueNtq60r0G0pCjNQ7yGaPqD/YszcphxFcsYrbxGuieGtSSP
         nM+M0LSYfQYkMaORfixuxR4PhxwBhSNh3aHzYRSO/DRAsDbPa0/vbyC0WcXT30fh1d0E
         FQaWoXt/5SI0y1db22h8bQVIQiwYEcSlzyMWxyv2/eUypoCQX5JSo5oEKAJuE/QAIsBK
         NzHd6m4x8oe9TlQl3kQ6e4l0hmdctBan7OtMRI+89omSbMBCtnw84gzrzdJFsIyKf49P
         j21dwreQhbhmbbW2+ozEkqg8XBTpokwe/7h/JD/jzzpBfM7ZHirBDIy7uDJfMMk9YWiv
         JmoQ==
X-Gm-Message-State: AOPr4FVbq3vFnkoj8CMci4E3sNVdTDvAxGQWBybCsxsKLLezpTbR8RZIdgCAR9ij5ml3nId6QLFDsujDLQMub6ge
X-Received: by 10.36.62.133 with SMTP id s127mr11804817its.98.1463436009907;
 Mon, 16 May 2016 15:00:09 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 16 May 2016 15:00:09 -0700 (PDT)
In-Reply-To: <xmqqh9dx1xku.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294803>

On Mon, May 16, 2016 at 2:50 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> And we want to have both "label=A B C" and attr:label=A B C" or *just* the
>> attr query?
>
> I think the choice at this point is between supporting just "label=A
> B C" or supporting just "attr:eol=crlf text=auto !diff".
>
> I think "attr:label=A" is merely a degenerated case of the latter.
>
>> We should not allow the user to add arbitrary attributes (i.e. labels).

Because we cannot extend our attributes any further from that?

Consider a user starts using attr <foo> for their labeling purposes.
Later (in 2 years) we decide that <foo> is an attribute we want to
use to mark files as foo-ish. so we add meaning to that attribute
(just like eol.crlf does an arbitrary thing, foo would do another arbitrary
thing).

Then the user picks up the new version of Git and expects <foo> to
still be a "I use it for labeling purposes only" thing. They would not
expect to all files labeled as <foo> to start behaving <foo-ish> ?

> Hmph, why not?

We need a namespace for which
* we can guarantee that it is for labeling purposes only (even in the future)
* is obvious to the user to be a labeling name space

Starting with "label" offers both?

>
>> Instead each of the "attr for labeling purposes" needs to follow a clear scheme
>> that allows us to add attributes later on that are outside of that scheme.
>
> That was my initial reaction when I saw Duy's "attr:crlf=auto" (by
> the way, there is no such setting; crlf should be one of TRUE, UNSET
> or set to string "input") idea.  But I do not think of a good
> argument to justify that arbitrary attributes are not allowed.

I agree that querying for attr:eol or attr:diff is a good idea.

I do however want to point out that all labels for "labeling purposes"
MUST be a clear from the beginning, otherwise we'll have the maintenance
problem down the road?
