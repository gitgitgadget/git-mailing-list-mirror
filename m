From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2] ls-files: Add eol diagnostics
Date: Sun, 1 Nov 2015 09:43:29 +0100
Message-ID: <5635D0B1.9040800@gmail.com>
References: <52B3B0AC-037A-4872-9E0E-CDF6BE7A9695@web.de>
 <vpqbnbfpc6p.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sun Nov 01 09:43:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsoEl-00032Z-1B
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 09:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752189AbbKAIne (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 03:43:34 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:36363 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751047AbbKAInd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 03:43:33 -0500
Received: by wmec75 with SMTP id c75so38969859wme.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 01:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:newsgroups:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=JTGIY4grfWtF3gwuEvxYSZExBxILZh2zpIvtloFY9Ck=;
        b=0G9owUy2XOzw7aN20PBUB4L48iAadpmg0+xZsPGe0ei7NpayT5cjVSuXdFtXeWd1ru
         xOMZYwvmJCB3oQBoTkLofDAfmePLNewtEtCCNDAOfCPvg2sb8/9ascBwnEKm0NcwTSt1
         bLrx5aHG7C+liD0LpVAP7pUB/hnF2wb/AZZb4WMI4GzeYUVhtWKGue3PM6+cvx68Ni27
         HXe9J6FQM+6Q1coRuykLO0mEPNmH2/4pu8bP2PIpWkITVVQ3AxeBERojVSjxabuBv/r2
         XMkhXb2lwr/mngJINklitTEpTrm31cA0IxpPRx7GLo8T43LNCxrBre9EFVS3lAHl8CEq
         +VQg==
X-Received: by 10.28.146.146 with SMTP id u140mr6715757wmd.85.1446367412892;
        Sun, 01 Nov 2015 01:43:32 -0700 (PDT)
Received: from [192.168.188.20] (p548D6BA4.dip0.t-ipconnect.de. [84.141.107.164])
        by smtp.googlemail.com with ESMTPSA id b12sm11789722wma.6.2015.11.01.01.43.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Nov 2015 01:43:32 -0700 (PDT)
Newsgroups: gmane.comp.version-control.git
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.1.12)
 Gecko/20080213 Thunderbird/2.0.0.12 Mnenhy/0.7.5.0
In-Reply-To: <vpqbnbfpc6p.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280614>

On 31.10.2015 11:25, Matthieu Moy wrote:

>> ca:text-no-eol   wt:text-no-eol   t/t5100/empty
>> ca:binary        wt:binary        t/test-binary-2.png
>> ca:text-lf       wt:text-lf       t/t5100/rfc2047-info-0007
>> ca:text-lf       wt:text-crlf     doit.bat
>> ca:text-crlf-lf  wt:text-crlf-lf  locale/XX.po
> 
> I would spell the first "in" or "idx" (for "index"), not "ca" (for
> "cache"). I think we avoid talking about "the cache" these days even
> though the doc sometimes says "cached in the index" (i.e. use "cache" as
> a verb, not a noun).

Good point, I'd prefer "idx" over ca", too.

However, the commit message says "to check if text files are stored normalized in the *repository*", yet the output refers to the index / cache. Is there a (potential) difference between line endings in the index and repo? AFAIK there is not. Any I find it a bit confusing to refer to the index where, as e.g. for a freshly cloned repo the index should be empty, yet you do have specific line endings in the repo.

Long story short, how about consistently talking about line endings in the repo, and also using "repo" instead of "ca" here?

-- 
Sebastian Schuberth
