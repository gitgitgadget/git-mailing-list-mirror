From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 1/2] git-p4: add test case for "Translation of file content failed" error
Date: Sun, 20 Sep 2015 23:34:23 +0200
Message-ID: <4DB8A17D-A670-4E84-8FA8-9B05F2DCE1CB@gmail.com>
References: <1442766131-45017-1-git-send-email-larsxschneider@gmail.com> <1442766131-45017-2-git-send-email-larsxschneider@gmail.com> <CAPig+cThcNa2Xg6GDkNKKeOMOzApTi_FQfQz_KRAbF8-PWY5Eg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Git List <git@vger.kernel.org>, Luke Diamand <luke@diamand.org>,
	=?iso-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Sep 20 23:34:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZdmFj-0004ka-F3
	for gcvg-git-2@plane.gmane.org; Sun, 20 Sep 2015 23:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755455AbbITVe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Sep 2015 17:34:27 -0400
Received: from mail-wi0-f180.google.com ([209.85.212.180]:37285 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755417AbbITVe1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Sep 2015 17:34:27 -0400
Received: by wicfx3 with SMTP id fx3so88129138wic.0
        for <git@vger.kernel.org>; Sun, 20 Sep 2015 14:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=upMxOxpydtxsLWofe7k6VWkn7y+SpQZuP4YT3Wz793s=;
        b=DkxHsklacGCTY77d9QcFtwsXdPUiubZKAnaRXsze3PEQSlVWITHywRVv2nDN7sUhI/
         jk9Dfcg7aDAIJ3twA8FAyP6bOrXsTKpUWhN0SZn3BjSzOn0pHT5HFcJcLAoQE369VKYG
         oRAhhhlDiRoFOb4luACf+zEAAhPWsQ/YKRgRl25z9mOMot0DZOlkJFm+UzQgdzCylMrb
         NHvN16or7lFdF+QBj7GwM9ABBWF5C+T5H80eZt+67mfWh3vb5n1+ulqMbzL1X1wH5usW
         0Ei3Z+72hqrrlKT8DYm37Y+9eiLjnmmp/Kw6KV2z87awL5EDTE/5B/hfHPkzUhQ/dOMu
         kWWA==
X-Received: by 10.194.117.39 with SMTP id kb7mr18658481wjb.129.1442784865928;
        Sun, 20 Sep 2015 14:34:25 -0700 (PDT)
Received: from slxbook3.fritz.box (dslb-188-106-098-135.188.106.pools.vodafone-ip.de. [188.106.98.135])
        by smtp.gmail.com with ESMTPSA id lf10sm20745841wjb.23.2015.09.20.14.34.24
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 20 Sep 2015 14:34:25 -0700 (PDT)
In-Reply-To: <CAPig+cThcNa2Xg6GDkNKKeOMOzApTi_FQfQz_KRAbF8-PWY5Eg@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278272>


On 20 Sep 2015, at 23:16, Eric Sunshine <sunshine@sunshineco.com> wrote:

> On Sun, Sep 20, 2015 at 12:22 PM,  <larsxschneider@gmail.com> wrote:
>> A P4 repository can get into a state where it contains a file with
>> type UTF-16 that does not contain a valid UTF-16 BOM. If git-p4
>> attempts to retrieve the file then the process crashes with a
>> "Translation of file content failed" error.
> 
> Hmm, are these tests going to succeed only after patch 2/2 is applied?
> If so, the order of these patches is backward since you want each
> patch to be able to stand on its own and not introduce any sort of
> breakage.
Yes, these tests succeed only after 2/2. I think I saw this approach somewhere in the Git history. I thought it would ease the reviewing process: show the problem in the first commit, fix it in a subsequent commit.
However, I understand your point as 1/2 would break the build.

What is the preferred way by the Git community? Combine patch and test in one commit or a patch commit followed by a test commit? I would prefer to have everything in one commit.

- Lars
