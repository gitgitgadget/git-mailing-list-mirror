From: Antoine Pelisse <apelisse@gmail.com>
Subject: Re: [PATCH 1/8] remote-bzr: fix export of utf-8 authors
Date: Wed, 28 Aug 2013 22:54:41 +0200
Message-ID: <CALWbr2xi1+EKHry4GRwLv=SwRUsaTKLQc6RUfuPKEre4pcpaFg@mail.gmail.com>
References: <1377717793-27170-1-git-send-email-felipe.contreras@gmail.com>
	<1377717793-27170-2-git-send-email-felipe.contreras@gmail.com>
	<vpqhae97f8j.fsf@anie.imag.fr>
	<CAMP44s2bu9gUE=McYq1prhjC3O2CRj1W_Yc+-CjTkk6Gc3JFTw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 28 22:54:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEmlM-00022E-1Q
	for gcvg-git-2@plane.gmane.org; Wed, 28 Aug 2013 22:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754146Ab3H1Uyn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 Aug 2013 16:54:43 -0400
Received: from mail-qe0-f52.google.com ([209.85.128.52]:65230 "EHLO
	mail-qe0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476Ab3H1Uym convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 28 Aug 2013 16:54:42 -0400
Received: by mail-qe0-f52.google.com with SMTP id a11so3771713qen.39
        for <git@vger.kernel.org>; Wed, 28 Aug 2013 13:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=kn9LMLt6MWyXNELEn57emW/mC9U1ncNLJ1DltEAXH4Q=;
        b=cGq00pflgHVBioJD3KyBsf7TlYK6bhjkKYWTa+JJ8xtj671lFYlKxL8nq7dp9oRp9V
         mOWXptgqrxrMbRK9VCtYl29XoU5sriMcKxioFy2uPled9kQ9Pxy//Ah9abDHPmfvdOnv
         GyfiaJTQCmCrlE1NY/yXzjCuklY13e2VNbJei6fggbph4ZlqklrwIZpyL02wsDiZOav9
         w0kLrvfUXdNnj8vk5dYrjs45adKplU195PGbkQOkl8a5ATl/LcTMqzyLfe35KtDc7qDk
         1562cEEyEGcKnHzRdOR0ZiPdu97JQA1IhaQm47azWhikogw9pj58P33sz2szfzZR53bC
         afPA==
X-Received: by 10.224.121.3 with SMTP id f3mr682355qar.47.1377723281234; Wed,
 28 Aug 2013 13:54:41 -0700 (PDT)
Received: by 10.49.104.211 with HTTP; Wed, 28 Aug 2013 13:54:41 -0700 (PDT)
In-Reply-To: <CAMP44s2bu9gUE=McYq1prhjC3O2CRj1W_Yc+-CjTkk6Gc3JFTw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233212>

On Wed, Aug 28, 2013 at 10:48 PM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> On Wed, Aug 28, 2013 at 3:05 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> +     echo greg >> content &&
>>> +     git add content &&
>>> +     git commit -m one
>>
>> test_commit would make it shorter.
>
> And it would make it inconsistent with the rest of the script.
>
>>> +     bzr log | grep "^committer: " > ../actual
>>> +     ) &&
>>> +
>>> +     echo "committer: Gr=C3=A9goire <committer@example.com>" > exp=
ected &&
>>
>> Git's source code usually says >../actual and >expected, without spa=
ce
>> after '>'.
>
> Not that usually:
>
> % git grep ' > ' t/*.sh | wc -l
> 1943

There are many false positive in that count.

As in this one:
$ git grep ' >[^ ]' -- t/*.sh | wc -l
10354
