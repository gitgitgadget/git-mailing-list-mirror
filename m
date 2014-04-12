From: Ronald Weiss <weiss.ronald@gmail.com>
Subject: Re: [PATCH v3 2/2] commit: add --ignore-submodules[=<when>] parameter
Date: Sun, 13 Apr 2014 00:20:28 +0200
Message-ID: <5349BC2C.9030509@gmail.com>
References: <CABxC_L92v=cV=+e_DNa0L6f21LB0BRP5duai2h_heGJN_PRoUQ@mail.gmail.com>	<5335A78C.60401@web.de>	<CABxC_L-4=qcZiix05dL8GrDJXv=19fw4yB0qFzRRfw=G=_Gxbg@mail.gmail.com>	<53374E49.9000702@gmail.com>	<533874F9.3090802@web.de>	<5338AC36.6000109@gmail.com>	<5338B1B0.3050703@gmail.com>	<5339BAE4.8020306@web.de> <CABxC_L8_tQrANXji_Z0LfigxsAuzSDj3K9ndTGOTHh2ctHvc6A@mail.gmail.com> <5339F122.60801@gmail.com> <5339FBB4.1010101@gmail.com> <533B2036.3050506@web.de> <533B36AA.3090600@gmail.com> <533C5CBD.4050601@web.de> <533C6B57.3080901@gmail.com> <534180BC.308@web.de> <53431CB8.2050600@gmail.com> <53432EA5.5060102@gmail.com> <53444368.9050607@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 13 00:20:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WZ6Ht-0007Sg-4I
	for gcvg-git-2@plane.gmane.org; Sun, 13 Apr 2014 00:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756762AbaDLWUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2014 18:20:33 -0400
Received: from mail-ee0-f51.google.com ([74.125.83.51]:37451 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755715AbaDLWUc (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2014 18:20:32 -0400
Received: by mail-ee0-f51.google.com with SMTP id c13so5220175eek.24
        for <git@vger.kernel.org>; Sat, 12 Apr 2014 15:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vlBsszzviwCDtj3qU1xrxDzPq1qmP9AzP4VGex/hcL8=;
        b=OsyaPeoUAe9wMUJrrzEJjINQLayAkH+56pyA7kQx+b+zsY1LqgBdJdnQDOLO/2v+vT
         q4sATq/1BN6czbSEKxune3pC32FtYXpj0Xw2Cx7ZCrTA4buC3ROizJn+SOoaNiNgzNnt
         +AzeEIP7YD/4htNqhddj3+617wCNwlbIBoMLDEffwOmwUqU5E2x+YpPFFHfiQK9dRyp+
         NfSIRza9kg5V94NjdP9WGHLXlECjMApaB1AGEZtIOq5ut4VDV5M1p34PR+r0GPhaLiTV
         x7K4C3Z9wMqLxDzNy0hNvUZeEUXqh3HJYH+e5PT9yknIhYmlqADSh78zElGHzh0p49PS
         +3kQ==
X-Received: by 10.15.90.201 with SMTP id q49mr4497265eez.65.1397341231198;
        Sat, 12 Apr 2014 15:20:31 -0700 (PDT)
Received: from [10.0.1.226] (chello089173067059.chello.sk. [89.173.67.59])
        by mx.google.com with ESMTPSA id u1sm28400129eex.31.2014.04.12.15.20.29
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Apr 2014 15:20:30 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <53444368.9050607@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246198>

On 8. 4. 2014 20:43, Jens Lehmann wrote:
>> Useful <when> values for commit are 'all' (default) or 'none'. The others
>> ('dirty' and 'untracked') have same effect as 'none', as commit is only
>> interested in whether the submodule's HEAD differs from what is commited
>> in the superproject.
>
> Unless it outputs a status message, then 'dirty' and 'untracked' do
> influence what is shown there. Apart from that (and maybe tests for
> these two cases ;-) this is looking good to me.

OK, I updated the patch for commit to take that into account. Also, I
rebased both patches onto current master. Sending them in a moment.

If you don't have any more complaints, can I add "Acked-by: <you>" and
resend the patches to Junio?
