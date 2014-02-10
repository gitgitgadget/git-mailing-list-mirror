From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 1/2] daemon: move daemonize() to libgit.a
Date: Tue, 11 Feb 2014 06:25:28 +0700
Message-ID: <CACsJy8Bq046c19T3RNQCvDHp8dA-Si_8k=R230ZHODiVu-1dZw@mail.gmail.com>
References: <xmqqd2j2afup.fsf@gitster.dls.corp.google.com> <1391843332-20583-1-git-send-email-pclouds@gmail.com>
 <xmqqha86st5f.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, chris <jugg@hotmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 11 00:26:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WD0En-0002Hy-3n
	for gcvg-git-2@plane.gmane.org; Tue, 11 Feb 2014 00:26:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752747AbaBJX0A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 10 Feb 2014 18:26:00 -0500
Received: from mail-qa0-f42.google.com ([209.85.216.42]:46358 "EHLO
	mail-qa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752554AbaBJXZ7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Feb 2014 18:25:59 -0500
Received: by mail-qa0-f42.google.com with SMTP id k4so10708959qaq.15
        for <git@vger.kernel.org>; Mon, 10 Feb 2014 15:25:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RF9JWhQcVSdtzP1XRAEmsLK0q8nAfZ7S5Jm+j6PqStY=;
        b=nkmcyb+mr1T/9CNzSiK9veZ12IzSbU3Jbxbsm2NdTOmfoNp68814f5CN5zO/KKWaat
         R23YAGz/2VN82+jjn1ytFjUWjROSES9Aj9AUIrUj01mZw1YPxY0PD1AdIkVTyVrGTkeL
         3wD0oirwIzMIgi74dBnIT2mEWi0K9HQ2QS5xCnNH8nVPJuKbn3xdAQzEGY+RgxQOIZzV
         Hqi+wZiVewcCHj1fLsXqTw9aiFbhnInKavID2fJq44WhbIdCZzuhmtuwYDC5UjnH+AYl
         ZlIKtvl4TSLY82ayLtZnlRGO+P+uEfjuSJs1DhLk0szqRun8LfHZ+LY7plClC5R3nV3Z
         FUug==
X-Received: by 10.140.93.130 with SMTP id d2mr48785054qge.41.1392074758582;
 Mon, 10 Feb 2014 15:25:58 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Mon, 10 Feb 2014 15:25:28 -0800 (PST)
In-Reply-To: <xmqqha86st5f.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241933>

On Tue, Feb 11, 2014 at 1:46 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> diff --git a/setup.c b/setup.c
>> index 6c3f85f..b09a412 100644
>> --- a/setup.c
>> +++ b/setup.c
>> @@ -787,3 +787,27 @@ void sanitize_stdfds(void)
>>       if (fd > 2)
>>               close(fd);
>>  }
>> +
>> +int daemonize(void)
>> +{
>> +#ifdef NO_POSIX_GOODIES
>> +     errno =3D -ENOSYS;
>
> Negated?

=46acepalm. I remember I wrote this somewhere but don't remember what
topic :( Should I resend?
--=20
Duy
