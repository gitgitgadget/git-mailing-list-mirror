From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [RFC/PATCH 02/11] ref-filter: add 'colornext' atom
Date: Wed, 29 Jul 2015 21:27:43 -0700
Message-ID: <CA+P7+xpYg4wsJW8JOGHMsDohCUvcD=X-34wcGGvEQM8mEK3dbg@mail.gmail.com>
References: <CAOLa=ZT3_DMJWFN62cbF19uxYBFsE69dGaFR=af1HPKsQ42otg@mail.gmail.com>
 <1438066594-5620-1-git-send-email-Karthik.188@gmail.com> <1438066594-5620-2-git-send-email-Karthik.188@gmail.com>
 <CAPig+cTb3U2AHjr4wmQGezqHOED3zyYHPG54BjdCZObt=7Mu3w@mail.gmail.com> <vpqtwsmd53f.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	"christian.couder@gmail.com" <christian.couder@gmail.com>,
	"gitster@pobox.com" <gitster@pobox.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Jul 30 06:28:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZKfRy-0002mS-IH
	for gcvg-git-2@plane.gmane.org; Thu, 30 Jul 2015 06:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160AbbG3E2F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jul 2015 00:28:05 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33292 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750882AbbG3E2E (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jul 2015 00:28:04 -0400
Received: by igbpg9 with SMTP id pg9so3453673igb.0
        for <git@vger.kernel.org>; Wed, 29 Jul 2015 21:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=h7Gu/r63TGIzOfDlO5xDrE8IejVXCFMbmepPymmwPcM=;
        b=KN0AVp7KFiiR5M2Ku9gz64PeWJe9luSw63AIFpllb971lq7DFEBBttDeRk6Ydt2csN
         V7f6KLiVSxMwaQlQ5lkaJqI/sujqh8K1vmQVAY51vdzDx/JINuQE1WD40IVntfz40fif
         8Jjw4RznNFocGa3OIPoGLgbmg7vXV0qEbIXOHyUQ23y2QsegbjdpkqL3Gsk/FJ4yvoxy
         Ad1VZK4TGu4SmoPJYXhlJlro1beExhLkUaUMXfo8Si0DnsVg+Dupn3eytRI1t8Z8PFyh
         9PCmjjF9SuWm/Aqn7bjW+RJnj2Xe4fuiqb9tL1RC4mP2VFMUQ3dnhmmx0hNId8Ei4dCl
         1vGg==
X-Received: by 10.50.124.97 with SMTP id mh1mr1799261igb.92.1438230483091;
 Wed, 29 Jul 2015 21:28:03 -0700 (PDT)
Received: by 10.107.5.203 with HTTP; Wed, 29 Jul 2015 21:27:43 -0700 (PDT)
In-Reply-To: <vpqtwsmd53f.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274967>

On Wed, Jul 29, 2015 at 2:30 PM, Matthieu Moy
<Matthieu.Moy@grenoble-inp.fr> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>> Also, please explain here and in the commit message why this highly
>> specialized colorizer ('colornext'), is needed even though a more
>> general purpose one ('color') is already available.
>
> It is needed in the current form to allow
> %(colornext:blue)%(ifexists:[%s]) to color only the replacement of %s
> and not the [].
>
> But I now think that this would be more elegantly solved by Junio's
> %(if) %(endif) idea:
>
>   %(if:atom) [ %(color:blue)%(atom)%(color:reset) ] %(endif)
>
> (I added spaces for clarity)
>

I agree, this style seems a lot more elegant and expressive while much
easier to understand. Same for doing this to the alignment atoms and
such as it solves the same problem(s) there.

I can't speak to how easy it is to implement tho.

Regards,
Jake
