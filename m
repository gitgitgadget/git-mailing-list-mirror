From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 0/3] fast textconv
Date: Sun, 28 Mar 2010 12:13:10 -0600
Message-ID: <fabb9a1e1003281113o4cb1e723p4ed39521b645fffe@mail.gmail.com>
References: <20100328145301.GA26213@coredump.intra.peff.net> 
	<4BAF7F3F.5020604@drmicha.warpmail.net> <20100328161728.GA2828@coredump.intra.peff.net> 
	<20100328161921.GA3435@coredump.intra.peff.net> <20100328165646.GA10293@coredump.intra.peff.net> 
	<20100328173420.GA18047@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 28 20:13:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NvwzS-00005s-N1
	for gcvg-git-2@lo.gmane.org; Sun, 28 Mar 2010 20:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754928Ab0C1SNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Mar 2010 14:13:33 -0400
Received: from mail-bw0-f209.google.com ([209.85.218.209]:38575 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754924Ab0C1SNd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Mar 2010 14:13:33 -0400
Received: by bwz1 with SMTP id 1so3039556bwz.21
        for <git@vger.kernel.org>; Sun, 28 Mar 2010 11:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type;
        bh=2ffeba7okDr0/OcK34E8neckq9km2MkyIJFJq7b2l7U=;
        b=MByZF9fqldp4PWn0vEcK9PfTNIGfDs7qY+pk1b3l02Yyir/3r0DU6E0NaFR6AXmfNs
         IMKDWGfOF5WtlbJx8sP2xqbo8yKVYFETG8MlJvAvh2d4YIHwsWUDqNknJiGNtZPAOfKR
         1Fi2ZJTWYQUgYelitCBeLqWB0ULuUwYYHUSa0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=tfjHoJW+ZlzDTBg7PYgKBMjn6B4QjhrPCIUWnypMGopPvZ6sKexdNnYLUsIeBISUBn
         NGf7VEx1r7/jxMHU7Ub0wvwHhrNhdmUhFDwiPsGY+HtW9vRIHUpgO7MicNi2pfUcT1XY
         q/RZcENXp6dBO7l0wFI+yDjL8lf+bsYsuJE10=
Received: by 10.204.142.7 with HTTP; Sun, 28 Mar 2010 11:13:10 -0700 (PDT)
In-Reply-To: <20100328173420.GA18047@coredump.intra.peff.net>
Received: by 10.204.132.214 with SMTP id c22mr975664bkt.60.1269800010142; Sun, 
	28 Mar 2010 11:13:30 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143415>

Heya,

On Sun, Mar 28, 2010 at 11:34, Jeff King <peff@peff.net> wrote:
> Here is a quick and dirty in-core implementation. The most notable
> defect is that all textconvs store under refs/notes/textconv, which is
> obviously bogus if you might textconv the same blob in two different
> ways.

What I did for the implementation of remote helpers is hash the url of
the remote when storing it locally, that way you don't have to worry
about escaping urls etc. You could do the same with the textconvs,
store it under  refs/notes/textconv/<hash of textconv filter>?

-- 
Cheers,

Sverre Rabbelier
