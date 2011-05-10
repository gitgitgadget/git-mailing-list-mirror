From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [BUG] Autocompletion fails with "bash: words: bad array subscript"
Date: Tue, 10 May 2011 23:02:53 +0200
Message-ID: <BANLkTin9=7y+2eqUgo_ObcYeGs3TQ7YMGw@mail.gmail.com>
References: <BANLkTi=nOUEp_J+2dkZZp=HvER-eAdG9eg@mail.gmail.com>
 <20110510203101.GG14456@sigill.intra.peff.net> <20110510203943.GH14456@sigill.intra.peff.net>
 <BANLkTi=0r_hCgt3wh4EkRqS6gnCyyKrY2g@mail.gmail.com> <20110510210116.GA25224@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	"Shawn O. Pearce" <gsoc@spearce.org>,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Stephen Boyd <bebarino@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 10 23:03:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJu5o-0007v7-OE
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 23:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161Ab1EJVDe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 17:03:34 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:62687 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752058Ab1EJVDd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 17:03:33 -0400
Received: by qyg14 with SMTP id 14so4943615qyg.19
        for <git@vger.kernel.org>; Tue, 10 May 2011 14:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=n/om/x/baquAO5mbQq+0rZIfeRcz+aZjaCG9GsFKgEM=;
        b=UjXNUCEW064kXOdhG8CuV44VNoVDwGD5iV/y8SzubxZaKh60Kj6UiKFO8/dlOu126j
         BgfNyI0G+cuwHi7koQKV4ckhtnuRN8kaDTKuiFLnTCrUcRvp+iK5mOmDZv+oSPZTWdWa
         uVgsdlhYTYXl6Jlcm5wYEFlGIG0JpaHgbwysA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=qJ2/zqW90dPH+wptrzDn5p2AvR5bUEl4OV71xBOZe9DNFFDGohOy8fKeJ8B2fsrzlJ
         TdtFehMzJ4Ds9YGSV5qRw100vJ74h6XzvVsskpKJkoGpB99tbS184hHo2Mj/x9e3E+MB
         YM7UpOIJDwYJ4EE6uZyNfEzQSuCjDq1eFMBJU=
Received: by 10.229.45.203 with SMTP id g11mr6668493qcf.65.1305061413145; Tue,
 10 May 2011 14:03:33 -0700 (PDT)
Received: by 10.229.229.5 with HTTP; Tue, 10 May 2011 14:02:53 -0700 (PDT)
In-Reply-To: <20110510210116.GA25224@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173365>

Heya,

On Tue, May 10, 2011 at 23:01, Jeff King <peff@peff.net> wrote:
> Right. Bash calls into our __git() completion function, which calls the
> implementation of _get_comp_words_by_ref from /etc/bash_completion,
> which has the bug. If you don't source git completion, then you are just
> getting bash's default file completion.

So should we file this bug with bash's completion people? Also, how
did you manage to reproduce? It doesn't happen all the time for me.

-- 
Cheers,

Sverre Rabbelier
