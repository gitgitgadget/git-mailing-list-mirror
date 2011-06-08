From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: gc getting called on each git command ... what's wrong?
Date: Tue, 7 Jun 2011 21:48:29 -0400
Message-ID: <BANLkTiksHRmp102XDJP5+-CLGj8hZXUR=g@mail.gmail.com>
References: <BANLkTi=oUARfwvNFNj-_FvZdwxQgibqPOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: geoffrey.russell@gmail.com
X-From: git-owner@vger.kernel.org Wed Jun 08 03:48:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU7sr-0003lb-SL
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 03:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545Ab1FHBsc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Jun 2011 21:48:32 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:39752 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751226Ab1FHBsb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 21:48:31 -0400
Received: by bwz15 with SMTP id 15so31415bwz.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 18:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=c0xQ+e06pq/y/IW5Z1V5Fl3LR5aiRZrfB+subHupXp4=;
        b=Ln6DbxsAjMM06vomzwRLqZ761wo08WctrZXar7EtNg/QGmfnJ9VhlrKZQbQkqRkLwh
         +/ufmoYEshRU9vpCS23WXRIoocD3XWst6cFPBN6gmrtvBMS7Ha2ggCu/wDZFySpNQiEP
         9k5zgBKWSAti/VMDZ2NWnmNf2ZQlWp95tSyGo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=ZNwrOxyrGJougHL3rlYIGkXUgYGFCEFllx/vrKfIgc/5G8MtYLvKXIH3b+yOwTasGH
         rhguTREEqOZMsJs/bGDuQh2Z66EAYYUL99FUNO8h0sn8oUU8P0JgNRWVvBfF5xhJ9eBg
         TmTUUF2Ri+/5JJqRTXrkwWpGhslD7x0XpJ1No=
Received: by 10.204.7.209 with SMTP id e17mr111209bke.162.1307497709592; Tue,
 07 Jun 2011 18:48:29 -0700 (PDT)
Received: by 10.204.115.198 with HTTP; Tue, 7 Jun 2011 18:48:29 -0700 (PDT)
In-Reply-To: <BANLkTi=oUARfwvNFNj-_FvZdwxQgibqPOg@mail.gmail.com>
X-Google-Sender-Auth: knBhfm8mB-fRODr9dA18E-7d6zY
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175292>

On Tue, Jun 7, 2011 at 9:33 PM, Geoff Russell wrote:
>
> As of today, almost every time I do a git command, gc is getting
> invoked.

>  =A0There are 96 pack files.

That's why. See gc.autopacklimit in "git help config" -- by default,
git will gc if there are more than 50 pack files.

Peter Harris
