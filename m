From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3] Add an explicit GIT_DIR to the list of excludes
Date: Wed, 28 May 2014 20:53:18 +0200
Message-ID: <5386309E.3070003@gmail.com>
References: <1400866411-14584-1-git-send-email-pasha.bolokhov@gmail.com> <CACsJy8CDeTn8h8uUn_=6ek7BJueN_1i01TB_AeH03RKnf6tNSw@mail.gmail.com> <CAKpPgvfqTBxFXOaStEyyS7wAdR5aUsEOX_M2gPvGz4_dJYvTOA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Pasha Bolokhov <pasha.bolokhov@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 28 20:53:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wpiyh-00019q-R0
	for gcvg-git-2@plane.gmane.org; Wed, 28 May 2014 20:53:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753573AbaE1Sx2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 28 May 2014 14:53:28 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:50995 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbaE1Sx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2014 14:53:27 -0400
Received: by mail-wi0-f174.google.com with SMTP id r20so4394267wiv.1
        for <git@vger.kernel.org>; Wed, 28 May 2014 11:53:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kxxOZ+u0qqejVVAdJGhiXwB+ZzbVdfybHSKsXOfrNMY=;
        b=ThufuZ8R8oQEVafkN0DH2PbKRA2xjypKmHIZhgf/QgdrtzasQVSTIWXlArTZxjvVa1
         9vuDcH6GoxEEOgyiHl3+Q2xbKwlhG6LrsuPWKQ10p9guz2Eu6aH42frm6WwsU6OhoejK
         MU/gFN+o6YBOQ7PpLXNmNvHFfXe5Y7+kkkvk6FVSglfEGfBdOnqa0GVymwhzWAOIfKZX
         XyvR6gJ7eyuCo8hAlC0+ZtDxpL9Sreyj/brkc1hKM5S1Mf4q/0jh1ww7TxU0mbUJZH8R
         s7YJDt0u6eVu6YyPuu8f9mbLEtMedZ3P1lhMn0GelGK2Z9CC6sID2l1r9qZ8dpwEaZbN
         8Aqg==
X-Received: by 10.180.198.178 with SMTP id jd18mr51606165wic.24.1401303205453;
        Wed, 28 May 2014 11:53:25 -0700 (PDT)
Received: from [192.168.130.241] ([158.75.2.130])
        by mx.google.com with ESMTPSA id nb8sm19011043wic.18.2014.05.28.11.53.23
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 28 May 2014 11:53:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <CAKpPgvfqTBxFXOaStEyyS7wAdR5aUsEOX_M2gPvGz4_dJYvTOA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250312>

W dniu 2014-05-27 19:16, Pasha Bolokhov pisze:
>>> Add GIT_DIR to the list of excludes in setup_standard_excludes(),
>>> while checking that GIT_DIR is not just '.git', in which case it
>>> would be ignored by default, and that GIT_DIR is inside GIT_WORK_TR=
EE
>>>
>> gives git-grep.txt and git-ls-files.txt. I don't know if we need to
>> add something about this extra exclude rule to those .txt. If it's s=
o
>> obvious that this should be the expected behavior, then probably not=
=2E
>
>      I suggest this. There appears to be a notion of "standard
> excludes" both in the code (dir.c) and in the man pages (git-grep,
> git-ls-files). However, it doesn't actually appear to be defined
> strictly speaking. So my suggestion is to define those "standard
> excludes" in one place (say "gitignore(5)"), and make other man pages
> (git-config, git-grip, git-ls-files) have references to that place
> instead of explaining every time in detail what is being excluded.

Or define those "standard excludes" in standard-excludes.txt "partial",
and include said file from git-grep(1), git-ls-files(1), and perhaps=20
gitignore(5).

--=20
Jakub Nar=C4=99bski
