From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH] git-completion.bash: always swallow error output of
 for-each-ref
Date: Fri, 12 Feb 2016 10:23:27 +0100
Message-ID: <56BDA48F.6020305@gmail.com>
References: <56B32953.2010908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: szeder@ira.uka.de, Junio C Hamano <gitster@pobox.com>,
	tr@thomasrast.ch
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 12 10:23:40 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aU9wx-0005Cd-DQ
	for gcvg-git-2@plane.gmane.org; Fri, 12 Feb 2016 10:23:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbcBLJXg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Feb 2016 04:23:36 -0500
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37284 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbcBLJXd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2016 04:23:33 -0500
Received: by mail-wm0-f44.google.com with SMTP id g62so11126777wme.0
        for <git@vger.kernel.org>; Fri, 12 Feb 2016 01:23:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=Tl2hAGtrcG6qQde7GcfSox6SLMfl+SEts61ZmW4gbcA=;
        b=tJFKmm1X0SIe9de6N3/9fK8KlWcJu62HwL0R1h3AVMq4GjwUdD6lzAAthzDxR9vLkt
         sMhYL6L6ah/m07p3fEqEmlQ+e/U+w7bM8cwsFZiq3oSjvLRwwPGY3pIsJKXTHyJVXGIJ
         chRTMPAwx+IC8MEF2vSSOzw33bBbK7qLdeM5MOc4jMZ9qhMxn6QfdcO01gPzEeKoOwDj
         Fw1+4bHCpdXjKF/keXIUYIJU3FXdN88SCDjvmsS/f7f+4Rn4RJMY7Mob9rRorW2g7nmU
         33Ry9PPwrKtonfBolNrOGpb7+ht52FSCQDip+6upv1O4lY+8LHGdOjGCJsg7XXczN0bW
         Fekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:newsgroups:from
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Tl2hAGtrcG6qQde7GcfSox6SLMfl+SEts61ZmW4gbcA=;
        b=avGY4p2sFlOY/3RBQqTCp6GubfR6dF3XIjzW+klsK4z6C2gGAU5oFQ5EL4/kcbYT4p
         HoK9ZX5sV1jhMWpHkio1GU18GV9faumseqLMD+RkchU3ptqfqZrbYLjcN9Q6VhA5AJZT
         WRfUU3iILXzAcGZdf2Eomc0c6tY9wUgZrY6gnQ4OgsPFezbuiyAmfIfMgL+hqmxlK+bM
         vEiJbcZRyv/FxVUiDk9WVOX9biAU82+9nxtYscUkwFwnGqEfd7gxdqY4QWWU7O0RG1W7
         DawcWUgUfz7XocrTeAENbRTAExyWJgQQqx/AuSSkWCDqZ3vjMccYmJU3g+8J3KrMa9cQ
         0v+g==
X-Gm-Message-State: AG10YOSiesfTlFA1C5z+Rt+c726Cn10WqoX19kDlV8zXm0rHm4/TAnWFTojwUMMVGEUnow==
X-Received: by 10.28.90.133 with SMTP id o127mr1910624wmb.101.1455269012115;
        Fri, 12 Feb 2016 01:23:32 -0800 (PST)
Received: from [192.168.188.20] (p508EAD77.dip0.t-ipconnect.de. [80.142.173.119])
        by smtp.googlemail.com with ESMTPSA id di1sm11158484wjc.3.2016.02.12.01.23.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 12 Feb 2016 01:23:31 -0800 (PST)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <56B32953.2010908@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286042>

On 04.02.2016 11:34, Sebastian Schuberth wrote:

> This avoids output like
>
>      warning: ignoring broken ref refs/remotes/origin/HEAD
>
> while completing branch names.
>
> Signed-off-by: Sebastian Schuberth <sschuberth@gmail.com>

The discussion got a bit off the point with the "short" vs. "strip=2" 
stuff, but I guess the patch itself if good to apply?

-- 
Sebastian Schuberth
