From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH 7/7] gitweb: group remote heads
Date: Thu, 16 Sep 2010 10:29:00 +0000
Message-ID: <AANLkTimFjofJo4ByFwr2Cz6-YqkHcZsHGk6r4siEFmDa@mail.gmail.com>
References: <1284629465-14798-1-git-send-email-giuseppe.bilotta@gmail.com>
	<1284629465-14798-8-git-send-email-giuseppe.bilotta@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 16 12:29:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OwBiG-0006XK-Dm
	for gcvg-git-2@lo.gmane.org; Thu, 16 Sep 2010 12:29:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754083Ab0IPK3D convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 16 Sep 2010 06:29:03 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:64445 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733Ab0IPK3B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Sep 2010 06:29:01 -0400
Received: by iwn5 with SMTP id 5so952229iwn.19
        for <git@vger.kernel.org>; Thu, 16 Sep 2010 03:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JjoScZoUrLt8IS0HtFLHbYg5cAcNmY8SCcOsIfKbUMs=;
        b=Zhv1AacicJKisj+ykZrw/Rw1yFvBOg9z9f+TphkmQna8iNbHHCfecvMjr7fN4A83Cr
         4NdI6BhPeBUi0dJBsXwSgQPEzYJZlOm/wMoIwSQPpu05r4tBypSL4qCpM1X0lhr8BgRU
         fqAQDy74rZ9AuhRbGL7fxuA2jKBjAAVt0IlCc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Roo9YUt4w+2ztvse3T2iwZ4tQWnrprVBKUOLC/roSELJWVELNwrYNoT1wRHS2/BDDb
         hQN01/G6u+eeMbkUEbYqytVCvwGUBf48AxRE94XyOc7qvGKCZ6frmNphrH3WUnEjaCwI
         feFxOEH8EZB8RjCJ6x4DjERLG4/6EQCgRuSzg=
Received: by 10.231.157.207 with SMTP id c15mr3234956ibx.143.1284632940916;
 Thu, 16 Sep 2010 03:29:00 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Thu, 16 Sep 2010 03:29:00 -0700 (PDT)
In-Reply-To: <1284629465-14798-8-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156313>

On Thu, Sep 16, 2010 at 09:31, Giuseppe Bilotta
<giuseppe.bilotta@gmail.com> wrote:

> +sub git_get_remotes {
> + =C2=A0 =C2=A0 =C2=A0 my ($limit) =3D @_;
> + =C2=A0 =C2=A0 =C2=A0 open my $fd, '-|' , git_cmd(), 'remote';
> + =C2=A0 =C2=A0 =C2=A0 return () unless $fd;
> + =C2=A0 =C2=A0 =C2=A0 my @remotes =3D map { chomp ; $_ } <$fd>;
> + =C2=A0 =C2=A0 =C2=A0 close $fd or return ();

    return unless $fd;
    chomp(my @remotes =3D <$fd>);
    close $fd or return;
