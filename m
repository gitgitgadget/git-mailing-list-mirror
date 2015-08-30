From: Luke Diamand <luke@diamand.org>
Subject: Re: [RFC PATCH] git-p4: add option to store files in Git LFS on import
Date: Sun, 30 Aug 2015 17:36:42 +0100
Message-ID: <CAE5ih7-w5ZjO=QUE45yBvwyqdqKCADczrLt7=4W8X6BR+cy4PA@mail.gmail.com>
References: <1440764691-62254-1-git-send-email-larsxschneider@gmail.com>
	<CAE5ih7-TfLqwye8YpmZz90AVjYGQ8m0sF6GLKnG9pjvV8cTSjw@mail.gmail.com>
	<9951C805-DFBF-47AC-B215-B9C657D4A852@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Users <git@vger.kernel.org>,
	Rick Olson <technoweenie@github.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 30 18:36:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZW5b6-0007rd-GL
	for gcvg-git-2@plane.gmane.org; Sun, 30 Aug 2015 18:36:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbbH3Qgo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 Aug 2015 12:36:44 -0400
Received: from mail-oi0-f46.google.com ([209.85.218.46]:33813 "EHLO
	mail-oi0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753449AbbH3Qgn convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 30 Aug 2015 12:36:43 -0400
Received: by oiex83 with SMTP id x83so53311355oie.1
        for <git@vger.kernel.org>; Sun, 30 Aug 2015 09:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=aRHFU4zY7bUMVwlitHEen7L5bPqPmlIEgB19EiWKe34=;
        b=MfJ6rZfDICDvcUgDoR6BAhYXXWrAfJCHljX7l1YgRs2tgDYl08uwzCYocsVfclIakA
         pvI+K+KqOJbDRxU4WmNQ3QQ7OyfPT2AI8qFE9lrA1VX7HH033BG5uzPV2NosFg7oFg3d
         2zxvI7a83S1d26Urw0UIeYcS245u+Us/2aGzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=aRHFU4zY7bUMVwlitHEen7L5bPqPmlIEgB19EiWKe34=;
        b=AgRMZil93K+ybfwTTLNGuSQrPS0I5/nkt1a45tN2UBgaQm+nfOkxfTJAGFzG59BjvK
         bsw4KH/uUsvcTHDXOknQrO/JGifMoMhXv2ZnjuJ2ec4b3Ox9GyschwvH4fz1CJWX3rix
         nbQDeCWCw3GdbQUCCWL29ncm5vzKGTtbUCvXFKEQTwwkHcLEiIGMKBvFOoVwb11t6aRl
         jk2FrIYxdIhvHnUbEaZangG0j0PBUcJ/CVsp3MB3mk7x74ktPz6xKtjE+8k/vP4lTcdd
         UiUo1+5y7VKfSm7cVkGVvPB5dDBxhzKRkrX+dMH+tXs+k2kUkbRhRo8EbH27RFvbXVx8
         DX9A==
X-Gm-Message-State: ALoCoQmXBKeV5tnuO2Xya4JHeELeDSI+2xcYQAmYzQvp76jTnlFohX6diIDLmk5hRrMpYx4VYHdN
X-Received: by 10.202.198.139 with SMTP id w133mr4211502oif.72.1440952603048;
 Sun, 30 Aug 2015 09:36:43 -0700 (PDT)
Received: by 10.60.46.38 with HTTP; Sun, 30 Aug 2015 09:36:42 -0700 (PDT)
In-Reply-To: <9951C805-DFBF-47AC-B215-B9C657D4A852@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276822>

On 30 August 2015 at 11:18, Lars Schneider <larsxschneider@gmail.com> w=
rote:
> Thanks for your feedback!
>
> I like the =E2=80=9Chandle big files=E2=80=9D plugin kind of idea. Ho=
wever, I wonder if it makes sense to put more and more stuff into git-p=
4.py (>3000 LOC already). What do you think about splitting git-p4 into=
 multiple files?

I was wondering about that. I think for now, the simplicity of keeping
everything in one file is worth the slight extra pain. I don't imagine
that the big-file-handler code would be very large.

>
> Regarding Python 3:
> Would you drop Python 2 support or do you want to support Python 2/3 =
in parallel? I would prefer the former=E2=80=A6

=46or quite some time we would need to support both; we can't just have
a release of git that one day breaks git-p4 for people stuck on Python
2. But it might not be that hard to support both (though converting
all those print statements could be quite tiresome).
