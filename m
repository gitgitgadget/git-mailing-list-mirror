From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Minor bug report
Date: Wed, 03 Jun 2015 17:39:14 +0200
Message-ID: <1433345954.21083.14.camel@kaarsemaker.net>
References: <CAMOUyJ_2snCaKcWNoOgH7aoHrdbUsCucqu_W_J3aH9_QQe1jEw@mail.gmail.com>
	 <20150603062005.GA20580@peff.net>
	 <CAPc5daU9VdndgkMFNmtiwhVdwyGQgDbFX3rrrsEEEUVewgs-dw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Tummala Dhanvi <dhanvicse@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 03 17:39:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z0AlH-0008Aa-Ac
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jun 2015 17:39:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753816AbbFCPjU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jun 2015 11:39:20 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33325 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752604AbbFCPjS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jun 2015 11:39:18 -0400
Received: by wiwd19 with SMTP id d19so57180789wiw.0
        for <git@vger.kernel.org>; Wed, 03 Jun 2015 08:39:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=Vl6sCN4dtLGi62Fg8tcJ7OvIX9wlSuWYnrnzpk+hkOI=;
        b=NlHPCwa2sEhFsWjzAuMUCnrdm2zeff8dBtwzKZW7rwpgw2h3RdfDtSzV0EwZGFdlUb
         i7TBVbF0yHUL2mHa3y15ObNGd+n51G2LqUBABsQx1aIP7YTzEc2MLdkGeetr3U5QLnjC
         r/Hm2rDA+GwTLOtqsN1Q82qmUH+NFdW3nkG0DmIoYC+D2wim/2LDinVulBrVVVQTwF4j
         LE6JMrU9+RqteCSvq9HQM8BIpuByeIEY7a3Xaq0w5LbmtvLTzIfimG6NzFEh7WdnJoPn
         YpkzVY9WZLt6cK0sXoixuUxkkYPrXKxMix1VF0iY6TXLA8Xly4DSfePciJuRxixiwAnM
         EZNA==
X-Gm-Message-State: ALoCoQnqSbYzn84GN9vIznfVYsObI4f7ypEP7mS1OOAz9KyQVPYMyctlA4NFQT3g+mmTs0m5yBN6
X-Received: by 10.194.200.228 with SMTP id jv4mr60753920wjc.157.1433345956858;
        Wed, 03 Jun 2015 08:39:16 -0700 (PDT)
Received: from spirit.home.kaarsemaker.net (82-171-80-33.ip.telfort.nl. [82.171.80.33])
        by mx.google.com with ESMTPSA id o4sm5476893wib.5.2015.06.03.08.39.15
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2015 08:39:16 -0700 (PDT)
In-Reply-To: <CAPc5daU9VdndgkMFNmtiwhVdwyGQgDbFX3rrrsEEEUVewgs-dw@mail.gmail.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270690>

On di, 2015-06-02 at 23:48 -0700, Junio C Hamano wrote:
> 
> I am kind of surprised after reading these two threads that my
> take on this issue has changed over time, as my knee-jerk
> reaction before reading them was the opposite, something
> along the lines of "This is only immediately after 'git init'; why
> bother?". Or depending on my mood, that "How stupid do you
> have to be..." sounds exactly like a message I may advocate
> for us to send. Perhaps I grew more bitter with age.

The "fatal: Failed to resolve 'HEAD' as a valid ref." message, closely
related to the "fatal: bad default revision 'HEAD'" message that started
this thread just came by in #git with the following situation:

$ git init
$ git add .
# Oops, didn't want to add foo.xyz
$ git reset foo.xyz
fatal: Failed to resolve 'HEAD' as a valid ref.

The solution there is simple, git rm --cached, but I think git could
produce more helpful messages when a repo is empty.

I think you are growing bitter with age ;)

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
