From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] Revert "gitweb: Time::HiRes is in core for Perl 5.8"
Date: Sun, 29 Jan 2012 03:29:09 +0100
Message-ID: <CACBZZX4KOc6Roz7U5rLrNnzJ_JY9WsSyV6zU_KOsHC+A8y7w4w@mail.gmail.com>
References: <hbf.20120123rqzg@bombur.uio.no> <CACBZZX4cjcY5d3mPJAV+rbSTqCEUOrF=_dd3ny_jSM++G-Bg1Q@mail.gmail.com>
 <201201271845.39576.jnareb@gmail.com> <7vty3gzxhs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Hallvard Breien Furuseth <h.b.furuseth@usit.uio.no>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jan 29 03:29:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrKWj-00006R-4u
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 03:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203Ab2A2C3c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jan 2012 21:29:32 -0500
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58339 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750957Ab2A2C3b convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jan 2012 21:29:31 -0500
Received: by lagu2 with SMTP id u2so1635172lag.19
        for <git@vger.kernel.org>; Sat, 28 Jan 2012 18:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=ixMd6Au8Cze0GakX6JmfyjtDUCJyzmDu/ObfUo9jnVE=;
        b=dhjJQg9I5uiLE6a4NiR6mAopUdRuL7J1WLdw+5+2yJ2Bft5rLXlrk4rI1cwfFS4zEy
         29NLKGU9zNCe5XksJg9iAdFXELa5XmoMLA9i0FD7WIgdOEPaiPYbw+KB9G7I8Qw2dI5W
         wXkUAsV8s6ve14GDb74DozwYhhnc05x4ns9OU=
Received: by 10.112.23.133 with SMTP id m5mr3247597lbf.10.1327804169915; Sat,
 28 Jan 2012 18:29:29 -0800 (PST)
Received: by 10.112.30.67 with HTTP; Sat, 28 Jan 2012 18:29:09 -0800 (PST)
In-Reply-To: <7vty3gzxhs.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189273>

On Fri, Jan 27, 2012 at 21:44, Junio C Hamano <gitster@pobox.com> wrote=
:
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (defined $t0)
>
> If you go this route, even though tee-zero, the beginning of the
> time, is a good name for the variable, you may want to rename it to
> avoid confusing readers who might take it as a temporary variable
> #0.

<trivia>

Personally I'd have written it as $START_TIME, but as a bit of Perl
trivia you might not realize $t0 is a commonly used and undestood
variable for dealing with a start time in Perl in the same way that
`i` is common for dealing with array indexes in C.

I.e. someone used to Perl will immediately think "oh that's the start
time" having seen it hundreds of times before, but someone not used to
Perl will go "what's this t-zero thing?".

Meanwhile some Lisp programmer is wondering what the hell "i" means in
your C for-loops, iterator? :)
