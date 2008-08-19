From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: Dumb "continuous" commit dumb question
Date: Tue, 19 Aug 2008 16:02:54 +0100
Message-ID: <e1dab3980808190802r202aadc0p2cf8431f645354e3@mail.gmail.com>
References: <48AA4263.8090606@gmail.com>
	 <e1dab3980808190732i303f06ach50e36e13a624bd23@mail.gmail.com>
	 <32541b130808190754l43f053abnc4e3c5c064d6ade7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Pat LeSmithe" <qed777@gmail.com>, git@vger.kernel.org
To: "Avery Pennarun" <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 19 17:04:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVSke-0005C7-DC
	for gcvg-git-2@gmane.org; Tue, 19 Aug 2008 17:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752604AbYHSPC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2008 11:02:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752520AbYHSPC5
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Aug 2008 11:02:57 -0400
Received: from mail-gx0-f16.google.com ([209.85.217.16]:40763 "EHLO
	mail-gx0-f16.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752500AbYHSPC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2008 11:02:56 -0400
Received: by gxk9 with SMTP id 9so5118146gxk.13
        for <git@vger.kernel.org>; Tue, 19 Aug 2008 08:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=xPzTiXAHSbn5f0GcHxWeBFkozXK7VtjBSYkqBfXssds=;
        b=lM1p3T95TZokzw62Su9jqo95kALzSg5XUDtcBNP+USWkHzxh7M57RtAATdPZWKdY8s
         eiFierOvNI7tZI1+c00s6SDlDk20cW/MmZCQaXzXHad6GaGx9cfapxvnHVtvp21yOf7O
         V8ge7DzLndz4InKvpm3m5fpSDzeSKv5hJR93A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=Iz/KD9CDJxpCfcDKw2KlxUsMVpnXu4cyxwPHyNGkQSa2kZx6aVR2S9pBYc0jFnwT4q
         U2V9LGHsCr5Ou3ygnn0qLf9oSj1kcNy2mElDWPllrgBnYRn4SHQ5lic1z3o55uhdkQOL
         hv74XDgrCyVLV3nWJl3sklEnEtuCs3qs+8JNU=
Received: by 10.142.134.17 with SMTP id h17mr2546105wfd.346.1219158174941;
        Tue, 19 Aug 2008 08:02:54 -0700 (PDT)
Received: by 10.142.136.18 with HTTP; Tue, 19 Aug 2008 08:02:54 -0700 (PDT)
In-Reply-To: <32541b130808190754l43f053abnc4e3c5c064d6ade7@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92874>

On Tue, Aug 19, 2008 at 3:54 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> You could just have a makefile rule or bash alias that does something
> like "make && git commit -a -m temp".  Then remember to always run
> that instead of 'make' when you're building.

As ever, I wanna do something more deviant than that :-) . The idea is
to take a snapshot (if any tracked file has changed) roughly every ten
minutes. If there happens to have been a successful compile around
that time (+/- 1 minute say), grab the snapshot (including detecting
potential newly created files) then. But if there hasn't, I still want
a snapshot roughly on that 10 minute interval. I could try doing
something like "git reset --soft HEAD~1 && git commit -a" if a make
succeeds within 1 minute, on a strictly chronological snapshot but
scripted resets make me a bit nervous.

It's not hyper-important, just something I'm thinking about.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
