From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 1/2] submodule: implement `module_list` as a builtin helper
Date: Mon, 03 Aug 2015 14:38:11 -0700
Message-ID: <xmqqfv406ojg.fsf@gitster.dls.corp.google.com>
References: <1438384147-3275-1-git-send-email-sbeller@google.com>
	<1438384147-3275-2-git-send-email-sbeller@google.com>
	<xmqqmvybakjl.fsf@gitster.dls.corp.google.com>
	<CAGZ79kY=39j4H=62=VZRm4VOcqzgOAU6tDpJVsqdeqnPtB8hQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon Aug 03 23:38:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMNR5-0008DS-O3
	for gcvg-git-2@plane.gmane.org; Mon, 03 Aug 2015 23:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755591AbbHCViP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Aug 2015 17:38:15 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33912 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755290AbbHCViN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Aug 2015 17:38:13 -0400
Received: by pawu10 with SMTP id u10so21529950paw.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2015 14:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=xr2C42bhwYMKgLW9oJREvYRfsgZYWP/p7wxC0+r5iAU=;
        b=aMpvQ7Tt+LMgNVlY0el9USFfUEPhYxr60rERv4ZvyXZjAmCdnB1+lTSaSC0pX3r1of
         YS6/NJxyA1C1c12ZJXBuMW0X5Fy81aIfxsfZ8va3AbtiYKnXk/qDQ7xF4ezSrZP3lE3J
         15qBY67HLr6yHwrnA2vd12FnkdVnxyp+CMsjauATJzDaXbKrpp/qne3lTpZ4HfIjt3MO
         0SoYOp3QC/6P64UMdG5GBqBbJR7dOI9E3nyfANBI7sPRW38Egtv3o8i/y0TuTTG5infa
         1Ff1Y1UDg6Abiv8BLP3owOy5MUXOYoN3HBZPidHwODliq8i3panMDsCTebVocX0JrXf3
         5o2A==
X-Received: by 10.66.63.71 with SMTP id e7mr290243pas.57.1438637892685;
        Mon, 03 Aug 2015 14:38:12 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:38a2:7ad5:137e:6e11])
        by smtp.gmail.com with ESMTPSA id v10sm5231775pbs.19.2015.08.03.14.38.11
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 14:38:12 -0700 (PDT)
In-Reply-To: <CAGZ79kY=39j4H=62=VZRm4VOcqzgOAU6tDpJVsqdeqnPtB8hQQ@mail.gmail.com>
	(Stefan Beller's message of "Mon, 3 Aug 2015 14:30:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275211>

Stefan Beller <sbeller@google.com> writes:

>>     $ git submodule--helper module_list
>
> Why would you use an underscore in here as opposed to a dash?

Simply because the diff would be easier to read; the callers used to
call module_list shell function, now they call the subcommand with the
same name of submodule--helper.
