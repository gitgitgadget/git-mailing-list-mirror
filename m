From: Steffen Nurpmeso <sdaoden@gmail.com>
Subject: Re: Compiling 2.4.0 doesn't seem to honour
 C_INCLUDE_PATH
Date: Tue, 05 May 2015 12:00:23 +0200
Message-ID: <20150505100023.smwAp4ppkZA=%sdaoden@yandex.com>
References: <20150505094909.rzitmjWhT6g=%sdaoden@yandex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 05 12:13:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpZqX-0002X9-Pq
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 12:13:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757595AbbEEKM4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 06:12:56 -0400
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34455 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757585AbbEEKMu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 May 2015 06:12:50 -0400
Received: by wicmx19 with SMTP id mx19so97022955wic.1
        for <git@vger.kernel.org>; Tue, 05 May 2015 03:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:date:to:subject:message-id:references:in-reply-to:user-agent
         :mime-version:content-type;
        bh=l8ylDIXyli14OF8/MqZm7ihuVt0RWsDgzdkh7ttlgqM=;
        b=o0DU1tbVwsAeROWPOkVdFJQ10V0xYUOvxTmbfOxr2oacUUouvG769drUHe4ttLRsjg
         SqiLtFJwjH1c0OxBlluwn8TGNXuJtqztQEQ30OuiRU9Y29KFj0ZI72chWBH5bh/7q1vs
         mLyHe3EEFwNsjC3HCu3kU11YhB4b2mRd20Zxj4XQUeY4ZFUYtmoNs98IbbhEhaEfUL4i
         RsKRrkFVG38h/Ytb/YbPHL7bNv+Q9mbx/+qXo0pVU8fXc8+GZAbq6v8iHvEziuk5yS00
         zEx9EPoGm7lysYtoSnuumByCrsX23/uEj3uEV/fx1RDDxW+5eeEk9C4fFONs24kPfH1G
         BmHg==
X-Received: by 10.181.13.44 with SMTP id ev12mr2526643wid.17.1430820769181;
        Tue, 05 May 2015 03:12:49 -0700 (PDT)
Received: from gmail.com ([89.15.239.237])
        by mx.google.com with ESMTPSA id o6sm15358884wiz.24.2015.05.05.03.12.47
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2015 03:12:48 -0700 (PDT)
X-Google-Original-From: Steffen Nurpmeso <sdaoden@yandex.com>
In-Reply-To: <20150505094909.rzitmjWhT6g=%sdaoden@yandex.com>
User-Agent: s-nail v14.8.0-10-g6fd1f69
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268390>

i wrote:
 |I'm right that CURLDIR shouldn't be needed here?
 |Compilation succeeded after explicitly setting that, but shouldn't
 |C_INCLUDE_PATH be honoured just as PATH is?

err, no, send too fast.  What made it succeed was actually

  ?0[steffen@sherwood git.git-no_reduce]$ git diff
  diff --git a/imap-send.c b/imap-send.c
  index 37ac4aa..e907108 100644
  --- a/imap-send.c
  +++ b/imap-send.c
  @@ -31,6 +31,7 @@
   typedef void *SSL;
   #endif
   #ifdef USE_CURL_FOR_IMAP_SEND
  +#include </Users/steffen/usr/include/curl/curl.h>
   #include "http.h"
   #endif
   

--steffen
