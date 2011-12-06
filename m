From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] Set hard limit on delta chain depth
Date: Tue, 6 Dec 2011 19:48:28 +0700
Message-ID: <CACsJy8BNzMbFcUpKq3vWqmevJeuPxZo+sB7ZxL5BTK_ojYZVjg@mail.gmail.com>
References: <1323068688-31481-1-git-send-email-pclouds@gmail.com>
 <CABPQNSaE=TWGbBRMnthEuT181=XbOafPfgx88_JQnnQ6TiYyqw@mail.gmail.com>
 <CACsJy8BuUn4htSR6jAJfbueOshE6-YVV5dZGSWTGXbkuA0HO=A@mail.gmail.com> <CABPQNSbOvVkSFAE32hXoZEZeHqg-+nHc93uGytfCPQMicu0uVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Tue Dec 06 13:49:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RXuSN-0001am-8o
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 13:49:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933145Ab1LFMtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 07:49:05 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:36246 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933120Ab1LFMtD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 07:49:03 -0500
Received: by eaak14 with SMTP id k14so5051485eaa.19
        for <git@vger.kernel.org>; Tue, 06 Dec 2011 04:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=6sKTUys2DvAcE5Kbh+jzyY95GgsxlaQ2CJOQVI0yYSw=;
        b=t8jGq4p/BMIBeB2JYyT0Kjc7mSnIcfejFQFuVn3WSNohK4pCJrAyoeSlTCDBQ+iXN+
         BWN28Axgm3603dTkCAtpVWtkfaTJdRbNUnVSho2dnbZfOJgi1n9DPvAywDVjaSAIKtUO
         PAlKg/YdumQ5YEvsaFp872R1FuijUl7dpfJY4=
Received: by 10.213.104.140 with SMTP id p12mr2320660ebo.46.1323175739483;
 Tue, 06 Dec 2011 04:48:59 -0800 (PST)
Received: by 10.204.23.2 with HTTP; Tue, 6 Dec 2011 04:48:28 -0800 (PST)
In-Reply-To: <CABPQNSbOvVkSFAE32hXoZEZeHqg-+nHc93uGytfCPQMicu0uVg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186347>

On Tue, Dec 6, 2011 at 7:41 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
>>> Wouldn't it make more sense to make the limit a config option rather
>>> than a hard-coded value of 128 (which seems arbitrary to me)? After
>>> all, different platforms have different stack-limitations...
>>
>> Then it'd make more sense to make a compile time config based on
>> platform.
>
> Can how much stack each recursion use be calculated at compile-time?
> If so, I agree with you.

No, but at least we know default stack size of each platform and can
make pretty good limit based on that.

>> We could have a config option that can override the default,
>> but I really don't see the point of making long delta chains.
>
> Aha, I figured you _did_ see a point in this, because 128 seemed
> excessive to me already. I was thinking more that some platforms can
> have a much smaller stack than (I would expect to) fit in 128
> recursions (I've worked relatively recently with platforms with as
> small as a static 2k stack per process), so you might not be fixing
> the issue for such platforms. But that's not really your
> responsibility either ;)

Ah, I was thinking of an option that extends the limit, not shortens
it. Yes it makes sense in this case.
-- 
Duy
