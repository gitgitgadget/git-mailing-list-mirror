From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/4] builtin: use builtin.h for all builtin commands
Date: Sun, 14 Nov 2010 11:47:51 -0600
Message-ID: <20101114174751.GE26459@burratino>
References: <1289745857-16704-1-git-send-email-avarab@gmail.com>
 <1289745857-16704-5-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 14 18:48:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHgh0-0000CM-PO
	for gcvg-git-2@lo.gmane.org; Sun, 14 Nov 2010 18:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756562Ab0KNRs1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Nov 2010 12:48:27 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:52351 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756434Ab0KNRs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Nov 2010 12:48:26 -0500
Received: by gwj17 with SMTP id 17so675640gwj.19
        for <git@vger.kernel.org>; Sun, 14 Nov 2010 09:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=k7UMuVWJ1ADOaWvEEEuz2lOb19vOYI4pFjRSPcxe65k=;
        b=HOwaoM1BzxGQbgtOzRtyRbwoaY3ij/guMwrDbPJWSn9TiQzdVXT1KZJes1lzTCwS5y
         Y1WdrjkxrpPQOe29/SYhkuGqYDSr04tttS4dvopt1yXdXejpMEmvgq4KUMhw/oewPyTK
         P7pAFANIVkIV+jD4YhHPE34y0x3zizcBNxnbo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vecKpzyeog2zRwtSE4IfEOA9rUJ1Akz7NDinJBNsl71MZ0KmxOamKcY5ilOGt2W3jM
         Fs5cW0y2AMwcr8CpjRd2ho+HAqNpKZlp2b472TGav3oNuPlNeOrXJqQlTF7WyCsMk+IL
         F3OSKKGTp2izr+ivmTAO9lSLD4UfT99ZTLZvY=
Received: by 10.151.13.13 with SMTP id q13mr7934276ybi.291.1289756904125;
        Sun, 14 Nov 2010 09:48:24 -0800 (PST)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id 13sm2739903anq.10.2010.11.14.09.48.22
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 14 Nov 2010 09:48:23 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1289745857-16704-5-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161425>

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> This impeded my efforts to gettextize git, since I'd otherwise have t=
o
> add gettext.h to all of these. Using builtin.h is a good idea in any
> case, since it's defining the prototypes for the cmd_* functions that
> these files define.

Yes, I think Junio acked this before, though I can't it in the archive.

Also compare: http://thread.gmane.org/gmane.comp.version-control.git/49=
523

> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1,4 +1,4 @@
> -#include "cache.h"
> +#include "builtin.h"
>  #include "wt-status.h"
>  #include "object.h"
>  #include "dir.h"

IMHO this deserves a separate mention in the log message.  If it is
just to get gettext.h, why not include gettext.h directly?
