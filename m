From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc0
Date: Mon, 29 Feb 2016 10:24:21 +0100
Message-ID: <56D40E45.5020304@gmail.com>
References: <xmqqmvqnhwf4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 29 10:24:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaK47-0000Aj-29
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 10:24:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752644AbcB2JY1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 04:24:27 -0500
Received: from mail-wm0-f49.google.com ([74.125.82.49]:33122 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009AbcB2JYY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 04:24:24 -0500
Received: by mail-wm0-f49.google.com with SMTP id l68so27703436wml.0;
        Mon, 29 Feb 2016 01:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=Hejx3j5sU6/afIpt+IArIbSKVyufwTAt10VGo6lPqHs=;
        b=sMDpYtKtjRB9bUzBwKBsTVhUpWbk9j1uxVnkeOpP4I2fpFIu8ostz5orZVbHX9KmAO
         U9g8bj/op+Cvp29SzDMbDtkHIy+QIXv7PtOR3CUT6HhAfQrT7zJstX9GT5nZCpL4+iom
         9J4ROltQfOk2/68cgps9cOGDF/8NTPG6AGJ9oyf84975P9pPM4v2XvSodYEGJb8DHKfI
         iLGApgzCsS47FcYHWhw0wl0s7iibafQdNI6Gr+ITvFnp9LDjE5Lp2iBcxABHHGEZ6t04
         CPMvTjZiJMdcoIlPn1PPds+kV49pE5bAxkkPVMH+F546b5FKisthkLrlUDYHEcFKDVzw
         ZEgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-transfer-encoding;
        bh=Hejx3j5sU6/afIpt+IArIbSKVyufwTAt10VGo6lPqHs=;
        b=WuIAVNWrsGnIjgwukqCA625F5y2lpM2LCXzI0wmuhO+XCxD+8ZNqBAR5hrE7hDIJm0
         YGDQmQCicTaGhtUxyl/kxzehS59aVdikgxLdqaWcFVgyBwKQJ1R8Yg/tJNaTQiGhOMEp
         6xAuRJFUlzfcs2y7EpPu3nUad1RTUAwIHXMX5zuRBOxNYxvnEr/IYNOnZz7pS2tYb80E
         /h/XNpl3fpLe2LdlhAuRF+n1yywxMT+vU5RwbetLVS76hcuklDbkIZIcbP7z/7jsCYvn
         zkfT3bRvojQSF78WuG2vlNW73/zap7LOgdek57qFZoRZax06C8G4AUUdDSA9x90IDqY2
         JRTg==
X-Gm-Message-State: AD7BkJIWaLnXuXjtXfwQZgxnBPrjNlNhurEPHlo9o8DhckGguTczrR/kJmHQDv/ji08MOA==
X-Received: by 10.28.180.193 with SMTP id d184mr10060391wmf.64.1456737863160;
        Mon, 29 Feb 2016 01:24:23 -0800 (PST)
Received: from [10.223.62.76] ([131.228.216.132])
        by smtp.googlemail.com with ESMTPSA id j10sm24924328wjb.46.2016.02.29.01.24.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 29 Feb 2016 01:24:22 -0800 (PST)
Newsgroups: gmane.comp.version-control.git,gmane.linux.kernel
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <xmqqmvqnhwf4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287812>

On 2/27/2016 0:41, Junio C Hamano wrote:

>   * Some calls to strcpy(3) triggers a false warning from static
>     analysers that are less intelligent than humans, and reducing the
>     number of these false hits helps us notice real issues.  A few
>     calls to strcpy(3) in test-path-utils that are already safe has
>     been rewritten to avoid false wanings.
>
>   * Some calls to strcpy(3) triggers a false warning from static
>     analysers that are less intelligent than humans, and reducing the
>     number of these false hits helps us notice real issues.  A few
>     calls to strcpy(3) in "git rerere" that are already safe has been
>     rewritten to avoid false wanings.

This is a duplicate.

Regards,
Sebastian
