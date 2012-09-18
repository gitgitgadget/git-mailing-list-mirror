From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH 4/4] rebase -i: Add tests for "--edit-todo"
Date: Tue, 18 Sep 2012 01:23:08 -0400
Message-ID: <5058053C.6080206@gmail.com>
References: <CANiSa6j2zA5P6yDaR7VU416Bzes6xbWuHbU83=BGN67Wo9j_Cw@mail.gmail.com> <1347931690-20625-1-git-send-email-andrew.kw.w@gmail.com> <1347931690-20625-5-git-send-email-andrew.kw.w@gmail.com> <CANiSa6jcBWbeydMViruM1UYanhHiEugfHa5DepjGNdizq2otbA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 07:26:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TDqKo-0000WZ-5p
	for gcvg-git-2@plane.gmane.org; Tue, 18 Sep 2012 07:26:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755047Ab2IRF0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2012 01:26:48 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64779 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754791Ab2IRF0U (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2012 01:26:20 -0400
Received: by qcro28 with SMTP id o28so5104308qcr.19
        for <git@vger.kernel.org>; Mon, 17 Sep 2012 22:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=45MGnTl+WA8MVuj4XeEZG8wp3FJ8N0d3FuCagybDtf8=;
        b=Bi4z4CSAEuHP5qeRheu85OTdn8C4tJhiKe3uhYhJGckRA0cXXYp8Bv0XbK4+XlV4Mp
         3NL8yqGLodDyjfZ/SeyTcBkrKYxSCQyIA17xY90P5CoSMSxnJhlVVIxVWU781dz6zxsX
         +m+cLReaursFj07gsCxZSu3GoFUGKc8J4hxXgYg2Upa0SP7fxNN0zSFiRUBZ/SfXFh5j
         LKfb8Q3RypSmVS5peoAwjWQqUMO4sHWk5GD7n9o8gg0nmT3pFoLDMEaFuLRRP2Khc5wl
         k4ncFrV9CtLZ+1QGMlbL1GNs4N/BcPfK+0rI/jic7EJVApshRvFstbRS5CxCrjXwpBxN
         p2GA==
Received: by 10.224.177.15 with SMTP id bg15mr32448189qab.85.1347945979881;
        Mon, 17 Sep 2012 22:26:19 -0700 (PDT)
Received: from [192.168.1.3] ([69.165.255.59])
        by mx.google.com with ESMTPS id ca8sm18233442qab.20.2012.09.17.22.26.18
        (version=SSLv3 cipher=OTHER);
        Mon, 17 Sep 2012 22:26:19 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.4) Gecko/20120602 Thunderbird/10.0.4
In-Reply-To: <CANiSa6jcBWbeydMViruM1UYanhHiEugfHa5DepjGNdizq2otbA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205790>

On 09/18/12 00:58, Martin von Zweigbergk wrote:
> On Mon, Sep 17, 2012 at 6:28 PM, Andrew Wong <andrew.kw.w@gmail.com> wrote:
>> +       test M = $(git cat-file commit HEAD^ | sed -ne \$p) &&
>> +       test L = $(git cat-file commit HEAD | sed -ne \$p)
> I couldn't find "$" (match last line) in the POSIX man page for sed.
> Besides, I think $(git show -s --format=%s HEAD) reads better.
It's under "Addresses in sed":
        ... a '$' character that addresses the last line of input ...
from:
        http://pubs.opengroup.org/onlinepubs/009695399/utilities/sed.html

Various places in that test get the content of files that way, so I
thought it's better to just follow the rest of the test. I agree that
there are better ways to achieve the same thing though.
