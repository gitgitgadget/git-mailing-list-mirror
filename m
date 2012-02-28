From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [RFC PATCH 2a] pretty: detect missing \n\n in commit message
Date: Tue, 28 Feb 2012 19:56:30 +0700
Message-ID: <CACsJy8Cj477QnMz5ZD=i7FcFV15__zP9S-kt81pmZ2=opPBi5w@mail.gmail.com>
References: <010901fbfffe0f806bb19d556ebc1e512a4697f4.1330425111.git.trast@student.ethz.ch>
 <5234ba4babd28d9430750d227d629b4d4386b131.1330425111.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Feb 28 13:57:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2McJ-0000qN-9x
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 13:57:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757209Ab2B1M5G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 07:57:06 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:54670 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756119Ab2B1M5E convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 07:57:04 -0500
Received: by lahj13 with SMTP id j13so2184449lah.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 04:57:02 -0800 (PST)
Received-SPF: pass (google.com: domain of pclouds@gmail.com designates 10.112.103.8 as permitted sender) client-ip=10.112.103.8;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of pclouds@gmail.com designates 10.112.103.8 as permitted sender) smtp.mail=pclouds@gmail.com; dkim=pass header.i=pclouds@gmail.com
Received: from mr.google.com ([10.112.103.8])
        by 10.112.103.8 with SMTP id fs8mr7748169lbb.39.1330433822923 (num_hops = 1);
        Tue, 28 Feb 2012 04:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=Q2a+IxkiuTI3OP+KLlBmQFOE3ZHBgoiCLGkmLvYFcDU=;
        b=xtV1B9z6ord8THdZtXj/qOzESEf/6BWGAmkGP2k42wdqFggcIuA+ZbegSAIIljuu+z
         scgKi/8EYFHICxTo0ikOPYkmC7Qjz0U//VCydztxataorJBqmzoa10NmdqlJWqfLOOlM
         ReA9Xwabe/8nHZbi7YCuD0vTDy1ROJYZreTqE=
Received: by 10.112.103.8 with SMTP id fs8mr6397741lbb.39.1330433822855; Tue,
 28 Feb 2012 04:57:02 -0800 (PST)
Received: by 10.152.111.34 with HTTP; Tue, 28 Feb 2012 04:56:30 -0800 (PST)
In-Reply-To: <5234ba4babd28d9430750d227d629b4d4386b131.1330425111.git.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191727>

On Tue, Feb 28, 2012 at 5:37 PM, Thomas Rast <trast@student.ethz.ch> wr=
ote:
> get_header()'s exit condition is finding the \n\n that separates the
> commit header from its message. =C2=A0If such a double newline is not
> present, it segfaults. =C2=A0Catch this case and die().

I'd prefer a gentler approach: if there's no \n\n, accept that this
commit has no body. I think I encountered such commits in the test
suite when I tried to convert commit encoding partially and made the
assumption that \n\n must exist.
--=20
Duy
