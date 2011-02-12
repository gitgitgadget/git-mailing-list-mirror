From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v3] Porcelain scripts: Rewrite cryptic "needs update"
 error message
Date: Sun, 13 Feb 2011 00:14:22 +0100
Message-ID: <AANLkTikuQdJykM7MUV=C5DR7HO5xseBifrY_w2ZWsCiR@mail.gmail.com>
References: <8835ADF9-45E5-4A26-9F7F-A72ECC065BB2@gmail.com>
	<1287499168-26569-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Joshua Jensen <jjensen@workspacewhiz.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Thore Husfeldt <thore.husfeldt@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 13 00:14:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PoOfd-0008N1-P9
	for gcvg-git-2@lo.gmane.org; Sun, 13 Feb 2011 00:14:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965Ab1BLXOZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 12 Feb 2011 18:14:25 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:51846 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752103Ab1BLXOY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Feb 2011 18:14:24 -0500
Received: by bwz15 with SMTP id 15so4382736bwz.19
        for <git@vger.kernel.org>; Sat, 12 Feb 2011 15:14:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kNl+nVJCZLSMjzyQAhR74xUB5cmcrYaY8nrqQV6by1w=;
        b=r8Ez8KCd99OiAJJp1Xg7VFLFF6xOuQG4nCuFnKL+CXI6/ripiChHbEmS0cr4/covsg
         yA0rsUsO89LwBHD5poTrTkEFDklPehxm545UAftQ70mWz7TkkvoUKXEw+mBUacNPHP/h
         GrwIcOJv07CYhWopvuw5gtzuMPFWctidCrgWs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bqeOW+id5AAjvrzzSa5ijU8aVV9c8L98RIfhZlliLeT5C6L9GoOmTGxcb8RdX7v2OT
         4E1Yb2sQf3mO2UPnWHJVsVmyO6RT/PQhQ4X0ViHCQrNOMaQlGvfWCKRRq0aGwRZrNn0S
         jFOXX5DgYDzdcUfm9cNGY/HTdtnASeh8r7Z5g=
Received: by 10.204.14.14 with SMTP id e14mr1911657bka.4.1297552462757; Sat,
 12 Feb 2011 15:14:22 -0800 (PST)
Received: by 10.204.52.135 with HTTP; Sat, 12 Feb 2011 15:14:22 -0800 (PST)
In-Reply-To: <1287499168-26569-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166630>

On Tue, Oct 19, 2010 at 16:39, Ramkumar Ramachandra <artagnon@gmail.com=
> wrote:

> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git update-index -=
-ignore-submodules --refresh &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git diff-files --i=
gnore-submodules --quiet &&
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 git diff-index --i=
gnore-submodules --cached --quiet HEAD -- ||
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 die "refusing to p=
ull with rebase: your working tree is not up-to-date"
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 require_clean_work=
_tree "pull with rebase" "Please commit or stash them."

Doing this sort of thing is basically incompatible with doing
i18n. I'll work around this when rebasing the ab/i18n series, but in
the long term we shouldn't be doing stuff like this.
