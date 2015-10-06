From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 34/43] refs.c: make struct ref_transaction generic
Date: Tue, 06 Oct 2015 13:53:26 -0400
Organization: Twitter
Message-ID: <1444154006.7739.28.camel@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	 <1443477738-32023-35-git-send-email-dturner@twopensource.com>
	 <CAO2U3QhdzLfx8qfnOHgXTWit5x7+TQNn0=xozouA4m-0+B1rtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, mhagger@alum.mit.edu
To: Michael Blume <blume.mike@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 19:53:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjWQf-0007Eq-VX
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 19:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751952AbbJFRxa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Oct 2015 13:53:30 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:34502 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbbJFRx3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 13:53:29 -0400
Received: by qgez77 with SMTP id z77so181867776qge.1
        for <git@vger.kernel.org>; Tue, 06 Oct 2015 10:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=mBc41wrOR3C4IMr7Yd7VN9wvs1DUGqZ+3ORU9Ntf7wE=;
        b=XPMLxPU6zZyNTujmKHDHMyTvUMyyabdJneIR+8My+32SkgPGIRyqwxZmwz+eqEFfPB
         ZMh1s818f05tA79uqdA713cuRzisUYRTUlIPCj5pBjv18yo+HxBwm5qdemYU1s5ny6dj
         8Er1aZul6JfKmEw9y4I8J0o/ncInVbke3Z0F8g0v2aF+D11QLomZgmSSVF7sezu9eDRj
         GdvtcFaWiG+0zQRCkBkK1C7pIhFAo590Z7RZ+QLdFt/GMx2HsNpGmnXTxlrarsivwxhZ
         R/hFcfSF5xlHmFuqyqRWsV0ebXeBS1qrUbq7ih14pUkR6d1zjBzBodw+yiTcNTNitPem
         Yqgg==
X-Gm-Message-State: ALoCoQnFRndVTBQPavUCaaPeFvnqL5J+o/3vdtZcgn4haCbdyuAsrkx9Go74Pj352CdIM3+xbIr5
X-Received: by 10.140.148.211 with SMTP id 202mr49134841qhu.29.1444154008119;
        Tue, 06 Oct 2015 10:53:28 -0700 (PDT)
Received: from ubuntu ([192.133.79.147])
        by smtp.gmail.com with ESMTPSA id x19sm14391723qkx.32.2015.10.06.10.53.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2015 10:53:27 -0700 (PDT)
In-Reply-To: <CAO2U3QhdzLfx8qfnOHgXTWit5x7+TQNn0=xozouA4m-0+B1rtw@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279156>

On Tue, 2015-10-06 at 10:43 -0700, Michael Blume wrote:
> This triggers a lot of build warnings on my mac, basically in every
> file that uses refs.h:
> 
>     CC archive.o
> In file included from archive.c:2:
> ./refs.h:635:16: warning: redefinition of typedef
> 'ref_transaction_free_fn' is a C11 feature [-Wtypedef-redefinition]
> typedef void (*ref_transaction_free_fn)(struct ref_transaction *transaction);
>                ^
> ./refs.h:613:16: note: previous definition is here
> typedef void (*ref_transaction_free_fn)(struct ref_transaction *transaction);
>                ^
> 1 warning generated.


Thanks. I'll fix that when I reroll.
