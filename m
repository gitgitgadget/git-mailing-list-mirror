From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2] trailer: load config to handle core.commentChar
Date: Thu, 28 Apr 2016 23:06:36 +0200
Message-ID: <CAP8UFD20p7D3J05xKpYDviXxV8EZvLFhESMDhrmCPaT=bsRcDA@mail.gmail.com>
References: <1461873658-11394-1-git-send-email-rafalklys@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Rafal Klys <rafalklys@wp.pl>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:06:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avt90-00080n-Ei
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 23:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753265AbcD1VGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 17:06:38 -0400
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36902 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753070AbcD1VGh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 17:06:37 -0400
Received: by mail-wm0-f53.google.com with SMTP id a17so5959033wme.0
        for <git@vger.kernel.org>; Thu, 28 Apr 2016 14:06:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=G7jOpt3S+mF1ZnNdaOkaxQ8xF1v91TcjAgmiBpWsuko=;
        b=LXLUIst7qzLBLjOusOHe6dRR1wx2O6ve2akO36iYwv3nFeHEoIqFVW9yXqC97n+C1O
         EuGT2hv4CD/zIMP1Fs5HsLIDYBOYhiQz+2mms8czn3aDbkIZumNqvpPRi/prPIcpe1QK
         Sb8e4kXyCHgXZB7UJz8TBY36g6MZpJRsOthzR69H2HonJCVpoPdpwfnJ7oCqv7VI+1hH
         oA7pSbnD+X1wzh1WJLgxSo2FsQQFFhjJixGIPuEnaY8o/3JXL2LNLO0KFdZ7mEcsOWxV
         /fTb4ns3E3q7DEPWifvyAGeN+U9FScnwQbrMSYyJ200iHgR/neVDorfaq9Ce8KmKJ6OF
         VicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=G7jOpt3S+mF1ZnNdaOkaxQ8xF1v91TcjAgmiBpWsuko=;
        b=lJFOejCXR73zMj8/Bbp8xuDVhn61MVo9MOgh+Awvn5HIA+VGAXUDMofbzW4ZyXk9jZ
         FBCEn3rxSaLUYaoM3yWH2Y0ZLeQz/rYgvtVgKXCS/ic3vHfk3YIYPC89g3lATL20F7TU
         ZW2SwXQ7Ybu1oSJYRWBGDJ5aYHRSi0YIaUmX/HHpUD2ouYjP6rAvDkLcULW9CJzCZ80P
         /Nvd7Pz3aAkgPeNnwbOht1qU8UIZKC8oyoNh2gaCHYmFZkLRugas7oSw4HLu/rCrbJAM
         +DDo13dYEe/FPP1SzH0yoI3tThrOQ5FV5eRtziv6t/TABLaPzHR/EJ6U2Udd72JJP8g6
         MSlA==
X-Gm-Message-State: AOPr4FUu0sy2glfPxzFc4nCJk4LyJqzY7ExGoyhr/6kY/bTyt9MVfHJ4NVW0kbo/OT/PZSdwOtZP91RJttN/xg==
X-Received: by 10.28.169.11 with SMTP id s11mr34203wme.62.1461877596506; Thu,
 28 Apr 2016 14:06:36 -0700 (PDT)
Received: by 10.194.95.129 with HTTP; Thu, 28 Apr 2016 14:06:36 -0700 (PDT)
In-Reply-To: <1461873658-11394-1-git-send-email-rafalklys@wp.pl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292953>

On Thu, Apr 28, 2016 at 10:00 PM, Rafal Klys <rafalklys@wp.pl> wrote:
> Fall throught git_default_config when reading config to update the
> comment_line_char from default '#' to possible different value set in
> core.commentChar.
>
> Signed-off-by: Rafal Klys <rafalklys@wp.pl>
> ---
>
> Added fallthru instead of reading config third time.
>
> Added test, updated commit message.
>
> I even tried to change that to only one pass, but looks like it would require a
> bit more coding, so maybe next time.
>
> Thanks for feedback, I'm impressed that contributing to Git is so easy for
> newbies (never sent a patch via email before!) and that the response is so
> quick.

Thanks for contributing great patches and for the kind words!
I am also happy that you find it easy for newbies to contribute.
