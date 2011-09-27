From: Andrew Ardill <andrew.ardill@gmail.com>
Subject: Re: [PATCH] git-submodule: a small fix
Date: Tue, 27 Sep 2011 13:22:32 +1000
Message-ID: <CAH5451k-6HHx2xxddJauE8=P1umjG=TnrcOKmQfeh=4GOzpCKQ@mail.gmail.com>
References: <CAOOg04z0UjOQCBMTuii37y3ykNU17hDTcD9E81C+r1whFpMaCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Roy Liu <carsomyr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 05:27:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8OK9-0000Ri-80
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 05:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472Ab1I0D1H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Sep 2011 23:27:07 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63668 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098Ab1I0D1G convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Sep 2011 23:27:06 -0400
Received: by fxe4 with SMTP id 4so6698176fxe.19
        for <git@vger.kernel.org>; Mon, 26 Sep 2011 20:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=RuLEosTG2B/sW66nFuPg71DhYoXPRHswLeg5wkzU94E=;
        b=qmeuPpRO5PqBLkwZZpKpFZVDSQC/VAzEVESp5HRp/8pJF1sYKhAi0MhdrIBs2dL7dK
         hleeIB5cMRM5fESIoLpao3gq7CJY/69cXCrQngrZeRlUjzGOFegWXlmcsCfgFixc98hK
         LViGeCeih1KiQn9N4MQiJ//vAlVSlRyuRTVKY=
Received: by 10.223.95.148 with SMTP id d20mr896677fan.59.1317093772653; Mon,
 26 Sep 2011 20:22:52 -0700 (PDT)
Received: by 10.152.37.66 with HTTP; Mon, 26 Sep 2011 20:22:32 -0700 (PDT)
In-Reply-To: <CAOOg04z0UjOQCBMTuii37y3ykNU17hDTcD9E81C+r1whFpMaCg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182207>

On 27 September 2011 08:00, Roy Liu <carsomyr@gmail.com> wrote:
> In git-submodule.sh, the "url" variable may contain a stale value fro=
m
> the previous loop iteration, so clear it.
>
> --- git-submodule.sh.orig =C2=A0 2011-09-26 17:50:45.000000000 -0400
> +++ git-submodule.sh =C2=A0 =C2=A02011-09-26 17:51:18.000000000 -0400
> @@ -370,6 +370,8 @@
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0esac
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0git config submodule."$name"=
=2Eurl "$url" ||
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0die "Failed to register url =
for submodule path '$path'"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0else
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0url=3D""
> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0# Copy "update" setting when it is not set=
 yet

Perhaps a better commit description would be:

git-submodule: clear the url variable when not set to avoid using stale=
 values

otherwise looks clean enough

Andrew
