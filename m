From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] completion: split __git_ps1 into a separate script
Date: Wed, 23 May 2012 13:59:10 +0200
Message-ID: <CAMP44s2DAFjtZY_s_h0GEMmDwwxApR1pwXVnfPP8S5bmauDkhQ@mail.gmail.com>
References: <1337719600-7361-1-git-send-email-felipe.contreras@gmail.com>
	<1337719600-7361-3-git-send-email-felipe.contreras@gmail.com>
	<4FBC0019.6030702@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Pavlic <ted@tedpavlic.com>,
	Thomas Rast <trast@student.ethz.ch>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Kerrick Staley <mail@kerrickstaley.com>,
	Marius Storm-Olsen <mstormo@gmail.com>,
	=?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>,
	Dan McGee <dan@archlinux.org>
To: =?UTF-8?Q?Zbigniew_J=C4=99drzejewski=2DSzmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Wed May 23 13:59:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXADk-0002u9-Mp
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 13:59:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932537Ab2EWL7M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 07:59:12 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:40050 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932473Ab2EWL7L convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 May 2012 07:59:11 -0400
Received: by lbbgm6 with SMTP id gm6so4996648lbb.19
        for <git@vger.kernel.org>; Wed, 23 May 2012 04:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=49TSigG2rG8a89ba9F/RQiRA4Qt3WbKFXcC2h8nitro=;
        b=DxJKvSXXy7bgsi5VPi+H6x7gWPpn+SQ05GHNU1z2d4xrC13MmlvVGz/h/8VvviEPBT
         BgUpoSVo/afrNt2veKpdhlrO98DWgJrMwNXy8y1PFtoieUsxhA7HYOGpPXm6HaRLNAUA
         lzN/3ivIz16ZPlr6vScDHQMI0J7mL9y7rvK0ah0280JjQ8W9GG2gAiv0ILQ0X2GBomu6
         ejryRezDTU5v63eFgXPi9LRFuGYnwrx5LSygVfwyAhhwI6esOzNvffJ5HdXyWK9Ep37o
         qAcrW/IswZhoqQvpgXaY8pv2JDkX3hTJXsML30TNL0gOpjxwWZQWU5wMsT7cSYTivz+i
         peCQ==
Received: by 10.152.112.138 with SMTP id iq10mr11497078lab.13.1337774350048;
 Wed, 23 May 2012 04:59:10 -0700 (PDT)
Received: by 10.112.107.65 with HTTP; Wed, 23 May 2012 04:59:10 -0700 (PDT)
In-Reply-To: <4FBC0019.6030702@in.waw.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198282>

On Tue, May 22, 2012 at 11:07 PM, Zbigniew J=C4=99drzejewski-Szmek
<zbyszek@in.waw.pl> wrote:
> On 05/22/2012 10:46 PM, Felipe Contreras wrote:
>> =C2=A0contrib/completion/git-completion.bash | =C2=A0257 +----------=
-----------------
>> =C2=A0contrib/completion/git-prompt.sh =C2=A0 =C2=A0 =C2=A0 | =C2=A0=
287 ++++++++++++++++++++++++++++++++
>> =C2=A0t/t9903-bash-prompt.sh =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 | =C2=A0 =C2=A02 +-
>> =C2=A03 files changed, 290 insertions(+), 256 deletions(-)
>> =C2=A0create mode 100644 contrib/completion/git-prompt.sh

> since git-prompt is not completion related anymore, should a differen=
t
> directory be used?

That's a good point. I personally wouldn't worry too much about this
until there's a real issue. If we were to fix this, I would rather
have a 'shell' sub-directory and move everything there; I think have a
sub-directory for 'completion' and another for 'prompt' would be
overkill.

Unfortunately this would mean packagers need to update.

Cheers.

--=20
=46elipe Contreras
