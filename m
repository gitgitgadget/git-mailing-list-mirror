From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Skip archive --remote tests on Windows
Date: Wed, 03 Aug 2011 02:09:11 -0700 (PDT)
Message-ID: <m3hb5yrhfw.fsf@localhost.localdomain>
References: <4E3904B8.7080208@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Git Mailing List <git@vger.kernel.org>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Aug 03 11:09:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QoXS3-0006ie-Am
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 11:09:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753117Ab1HCJJP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 3 Aug 2011 05:09:15 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:41888 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752670Ab1HCJJN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2011 05:09:13 -0400
Received: by fxh19 with SMTP id 19so448302fxh.19
        for <git@vger.kernel.org>; Wed, 03 Aug 2011 02:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=yl2NiCL5rH2SyQT3DkZmWgW46C2ZT4UHuO1/YBIUDdY=;
        b=gdKBiWMT9jyyEcwmWfVREj8CGwGDeUIxfQCTngkYVQWIVV7WdAcuWhxtJ68CnGLZSe
         1uTTWQc6sctMQgHIcl7LzmCn+w5hBLtiN+p1vou6JzXTqvgY6+Bam/z+lr72+MPbuPH+
         oyKswCLtfW99T/ZSIGm4oNBMqgJTUSi62nyGE=
Received: by 10.204.132.1 with SMTP id z1mr14176bks.132.1312362552577;
        Wed, 03 Aug 2011 02:09:12 -0700 (PDT)
Received: from localhost.localdomain (abwn226.neoplus.adsl.tpnet.pl [83.8.237.226])
        by mx.google.com with ESMTPS id x1sm2378563fah.2.2011.08.03.02.09.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Aug 2011 02:09:11 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p7398XZw026458;
	Wed, 3 Aug 2011 11:08:43 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p73984Jl026453;
	Wed, 3 Aug 2011 11:08:04 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4E3904B8.7080208@viscovery.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178550>

Johannes Sixt <j.sixt@viscovery.net> writes:

> From: Johannes Sixt <j6t@kdbg.org>
>=20
> These depend on a working git-upload-archive, which is broken on Wind=
ows,
> because it depends on fork().
>=20
> Signed-off-by: Johannes Sixt <j6t@kdbg.org>
> ---
>  These prerequisites are needed in current master, but would have to =
be
>  patched out again by Erik's upload-archive series.
[...]

> -test_expect_success 'archive --list shows only enabled remote filter=
s' '
> +test_expect_success NOT_MINGW 'archive --list shows only enabled rem=
ote filters' '

Shouldn't the prerequisite be called FORK rather than NON_MINGW?

--=20
Jakub Nar=EAbski
