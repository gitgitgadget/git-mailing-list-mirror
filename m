From: Mat Arge <argemat1010@gmail.com>
Subject: Re: signing commits with openssl/PKCS#11
Date: Thu, 25 Oct 2012 11:12:02 +0200
Message-ID: <2180562.jsxWbf0rnE@off17>
References: <1392235.RizYqAYdkC@off17> <5087B8E7.8010306@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 25 11:12:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRJUF-0001GG-5V
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 11:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934892Ab2JYJMJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 05:12:09 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:61619 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934834Ab2JYJMG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 05:12:06 -0400
Received: by mail-ee0-f46.google.com with SMTP id b15so510524eek.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 02:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:content-type;
        bh=wV70vYVSqRVBtVa+PIPGRsRhVvHdO7krRRzkcRED3nY=;
        b=b0ZY3AIvMjUTGIC5rOFJXXmMJTk00UlqzJjGpNcmIjY8QZdvoAk7FREZz/HmMITe/h
         o98kjbKpUETOm+59eGg1TVJQtwlfn9v3LlOySyMznNO2kqKkeB3mw1odBB6oF0PrKzxN
         MuUA+B7mH6O/wJMFY03wRy3zCUfLhQ95fFA5wPIhm7yxMNSi2noLFdHukxGPbI7R41iZ
         fGDdubyu+X4YpzBkrQrFIYqPm3g8xkvZBRgSzXPid9JVTv6n6NnuumCoPlUWkmQH5Nrl
         3iwk18+7ry0RMFnNahQsufXkJ12518UBWK7URJh07Lii7wDELfamWx/QCBvm0lChssK6
         R86Q==
Received: by 10.14.174.194 with SMTP id x42mr10245052eel.22.1351156325135;
        Thu, 25 Oct 2012 02:12:05 -0700 (PDT)
Received: from off17.localnet ([188.118.223.98])
        by mx.google.com with ESMTPS id f3sm22874081eeo.13.2012.10.25.02.12.03
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 25 Oct 2012 02:12:04 -0700 (PDT)
User-Agent: KMail/4.9.2 (Linux/3.4.11-2.16-default; KDE/4.9.2; i686; ; )
In-Reply-To: <5087B8E7.8010306@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208372>

On Wednesday 24. October 2012 11:46:15 Michael J Gruber wrote:
> Mat Arge venit, vidit, dixit 22.10.2012 15:38:
> > Hy!
> > 
> > I would like to sign each commit with a X.509 certificate and a private
> > key
> > stored on a PKCS#11 token. I assume that that should be possible somehow
> > using a hook which calls openssl. Does somebody know a working
> > implementation of this?
> > 
> > cheers
> > Mat
> 
> In principle, we have an almost pluggable architecture. See for example
> the latter part of the 2nd post in
> 
> http://article.gmane.org/gmane.comp.version-control.git/175127
> 
> Unless you want to change git itself, you're probably better off storing
> your non-gpg signatures in a note (or a self-created signed tag). 

So, there is no possibility to modify the commit itself via a hook, and add a, 
say, "opensslsig" instead of a gpgsig tag?

> To
> sign the commit rev, you could sign the output of "git cat-file commit
> rev" (or of "git rev-parse rev") and store that signature in a note that
> commit. To verify, you verify the note against the commit.
> 
> Michael

But if I crete/modify a signature file while commiting, that file wouldn't be 
commited itself, so the signatur-file would always be one commit behind. Or am 
I missing something? I'm quite new to git (or DVCSs in general), so sorry if 
this is a dumb question.

cheers
Mat
