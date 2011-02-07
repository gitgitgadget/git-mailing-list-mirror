From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [1.8.0] Provide proper remote ref namespaces
Date: Mon, 7 Feb 2011 03:14:31 +0300
Message-ID: <AANLkTim5jGpCYA3r8wV79C8-qjxqW7ABhJrbP-C0YjLa@mail.gmail.com>
References: <AANLkTi=yFwOAQMHhvLsB1_xmYOE9HHP2YB4H4TQzwwc8@mail.gmail.com>
	<201102060104.37146.johan@herland.net>
	<vpqaai8oqkc.fsf@bauges.imag.fr>
	<201102070022.51403.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Nicolas Pitre <nico@fluxnic.net>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Mon Feb 07 01:14:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmEkW-0002nH-Un
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 01:14:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754319Ab1BGAOc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Feb 2011 19:14:32 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42889 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754267Ab1BGAOb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Feb 2011 19:14:31 -0500
Received: by qwa26 with SMTP id 26so3138395qwa.19
        for <git@vger.kernel.org>; Sun, 06 Feb 2011 16:14:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=bDnGr0fNlZIlRvWqhwiWQYR8MNJif9KykqZOvlk2trU=;
        b=UZRvNqXIxmztNSODkYVwCcqQJ2b3tFVjEMZHqW2kQGFMJGRrE6yUpo7Gv6SDGFBwsQ
         RL4eeg2p+a1FI4JMro3h7Gpd4nXMvd30+5WDBCPn0PIR8fGDEk5xI5CzmSHSFpUkjJr1
         I1sOFd//kD6UfuNk5Jar9jedi2g8LckhVIv9A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=sDgVu9P7DdZXs4Mj54IPinGk43LrDCT1AJnGrcZY439nZNPzJAJKBZzJdJyNoczGYZ
         KqAd2R8YifQTagkSf6ML8URQA3zlzRqgAV3Ni99Nb/XmBozjrNk0hnHHjJsEFJ6tWX27
         DgdXeuLyWeGvwZX0/NDXMz94LUAa2cQpCSNT0=
Received: by 10.229.184.1 with SMTP id ci1mr10480251qcb.193.1297037671156;
 Sun, 06 Feb 2011 16:14:31 -0800 (PST)
Received: by 10.229.213.4 with HTTP; Sun, 6 Feb 2011 16:14:31 -0800 (PST)
In-Reply-To: <201102070022.51403.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166218>

On Mon, Feb 07, 2011 at 12:22:51AM +0100, Johan Herland wrote:
>
> As Nicolas mentioned elsewhere in the thread, having separate tag namespaces
> does not prevent us from also warning about ambiguous tag names on fetch.
> With separate namespaces, you could probably implement such a warning more
> easily as a hook, instead of hacking the fetch code directly.

Since when we started to handle the common case by forcing each user to
write some hook (BTW, which one?), while having an uncommon case as the
default? It makes no sense. And Nicolas suggested something different --
always warn on fetch, which means there will be warnings in your case
where you have two projects in one repo.

Dmitry
