From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH] MSVC: Enable OpenSSL, and translate -lcrypto
Date: Sat, 3 Oct 2009 13:05:36 -0700
Message-ID: <40aa078e0910031305u38cfaf4aua72d4c7af2a470b2@mail.gmail.com>
References: <18cd41840910031300i32c74b15t74eb9eee23ff8469@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Cc: git@vger.kernel.org, msysgit@googlegroups.com
To: Marius Storm-Olsen <mstormo@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Sat Oct 03 22:05:54 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-vw0-f159.google.com ([209.85.212.159])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MuArZ-0007vu-QE
	for gcvm-msysgit@m.gmane.org; Sat, 03 Oct 2009 22:05:54 +0200
Received: by vws31 with SMTP id 31so3643659vws.21
        for <gcvm-msysgit@m.gmane.org>; Sat, 03 Oct 2009 13:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        bh=2Zwa2o25tYHEGghEHpDT87FXDXulu0wHvl+RdWRgsWw=;
        b=iUIPCITSo1CcgzlW5URgSMyVw3kvSqx3uG9SCE+QJUo6AfcyN1jtYp22OELBI+x9hK
         cCeQX0/rlbnnmTtca60e6Y6lwrgwyg96l+cV2JNsOMvwQ3uMa+VyoijqzXnJXLzYO3P2
         o/m+8d6npzo0QEYwK74dXNFyaUFLuZWv/dwnA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:mime-version:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding:sender:precedence:x-google-loop
         :mailing-list:list-id:list-post:list-help:list-unsubscribe
         :x-beenthere-env:x-beenthere;
        b=JrtRo/Ph76C/0k2121qMyrcEaPsTVt0u1PNJDoqyln5Y8UnRpAf4KiWQVD4jyDhgJ3
         51IE+YOBpsq0iIjFc8KvaD/WVRKKDCbgEQLqmFYShQ+4gMFVfQyOkZmdW1MhUAI9RVVS
         9f8G5ex4EagJ5KTpjvVm9UXadqTHr8ggvXdM4=
Received: by 10.220.69.232 with SMTP id a40mr335314vcj.22.1254600346369;
        Sat, 03 Oct 2009 13:05:46 -0700 (PDT)
Received: by 10.176.233.14 with SMTP id f14gr7245yqh.0;
	Sat, 03 Oct 2009 13:05:39 -0700 (PDT)
X-Sender: kusmabite@googlemail.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.204.48.140 with SMTP id r12mr119739bkf.28.1254600338070; Sat, 03 Oct 2009 13:05:38 -0700 (PDT)
Received: by 10.204.48.140 with SMTP id r12mr119738bkf.28.1254600338032; Sat, 03 Oct 2009 13:05:38 -0700 (PDT)
Received: from mail-bw0-f225.google.com (mail-bw0-f225.google.com [209.85.218.225]) by gmr-mx.google.com with ESMTP id 15si388991bwz.6.2009.10.03.13.05.36; Sat, 03 Oct 2009 13:05:37 -0700 (PDT)
Received-SPF: pass (google.com: domain of kusmabite@googlemail.com designates 209.85.218.225 as permitted sender) client-ip=209.85.218.225;
Authentication-Results: gmr-mx.google.com; spf=pass (google.com: domain of kusmabite@googlemail.com designates 209.85.218.225 as permitted sender) smtp.mail=kusmabite@googlemail.com; dkim=pass (test mode) header.i=@googlemail.com
Received: by mail-bw0-f225.google.com with SMTP id 25so6370870bwz.32 for <msysgit@googlegroups.com>; Sat, 03 Oct 2009 13:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=googlemail.com; s=gamma; h=domainkey-signature:mime-version:received:in-reply-to:references :date:message-id:subject:from:to:cc:content-type :content-transfer-encoding; bh=nDrzzrPzuFHstn7OLhd74YuGa1hu5az3LCeY/lv1IxI=; b=cGPLobzYM6XCS0UHu54xi/ErG23hUKkWE1bH7nmDWasRRgewL43Yhf7aSo4O1tfHMz 20ihl1wQnvYV8S3W4pjy2f4a+92VLatrytB32Hj7oQvYI9qqavVDGRSb4OfAi2Zkwz/s Yjfx8mI+mPuNJ1dj/UFKFim5pSaqeHrbaLd/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=googlemail.com; s=gamma; h=mime-version:in-reply-to:references:date:message-id:subject:from:to :cc:content-type:content-transfer-encoding; b=dQhd6EPP1gVWBQSqDCVFC3NdVIBzPGHIKQLrtyx9+El/Flce8UNyb20c8NbVAbQtAG 1Kt90HvWvQlRPsU7w9vD91KHh8yPofkLxZOFkxITpIoPzLpJDs4UkOVqjfg4qk/1tJAi /i2P0N4iLpYA4ag7iOVcqs/tLr3nYjJF8+gEE=
Received: by 10.204.13.204 with SMTP id d12mr2423496bka.61.1254600336922; Sat,  03 Oct 2009 13:05:36 -0700 (PDT)
In-Reply-To: <18cd41840910031300i32c74b15t74eb9eee23ff8469@mail.gmail.com>
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129497>


On Sat, Oct 3, 2009 at 1:00 PM, Marius Storm-Olsen <mstormo@gmail.com> wrot=
e:
> =A0This patch was actually sent using the MSVC
> =A0git-imap-send.exe to my GMail account.
> =A0 D:\msvc\git>cat
> 0001-MSVC-Enable-OpenSSL-and-translate-lcrypto.patch |
> git-imap-send.exe
> =A0 Resolving imap.gmail.com... ok
> =A0 Connecting to 74.125.79.109:993... ok
> =A0 Logging in...
> =A0 sending 1 message
> =A0 100% (1/1) done
> =A0:)

Awesome :)

> diff --git a/Makefile b/Makefile
> index 8818f0f..c4b91d8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -881,7 +881,6 @@ ifdef MSVC
> =A0 =A0 =A0 =A0GIT_VERSION :=3D $(GIT_VERSION).MSVC
> =A0 =A0 =A0 =A0pathsep =3D ;
> =A0 =A0 =A0 =A0NO_PREAD =3D YesPlease
> - =A0 =A0 =A0 NO_OPENSSL =3D YesPlease
> =A0 =A0 =A0 =A0NO_LIBGEN_H =3D YesPlease
> =A0 =A0 =A0 =A0NO_SYMLINK_HEAD =3D YesPlease
> =A0 =A0 =A0 =A0NO_IPV6 =3D YesPlease

Didn't my 7/7 already do this hunk?

--=20
Erik "kusma" Faye-Lund
kusmabite@gmail.com
(+47) 986 59 656
