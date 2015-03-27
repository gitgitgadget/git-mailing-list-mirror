From: Vitor Antunes <vitor.hda@gmail.com>
Subject: Re: [PATCH 2/2] git-p4: Fix copy detection test
Date: Fri, 27 Mar 2015 23:59:02 +0000
Message-ID: <20150327235902.25ebf380@pt-vhugo>
References: <1427418269-3263-1-git-send-email-vitor.hda@gmail.com>
	<1427418269-3263-3-git-send-email-vitor.hda@gmail.com>
	<xmqq619mw04r.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Pete Wyckoff <pw@padd.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 28 00:59:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ybe9r-0007pG-3T
	for gcvg-git-2@plane.gmane.org; Sat, 28 Mar 2015 00:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbbC0X7S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Mar 2015 19:59:18 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36542 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbbC0X7R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2015 19:59:17 -0400
Received: by wibg7 with SMTP id g7so43181841wib.1
        for <git@vger.kernel.org>; Fri, 27 Mar 2015 16:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=GtaicJj6pJrZ+DsEzEkuc68FFBSby96+fQLwMKz8sPc=;
        b=xsW50nxWOqXe4hAuWaLGS8LrQTdxZ2SuEJuCUUy68vrxfqf8BVfkBbz6y9WgffrZSs
         HKZWnBEw7LubtOxLFTQDP2fGH6/0q4XAmN3cYnNhdKkdt1PcU+BTDGGtIcgz25zhwRS2
         KlCA3Y7LrHnwSTAYCVXpFajK5TO037EEef6EVC8BoYIpTH+Cavin6H/CMWO69wJq2xfn
         aDJbhiIkdGbn60g8IUXx/4V29J5/LON+Iy1sk9MC4/EFBhDmARgN4sQxXl9DGMhbXBUB
         12AWYqgGtBkWZez+0Hvioh+IRoxKUNxwuDuCWxdbdvew0JKtVaqO62RRzPlfTezmj8KY
         vlRA==
X-Received: by 10.194.6.228 with SMTP id e4mr41340991wja.63.1427500756819;
        Fri, 27 Mar 2015 16:59:16 -0700 (PDT)
Received: from pt-vhugo (88.41.108.93.rev.vodafone.pt. [93.108.41.88])
        by mx.google.com with ESMTPSA id e2sm4856871wjy.46.2015.03.27.16.59.15
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Fri, 27 Mar 2015 16:59:16 -0700 (PDT)
In-Reply-To: <xmqq619mw04r.fsf@gitster.dls.corp.google.com>
X-Mailer: Claws Mail 3.8.1 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266405>

Junio C Hamano <gitster@pobox.com> wrote:

>Vitor Antunes <vitor.hda@gmail.com> writes:
>
>> File file11 is copied from file2 and diff-tree correctly reports this file as
>> its the source, but the test expression was checking for file10 instead (which
>> was a file that also originated from file2). It is possible that the diff-tree
>> algorithm was updated in recent versions, which resulted in this mismatch in
>> behavior.
>>
>> Signed-off-by: Vitor Antunes <vitor.hda@gmail.com>
>
>Pete, these tests blame to your 9b6513ac (git p4 test: split up big
>t9800 test, 2012-06-27).  I presume that you tested the result of
>this splitting, but do you happen to know if we did something to
>cause the test to break recently?

I also worked on these tests at that time and they were passing before and
after the reorganization. I'll prepare a bisect script and will try to find the
commit that started making this test fail.
