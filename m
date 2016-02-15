From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Issues with cc-cmd
Date: Mon, 15 Feb 2016 13:57:46 +0530
Message-ID: <20160215082746.GH6334@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 09:28:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVEVj-0007tr-Dz
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 09:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752265AbcBOI1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 03:27:55 -0500
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34487 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbcBOI1y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 03:27:54 -0500
Received: by mail-pa0-f50.google.com with SMTP id fy10so42938194pac.1
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 00:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=J7FMGa+jzJEkuo5UnIQoulcqw2u5JOXUaKxDJl9xzuQ=;
        b=ff+mxICL+NId8uSmVtu2Dg02OzzVy1hie+/8cQ8w/MDbMHsBBjqnSiBwVYf8U+R40t
         hl0PLv1CIGqSS7e8Ax2ZwwvjMr87+LZ9sK2BQD5YEXNYp56vTP5lL5i1d58f0eRc3Fx5
         DoQGtSVTl4VNZULbZ81eyJDkvZWpetRnwKYlg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=J7FMGa+jzJEkuo5UnIQoulcqw2u5JOXUaKxDJl9xzuQ=;
        b=BEzvuXpjDwIKp5PLFMCBTbvkBbXOHBl0sdSWEehPJA2QAjcF9r1PS/FOO4jkuyaciG
         SvSs/glhKVfe/BV+6nGm2auN2NhuEqSzjbPqA4Qn7bV4s6jGpW0K0Ex18xOrZCP2eOiy
         ZTS2xl00ugMbeXq31Wyc9lIAR8/GKuYZuukS33WaUKkUZshjNJdaNT8p/spv5wLJEr7h
         wmeC6az5G1pQmUdQBw3rbKwERwlPNw6mDVanfc37lZ40AEnc+KC8W+qjl8q+pMr8HCQT
         VdYwrwU5iKdWU7ZczQSY8yqx11wpy5yrSpIgk0E9k2nAYJ0ZugFhtYrraZhgCz7uvjMt
         wRiQ==
X-Gm-Message-State: AG10YOSVnwqLMW17SB9rNZA74F+L8BAEQx1Y8GB8CdM0Q5F2fVdZb38AvXSNSaPe3V6n35CG
X-Received: by 10.67.21.205 with SMTP id hm13mr21811443pad.56.1455524874019;
        Mon, 15 Feb 2016 00:27:54 -0800 (PST)
Received: from localhost ([122.172.89.184])
        by smtp.gmail.com with ESMTPSA id ud10sm36560934pab.27.2016.02.15.00.27.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Feb 2016 00:27:53 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286183>

Hi Guys,

I am facing a strange issue with git send-email, with cccmd and was
looking for some help.

I am using it with Linux Kernel..

I used get-maintainers today to submit few patches for OPP framework
and that is defined as below in MAINTAINERS:

OPERATING PERFORMANCE POINTS (OPP)
M:      Viresh Kumar <vireshk@kernel.org>
M:      Nishanth Menon <nm@ti.com>
M:      Stephen Boyd <sboyd@codeaurora.org>
L:      linux-pm@vger.kernel.org
S:      Maintained
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git
F:      drivers/base/power/opp/
F:      include/linux/pm_opp.h
F:      Documentation/power/opp.txt
F:      Documentation/devicetree/bindings/opp/


The parenthesis in the subsystem-name causes the cc list to look like:

Cc: linaro-kernel@lists.linaro.org,
linux-pm@vger.kernel.org,
Viresh Kumar <viresh.kumar@linaro.org>,
Krzysztof Kozlowski <k.kozlowski@samsung.com>,
Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
Len Brown <len.brown@intel.com>,
linux-kernel@vger.kernel.org (open list),
linux-pm@vger.kernel.org) (open list:OPERATING PERFORMANCE POINTS
(OPP),
Nishanth Menon <nm@ti.com>,
Pavel Machek <pavel@ucw.cz>,
Stephen Boyd <sboyd@codeaurora.org>,
Viresh Kumar <vireshk@kernel.org>


Look at the second linux-pm entry here, it adds a ')' at the end of
the list's address and removes it from the end of the line.

And so that becomes an invalid address to git-send-email.

Dropping () from the subsystem name fixes it though..

The output of get_maintainers looks fine, but when its being used by
putting following into .gitconfig:

[sendemail]
        cccmd = scripts/get_maintainers


it doesn't work well..

-- 
viresh
