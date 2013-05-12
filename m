From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/3] cache.h: eliminate SHA-1 deprecation warnings on
 OS X 10.8
Date: Sun, 12 May 2013 14:37:28 -0400
Message-ID: <CAPig+cSw5-S7MDhG+5WdnLd+7PDUrSJcZJ-caXGM8JmYU6YWHw@mail.gmail.com>
References: <1368260548-52612-1-git-send-email-davvid@gmail.com>
	<1368260548-52612-2-git-send-email-davvid@gmail.com>
	<1368260548-52612-3-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 12 20:37:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ubb9L-0002o6-Qp
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 20:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066Ab3ELSha (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 14:37:30 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:43114 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750813Ab3ELSh3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 14:37:29 -0400
Received: by mail-la0-f53.google.com with SMTP id eo20so5484937lab.12
        for <git@vger.kernel.org>; Sun, 12 May 2013 11:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=J5HSq82wwqZupsFBfhQLVcY2qsvihy82oPFTS9GNT+E=;
        b=syJYE64nFhrAmxjMQsK/O8XFOkKep+9iHxd65OdXH6sMB5D0JNyGzkgZ5rbK5ok+4S
         wrINJuSeukeauh9HP3eb+71fZBU/t6VvaOdDwaA8PYQmK4jmS9p7Mwlsomv+Wo/pMdXf
         l/oBDc1e6NPYspchS1shIjhhOmzeGBdb1laYmfu+pGSupT+33AXazlOVvaoN2R0VPBqd
         ci0N6EuNdu+ycew0UOIwGm4lkZdEkSmp+B+Dcfyrq3J7dIM1VGoQxrB+toeTbezSGnNu
         e0IxlNGIIpJhUB2CU46nzcswk4hfofkeT/ANl0S4Isvnack76Awg3NdFREedEkiPwhWB
         Gsyw==
X-Received: by 10.152.121.105 with SMTP id lj9mr11684816lab.6.1368383848194;
 Sun, 12 May 2013 11:37:28 -0700 (PDT)
Received: by 10.114.181.3 with HTTP; Sun, 12 May 2013 11:37:28 -0700 (PDT)
In-Reply-To: <1368260548-52612-3-git-send-email-davvid@gmail.com>
X-Google-Sender-Auth: Pz0FlPDgDpXFrYBOkm6GocHYLsM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224060>

On Sat, May 11, 2013 at 4:22 AM, David Aguilar <davvid@gmail.com> wrote:
> Mac OS X Mountain Lion prints warnings when building git:
>
>         warning: 'SHA1_Init' is deprecated
>         (declared at /usr/include/openssl/sha.h:121)
>
> Silence the warnings by using the Common Digest SHA-1
> functions for SHA1_Init(), SHA1_Update(), and SHA1_Final().
>
> Add a COMMON_DIGEST_SHA1 knob to the Makefile to allow
> choosing this implementation and define it by default on Darwin.
>
> Signed-off-by: David Aguilar <davvid@gmail.com>
> ---
> Unchanged since last time; rebased to 3/3.

Ignore my earlier response. I had not seen your revised patches. With
this patch series, the SHA1_Foo() warnings are indeed resolved,
however, there are still a bunch of remaining deprecation warnings
regarding ERR_error_string, SSL_get_error, X509_get_ext_d2i, and so
forth.
