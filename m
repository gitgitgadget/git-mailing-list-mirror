From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 2/2] remove NORETURN from function pointers
Date: Fri, 25 Sep 2009 15:56:27 +0200
Message-ID: <40aa078e0909250656j4b791a99naf632b5b8d8e1038@mail.gmail.com>
References: <1252923370-5768-1-git-send-email-kusmabite@gmail.com>
	 <40aa078e0909140440x2e189957uf66f36ff29bef302@mail.gmail.com>
	 <20090914120311.GA17172@sigill.intra.peff.net>
	 <40aa078e0909140532q693a7f9qc3d9b1d354cac356@mail.gmail.com>
	 <4AAE4087.5030607@viscovery.net>
	 <40aa078e0909140612w71ad3bdeyfa94838cb57cec19@mail.gmail.com>
	 <4AAE42F2.30304@viscovery.net>
	 <40aa078e0909140626k63b9de2fu8c9411baf8200da6@mail.gmail.com>
	 <4AAE4724.1090705@viscovery.net>
	 <7v1vlyrcef.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 25 15:56:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrBHo-0003Ad-RN
	for gcvg-git-2@lo.gmane.org; Fri, 25 Sep 2009 15:56:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbZIYN4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 09:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751730AbZIYN4Z
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 09:56:25 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:34583 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751329AbZIYN4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 09:56:24 -0400
Received: by bwz6 with SMTP id 6so2038900bwz.37
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 06:56:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=+n8J0eZ/Hnuc/R7/yXnJ1eLP9p/pdoGczS/QoOPkwYs=;
        b=aDLrp/3GujsTNX8gqBR6Mahzgto9jgmCNUHgUfkHRE2g+M/+mVudkYlHfFy9TesJhS
         N9P6/B8gUFAmSQNwHFkF+D6H1DULs8FoBaoz01AHefdXpQs/0pZob7dNspm6RK3h92ww
         ZpHd1izj4PcxAAabhj2Ae5nShz2hx7j3bmq0o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=tOBarAHBNZR4ZHBV/fsHXAuvas1yDza+sSG6rMwrb6fFpeRWV8aQDsKionwUMv2W+F
         7L5e6Xw7CMKn+1eJ5nud6jMCyii8e8fwY6S6SpXzcaOlg1haFnTgWZD6VvOyKpJbGP9U
         3Au6n7xOswxEP8bi+5pE3gLB2Pxg9d7FEdSOI=
Received: by 10.204.48.131 with SMTP id r3mr127689bkf.195.1253886987147; Fri, 
	25 Sep 2009 06:56:27 -0700 (PDT)
In-Reply-To: <7v1vlyrcef.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129083>

On Tue, Sep 22, 2009 at 9:46 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
>
>> Erik Faye-Lund schrieb:
>>> On Mon, Sep 14, 2009 at 3:19 PM, Johannes Sixt <j.sixt@viscovery.net> wrote:
>>>> "The" warning? Not "the two" warnings? Then I suggest to stop here; MSVC
>>>> is only half-competent with regards to noreturn.
>>>
>>> There was only one warning in this regard on MSVC - the one about
>>> unreachable code. And yes, MSVC is only half-competent, but it seems
>>> it's competence is in the half that matters in our case.
>>>
>>> Do you suggest to stop the patch-series, or to stop the testing?
>>
>> My suggestion was about stopping the patch series.
>>
>> But thinking a bit more about it, I can imagine that there are calls to
>> die() that, if it is not marked noreturn, could trigger other warnings
>> with MSVC. That would be annoying, and it's better to mark it noreturn.
>>
>> So I withdraw my suggestion to stop :-)
>
> Anything happened to this series?

No, I'm sorry for not updating. I'm currently on vacation, and I
didn't get time to fix it up before going, due to my dayjob. I'll pick
it up again as soon as I get back home, in a bit more than a week.

-- 
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
