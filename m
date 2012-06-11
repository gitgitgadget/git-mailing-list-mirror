From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 0/5] transport: unify ipv4 and ipv6 code paths
Date: Mon, 11 Jun 2012 20:12:00 +0200
Message-ID: <CABPQNSb9EGOgHb7NtsEtDh2QkjkHYn7YemYsa8Yaqyuce-aDMw@mail.gmail.com>
References: <20120308124857.GA7666@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Eric Wong <normalperson@yhbt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 20:12:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Se96h-000543-Uu
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 20:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752372Ab2FKSMs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 11 Jun 2012 14:12:48 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:56012 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752062Ab2FKSMr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 11 Jun 2012 14:12:47 -0400
Received: by dady13 with SMTP id y13so5728708dad.19
        for <git@vger.kernel.org>; Mon, 11 Jun 2012 11:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=JbP0RP8Avdq7Kd0niRBx3OpXmXxGgegDfhMkcP1togE=;
        b=hWxCbZZ+JTBdD4l4A3cIDN2UWM+rB870LYcx6MA6q8/+rudij/WVE3784QPlr8MsiF
         dmYlqPBKvTGl/nDyPI6pTto0mri6SlvvlGvowzCfyWrI6TesaiOvt89A9J7zP8yUn5gg
         hIC/JuGUinNrWLD2pST3AFOIChCBjk+i98nJqztQXkPz4P8P1kqA07bq79l75nNldAq+
         OAyA9FIaIT2MR6kkeOsJ7O3mpwI1byRr8jJPa3idSjuTyITMKwJw1w9fJY+r84VlmK63
         wXio0qt+ZShmuMGQ1Lyb2NNVr5N8WZhJ8pT1JiQu3GsX1E2yHCho9EMK3Wo3rgcJSIIP
         sGgw==
Received: by 10.68.203.7 with SMTP id km7mr29422949pbc.7.1339438367115; Mon,
 11 Jun 2012 11:12:47 -0700 (PDT)
Received: by 10.68.40.98 with HTTP; Mon, 11 Jun 2012 11:12:00 -0700 (PDT)
In-Reply-To: <20120308124857.GA7666@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199687>

On Thu, Mar 8, 2012 at 1:48 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Hi,
>
> These patches eliminate some ifdef-ery concerning NO_IPV6. =A0I used
> them when writing the SRV patch, which applies on top, but it's
> probably best to think of it as an independent topic.
>
> Patch 4 is the heart of the series. =A0It provides an interface simil=
ar
> to getaddrinfo that can be implemented on top of either gethostbyname
> or getaddrinfo and puts each implementation in a separate file. =A0Th=
is
> way, callers can just use the common API and they do not need to have
> two copies of their code, one for each host resolution API.
>
> Patches 1-3 move code around until all the code that patch 4 touches
> is in one place.
>
> Patches 5 is a potential error handling improvement noticed while
> writing patches 1-4. =A0It's probably not actually needed but it was =
a
> comfort to me.
>
> These patches have been in use in Debian since June of last year. =A0=
I'd
> like to see this in mainline early in the 1.7.11 cycle to make coding
> that touches this area during that cycle more pleasant. =A0Thoughts o=
f
> all kinds welcome.

What happened to this series?
