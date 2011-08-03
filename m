From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v13 5/8] bisect: introduce --no-checkout support into porcelain.
Date: Wed, 3 Aug 2011 16:09:52 +0200
Message-ID: <CAP8UFD3QvXv_gnAtw3qMCOdDyAUAFMYcf33ieP+HebvTf3SGAg@mail.gmail.com>
References: <1312284545-2426-1-git-send-email-jon.seymour@gmail.com>
	<CAP8UFD3XzUjxiz6QQzyTOYzfiWrF4ckiv0h+gvi7YuZkma6yiw@mail.gmail.com>
	<CAH3AnrrkAeN3BgnnFBsbzh=37tC6f6aRACgk94wxW85qFQpfVw@mail.gmail.com>
	<201108030727.04246.chriscool@tuxfamily.org>
	<CAH3Anroaq+fH3T3_G1HsS3ecdNdpReaKLC5v=x37rDqSmtghww@mail.gmail.com>
	<CAH3AnrpQZJprVtkNH1oeGXADzy1HA20xSTD8Cwpo3=ymOjgYhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	gitster@pobox.com, j6t@kdbg.org, jnareb@gmail.com
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 16:16:39 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QocFR-0006hn-Uc
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 16:16:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753915Ab1HCOQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 10:16:34 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:51499 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753379Ab1HCOQc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 10:16:32 -0400
Received: by gxk21 with SMTP id 21so471309gxk.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 07:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=QLHjTOkbEJzGF287FMYEyDoBTWk5fU4flwohtcw9k8k=;
        b=wALY2tgrg/mZL+2MDqaBhUcigdlrxMcJp/X6dpCY/qICTKIl9JsTn9BfBkNm8daW38
         MaZxaireZdXPuyfacjeJiqBsxzeUdpNLvvGSsU/VdVzgpm7Yj0IFxQHtYpVgbStj6v5b
         rJHIVr6+UfN4NsVSXeTdmMuTcPTGR8EFyX3PI=
Received: by 10.146.88.15 with SMTP id l15mr5176610yab.6.1312380592173; Wed,
 03 Aug 2011 07:09:52 -0700 (PDT)
Received: by 10.147.124.3 with HTTP; Wed, 3 Aug 2011 07:09:52 -0700 (PDT)
In-Reply-To: <CAH3AnrpQZJprVtkNH1oeGXADzy1HA20xSTD8Cwpo3=ymOjgYhA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178580>

On Wed, Aug 3, 2011 at 3:24 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
> On Wed, Aug 3, 2011 at 10:46 PM, Jon Seymour <jon.seymour@gmail.com> wrote:
>> On Wed, Aug 3, 2011 at 3:27 PM, Christian Couder
>> <chriscool@tuxfamily.org> wrote:
>>> On Tuesday 02 August 2011 16:41:13 Jon Seymour wrote:
>>>> On Tue, Aug 2, 2011 at 10:04 PM, Christian Couder
>>>>
>>>> If I was to do this, I'd prefer to change uses of $BISECT_MODE with a
>>>> call to a function bisect_mode() that does the same thing.
>>>
>>> Yeah, I think it would be a good idea to have a bisect_mode() function.
>>> I don't like very much to blindly call some code when we might not need it.
>>>
>>
> Mmmm.
>
> Actually, there is a neater way to do this.
>
> I'll such use the existence of BISECT_HEAD to inform the
> implementation of bisect_mode().
>
> This avoids the need for a separate .git/BISECT_MODE file.

Yeah, but then you have to be careful of the fact that BISECT_HEAD
might have not been properly deleted or might have been created by the
user for other purposes.

Thanks,
Christian.
