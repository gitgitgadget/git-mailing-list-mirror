From: Marcio Almada <marcio.web2@gmail.com>
Subject: Re: [PATCH] fix global bash variable leak on __gitcompappend
Date: Thu, 9 Apr 2015 10:52:52 -0300
Message-ID: <CAOsHV+tCHrbmapXU+eei7v1jfiwdpK8jT+ue=kb_dm9nDXtq_Q@mail.gmail.com>
References: <1428471958-12339-1-git-send-email-marcio3w@gmail.com>
 <1428471958-12339-2-git-send-email-marcio3w@gmail.com> <xmqqiod6ar9v.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 09 15:53:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YgCtV-0008Hu-Vr
	for gcvg-git-2@plane.gmane.org; Thu, 09 Apr 2015 15:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbbDINxR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 9 Apr 2015 09:53:17 -0400
Received: from mail-ig0-f174.google.com ([209.85.213.174]:36070 "EHLO
	mail-ig0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbbDINxR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Apr 2015 09:53:17 -0400
Received: by igblo3 with SMTP id lo3so66873000igb.1
        for <git@vger.kernel.org>; Thu, 09 Apr 2015 06:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6UxYAk6yLzDssh7klrsp2UptqD2UouToO6cEV+5PPH0=;
        b=UesrhVP32OFHYiEaOzP2bgo5jP5t3P1M1KX8BU44ys518Gn6dUKIqNV6tfbkQssilR
         MUg6sLHOCVf2ayKjvvESroCxWSl0Z5+c6vRvFVgtAbvNqsW2uMy9hpN29q5ATqtlKH73
         B2OhGR6OifYxLDV3OhyIUbBpVbVPEZ4GFHeQiFB3+QeTh8Npr4UTnJp/vSb1DBkgt5AM
         CQytmLfB4F8gJ/R3P4jiju8BNWyLriUmuBW6hybMhz0ekhGYPzKFv9uGciygkvMWXuhy
         a/k1CL3U7+Xu1W+3A60dZEjW5X2M1wNbDjYDvB96OAsAkfQyVKG7pKnjjualCNOQOyM7
         aRmA==
X-Received: by 10.107.40.2 with SMTP id o2mr47784422ioo.68.1428587596210; Thu,
 09 Apr 2015 06:53:16 -0700 (PDT)
Received: by 10.36.93.144 with HTTP; Thu, 9 Apr 2015 06:52:52 -0700 (PDT)
In-Reply-To: <xmqqiod6ar9v.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266996>

2015-04-09 0:56 GMT-03:00 Junio C Hamano <gitster@pobox.com>:
> "M=C3=A1rcio Almada" <marcio.web2@gmail.com> writes:
>
>> ---
>>  contrib/completion/git-completion.bash | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> Nicely found and corrected.  Please sign-off your patch and Cc area
> experts if you can find them (I'll do that this time for you).
>
> Thanks.
>

Ok, I'll remember this next time. Thanks for your incredible work here.

>>
>> diff --git a/contrib/completion/git-completion.bash b/contrib/comple=
tion/git-completion.bash
>> index 661a829..1620546 100644
>> --- a/contrib/completion/git-completion.bash
>> +++ b/contrib/completion/git-completion.bash
>> @@ -186,7 +186,7 @@ fi
>>
>>  __gitcompappend ()
>>  {
>> -     local i=3D${#COMPREPLY[@]}
>> +     local x i=3D${#COMPREPLY[@]}
>>       for x in $1; do
>>               if [[ "$x" =3D=3D "$3"* ]]; then
>>                       COMPREPLY[i++]=3D"$2$x$4"
