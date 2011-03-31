From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: Re: Usability improvement request: git show revision -- file
Date: Thu, 31 Mar 2011 21:59:24 +0200
Message-ID: <AANLkTimkdRtY_2S1U=Kog08EOAx_U2cgAFdEC60AZ4eO@mail.gmail.com>
References: <AANLkTi=JPVXD7Je7Rz9yhKHnJo+K2rs5WnwTY22c3h6L@mail.gmail.com>
	<4D94322A.8030409@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Mar 31 21:59:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5O1j-0006wV-Gc
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 21:59:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759308Ab1CaT70 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2011 15:59:26 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:38325 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759298Ab1CaT7Z convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Mar 2011 15:59:25 -0400
Received: by vws1 with SMTP id 1so2176706vws.19
        for <git@vger.kernel.org>; Thu, 31 Mar 2011 12:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Kuw4C8LS0uLAquPBMlsPZIiZpvZV80ZbWgfzPE+JbIU=;
        b=itCiTVIHJ/QKfNe5URGkg2BoiLDVMDWOXxDpcGpWcT00+MyEE9Wn1HHqpHK7Maglub
         r1f0cIdf/tq9CrfCE+EJCtYE/dayqbw4IJkjz+Sausf89Qkmq6y5Aq1y4xH2kZfGiJ+6
         Q9hDMB+CMu/DFE8Eo2Ras8pxbl1tlHbpzKYgM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=r1nxe8qkV923csjdzhYOZvqieIxSEotK6NV+XpQFGXnnVYgscHqb/oS1W3EVqjdF4z
         00LxlsfOMYHtVyFgjxfmaH7CJb/nbmfUvE6CSwcNc6XtU8nyOdtfCI2Rkd+xvHkcb1Ko
         9M0cwVmUh5Y2LHzPAQ/UMRSxJ+Cm6g85NDBCk=
Received: by 10.52.93.177 with SMTP id cv17mr4239890vdb.133.1301601564729;
 Thu, 31 Mar 2011 12:59:24 -0700 (PDT)
Received: by 10.220.210.16 with HTTP; Thu, 31 Mar 2011 12:59:24 -0700 (PDT)
In-Reply-To: <4D94322A.8030409@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170526>

On Thu, Mar 31, 2011 at 9:50 AM, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Piotr Krukowiecki venit, vidit, dixit 31.03.2011 08:45:
>> Hi,
>>
>> if there's existing way to do this please tell me.
>>
>> There's this file "src/subdir/file". I'm in the "src" directory and =
want to
>> see the "file" at specific revision.
>>
>> Knowing about git show I'd expect something like this to work:
>>
>> =A0 =A0$ git show master -- subdir/file
>>
>> But it shows nothing (no output, no warning).
>
> ...because you are asking git to show the commit master, filtered by
> subdir/file, and if that file is not changed there, the commit is not

It wasn't - I was doing git-blame and wanted to see file as it was befo=
re
the blamed commit.


> selected. If it is changed there, it shows you only the diff affectin=
g

I see - that makes sense too.


> that file. (We might want to change this to filter the diff only.)

Not sure what you mean by that?


>> Following also does not
>> work as expected:
>>
>> =A0 =A0$ git show master:subdir/file
>> =A0 =A0fatal: Path 'src/subdir/file' exists, but not 'subdir/file'.
>> =A0 =A0Did you mean 'master:src/subdir/file'?
>
> But git is really understanding about your situation, isn't it? ;)

Yeah, but this looks like a workround for a common problem -
people specify relative path a lot, so a warning was added.


>> Of course following works:
>>
>> =A0 =A0$ git show master:src/subdir/file
>>
>> but it's not very convenient to have to specify full path, and it's =
not what
>> you would expect given that most other commands accept "-- relativep=
ath"
>> syntax.
>
> It's not the command in this case, but the "commit:pathspec" syntax, =
and
> for every command which understands it, it is relative to root (i.e.
> expects a full path). But we do have a syntax for relative:
>
> git show master:./subdir/file

Thanks, I'll try to remember. I don't have a better idea for solving
this problem.


--=20
Piotr Krukowiecki
