From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 0/6] echo usernames as they are typed
Date: Sun, 27 Nov 2011 10:17:26 +0100
Message-ID: <CABPQNSb09kxjvdvz2P-WqU2VtMspaaA8ujTNLJ4+MuCrV=2zsw@mail.gmail.com>
References: <20111124105801.GA6168@sigill.intra.peff.net> <20111127082744.GA32068@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 27 10:18:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUasL-0006b0-83
	for gcvg-git-2@lo.gmane.org; Sun, 27 Nov 2011 10:18:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196Ab1K0JSM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 Nov 2011 04:18:12 -0500
Received: from mail-gx0-f174.google.com ([209.85.161.174]:54701 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750900Ab1K0JSI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2011 04:18:08 -0500
Received: by ggnr5 with SMTP id r5so4433888ggn.19
        for <git@vger.kernel.org>; Sun, 27 Nov 2011 01:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=jGrD0CRl7lqVoPauk+SEyT0YgkoCXbUXg/ztHZ533TY=;
        b=Yek6mgqjp4NjLKLaMiCVwabsxGRy29BbwI4eD051zv7yF6oGBYlQy2S9zZ/9drFHlA
         nrJx7pZx6Sac2CVM/EvMNKAml0qGQlQMuDeJ6Uaf3ExArDbes0Tivz/OaUsETJmQPste
         4XlyhDWdZsuP6hc9ZNb5/ydrkZXH7SV80GbiA=
Received: by 10.68.36.1 with SMTP id m1mr36197347pbj.3.1322385487065; Sun, 27
 Nov 2011 01:18:07 -0800 (PST)
Received: by 10.68.21.39 with HTTP; Sun, 27 Nov 2011 01:17:26 -0800 (PST)
In-Reply-To: <20111127082744.GA32068@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185979>

On Sun, Nov 27, 2011 at 9:27 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 24, 2011 at 05:58:01AM -0500, Jeff King wrote:
>
>> Here's a revised version of the http-auth / credential-helper series=
=2E
>
> And here's something I've been meaning to do on top: actually echo
> characters at the username prompt. We can't do this portably, but we =
can
> at least stub out a compatibility layer and let each system do someth=
ing
> sensible.
>
> =A0[1/6]: move git_getpass to its own source file
> =A0[2/6]: refactor git_getpass into generic prompt function
> =A0[3/6]: stub out getpass_echo function
> =A0[4/6]: prompt: add PROMPT_ECHO flag
> =A0[5/6]: credential: use git_prompt instead of git_getpass
> =A0[6/6]: compat/getpass: add a /dev/tty implementation
>
> -Peff

Interesting, I've been working on something pretty similar: getting
rid of getpass usage all together:

https://github.com/kusma/git/tree/work/askpass

My reason to write a getpass replacement was to avoid capping input to
PASS_MAX, which can be as low as 8 characters (and AFAIK is just that
on Solaris)...
