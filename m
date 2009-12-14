From: Jacob Helwig <jacob.helwig@gmail.com>
Subject: Re: git gc logs to standard error
Date: Mon, 14 Dec 2009 08:46:22 -0800
Message-ID: <8c9a060912140846r36897c7cl738036963b0d5693@mail.gmail.com>
References: <4B264F7B.8070504@inf.utfsm.cl> <200912141655.01268.johan@herland.net> 
	<8c9a060912140804t409030b4g168014bd80a0b88c@mail.gmail.com> 
	<4B26669A.8020806@inf.utfsm.cl> <8c9a060912140828p3b05972lf9abc82c7b0f9bc1@mail.gmail.com> 
	<4B2669CD.9020505@inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Richard Rossel <rrossel@inf.utfsm.cl>
X-From: git-owner@vger.kernel.org Mon Dec 14 17:46:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKE4Q-0002I4-OI
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 17:46:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757950AbZLNQqo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 11:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757949AbZLNQqo
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 11:46:44 -0500
Received: from mail-pz0-f171.google.com ([209.85.222.171]:58504 "EHLO
	mail-pz0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756659AbZLNQqn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2009 11:46:43 -0500
Received: by pzk1 with SMTP id 1so2390587pzk.33
        for <git@vger.kernel.org>; Mon, 14 Dec 2009 08:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=0ZH4TVzs21fY1PmoVHw1KYKbiUxdMe61bSLDhot8fdI=;
        b=I9AtNfOk1AlYbjYFhkq4RGltLm8/CR2Ao4D8Q2HqEdNWMfHW22UW559P1vnUTkhQpq
         1wMW55NaT0z/EMK8+Z1HuR7bJ4xMc9BFR/Ak0zRd09rBkoGFA5kuuUesxLF8ouED7yWP
         KhDL6zyDTfaAnddSngQ9sOY9yKHYO9FxsXLIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=p8l9pigPMBOlGTuCPcD0OrWM8PozlIpbx5hB911BuHWDXQmSj6PrnnloPOI67xxt/L
         ieWyktc2dzW+jziYeqetFqXhRn6wuUQgUWOURehGhkpawErI6kWLtvDTcYufFln8q1q+
         dd1U5FJaRT69uF+RUD2/9NdgOdxftC9ZB25rs=
Received: by 10.140.82.42 with SMTP id f42mr3443557rvb.40.1260809202121; Mon, 
	14 Dec 2009 08:46:42 -0800 (PST)
In-Reply-To: <4B2669CD.9020505@inf.utfsm.cl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135227>

On Mon, Dec 14, 2009 at 08:37, Richard Rossel <rrossel@inf.utfsm.cl> wr=
ote:
>>
>> On Mon, Dec 14, 2009 at 08:23, Richard Rossel<rrossel@inf.utfsm.cl>
>> =C2=A0wrote:
>>
>>>
>>> $ git --version
>>> git version 1.5.4.3
>>>
>>> And when there is no change in the repo
>>>
>>> $ git fetch --q; echo $?
>>> 0
>>>
>>> no messages and no error , but when there is a change to syncronize
>>>
>>> $ git fetch --q; echo $?
>>> remote: Counting objects: 7, done.
>>> remote: Compressing objects: 100% (5/5), done.
>>> remote: Total 5 (delta remote: 2), reused 0 (delta 0)
>>> Unpacking objects: 100% (5/5), done.
>>> =C2=A0From git@boss:sandbox
>>> =C2=A0 3e4df7f..b92d27c =C2=A0master =C2=A0 =C2=A0 -> =C2=A0origin/=
master
>>> 0
>>>
>>>
>>
>> Don't use a double dash, if you're using the short option.
>>
>> git fetch -q
>> OR
>> git fetch --quiet
>>
>> git fetch --q<--- This is not what you think it is.
>>
>> -Jacob
>>
>>
>
> doh, sorry, my mistake
>
> $ git fetch -q; echo $?
> remote: Counting objects: 5, done.
> remote: Compressing objects: 100% (2/2), done.
> remote: Total 3 (delta 1), reused 0 (delta 0)
> Unpacking objects: 100% (3/3), done.
> From git@boss:sandbox
> =C2=A0 b92d27c..17b8b5d =C2=A0master =C2=A0 =C2=A0 -> origin/master
> 0
>
> These is the output when there is a change to be syncronized
>
> BTW, =C2=A0in crontab the commands are using -q option, the mistake w=
as made just
> here :)
>

It looks like you want to upgrade to at least 1.6.0.3 (I know that
with 1.6.5.5 I get no output with 'git fetch -q', whether or not there
are pending updates).  There's a fix (fe8aa148) for the issue[1] it
looks like you're having.

[1] http://marc.info/?l=3Dgit&m=3D121529226023180&w=3D2
