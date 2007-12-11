From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 21:29:59 +0100
Message-ID: <e5bfff550712111229i227361e9s1a6dcbed9a13019d@mail.gmail.com>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com>
	 <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
	 <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Linus Torvalds" <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Daniel Berlin" <dberlin@dberlin.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 21:30:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2BkE-0006nJ-9C
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 21:30:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751841AbXLKUaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 15:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751410AbXLKUaA
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 15:30:00 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:56455 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbXLKU37 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 15:29:59 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2159173rvb
        for <git@vger.kernel.org>; Tue, 11 Dec 2007 12:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=iamFoon4dzMkrladm7UjqlWq8UydxvpCYzyokor/caI=;
        b=fIhFwinjarfCAoY6vIFRj24t6fBQ6qpc1T7JjIO1E/VlrbaYBQpeJG1l3N4UNErKueBxo/wA3PiW9UCJUlm/n8y7vm1npguQjo2eLY5/KdMN95aneHGhabrmlZnMMej7x6eQ8I8lvuXUHm4D3i8jrrsMh0fvKVh2ybqwu87zY5Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rsXd3kpawAWIN44JTVip6uS6EwZX8XSljw8kn+/pRAFheKMVaQjeSM/dnWN4ez3l7KZ1XkzQSTlRVa6nTtv554UGwWQCNchJJEzDxeaNOikfdHqs2gMHdET/ooMAj0fAVIakLnUQLriAxmXXWOn4LXrBrgPONVc0n4nTIrUE22s=
Received: by 10.141.198.8 with SMTP id a8mr2588653rvq.1197404999391;
        Tue, 11 Dec 2007 12:29:59 -0800 (PST)
Received: by 10.141.76.1 with HTTP; Tue, 11 Dec 2007 12:29:59 -0800 (PST)
In-Reply-To: <4aca3dc20712111109y5d74a292rf29be6308932393c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67933>

On Dec 11, 2007 8:09 PM, Daniel Berlin <dberlin@dberlin.org> wrote:
>
> In GCC history, it is likely you will be able to cut off at least 30%
> of the time if you do this, because files often have changed entirely
> multiple times.
>

This could be useful for a command line tool but for a GUI the top
down approach is a myth IMHO.

In the GUI case what you actually end up doing (because a GUI allows
it) is to start from the latest file version, check the code region
you are interested then when you find the changed lines you _may_ want
to double click and go to see how it was the file before that change
and then perhaps start a new digging.

I found this is my typical workflow with annotation info because I'm
more interested not in what lines have changed but _why_ have changed
and to do this you naturally end up digging in the past (and checking
also the corresponding revisions patch as example in another tab)

In this case the advantage of oldest to newest annotation algorithm is
that you have _already_ annotated all the history so you can walk and
dig back and forth among the different file versions without *any*
additional delay.

Marco
