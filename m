From: Dmitry Ivankov <divanorama@gmail.com>
Subject: Re: [PATCH 5/5] fsck: improve committer/author check
Date: Wed, 3 Aug 2011 01:50:20 +0600
Message-ID: <CA+gfSn8xp3yj0Odu-7DSQyPq4mxVOdOzpS98nSx9gUpfrx-5Jg@mail.gmail.com>
References: <1311831844-13123-1-git-send-email-divanorama@gmail.com>
	<1311831844-13123-6-git-send-email-divanorama@gmail.com>
	<7vfwljg33p.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, SASAKI Suguru <sss.sonik@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 02 21:50:28 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoKyw-00026O-LX
	for gcvg-git-2@lo.gmane.org; Tue, 02 Aug 2011 21:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755091Ab1HBTuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Aug 2011 15:50:22 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:38403 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754819Ab1HBTuV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Aug 2011 15:50:21 -0400
Received: by qwk3 with SMTP id 3so91289qwk.19
        for <git@vger.kernel.org>; Tue, 02 Aug 2011 12:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Co6phJW5TlhGKmY3jo58fp99Z4tKroyOKhQQQYToy0g=;
        b=gUBYESm0TpGT8706j3Mjz13S1d1ff3cfpihwOgrjK9tmV2snd7wqcko8gn5BrDFI2M
         gCaqL170URzixYy2P5H08TXJPgXNmLY82hBcEq0iJ1atRTJ/a228isQnShEKV4aQtfEw
         aXw6vkTnp9IKAyeA1dDeV9Ol00+MiTzg49nXQ=
Received: by 10.229.101.93 with SMTP id b29mr4007485qco.112.1312314620605;
 Tue, 02 Aug 2011 12:50:20 -0700 (PDT)
Received: by 10.229.189.3 with HTTP; Tue, 2 Aug 2011 12:50:20 -0700 (PDT)
In-Reply-To: <7vfwljg33p.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178506>

On Tue, Aug 2, 2011 at 11:00 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Dmitry Ivankov <divanorama@gmail.com> writes:
>
>> Neither name nor email should contain < or >, so split the string with
>> these and check they come in that order and < is preceeded with a space.
>>
>> If < is missing don't say a confusing "missing space", say "bad name" if
>>> isn't missing and "missing email" if both < and > are missing.
>>
>> Signed-off-by: Dmitry Ivankov <divanorama@gmail.com>
>> ---
>
> Same comment as 3/5; before starting to talk about how you implemented
> your validation, please state what rules you are enforcing.
Thanks, will apply and reroll.
But before this, is it ok to reject "Name> <email>" idents in fsck and
fast-import?
fsck already denies '<' and '>' inside email, and '<' in name. But
accepts '>' in name.
It just hit me that Documentation/fast-import.c doesn't deny '>' in
name and it is
consistent with fsck, so there may be a reason behind it.

>
> Thanks.
>
