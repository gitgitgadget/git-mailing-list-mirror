From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH][Outreachy] branch -D: allow - as abbreviation of @{-1}
Date: Mon, 21 Mar 2016 15:26:15 -0400
Message-ID: <CAPig+cS-07dMStzAp+J+9_FJkREdRZcACg1CMoz_YEu9AezmJQ@mail.gmail.com>
References: <1458573317-15532-1-git-send-email-elena.petrashen@gmail.com>
	<vpqfuvju4km.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elena Petrashen <elena.petrashen@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:26:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai5T9-0005i3-H7
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 20:26:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757847AbcCUT0U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2016 15:26:20 -0400
Received: from mail-vk0-f48.google.com ([209.85.213.48]:34341 "EHLO
	mail-vk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757778AbcCUT0S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2016 15:26:18 -0400
Received: by mail-vk0-f48.google.com with SMTP id e185so226900880vkb.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 12:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=Vi3CqikChtIkqqCGs/M7h5+HXvme+Up4YSQfh/rHeic=;
        b=vvmBQInVhL1lRobiYd8BxrJg2N+K1i3NkcqX0y4nVsIFlZaztHkNBAGJwKTSJGwzTr
         zr9Ce+nOmWtYqqL1gYf4TJGdFi3YN7JKfDs9EPp3abb9ZncxGBkI6heY6JE6FZEIRYZZ
         DnWHQCJsMt2DGVgyOJmxm6O2VtOQJ4sMK7A2lFNOU0dhc2NfgNo1hjx0ovFNyUylBMkQ
         coYFLT0kCHQXiE4QsCD8L6XtzwbyqSqc1L3C4oJiBl3uMDoSYnOhjbhZV+gTgNO7gHMG
         MwYn7VuoXArpjCKjU522V8Yk7hZG5U5gquZ+9Z1md0abDBRX7aItxg8uQz+1Gtm76IXZ
         hAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=Vi3CqikChtIkqqCGs/M7h5+HXvme+Up4YSQfh/rHeic=;
        b=HPBxGfJVtfm+VSNeztpVr2iseShLsV4VRKTFMf8G/ya3BcfIKroSVr9dATbym2sJAU
         2qJicqt2QSGLXbYmXXhcDrzQoZJ9CaDPyClDuFEsli9On1YYaqSzLlJSu6zg5YdKwKzn
         aDTVIeivBcebqY7K+Qh4gc/MYpbsjiUWklC2p+zUDVjUQoB6wKlTPICLeiBGYe4s6yfe
         h4/wt9euI2CEEUNqYp4SrtKrEvCt0tvAPzm8Mp/6TDGdOJnfczOeTA0Ael01BCJ5X3q6
         7qX9DWarPDESl/jiRfvHXOk8mOy83sDRTpaKrjBa+fZvs2D2uffz+r4IbNvubIMVaI4m
         rx6g==
X-Gm-Message-State: AD7BkJL0O725rxP8QFxwtQeBlrPKPcWpxagqnDYvcl1hD+f0F/lnxrQaHp1LCLtveiWr5BurRrHSbtECpu9xtA==
X-Received: by 10.176.3.48 with SMTP id 45mr2369064uat.123.1458588375137; Mon,
 21 Mar 2016 12:26:15 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Mon, 21 Mar 2016 12:26:15 -0700 (PDT)
In-Reply-To: <vpqfuvju4km.fsf@anie.imag.fr>
X-Google-Sender-Auth: Q9YUqefcOL1-8KzVjuZyNQtIK_0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289439>

On Mon, Mar 21, 2016 at 1:24 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Elena Petrashen <elena.petrashen@gmail.com> writes:
>> * git branch (-d | -D) is not supposed to accept any other
>> arguments except for branch name so it makes sense to replace
>> the argv[i] with @{-1}. We will not lose the opportunity to
>> use it for something different for other git branch uses if
>> we will decide it=E2=80=99s required.
>
> This could go inside the commit message, not below the ---.

No, I think this does indeed belong here in the commentary area (below
"---"); not in the commit message. The previous version of the patch
incorrectly mapped "-" to "@{-1}" for all argv[], not just for the
branch name, and the above paragraph is explaining that the mistake
has been fixed in the current version of the patch. Whatever minor
additional information the above paragraph states is already implied
by the patch title and by common sense, so it probably wouldn't be
helpful to bulk up the commit message just for that.
