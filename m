From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/2] i18n: assure command not corrupted by _() process
Date: Tue, 11 Mar 2014 18:40:54 +0700
Message-ID: <CACsJy8DvuuiKXB4XUACJzhoibL8Hmk-3_GNxh9t1OF412b97vw@mail.gmail.com>
References: <1393620766-17582-1-git-send-email-sandy.carter@savoirfairelinux.com>
 <1393858554-4392-1-git-send-email-sandy.carter@savoirfairelinux.com>
 <1393858554-4392-2-git-send-email-sandy.carter@savoirfairelinux.com> <531DB549.5060304@savoirfairelinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, jn.avila@free.fr,
	Junio C Hamano <gitster@pobox.com>
To: Sandy Carter <sandy.carter@savoirfairelinux.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 12:41:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNL3q-0006c9-IU
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 12:41:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbaCKLl0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Mar 2014 07:41:26 -0400
Received: from mail-qc0-f182.google.com ([209.85.216.182]:56168 "EHLO
	mail-qc0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbaCKLlZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Mar 2014 07:41:25 -0400
Received: by mail-qc0-f182.google.com with SMTP id e16so9374632qcx.13
        for <git@vger.kernel.org>; Tue, 11 Mar 2014 04:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ZI8TaMzCyIgLt3ISajdSE0oEuxhntaH04WDMmBSzUAw=;
        b=Azw2/712ZXD/eIwyRx0cZG3aCGa0BerlljERQgOsSxxCNBBj71VIPyeCTLJfqiOc+F
         DcA9RfgdoipoU01dgf0PaoqfbRzSn2RBJBLui/Q3H0ZUSbbVAgY0TvVKHv31j3wDcVJV
         rZ06FUyZsgNO+ozYNmWnmSxmvgsIBkdZuwHUoip+J99hY3Y09TVDkq1JuKp2ercNiaNK
         BttIlSIYIzw6aAO8EUx5fgENzl6Tpb05p725tm9kQPEcG/sIcCaSfm9ZBN7CXdeNrOE2
         vNrDasGLBYKQpB+rVi8dw5kkp5bU8whlJG4pnxmoU0rWMFRnBC8wIm1Lf6gDTIaY3atX
         zEnw==
X-Received: by 10.140.84.40 with SMTP id k37mr1394564qgd.98.1394538084767;
 Tue, 11 Mar 2014 04:41:24 -0700 (PDT)
Received: by 10.96.215.102 with HTTP; Tue, 11 Mar 2014 04:40:54 -0700 (PDT)
In-Reply-To: <531DB549.5060304@savoirfairelinux.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243858>

On Mon, Mar 10, 2014 at 7:51 PM, Sandy Carter
<sandy.carter@savoirfairelinux.com> wrote:
> Is there any update on this patch?

The patch looks good. Maybe Junio missed it.

>
> Le 2014-03-03 09:55, Sandy Carter a =C3=A9crit :
>
>> Separate message from command examples to avoid translation issues
>> such as a dash being omitted in a translation.
>>
>> Signed-off-by: Sandy Carter <sandy.carter@savoirfairelinux.com>
>> ---
>>   builtin/branch.c | 10 ++++++----
>>   1 file changed, 6 insertions(+), 4 deletions(-)
>>
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index b4d7716..b304da8 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -1022,11 +1022,13 @@ int cmd_branch(int argc, const char **argv, =
const
>> char *prefix)
>>                  */
>>                 if (argc =3D=3D 1 && track =3D=3D BRANCH_TRACK_OVERR=
IDE &&
>>                     !branch_existed && remote_tracking) {
>> -                       fprintf(stderr, _("\nIf you wanted to make '=
%s'
>> track '%s', do this:\n\n"), head, branch->name);
>> -                       fprintf(stderr, _("    git branch -d %s\n"),
>> branch->name);
>> -                       fprintf(stderr, _("    git branch
>> --set-upstream-to %s\n"), branch->name);
>> +                       fprintf(stderr, "\n");
>> +                       fprintf(stderr, _("If you wanted to make '%s=
'
>> track '%s', do this:"), head, branch->name);
>> +                       fprintf(stderr, "\n\n");
>> +                       fprintf(stderr, "    git branch -d %s\n",
>> branch->name);
>> +                       fprintf(stderr, "    git branch --set-upstre=
am-to
>> %s\n", branch->name);
>> +                       fprintf(stderr, "\n");
>>                 }
>> -
>>         } else
>>                 usage_with_options(builtin_branch_usage, options);
>>
>>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
Duy
