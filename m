From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v0 3/3] Build in git-rebase.sh
Date: Mon, 25 May 2009 16:34:52 +1000
Message-ID: <fcaeb9bf0905242334q37ef9a05xa05315639af4daf3@mail.gmail.com>
References: <1242899229-27603-1-git-send-email-pclouds@gmail.com> 
	<1242899229-27603-2-git-send-email-pclouds@gmail.com> <1242899229-27603-3-git-send-email-pclouds@gmail.com> 
	<4A164C85.3000703@viscovery.net> <fcaeb9bf0905220030l45e1b7dfqd30f35b7c8e43b51@mail.gmail.com> 
	<20090523092603.GA7420@dektop> <20090523145042.GA13139@dektop> 
	<4A1A37AD.4080309@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 25 08:35:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M8TmQ-0007sv-T6
	for gcvg-git-2@gmane.org; Mon, 25 May 2009 08:35:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbZEYGfO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 May 2009 02:35:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751815AbZEYGfM
	(ORCPT <rfc822;git-outgoing>); Mon, 25 May 2009 02:35:12 -0400
Received: from yw-out-2324.google.com ([74.125.46.29]:50606 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123AbZEYGfL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 May 2009 02:35:11 -0400
Received: by yw-out-2324.google.com with SMTP id 5so1764769ywb.1
        for <git@vger.kernel.org>; Sun, 24 May 2009 23:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=A4GbYgioNhvI5dTXYR53ACm3W8owbs9YL48tBGtvD6A=;
        b=gGo3nE+5gSWMEw82J6aNq3OhGXrSdDPKhD2P7m/UJQ0WJuzBz6aqD2GLls24sGOXiG
         T2M5tRJCgF5+aC9BPRXnmvWXuEYJnfOV8DorxNSl+qJ8KKeJH8GpkEMYNw4efEKfYP7X
         6LqCH5BnR3S+MowQslsHUat5oDxyq9iP52SIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=gn88stf68cJddQa8WkM9V9SD3YZdOV9oFWsVk8YhRd02GH1zKSScXASiac2O2dICJ5
         TH+QzLf8NNvaSNaaONJEA6jBawugE8IYeuIBkJ7wXvhyX95VmRiGFbaxJe4ALw66d+9i
         96w2HC0M5R5SKsn+FUYG1pELCMaWusGSFOg3k=
Received: by 10.100.43.10 with SMTP id q10mr7571301anq.125.1243233312348; Sun, 
	24 May 2009 23:35:12 -0700 (PDT)
In-Reply-To: <4A1A37AD.4080309@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119887>

On Mon, May 25, 2009 at 4:16 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Nguyen Thai Ngoc Duy schrieb:
>> On Sat, May 23, 2009 at 07:26:03PM +1000, Nguyen Thai Ngoc Duy wrote=
:
>>> On Fri, May 22, 2009 at 05:30:31PM +1000, Nguyen Thai Ngoc Duy wrot=
e:
>>>> 2009/5/22 Johannes Sixt <j.sixt@viscovery.net>:
>>>>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy schrieb:
>>>>>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pcloud=
s@gmail.com>
>>>>> Is it possible for you to test this series on Windows? Many rebas=
e tests
>>>>> fail, but I haven't investigated why.
>>>> I'll try it this weekend.
>>> This patch makes t3*rebase*.sh pass for me except t3412 (more exact=
ly
>>> t3412.8). That test failed even with git-rebase.sh. Hmm... Anyway
>>> could you try again to see what tests still fail?
>>
>> Someone with better Windows knowledge than me should explain how thi=
s works. Windows'
>> snprintf() just cuts out the last character in this statement:
>>
>> snprintf(buf, 8, "--%s", "onto"); // result: '--ont', expected: '--o=
nto'
>
> This doesn't happen for me: neither with Windows's original snprintf =
nor
> with the version from compat/. Are you using the latest msysgit
> environment to compile, i.e. gcc 4.4? There was a change regarding
> SNPRINTF_SIZE_CORR; perhaps that's the culprit?

It could be. I used git.git's next branch, not msys4git or mingw.git
repositories.

> I don't undertand what this patch does, anyway. Where is the detail t=
hat I
> am missing?

The first vsnprintf() in "onto" case above did not produce " --onto"
as it should have been. I tried to recover by filling "str" with the
second vsnprintf() in the loop.

>> All rebase tests now pass for me on Windows (Vista something, I have
>> yet to find where it hides its "uname" command)
>
> They also pass for me with your earlier fix-up patch, but with or wit=
hout
> this patch to compat/snprintf.c.

Good to know.
--=20
Duy
