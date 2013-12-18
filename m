From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH v3 07/10] builtin/replace: teach listing using short,
 medium or full formats
Date: Wed, 18 Dec 2013 13:37:05 +0100
Message-ID: <52B196F1.3060003@gmail.com>
References: <20131211074147.11117.1155.chriscool@tuxfamily.org> <20131211074614.11117.96106.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Joey Hess <joey@kitenet.net>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 18 13:37:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VtGNG-00060v-Q7
	for gcvg-git-2@plane.gmane.org; Wed, 18 Dec 2013 13:37:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753195Ab3LRMhI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 Dec 2013 07:37:08 -0500
Received: from mail-ee0-f48.google.com ([74.125.83.48]:61344 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753091Ab3LRMhG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Dec 2013 07:37:06 -0500
Received: by mail-ee0-f48.google.com with SMTP id e49so3500493eek.7
        for <git@vger.kernel.org>; Wed, 18 Dec 2013 04:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=p84dMC5jnMG9t94uUTEmN1axcf9Q0pH3ccuRVhGwrEk=;
        b=sPyRaoU7y0aiP/ACvy2BQwXtyxNEei1WsZFff9cCw9rdfbZK9a260eUiMJOb3nq19W
         /Ni+0zO2zLhUWxEYZwIrq7wdFWZ+bEuvUk/Y1jnlNJ6b32zidiq7ynXFUKKBcjcyyuTt
         lN/KVHV4InPJq33MdVnayHB1ncknY7a1E8gG5YR+5+9sD2ddAOCVaMAQb9aMhvNzi3YG
         QXbtRylRiNsntEIWFdcKtLAYrxB+2+ftEoizmfSK/+qbH+XjrwmW7xW+xpNTIsXVfQV8
         JORIJ6J/ItJrlSI73g0OyvfIjgK4eRLemLQNeFD0P50P3fAUFef0Tzg9O9djNIra1k8V
         UdVg==
X-Received: by 10.14.87.195 with SMTP id y43mr17706582eee.32.1387370225573;
        Wed, 18 Dec 2013 04:37:05 -0800 (PST)
Received: from [10.1.100.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id b41sm62122884eef.16.2013.12.18.04.37.04
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 18 Dec 2013 04:37:04 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20131211074614.11117.96106.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239429>

Am 11.12.2013 08:46, schrieb Christian Couder:
> +enum repl_fmt { SHORT, MEDIUM, FULL };

SHORT is predefined on Windows, could you choose another name?

MinGW:

builtin/replace.c:23: error: 'SHORT' redeclared as different kind of sy=
mbol
c:\git\msysgit\mingw\bin\../lib/gcc/mingw32/4.4.0/../../../../include/w=
innt.h:78: note: previous declaration of 'SHORT'
was here
make: *** [builtin/replace.o] Error 1


MSVC:

    CC builtin/replace.o
replace.c
builtin/replace.c(23) : error C2365: "SHORT": Erneute Definition; vorhe=
rige Definition war "Typedef".
        C:\Program Files\Microsoft SDKs\Windows\v7.1\include\winnt.h(33=
2): Siehe Deklaration von 'SHORT'
builtin/replace.c(23) : error C2086: 'repl_fmt SHORT': Neudefinition
        builtin/replace.c(23): Siehe Deklaration von 'SHORT'
builtin/replace.c(36) : error C2275: 'SHORT': Ung=FCltige Verwendung di=
eses Typs als Ausdruck
        C:\Program Files\Microsoft SDKs\Windows\v7.1\include\winnt.h(33=
2): Siehe Deklaration von 'SHORT'
builtin/replace.c(67) : error C2275: 'SHORT': Ung=FCltige Verwendung di=
eses Typs als Ausdruck
        C:\Program Files\Microsoft SDKs\Windows\v7.1\include\winnt.h(33=
2): Siehe Deklaration von 'SHORT'
builtin/replace.c(173) : warning C4090: 'Initialisierung': Unterschiedl=
iche 'const'-Bezeichner
make: *** [builtin/replace.o] Error 1
