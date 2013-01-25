From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] branch: reject -D/-d without branch name
Date: Fri, 25 Jan 2013 15:56:41 +0700
Message-ID: <CACsJy8AyDKEFG511e70vB7YrwLP4xoWmE34tqazMZA59hs6iHA@mail.gmail.com>
References: <1359102416-1240-1-git-send-email-pclouds@gmail.com> <vpqmwvxhcra.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jan 25 09:57:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tyf6Q-0005pF-9K
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 09:57:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754620Ab3AYI5P convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Jan 2013 03:57:15 -0500
Received: from mail-ob0-f176.google.com ([209.85.214.176]:38158 "EHLO
	mail-ob0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754553Ab3AYI5M convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Jan 2013 03:57:12 -0500
Received: by mail-ob0-f176.google.com with SMTP id v19so118246obq.21
        for <git@vger.kernel.org>; Fri, 25 Jan 2013 00:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=4QYahA5r5M2igzAoz7XpxUL1EVOp2DHzl1e13Lbr+wA=;
        b=FASQun10N5LRWFgc/CWatLVC+ytNDuJgOv13pMC4t5MSSrlGFznvTw7PvW+nBY5xa8
         PwdHtPTQ0+dNdzEZYUL1KbEHlrtSvl0UD2nZbdZniiWbhPSDRtyuNRr99vIa4wPPmHbU
         4GuW9/HhK1W06O940dQVp1mPPSypqU63U/L5XOf5n0pOrUXvCz2LKc+lAC2Bvk3OdL69
         GxkFfUhvEciJF+Fu8iPv5MwA2l977Gpxgudg6+9Bvco24X/VtD0fsmhGKWa3rki2/1tc
         KRpRUkbnI7/k6h2JOthTziadhk7UoHjCTupouKFkv17c9W2UqCFi78TH6CAEbXYZSkom
         JWRA==
X-Received: by 10.60.22.164 with SMTP id e4mr3883755oef.87.1359104231611; Fri,
 25 Jan 2013 00:57:11 -0800 (PST)
Received: by 10.182.153.69 with HTTP; Fri, 25 Jan 2013 00:56:41 -0800 (PST)
In-Reply-To: <vpqmwvxhcra.fsf@grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214517>

On Fri, Jan 25, 2013 at 3:45 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index 873f624..1d3e842 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -837,7 +837,7 @@ int cmd_branch(int argc, const char **argv, cons=
t char *prefix)
>>               colopts =3D 0;
>>       }
>>
>> -     if (delete)
>> +     if (delete && argc)
>>               return delete_branches(argc, argv, delete > 1, kinds, =
quiet);
>>       else if (list) {
>>               int ret =3D print_ref_list(kinds, detached, verbose, a=
bbrev,
>
> Shouldn't this error out with a clean error message ("branch name
> expected" or so)?

Yeah. But on the other hand, this command seems to prefer to print
help usage when incorrect number of arguments is given (checkout
blocks "if (edit_description)" and "if (rename)" in cmd_branch).
Should those be fixed too?
--=20
Duy
