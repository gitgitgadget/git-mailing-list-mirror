From: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: ref markers link to named shortlogs
Date: Fri, 22 Aug 2008 14:34:04 +0200
Message-ID: <cb7bb73a0808220534i2786af30hc924e9965cdb7fa8@mail.gmail.com>
References: <1219341860-4913-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <200808221049.21337.jnareb@gmail.com>
	 <cb7bb73a0808220231w37d2341eic56cabb595399f68@mail.gmail.com>
	 <200808221256.21805.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 14:35:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWVrL-0004oD-Gm
	for gcvg-git-2@gmane.org; Fri, 22 Aug 2008 14:35:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbYHVMeI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Aug 2008 08:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753430AbYHVMeH
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Aug 2008 08:34:07 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:37658 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbYHVMeG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Aug 2008 08:34:06 -0400
Received: by gxk9 with SMTP id 9so1063429gxk.13
        for <git@vger.kernel.org>; Fri, 22 Aug 2008 05:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xpplMS/SPp4f+br4P6aDG5LAMS2YKiiXXkrtus0eaok=;
        b=frLeooIgDZJRknttrArAHndQisVhzDy2bpKcvQVM0D/YOM0/gjZwAcsEcOHefT7soc
         2afVPuUD6ziQWTxhBqSs8TooiNDyg/4Ir0Z85Xmp4LO8p7R8CLwUJ/1KLrblFBmksfAO
         4//tdiZjw07U0WLd9WOC7WrLxHRt0yC2JUNzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=ekt9yS5fnKTDhyPuA/7qZWkue0fOqKsnW8OQrM8ReyT1lIaJxSMUIEirXtJD9nK6sa
         ytk59aRTu1l0a9zl9PDuBEPVF1qL/pTMKuDfgX56C4UeGJvHvbBumE8ThqZmOexHY5Gi
         ShM7aS03y2OQNEpKsMePLjVxKFa7mkIItMknU=
Received: by 10.151.107.8 with SMTP id j8mr1740836ybm.163.1219408444767;
        Fri, 22 Aug 2008 05:34:04 -0700 (PDT)
Received: by 10.150.155.12 with HTTP; Fri, 22 Aug 2008 05:34:04 -0700 (PDT)
In-Reply-To: <200808221256.21805.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93288>

On Fri, Aug 22, 2008 at 12:56 PM, Jakub Narebski <jnareb@gmail.com> wrote:
> This "couple of extra info" could be just '^{}' suffix.  So I don't
> think it would be very complicated.
>
> You could simply do not strip '^{}' suffix in git_get_references()
> subroutine (so for example $refs->{$id} could be "tags/v1.6.0^{}",
> and not simply "tags/v1.6.0" when $id is sha-1 of a _commit_ indirectly
> referenced by v1.6.0, i.e. referenced by v1.6.0 _tag_), and strip
> it and make use of it in format_ref_marker():
>
>   if ($ref =~ s/\^\{\}$//) {
>      # $ref is a tag
>   } else {
>      # $ref points directly to object
>   }

I've actually changed the format of $refs, making the values into
arrays whose first value is the name and the other is the ^{} marker,
if present. Patch incoming.

> P.S. I have re-added git mailing list to Cc:.

Oops, didn't realized I had forgotten it.

-- 
Giuseppe "Oblomov" Bilotta
