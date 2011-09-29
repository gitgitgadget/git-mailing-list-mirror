From: Chris Mear <chrismear@gmail.com>
Subject: Re: [PATCH] contrib: add a pair of credential helpers for Mac OS X's keychain
Date: Thu, 29 Sep 2011 09:19:42 +0100
Message-ID: <53869134-BC37-4B71-AB90-E7F1AABC633B@gmail.com>
References: <1316055113-2353-1-git-send-email-jaysoffian@gmail.com> <20110929075627.GB14022@sigill.intra.peff.net>
Mime-Version: 1.0 (1.0)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Jay Soffian <jaysoffian@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	John Szakmeister <john@szakmeister.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 29 10:23:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9Btb-0001n8-AC
	for gcvg-git-2@lo.gmane.org; Thu, 29 Sep 2011 10:23:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755464Ab1I2IXA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Sep 2011 04:23:00 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:51194 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755298Ab1I2IW6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Sep 2011 04:22:58 -0400
Received: by wwn22 with SMTP id 22so2677094wwn.1
        for <git@vger.kernel.org>; Thu, 29 Sep 2011 01:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=subject:references:from:content-transfer-encoding:content-type
         :in-reply-to:message-id:date:cc:to:mime-version:x-mailer;
        bh=mlxKfKMt91M9nkpBYih6pYVoNJ2JYqoeOWZWGbn5rPA=;
        b=sQq20T8dR6fbSyDBIxtQ2d+Oj+l1Et9dGM8fSL0TVvb4KOGOJ0Lo1LYEMpfkYHhZtb
         v+luWjDMBXW6yw/3EZZ5b1yUXa23Jl+rwS5LCC6hPN5mNS3VpGI+WdfSQgXpvl+zTG7K
         kstDB4fDMFb6VTSoRYB+mGYI7WajnaFV13hpk=
Received: by 10.227.197.207 with SMTP id el15mr4893619wbb.31.1317284575990;
        Thu, 29 Sep 2011 01:22:55 -0700 (PDT)
Received: from [10.22.210.56] ([82.132.210.70])
        by mx.google.com with ESMTPS id n21sm1332643wbp.2.2011.09.29.01.20.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 29 Sep 2011 01:22:54 -0700 (PDT)
In-Reply-To: <20110929075627.GB14022@sigill.intra.peff.net>
X-Mailer: iPhone Mail (9A5313e)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182388>

On 29 Sep 2011, at 08:56, Jeff King <peff@peff.net> wrote:

>> Here's a C version that no longer links to git. I also kept the original
>> Python version as an example. I decided not to call out to
>> 'git credential-gitpass' as it was simple enough to manage /dev/tty
>> and there's no portability issues since this is OS X specific.
> 
> This was my first one. I kind of expected there to be some kind of
> graphical password dialog. Especially because keychain will pop up a
> dialog and ask you "is it OK for git to access this password?". So I
> sort of assumed that people would assume that credentials happened
> outside of the regular terminal session (I see the same thing on Linux,
> for example, with gpg-agent, which will open a new window and grab
> focus).
> 
> But I have no idea what's "normal" on OS X.

It's normal for applications on OS X to present their own UI when asking for credentials in order to save them to the keychain. For example, web passwords stored by Safari are captured via the normal web page form elements, but stored in the keychain.

That said, most terminal applications aren't aware of the Mac OS X keychain. So I suppose it may surprise users to come across the password prompt in the terminal UI, even though that is the same pattern that graphical programs follow.

But it's not without precedent: I'm pretty certain Subversion collects credentials directly in the terminal for storage in the keychain.

Chris
