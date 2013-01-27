From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v3 2/2] mergetools: Simplify how we handle "vim" and "defaults"
Date: Sat, 26 Jan 2013 19:56:45 -0800
Message-ID: <CAJDDKr7E1NkMV0_G+6oY9O3iCS9OCEzR1HYssKpwh77swDUcig@mail.gmail.com>
References: <1359247573-75825-1-git-send-email-davvid@gmail.com>
	<7vobgbz58a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 27 04:57:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzJMt-0008QH-CN
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755574Ab3A0D4s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:56:48 -0500
Received: from mail-ee0-f41.google.com ([74.125.83.41]:59933 "EHLO
	mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752937Ab3A0D4r (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:56:47 -0500
Received: by mail-ee0-f41.google.com with SMTP id c13so774806eek.14
        for <git@vger.kernel.org>; Sat, 26 Jan 2013 19:56:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=8jHhMZKaeDIhH4cSAT130lXnjiOtjYvJR4DpFW8ijmU=;
        b=oPW7WWbmSFrN55fpWZ5Z0udFGPFCRfrFpZEwHnGj9e7wWL/L0YlUbt+QBidtg6NTDe
         Ot3er/rHj9TZO4msIZh4WaDKd8XQydFAr0+6IQ4YBNS20LycdA6W5cHkj70I2cSJ0La0
         UYqUQyUqruZ7/3Fcny/FAqtMiJ0x8EKNOi9aGhLW6qqddnYVko8CiNxtXLs6CGuyAehj
         oR2rf/dYW3W4SCRLcjopeuPOS3PCdpfFCd/KoO4lkI3RjeOy98kW05E9dgl7ZH+tdU8A
         wBN7ob7awH8Bsm67HHLujdV7PSGey/z5P57xw+F/uRZQyXQLWgYya/MHZXHcCkq11DD0
         GTfg==
X-Received: by 10.14.219.72 with SMTP id l48mr36704026eep.37.1359259005833;
 Sat, 26 Jan 2013 19:56:45 -0800 (PST)
Received: by 10.14.125.135 with HTTP; Sat, 26 Jan 2013 19:56:45 -0800 (PST)
In-Reply-To: <7vobgbz58a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214673>

On Sat, Jan 26, 2013 at 7:15 PM, Junio C Hamano <gitster@pobox.com> wrote:
> David Aguilar <davvid@gmail.com> writes:
>
>> @@ -44,19 +46,9 @@ valid_tool () {
>>  }
>>
>>  setup_tool () {
>> -     case "$1" in
>> -     vim*|gvim*)
>> -             tool=vim
>> -             ;;
>> -     *)
>> -             tool="$1"
>> -             ;;
>> -     esac
>
> This part was an eyesore every time I looked at mergetools scripts.
> Good riddance.
>
> Is there still other special case like this, or was this the last
> one?
>
> Thanks, both of you, for working on this.

I believe that was the last special case. :-)  It should be easier
to auto-generate a list of tools for use in the documentation now.
That'll be the the next topic I look into.

I have a question. John mentioned that we can replace the use of
"$(..)" with $(..) in shell.

I have a trivial style patches to replace "$(..)" with $(..)
sitting uncommitted in my tree for mergetool--lib.

Grepping the rest of the tree shows that there are many
occurrences of the "$(..)" idiom in the shell code.

Is this a general rule that should be in CodingStyle,
or is it better left as-is?  Are there cases where DQ should
be used around $(..)?  My understanding is "no", but I don't
know whether that is correct.

Doing the documentation stuff is more important IMO so I probably
shouldn't let myself get too distracted by it, though I am curious.
-- 
David
