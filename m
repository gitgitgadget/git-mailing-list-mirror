From: Lars Schneider <larsxschneider@gmail.com>
Subject: [RFC] Case insensitive URL rewrite
Date: Fri, 11 Dec 2015 14:45:37 +0100
Message-ID: <B207EFC1-48DF-4B8F-8373-28A0CB5660B0@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 9.1 \(3096.5\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Dec 11 14:45:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a7O18-0007V3-Vz
	for gcvg-git-2@plane.gmane.org; Fri, 11 Dec 2015 14:45:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753085AbbLKNpm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Dec 2015 08:45:42 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35718 "EHLO
	mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751827AbbLKNpl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Dec 2015 08:45:41 -0500
Received: by mail-wm0-f50.google.com with SMTP id l68so14215096wml.0
        for <git@vger.kernel.org>; Fri, 11 Dec 2015 05:45:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:content-type:content-transfer-encoding:subject:message-id:date
         :to:mime-version;
        bh=0hhekKLzY/Q/8ZTL93FuzVQ4A/1Tvsp3/ttT9gtH9As=;
        b=TJT+RZOjG5xblEdM8qSkOLbPSkMfHkOaNyNA384zQaRRFUdyou0SzQYVXWElcOo6Ev
         cCewO90cMRXnYC15a++pRcGJUBC9ZLfmLPtLO+8rMtfC38LZqMIs1l/+wHrronHPL8HA
         1Ojn7dl+UA9bwkHMiA7qczuO32MED4yCqWOTCWQPheQWc0u213TPtSQ5p64S8GCv5Aft
         PLchiY34m8Ve6tgATy/HzeSyEfbD8YQShGzX2je6NgIPeSezrH1vLfCZE+xSR5iVza+n
         bclUya1YFsu5q+0MtjPxbui2Z1ilhCXit1UjfVl2w8gQuvTZAy6fr06AFpzvr2trGigy
         tI4Q==
X-Received: by 10.194.84.4 with SMTP id u4mr23323985wjy.149.1449841539466;
        Fri, 11 Dec 2015 05:45:39 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id l128sm3460597wmf.10.2015.12.11.05.45.38
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 11 Dec 2015 05:45:38 -0800 (PST)
X-Mailer: Apple Mail (2.3096.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282256>

Hi,

the "url.<someURL>.insteadOf" git config is case sensitive. I understand that this makes sense on case sensitive file systems. However, URLs are mostly case insensitive:

Consider this:
git clone https://GIThub.com/GIT/GIT
git clone https://github.com/git/git

Both commands will clone the same repository.

Interestingly enough this works, too:
git clone git@GIThub.com:GIT/GIT

What do you think about a flag that makes these rewrites case insensitive? E.g. with the following config flag:

[url "<actual url base>"]
	insteadOf = <other url base>
	ignorecase = true

Thanks,
Lars
