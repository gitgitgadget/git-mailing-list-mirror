From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 5/9] t3510 (cherry-pick-sequencer): use exit status
Date: Sat, 10 Dec 2011 02:06:47 +0530
Message-ID: <CALkWK0=a=-4N4aZHuu=5zkNtwmfLsog5WkBVbuJAbYpvaLUsAg@mail.gmail.com>
References: <1323445326-24637-1-git-send-email-artagnon@gmail.com>
 <1323445326-24637-6-git-send-email-artagnon@gmail.com> <20111209202149.GH20913@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 09 21:37:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ7C9-00069k-QJ
	for gcvg-git-2@lo.gmane.org; Fri, 09 Dec 2011 21:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754783Ab1LIUhM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 9 Dec 2011 15:37:12 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:35812 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954Ab1LIUhJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 9 Dec 2011 15:37:09 -0500
Received: by qcqz2 with SMTP id z2so2497327qcq.19
        for <git@vger.kernel.org>; Fri, 09 Dec 2011 12:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=IutCb1JDtxJAEDD5wSUpL0XCS8fp7sRicYFtEwxbJ7Y=;
        b=NJGgxrQ5+yQXI6xqbb0mK38eboK/KbTN7fA1qxFNmuAzmbZjEYE+CA+SMb/MaT4G7E
         yTPyKH/3UZ48J75n4ScYuund071VvwZClwnDIIP0WESzdcsNEWqYS8/RDFplR8wxNQ7o
         YZuO3k4P4u60Q59pW+iHjx9ShxzTyL7L5xa/o=
Received: by 10.229.65.103 with SMTP id h39mr2238217qci.202.1323463028290;
 Fri, 09 Dec 2011 12:37:08 -0800 (PST)
Received: by 10.229.165.194 with HTTP; Fri, 9 Dec 2011 12:36:47 -0800 (PST)
In-Reply-To: <20111209202149.GH20913@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186691>

Jonathan Nieder wrote:
> Ramkumar Ramachandra wrote:
>
> [...]
>> --- a/t/t3510-cherry-pick-sequence.sh
>> +++ b/t/t3510-cherry-pick-sequence.sh
> [...]
>> @@ -53,7 +53,7 @@ test_expect_success 'cherry-pick persists data on =
failure' '
>>
>> =C2=A0test_expect_success 'cherry-pick persists opts correctly' '
>> =C2=A0 =C2=A0 =C2=A0 pristine_detach initial &&
>> - =C2=A0 =C2=A0 test_must_fail git cherry-pick -s -m 1 --strategy=3D=
recursive -X patience -X ours base..anotherpick &&
>> + =C2=A0 =C2=A0 test_expect_code 128 git cherry-pick -s -m 1 --strat=
egy=3Drecursive -X patience -X ours base..anotherpick &&
>> =C2=A0 =C2=A0 =C2=A0 test_path_is_dir .git/sequencer &&
>
> Encountered conflicts, preserving options, but the exit is with statu=
s
> 128? =C2=A0Smells like a bug.

No bug.  Notice that "-m 1" is used when "initial" isn't a merge
commit.  But yeah, I should probably clarify this by changing the
revision range to "initial..anotherpick" so as not to distract the
user.

-- Ram
