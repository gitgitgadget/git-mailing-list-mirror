From: Klas Lindberg <klas.lindberg@gmail.com>
Subject: Re: git merge-tree segfault
Date: Sat, 30 Oct 2010 20:11:22 +0200
Message-ID: <AANLkTi=2JHqXO75Ckgrg7R1B2_nhaPukR6tkk9EoFjPd@mail.gmail.com>
References: <AANLkTinJQCqwRZpbO66VHrgxezedS1Ay3nr9kayiODi9@mail.gmail.com>
	<4CCC5542.8020105@debugon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mathias Lafeldt <misfire@debugon.org>
X-From: git-owner@vger.kernel.org Sat Oct 30 20:11:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCFu8-0001pV-GE
	for gcvg-git-2@lo.gmane.org; Sat, 30 Oct 2010 20:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755256Ab0J3SLY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Oct 2010 14:11:24 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48499 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755053Ab0J3SLX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Oct 2010 14:11:23 -0400
Received: by vws13 with SMTP id 13so1466466vws.19
        for <git@vger.kernel.org>; Sat, 30 Oct 2010 11:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=7rKIIcuyoMsITRn6Lf85CihyGyYgbZBe7mIdvqw49lc=;
        b=W44FluadRBQyE5IbXEFfFOCHxVVT4TQ/5rgOh6x0IoN7yhVqD7RJfZyu6ANtLSJAWq
         iZljX7e/1VYsEHFQYu+qzieDri7lB+tVu8iC5XoW+mm/1dSQlPV+1Gk3mCzBEBBkwzfA
         TGvS2Gp1pKpD/Nvght51n6xQvXguXfgHZR/As=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=sQtSp2zBoDd988vhuvY56Y7ilTsz262RUc9Eye1sn7KMUPzf+hxXYgZ6kQZWaZe7IY
         nr6mmVgt+oS8YYG8XTrMcTooLvHvQyhn4Cno5S1VOhOSEW8kNtNeP2iBxYOJ2+7exkmv
         5as8/DDoKLiughn9KlqHYlmb3NC9AwUtOLzH8=
Received: by 10.224.194.131 with SMTP id dy3mr6345236qab.60.1288462282372;
 Sat, 30 Oct 2010 11:11:22 -0700 (PDT)
Received: by 10.229.182.209 with HTTP; Sat, 30 Oct 2010 11:11:22 -0700 (PDT)
In-Reply-To: <4CCC5542.8020105@debugon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160404>

Beautiful, and it's in Debian/squeeze too  :-)

Thanks for finding the fixed version. I was just about to make a
kludge in my porcelain to work around this.

BR / Klas

On Sat, Oct 30, 2010 at 7:26 PM, Mathias Lafeldt <misfire@debugon.org> =
wrote:
> On 10/28/2010 10:16 PM, Klas Lindberg wrote:
>> I haven't tried this on newer versions of git, but the release notes
>> for later releases don't mention merge-tree anywhere, so...
>>
>> git version: 1.7.0
>> uname -a: Linux tor 2.6.32-trunk-amd64 #1 SMP Sun Jan 10 22:40:40 UT=
C
>> 2010 x86_64 GNU/Linux
>> distro: Debian GNU/Linux squeeze/sid
>>
>> Unpack the attached tree, cd into it and run:
>> git merge-tree common master other
>>
>> I get the following result:
>> added in local
>> =C2=A0 our =C2=A0 =C2=A0100644 d68dd4031d2ad5b7a3829ad7df6635e27a7da=
a22 t1.txt
>> Segmentation fault
>>
>> The exit code:
>> 139
>>
>> BR / Klas
>
> Looks like this has been fixed by 21baa6e (merge-tree: fix where two
> branches share no changes, 2010-07-14).
>
> $ git merge-tree common master other
> added in local
> =C2=A0our =C2=A0 =C2=A0100644 d68dd4031d2ad5b7a3829ad7df6635e27a7daa2=
2 t1.txt
>
> $ echo $?
> 0
>
> $ git --version
> git version 1.7.3.2
>
> -Mathias
>
