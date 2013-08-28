From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Wed, 28 Aug 2013 16:21:02 -0500
Message-ID: <CAMP44s2G0Nm56q30EXgjpatsJhQZgiJ6uxr83o_74TsUAnHt3w@mail.gmail.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
	<1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
	<vpqhae97f8j.fsf@anie.imag.fr>
	<CAMP44s2bu9gUE=McYq1prhjC3O2CRj1W_Yc+-CjTkk6Gc3JFTw@mail.gmail.com>
	<CALWbr2xi1+EKHry4GRwLv=SwRUsaTKLQc6RUfuPKEre4pcpaFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 23:21:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEnAs-000567-3v
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 23:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755496Ab3H1VVF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Aug 2013 17:21:05 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:42818 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755295Ab3H1VVE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Aug 2013 17:21:04 -0400
Received: by mail-lb0-f174.google.com with SMTP id w6so4339243lbh.33
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 14:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=5hWj2deOldGUtSLt1VsZQHjc54zHyNHOEQ5ZsenTzY0=;
        b=V2R5djmzNap2ET2c5RVv3jXZZARP5hzPTCfd+ecdVNcdCT3y5jntpy3XUXKXQpCYX2
         r9cTAQtVwvS6x6lF+8SBRcPwwH32N8xCII6HE+H3vUruE7VorwrYSmNbJw8QtJWgir8C
         qBa1D0BCiRVfOh0QBlstMDSQqC+xf8LWtksBM/k5ezWnFgdNYEhV7K7/eYwl8CxoTJod
         EVL/5998Jn8hiIf3Ejp1ldijDW7NkPvsJvoNI8Ly09QP1GLyB67xQJQZIomMts9qQPvE
         YVNfD5eU2PBc9JXwBH/b30XaIsyngNxymyZ/xExx65AjtFx73IQTDsKKSnO8BmmumW8B
         ZFqA==
X-Received: by 10.152.22.35 with SMTP id a3mr42802laf.45.1377724862119; Wed,
 28 Aug 2013 14:21:02 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Wed, 28 Aug 2013 14:21:02 -0700 (PDT)
In-Reply-To: <CALWbr2xi1+EKHry4GRwLv=SwRUsaTKLQc6RUfuPKEre4pcpaFg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233217>

On Wed, Aug 28, 2013 at 3:54 PM, Antoine Pelisse <apelisse@gmail.com> w=
rote:
> On Wed, Aug 28, 2013 at 10:48 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> On Wed, Aug 28, 2013 at 3:05 PM, Matthieu Moy
>> <Matthieu.Moy@grenoble-inp.fr> wrote:
>>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>>
>>>> +     echo greg >> content &&
>>>> +     git add content &&
>>>> +     git commit -m one
>>>
>>> test_commit would make it shorter.
>>
>> And it would make it inconsistent with the rest of the script.
>>
>>>> +     bzr log | grep "^committer: " > ../actual
>>>> +     ) &&
>>>> +
>>>> +     echo "committer: Gr=C3=A9goire <committer@example.com>" > ex=
pected &&
>>>
>>> Git's source code usually says >../actual and >expected, without sp=
ace
>>> after '>'.
>>
>> Not that usually:
>>
>> % git grep ' > ' t/*.sh | wc -l
>> 1943
>
> There are many false positive in that count.
>
> As in this one:
> $ git grep ' >[^ ]' -- t/*.sh | wc -l
> 10354

Ten thousand is still a lot, and the claim remains: it's far from
unusual to follow this style.

--=20
=46elipe Contreras
