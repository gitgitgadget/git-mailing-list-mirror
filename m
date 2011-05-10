From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [BUG] Autocompletion fails with "bash: words: bad array subscript"
Date: Tue, 10 May 2011 22:47:49 +0200
Message-ID: <BANLkTi=0r_hCgt3wh4EkRqS6gnCyyKrY2g@mail.gmail.com>
References: <BANLkTi=nOUEp_J+2dkZZp=HvER-eAdG9eg@mail.gmail.com>
 <20110510203101.GG14456@sigill.intra.peff.net> <20110510203943.GH14456@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	"Shawn O. Pearce" <gsoc@spearce.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Stephen Boyd <bebarino@gmail.com>
To: Jeff King <peff@peff.net>, Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 22:48:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJtrA-00010p-Nb
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 22:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543Ab1EJUsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 16:48:31 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:42807 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750784Ab1EJUsa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 16:48:30 -0400
Received: by qyk7 with SMTP id 7so1951161qyk.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 13:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Wc9ftCzsjx47nwbIWrN5U7kk7gs63twfD97DVaUOO0Q=;
        b=JrGzkYvGhPJG9P0ERu41vBe2qZyLUKm6Tl8aO9A4e6Foy1diMK/Hve2fHVT9IyMD13
         aWtMYexbhGHsToADb6uSp4qAnunypCBQfQJhNmJQYEILw54ZeiGGOZiwAnBCE6uoNY6E
         ndLq5NXEs9XMuDJztNrNAdoae6FVlbjnSvnp4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=ZuqLkU0aazUqoPevhW5NBBfZwHtQ0DxK4T6gK3KiYyWn0FXb6es9waYu40VTY6+K4m
         1e96Im8jaK2DmdPWohkOjjr68zx4LOzmMOaaMzFtZXG/2aZKhBnNBjKYXWXFK46oM80S
         UCkPULnlXdI+bVj5lnj5b2QTTvGwlSqvgvEAQ=
Received: by 10.229.48.74 with SMTP id q10mr6635371qcf.141.1305060510136; Tue,
 10 May 2011 13:48:30 -0700 (PDT)
Received: by 10.229.229.5 with HTTP; Tue, 10 May 2011 13:47:49 -0700 (PDT)
In-Reply-To: <20110510203943.GH14456@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173362>

Heya,

[also +Jonathan, who I seem to have forgotten to cc]

On Tue, May 10, 2011 at 22:39, Jeff King <peff@peff.net> wrote:
> Hrm. That code doesn't appear in our completion at all. We provide our
> own _get_comp_words_by_ref, but if it is already defined, we use
> whatever is there. So on my box, the problematic code comes from
> /etc/bash_completion. And I think it is a bug there, as this is one of
> the first things called (so git's completion hasn't had a change to
> introduce any bugs yet :) ).

Most curious, since it doesn't happen when I don't source git
completion. Perhaps it'll happen for any completion, or maybe we're
using the completion wrong somehow? I'm on Debian wheezy/sid.

-- 
Cheers,

Sverre Rabbelier
