From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/32] nd/multiple-work-trees cleanup
Date: Sat, 30 Aug 2014 18:14:57 +0700
Message-ID: <CACsJy8AsFuxBcWcb0BvKKKnmN-9tWq=qYjOTKEWZpyQP_8nseQ@mail.gmail.com>
References: <1409387642-24492-1-git-send-email-pclouds@gmail.com> <CAPig+cT6J-qts-KqYK-quy+zLmWOfk6eeMfuoXBPKN4he=bncg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sat Aug 30 13:15:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XNgd2-0007VE-QP
	for gcvg-git-2@plane.gmane.org; Sat, 30 Aug 2014 13:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751566AbaH3LP3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2014 07:15:29 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:62303 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751369AbaH3LP2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Aug 2014 07:15:28 -0400
Received: by mail-ie0-f171.google.com with SMTP id rp18so4050725iec.30
        for <git@vger.kernel.org>; Sat, 30 Aug 2014 04:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=EDdkWPL1LaCjKsCZn1FuhJksqpD3wqlvm0YABphtdZA=;
        b=ZuLzA6JZ06WfFfS/VutwK/uer0oSA9g1xHLM1yz5M++mzXdoHAZCsBvmTIKP08/Sgq
         j80UNX0FBNParC33mA8bugZJf+q5ROXzKccTuVxa6bPuBAhKvB51Lg2mwIrCElWs/i6v
         /7dw4/+wOyCcg2DgbaOCQiSMhihsaPLnq76dkNyIshWb2hE1GIOKo8DNv5lxG0h+GitV
         CpLFJtu5+klt2oaMzWJmrRB1cX9/8sMb/spiSakCad4c0RFjJPfbw3qMQkvTslO4PMo4
         M3STFo7p2zDYI4Dk8+Sux1THAuNpdDYvI80ZSrI0UqDzfKyrzv/JnXZdb0AB6GVsByUF
         P7LQ==
X-Received: by 10.50.43.164 with SMTP id x4mr10170699igl.27.1409397327798;
 Sat, 30 Aug 2014 04:15:27 -0700 (PDT)
Received: by 10.107.13.80 with HTTP; Sat, 30 Aug 2014 04:14:57 -0700 (PDT)
In-Reply-To: <CAPig+cT6J-qts-KqYK-quy+zLmWOfk6eeMfuoXBPKN4he=bncg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256247>

On Sat, Aug 30, 2014 at 6:11 PM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Sat, Aug 30, 2014 at 4:33 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> This collapes some bug fix patches into the main ones, adds a few mo=
re
>> tests to cover recent changes, and removes advice.checkoutLocked (wh=
en
>> things are controversal, probably best to go without them until they
>> are settled). Diff against current version in 'pu'
>>
>> diff --git a/Documentation/gitrepository-layout.txt b/Documentation/=
gitrepository-layout.txt
>> index 6bd82af..c9a7d1a 100644
>> --- a/Documentation/gitrepository-layout.txt
>> +++ b/Documentation/gitrepository-layout.txt
>> @@ -218,11 +218,10 @@ remotes::
>>         "$GIT_COMMON_DIR/remotes" will be used instead.
>>
>>  logs::
>> -       Records of changes made to refs are stored in this
>> -       directory.  See linkgit:git-update-ref[1]
>> -       for more information. This directory is ignored if
>> -       $GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/logs" will be us=
ed
>> -       instead.
>> +       Records of changes made to refs are stored in this directory=
=2E
>> +       See linkgit:git-update-ref[1] for more information. This
>> +       directory is ignored $GIT_COMMON_DIR is set and
>
> The 'if' got lost again: s/ignored/ignored if/

Argghh.. 'if' hates me, or I hate it. Junio please put it back. I
don't think I should send another 32 mails for one 'if'.
--=20
Duy
