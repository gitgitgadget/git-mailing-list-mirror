From: Victor Leschuk <vleschuk@gmail.com>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with
 gdb
Date: Thu, 29 Oct 2015 08:15:33 +0300
Message-ID: <5631AB75.5030800@gmail.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de>
 <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, vleschuk@accesssoftek.com
To: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 29 06:15:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrfYr-00053h-Ua
	for gcvg-git-2@plane.gmane.org; Thu, 29 Oct 2015 06:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbbJ2FPh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2015 01:15:37 -0400
Received: from mail-lb0-f177.google.com ([209.85.217.177]:34752 "EHLO
	mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751812AbbJ2FPg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2015 01:15:36 -0400
Received: by lbbwb3 with SMTP id wb3so20541793lbb.1
        for <git@vger.kernel.org>; Wed, 28 Oct 2015 22:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=OCp9F5Xr3nzlqGPJpQkiZg8e06POTRoaCl7DD6w4H0c=;
        b=01E8Fl7/h4NF7nKxVhI/T+iJxHqvOD5mbhiXqKf8u9ucn9oRC0yeID7yrn3AXM7Bwj
         Z94pHa6Lvlk3wp+vXX3SwUQ4wg76x6DcCCO/zGaWSJyz75Ekwa/D2lFiH+bhrzunc/jJ
         4UKaVjkc+SnHAjfHXgbeGmujmo6bLO3i9d6FAMzdydo5EgexHJy+47IxMuosgyEl/Y/C
         Mssr3dS3p+Tb6g+oi7ZYQWACNFwA99HIDLAjOzvgxNWMaMHBs/IUIREjJOC75brNsgyg
         UyddEPYwwRY4Hr94pZL2hb71D2PYFOGy/EKX7kmY0RENOGAcRFutT86aANC6/MxgvYsw
         JMig==
X-Received: by 10.112.62.232 with SMTP id b8mr24666754lbs.27.1446095735112;
        Wed, 28 Oct 2015 22:15:35 -0700 (PDT)
Received: from [192.168.1.101] (93-80-35-11.broadband.corbina.ru. [93.80.35.11])
        by smtp.gmail.com with ESMTPSA id q201sm8622423lfe.43.2015.10.28.22.15.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Oct 2015 22:15:34 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280433>


>   
> +if test -n "$TEST_GDB_GIT"
> +then
> +	exec gdb -args "${GIT_EXEC_PATH}/@@PROG@@" "$@"
Maybe we could make $TEST_GDB_GIT not just a boolean flag? It would be 
useful to contain "gdb" executable name. It would allow to set path to 
GDB when it is not in $PATH, set different debuggers (for example, I 
usually use cgdb), or even set it to /path/to/gdb_wrapper.sh which could 
contain different gdb options and tunings.

--
Victor
