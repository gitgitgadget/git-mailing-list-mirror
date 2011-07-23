From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: RFC: Should git gc/repack respect .git/refs/replace?
Date: Sat, 23 Jul 2011 19:25:50 +1000
Message-ID: <CAH3Anrqt-s6mPLXw_Uzf0YODFtTPRPJEDgvphjMFxybJibvbPg@mail.gmail.com>
References: <CAH3AnrqDbebODK-A90msoB9JXUwDHKKtQAQo5VdXZ=k8bxzkYQ@mail.gmail.com>
	<m2wrf9cq0i.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sat Jul 23 11:25:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QkYT6-0003fU-Cd
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jul 2011 11:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228Ab1GWJZw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 23 Jul 2011 05:25:52 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:55455 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab1GWJZv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 Jul 2011 05:25:51 -0400
Received: by vws1 with SMTP id 1so2119097vws.19
        for <git@vger.kernel.org>; Sat, 23 Jul 2011 02:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=xbR8jY+t+5GgjnJ8Clh2E5Le4SvsptxoxI2OiF8/nPI=;
        b=vSg3l6OTP0tePTmCnku80TPqwYd9PTaUjAZU/f5o5cTZzS2Shfq+ue0VSijHoM6bHW
         huummoZYl7L9H48/tWOW0SzglHhNDbHc6k0TkmT99H9d6q8pgo/YkOKCepCHV0ohZkQO
         TR69oX6IBz9bKyeobZKlJzWb84xIHvgOS8iRY=
Received: by 10.52.24.77 with SMTP id s13mr2423372vdf.508.1311413150767; Sat,
 23 Jul 2011 02:25:50 -0700 (PDT)
Received: by 10.52.183.41 with HTTP; Sat, 23 Jul 2011 02:25:50 -0700 (PDT)
In-Reply-To: <m2wrf9cq0i.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177684>

On Sat, Jul 23, 2011 at 7:20 PM, Andreas Schwab <schwab@linux-m68k.org>=
 wrote:
> Jon Seymour <jon.seymour@gmail.com> writes:
>
>> I recently damaged a USB drive containing an archive of a finished p=
roject.
>>
>> I am able to paper over a week of missing history by using the git
>> replace mechanism, so that git rev-list now works as expected.
>>
>> When I run git gc or git repack, I get the following:
>>
>> =C2=A0 =C2=A0error: Could not read 023a1d5d3977420ba041cb556c0eee17c=
326aeb6
>> =C2=A0 =C2=A0fatal: Failed to traverse parents of commit
>> 44d578ea81f7a90989e2ee3c676f50e3aff7071f
>
> git-replace(1):
>
> =C2=A0 =C2=A0 =C2=A0 Replacement references will be used by default b=
y all git commands
> =C2=A0 =C2=A0 =C2=A0 except those doing reachability traversal (prune=
, pack transfer and
> =C2=A0 =C2=A0 =C2=A0 fsck).
>

Oops. Missed that - thanks.

> This is required, since the replaced objects are not supposed to be
> recycled. =C2=A0If you want to make the replacements permanent use gi=
t
> filter-branch.

Ah, makes sense.

jon.
