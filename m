From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] t3700: note a .gitignore matching fault
Date: Mon, 2 May 2011 22:52:37 +0700
Message-ID: <BANLkTik=GYXUOeo3hA5yyXfOuBydT40koA@mail.gmail.com>
References: <1304340464-14829-1-git-send-email-pclouds@gmail.com>
 <1304340923-15927-1-git-send-email-pclouds@gmail.com> <4DBEC766.8020008@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Mon May 02 17:53:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QGvQw-0000Nx-Gc
	for gcvg-git-2@lo.gmane.org; Mon, 02 May 2011 17:53:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756326Ab1EBPxK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 May 2011 11:53:10 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:59991 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753546Ab1EBPxI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 May 2011 11:53:08 -0400
Received: by fxm17 with SMTP id 17so3715588fxm.19
        for <git@vger.kernel.org>; Mon, 02 May 2011 08:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=ImShkzlN5Thc0tMJBGMirj8WhNd3j7LXLGYln7ABhcQ=;
        b=FpC5lCKwwIpU6bufsACJ/WKLpxVYlLrzvfzMTtCN1sFtqlduSYWoxvvRYJYKsdW5iL
         zlKDAz331GSRHxsxiBMpSGQEK9T7k1Dg8LiXArnqytt1EpaT99HCWngQyq7y22FboPCJ
         aS0CzKs1rzPHPP5eHAoEQjSb7erQJyVxlniXo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=CGg7yPrr1dr8wJTYkhgKg8L091IntXYPU+XybRVrHS+yRERqWFG5HfYHoVvcDEADHp
         woBzfrkzUK2dV68gTIh1vO4Gjj6jMekA7ihgIfkRqlGXA4zGy7ZhsXLGL9cr+cdj/QXg
         qQ09XTtEF9edw1eZQeNXcRIelahE8wFIQzbiE=
Received: by 10.223.98.141 with SMTP id q13mr46022fan.96.1304351587081; Mon,
 02 May 2011 08:53:07 -0700 (PDT)
Received: by 10.223.118.5 with HTTP; Mon, 2 May 2011 08:52:37 -0700 (PDT)
In-Reply-To: <4DBEC766.8020008@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172598>

2011/5/2 Johannes Sixt <j.sixt@viscovery.net>:
> Am 5/2/2011 14:55, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy:
>> excluded_from_list() fails to handle this case. It too eagerly decid=
es
>> the fate of the whole directory without looking further in.
>
> This has been debated just recently, and I don't think the current
> behavior is broken. See
>
> http://thread.gmane.org/gmane.comp.version-control.git/169913
> http://thread.gmane.org/gmane.comp.version-control.git/157190/focus=3D=
157196

Because it's expensive to do does not make it right not to do it. I
agree that traversing all the way down just to make the final decision
is expensive. But we could at least state that we only support looking
for .gitignore down to some level (0 as in current git), or based on
=2Egitignore paths in index, then stop. The point is make it
configurable with sane default. It's up to users to decide how they
want to pay.
--=20
Duy
