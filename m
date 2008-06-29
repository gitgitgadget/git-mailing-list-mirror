From: Lea Wiemann <lewiemann@gmail.com>
Subject: Re: perl t9700 failures?
Date: Mon, 30 Jun 2008 00:56:15 +0200
Message-ID: <4868130F.2080600@gmail.com>
References: <alpine.LFD.1.10.0806291241210.27776@hp.linux-foundation.org> <7vzlp47zy8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 30 00:57:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KD5pe-00078m-Qr
	for gcvg-git-2@gmane.org; Mon, 30 Jun 2008 00:57:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752563AbYF2W4U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 18:56:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbYF2W4U
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 18:56:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:42541 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751950AbYF2W4U (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 18:56:20 -0400
Received: by fg-out-1718.google.com with SMTP id 19so643012fgg.17
        for <git@vger.kernel.org>; Sun, 29 Jun 2008 15:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:from;
        bh=9tLbEQgf6QPCb/fxfRUh5g3Qo580o7r5xPD+qoqaTiw=;
        b=aZD3EObyjEsaW6RXBWTPpLbMZFUXhx0YPnx3bZ1GjND3oW+OmJ/RhbvIiIvFVeTwFY
         FlBUg0AQp0EwTg+wEUBYtnonfiAySGXxhM9VyQnUkNZdZE72QQf4ApkQi2tsrp2SzIRX
         m7rdUB7fiCfTE/pU33otdQm+yX0mWExSDZyqE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:user-agent:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding:from;
        b=H1+f3lcM4r9KlBRQaMev7qarlO1CWBzT+7qhpI3WFMOKT3n2FNe2liMbuK/3FXVNO9
         dPZZg6ioDksdivIPgCBYDlQKzmh7MYM+hTWIH1na0JhnwytApPCkdpJkAvE/JcoO7w9g
         H3otyOogBV/vCeuhTrk8+TP7Z5O0E7uOb9+m0=
Received: by 10.86.70.11 with SMTP id s11mr5254065fga.71.1214780178197;
        Sun, 29 Jun 2008 15:56:18 -0700 (PDT)
Received: from ?172.16.30.128? ( [91.33.203.119])
        by mx.google.com with ESMTPS id d4sm7682658fga.8.2008.06.29.15.56.16
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 29 Jun 2008 15:56:17 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.14) Gecko/20080421 Thunderbird/2.0.0.14 Mnenhy/0.7.5.666
In-Reply-To: <7vzlp47zy8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86847>

Junio C Hamano wrote:
> +perl -MTest::More -e 0 2>/dev/null || {
> +	say skip "Perl Test::More unavailable, skipping test"

That looks fine -- the git scripts that use Git.pm are still tested
separately, so even if this test is skipped, Git.pm can be assumed to
not be broken.

Jakub Narebski wrote:
> +perl -MTest::More -e '' >/dev/null 2>&1 || {
> [...]
> +perl -e 'use 5.006002;' >/dev/null 2>&1 || {

I don't think checking for 5.6.2 (which is the version in which
Test::More was added) is actually necessary.  If someone installs
Test::More on an older Perl version, we might as well run the tests --
apparently Git.pm works even with older versions, since
t3701-add-interactive.sh seems to work fine for Linus.

Johannes Schindelin wrote:
> And given that I _actively_  warned [...] I
> am actually a little pleased

Johannes, I'd actually be a little pleased if you either

- stop "actively warning" and start actively sending patches, or
- spare the list (and in particular, my mailbox) your whining.

TIA.
