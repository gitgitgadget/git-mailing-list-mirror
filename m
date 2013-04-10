From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 5/7] completion: get rid of compgen
Date: Wed, 10 Apr 2013 06:10:28 -0400
Message-ID: <CAPig+cThNDvHWMq3h1Kh2QKNew0kqbXrfxcS05jrBh+rCLghzA@mail.gmail.com>
References: <1365577077-12648-1-git-send-email-felipe.contreras@gmail.com>
	<1365577077-12648-6-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-1?Q?SZEDER_G=E1bor?= <szeder@ira.uka.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 10 12:10:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPrz8-00006P-FY
	for gcvg-git-2@plane.gmane.org; Wed, 10 Apr 2013 12:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462Ab3DJKKa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 10 Apr 2013 06:10:30 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:59525 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750803Ab3DJKK3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Apr 2013 06:10:29 -0400
Received: by mail-lb0-f173.google.com with SMTP id w20so343214lbh.18
        for <git@vger.kernel.org>; Wed, 10 Apr 2013 03:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pLluIbXUbcZNMBcp7lKJbfvfqSYrDZVFDmbJRtiGkOU=;
        b=JklWX8T1Ar8M5UMktqyFaTK+V9jNT4p/uPza4doecG3k+qjg3SLs8c7MnyGqKFHr82
         OGIM9af/iRquj/QO5bFQwREhX2R/J01Q2qgVQ3FJH6Y7cwqq4bnPJP+LLLJDHwbyYOOv
         MqsjcvbcwIwiRMKca/Mvbsims+pWBoPjHGKYfc3+bit8ltrW30QRsZjdKSBy1zNOTXIY
         TfUUNC4/bAgGB2cZF0cNiACC9mItSaN0sl7oUMsljp0ZG0HgcdQPtzFviJUEphY/p7cU
         SybB6Swwyzuudjbr5dNU/GbY+TqvY9jpJIfXsygujiE/mRJCo6ICpmkz5Id6A1CnaSoN
         Ju9w==
X-Received: by 10.112.132.40 with SMTP id or8mr853440lbb.119.1365588628212;
 Wed, 10 Apr 2013 03:10:28 -0700 (PDT)
Received: by 10.114.174.104 with HTTP; Wed, 10 Apr 2013 03:10:28 -0700 (PDT)
In-Reply-To: <1365577077-12648-6-git-send-email-felipe.contreras@gmail.com>
X-Google-Sender-Auth: ZiMGqh8sMec8k0NGyCiHtn-4bcs
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220676>

On Wed, Apr 10, 2013 at 2:57 AM, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
> The functionality we use from compgen is not much, we can do the same
> manually, with drastical improvements in speed, specially when dealin=
g

s/drastical/drastic/
s/specially/especially/

> with only a few words.
>
> This patch also has the sideffect that brekage reported by Jeroen Mei=
jer

s/sideffect/side effect/
s/brekage/breakage/

> and SZEDER G=E1bor gets fixed because we no longer expand the resulti=
ng
> words.
>
> So, unless 'git checkout <tab>' usually gives you more than 100000
> results, you'll get an improvement :)
>
> Other possible solutions perform better after 1000 words, but worst i=
f

s/worst/worse/

> less than that:
>
>   COMPREPLY=3D($(awk -v cur=3D"$3" -v pre=3D"$2" -v suf=3D"$4"
>         '$0 ~ cur { print pre$0suf }' <<< "$1" ))
>
>   COMPREPLY=3D($(printf -- "$2%s$4\n" $1 | grep "^$2$3"))
>
> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
