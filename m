From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.14
Date: Thu, 12 Feb 2009 02:08:14 +0100
Message-ID: <2c6b72b30902111708t4513aa18wca9b7306796509ce@mail.gmail.com>
References: <20090205204436.GA6072@diku.dk> <49930F1A.6030509@tedpavlic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Ted Pavlic <ted@tedpavlic.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 02:09:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXQ5O-0005l1-VH
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 02:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333AbZBLBIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 20:08:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753890AbZBLBIV
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 20:08:21 -0500
Received: from mail-bw0-f161.google.com ([209.85.218.161]:41889 "EHLO
	mail-bw0-f161.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752903AbZBLBIU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 20:08:20 -0500
Received: by bwz5 with SMTP id 5so686545bwz.13
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 17:08:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=cC+M0WTgLIybaksp5XPM2CACtbFTwvq1ux2DFLYbzmg=;
        b=EYhRhBne6uNC44TkL9PyBbax/7v5NJCORpEwOyOmp3aeEfGQrXpgHhtQ5Ze7FN+d0H
         bGZY7A3WFIYvl/mpeicDBCodRU6JrovmvwqOPJIndpqTa41IXV+Sgqyxb0/O2rpf0Hse
         81nU3zvHGtXcmp6kJL8G44woRTw7LPjF39XaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=AA7JfGabEVxOUiwM+4dXGB7ehGeKK/Sguu6Q8cA4lJTjeqpk2ZxeUVzRrdvNDfVkSF
         yssKKVOBt7z1/0yINw2u6jpdujR8a4Qixgk1phAvkZWCHJlvfJFo/k/5R634RyNwWEh4
         e3D6McXmlOmC1Ih9da3w0fRnv2NJqk2j9p1WI=
Received: by 10.181.141.7 with SMTP id t7mr101430bkn.10.1234400894324; Wed, 11 
	Feb 2009 17:08:14 -0800 (PST)
In-Reply-To: <49930F1A.6030509@tedpavlic.com>
X-Google-Sender-Auth: d410a65c52c2aebd
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109552>

On Wed, Feb 11, 2009 at 18:47, Ted Pavlic <ted@tedpavlic.com> wrote:
> *) Is there any way for "tig" to emulate "less -R"?
>
> That is, if an output is already colorized, can tig just pass through the
> ANSI?

Tig is heavily tied to ncurses and as far as I know ncurses does not
support this. So it would require tig to parse the ANSI terminal codes
into some representation from which the equivalent calls to the
ncurses API is made.

> *) When doing "git diff|tig" when there directory is clean, tig should
> probably exit immediately, right?

Yes, good idea. The blame and main view currently does this too. Will
look into it.

> *) Also, is there a way to configure "tig" to colorize and *exit* if the
> piped text doesn't fill a page?

No. However, this I have actually considered to support at some point,
since it would make it possible to test the rendering. Again, this is
not something ncurses supports as far as I know, so would require some
kind ofl "ANSI" code emitter.

> (in other words, I'd like "tig" to be able to replace my current "less -FRX"
> pager)

It will probably take a some time to get there, but I am open to
moving in this direction.

-- 
Jonas Fonseca
