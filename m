From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 0/3] add test to demonstrate that shallow recursive clones fail
Date: Thu, 7 Jan 2016 22:50:28 +0100
Message-ID: <79770C7D-B6A1-4239-A1EF-0A986CCD24AA@gmail.com>
References: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 07 22:50:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHIS5-0005Mz-Gx
	for gcvg-git-2@plane.gmane.org; Thu, 07 Jan 2016 22:50:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753369AbcAGVud (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 16:50:33 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:36913 "EHLO
	mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230AbcAGVuc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2016 16:50:32 -0500
Received: by mail-wm0-f53.google.com with SMTP id f206so144731522wmf.0
        for <git@vger.kernel.org>; Thu, 07 Jan 2016 13:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1dl0V6Irh912DkXMntQ2zGmwgNVYrT0Z9NJ6qiLglBA=;
        b=FyTYwA5xlAjOS0NMUt1wHjf1sVKzwq2uirvyqDnwe5JW7J6g1v6NgXZaoOECpj4yhI
         IqBojCrnUHID0FP+vC6CEe9gM9Y2rv2OfXZvJrwQTOs7/E5BnxXv0xqNreI5830EfXL1
         ZWtw+87p2QvHQbN8vmV7S9r9RpJ/rmk3P9aPu9qvLrTmbOr36FqwppTQJDDw7Exh6PJG
         ILHFluPPRE/RqiJZCHdaob64J4resSRzyVQN6Frv3LqJIYbKnX2W4IgQta7kzxKTndc0
         kXTK3VfR0MGp7ackkjHdPHYNJpuqRlOXNC4J6c0LdQJKOg6h9L63pcb8CguAXNVW3uX0
         w8yg==
X-Received: by 10.28.24.85 with SMTP id 82mr19936081wmy.58.1452203431336;
        Thu, 07 Jan 2016 13:50:31 -0800 (PST)
Received: from slxbook3.fritz.box (p5DDB47F7.dip0.t-ipconnect.de. [93.219.71.247])
        by smtp.gmail.com with ESMTPSA id y8sm15444826wmg.9.2016.01.07.13.50.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Jan 2016 13:50:30 -0800 (PST)
In-Reply-To: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283510>

Hi,

does anyone have a few free cycles to take a look at this patch series?
I wonder if you deem it as not interesting or if it got lost.

Thank you,
Lars


On 21 Dec 2015, at 00:19, larsxschneider@gmail.com wrote:

> From: Lars Schneider <larsxschneider@gmail.com>
> 
> diff to v2:
> * remove workaround tests as suggested by Peff [1]
> * fix chain breakage introduced in 275cd18
> * add hints to the user if a submodule checkout fails while using the
>  depth argument [2]
> 
> Thanks,
> Lars
> 
> [1] http://article.gmane.org/gmane.comp.version-control.git/281237
> [2] http://article.gmane.org/gmane.comp.version-control.git/281420
> 
> Lars Schneider (3):
>  submodule: add test to demonstrate that shallow recursive clones fail
>  submodule: fix &&-chain breakage
>  submodule: extend die message on failed checkout with depth argument
> 
> git-submodule.sh               |  4 ++++
> t/t7406-submodule-update.sh    | 35 +++++++++++++++++++++++++---
> t/t7412-submodule-recursive.sh | 52 ++++++++++++++++++++++++++++++++++++++++++
> 3 files changed, 88 insertions(+), 3 deletions(-)
> create mode 100755 t/t7412-submodule-recursive.sh
> 
> --
> 2.5.1
> 
