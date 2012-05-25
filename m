From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH 1/2] git-p4: Test changelists touching two branches
Date: Fri, 25 May 2012 09:32:29 +0100
Message-ID: <CAOpHH-U5dRaMsMPn3X6KujSb=pnw+voaOLaEntGhi+4x1uboGA@mail.gmail.com>
References: <1337729891-27648-1-git-send-email-vitor.hda@gmail.com>
 <1337729891-27648-2-git-send-email-vitor.hda@gmail.com> <20120524010805.GA26443@padd.com>
 <CAOpHH-U+cG2DvTtWD25JNgLYKrNcwXgqysA0G-wr5DFhLG-DAg@mail.gmail.com> <7vmx4xunzr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org,
	Luke Diamand <luke@diamand.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 25 10:33:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXpxQ-0000Or-Jm
	for gcvg-git-2@plane.gmane.org; Fri, 25 May 2012 10:33:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756459Ab2EYIdF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 May 2012 04:33:05 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:53552 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753788Ab2EYIdA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 May 2012 04:33:00 -0400
Received: by bkcji2 with SMTP id ji2so530699bkc.19
        for <git@vger.kernel.org>; Fri, 25 May 2012 01:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=gd6yN/Sco8r/NXvol74ZZh23tMHsYXKxNcz5b7fYOxk=;
        b=WKPXPRfGCp9ZPemmDejUw067kHMB0DX00yvtfvtYo1JgYRu/1qqeFvnJ3xfENmfRoM
         KjtNsrM5CiCuEWEYvAXJqwaP18haD1wmNEQ3XiiP8ajbaHK5jUkAgl5E292bFoFDmC7X
         8Q/mg4CTUt/TvFDtv+UhOGJKFC7TKFssPOPr0JWcxIFNukpKmgMEQCSonTDk+FBUPAl/
         1QMVm4ZmTdMmvRKnQTETDQg59rhMc2bORTK4aEgyFJK0qT8tvNlXjKoINk3OLRKh87wk
         kbrjAEs6BpurcrFtUwtccBd7gaLYXOYSBsalwCzx4pS8pbCysdl27Vz6SwH6PQO3b5O8
         qgug==
Received: by 10.204.130.85 with SMTP id r21mr1121509bks.53.1337934779353; Fri,
 25 May 2012 01:32:59 -0700 (PDT)
Received: by 10.204.129.215 with HTTP; Fri, 25 May 2012 01:32:29 -0700 (PDT)
In-Reply-To: <7vmx4xunzr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198470>

On Fri, May 25, 2012 at 1:02 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Vitor Antunes <vitor.hda@gmail.com> writes:
>
>> What about the parentheses in the next line, is it necessary? Or can=
 I
>> simply remove that pair of parentheses and unindent the code in
>> between?
>>
>>> ...
>>>> + =A0 =A0 (
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 cd "$cli" &&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 p4 integrate //depot/branch3/file3 //dep=
ot/branch4/file3 &&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 p4 delete //depot/branch3/file3 &&
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 p4 submit -d "Move branch3/file3 to bran=
ch4/file3"
>>>> + =A0 =A0 )
>>>> +'
>
> If you mean this part, the parentheses to throw you into a subprocess=
 are
> required. =A0Otherwise, a failure in any of these three p4 commands w=
ill
> leave you in $cli directory, causing the next test to start in a dire=
ctory
> that it does not expect.

That makes sense and is quite obvious now that I _see_ it.

Thanks for your help Junio.

Vitor
