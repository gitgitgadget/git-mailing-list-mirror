From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Something is broken in repack
Date: Tue, 11 Dec 2007 01:20:37 -0500
Message-ID: <9e4733910712102220u47601845q60ccfd754e71936b@mail.gmail.com>
References: <9e4733910712071505y6834f040k37261d65a2d445c4@mail.gmail.com>
	 <9e4733910712101825l33cdc2c0mca2ddbfd5afdb298@mail.gmail.com>
	 <alpine.LFD.0.99999.0712102231570.555@xanadu.home>
	 <9e4733910712102125w56c70c0cxb8b00a060b62077@mail.gmail.com>
	 <BAYC1-PASMTP08CFB6F824B1282649E5EAAE640@CEZ.ICE>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: Sean <seanlkml@sympatico.ca>
X-From: git-owner@vger.kernel.org Tue Dec 11 07:21:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1yUG-0007TI-Jx
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 07:21:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751848AbXLKGUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 01:20:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751840AbXLKGUj
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 01:20:39 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:51499 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751813AbXLKGUi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 01:20:38 -0500
Received: by wa-out-1112.google.com with SMTP id v27so3810028wah
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 22:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4HdRnBdxBW8L08vKgjnxzcFixJeD5N6Yiw2Fd4PisnM=;
        b=vBUMj+/TopsrJpwxDFP9Rbz5dQcN6EIPXBhntE0OfwPZP93M+YTtMG1up89gx2zYfFMSWi+lLja/qruWi5KTnZNpgk0dP5fSLhGHBBe82zpMeopSwh9amnHYGJvtM5OGklhbO2GGeLWLjjpGD7c6EKqvwjTWB60JITgAmwKmu1E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=m2XW3AW8LQ9YeTZgNsSQC5mKyGRhRFLN49aXTHNlajGV7vgneX1aIQDUWxqvfg5kTmK+t4dKA5poxBdj8CeRF7LYyn7KplymhVubjeojyCPmn9N/R9IhclB1NIFV1R+/7GmXh2d33xJLWKq+8oPDEe5CX8phLzkavVyyg21MymA=
Received: by 10.115.111.1 with SMTP id o1mr229530wam.1197354037689;
        Mon, 10 Dec 2007 22:20:37 -0800 (PST)
Received: by 10.114.208.17 with HTTP; Mon, 10 Dec 2007 22:20:37 -0800 (PST)
In-Reply-To: <BAYC1-PASMTP08CFB6F824B1282649E5EAAE640@CEZ.ICE>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67799>

On 12/11/07, Sean <seanlkml@sympatico.ca> wrote:
> On Tue, 11 Dec 2007 00:25:55 -0500
> "Jon Smirl" <jonsmirl@gmail.com> wrote:
>
> > Something is hurting bad with threads. 170 CPU minutes with one
> > thread, versus 195 CPU minutes with four threads.
> >
> > Is there a different memory allocator that can be used when
> > multithreaded on gcc? This whole problem may be coming from the memory
> > allocation function. git is hardly interacting at all on the thread
> > level so it's likely a problem in the C run-time.
>
> You might want to try Google's malloc, it's basically a drop in replacement
> with some optional built-in performance monitoring capabilities.  It is said
> to be much faster and better at threading than glibc's:
>
>   http://code.google.com/p/google-perftools/wiki/GooglePerformanceTools
>   http://google-perftools.googlecode.com/svn/trunk/doc/tcmalloc.html
>
>
> You can LD_PRELOAD it or link directly.

I'm 45 minutes into a run using it. It doesn't seem to be any faster
but it is reducing memory consumption significantly. The run should be
done in another 20 minutes or so.


>
> Cheers,
> Sean
>


-- 
Jon Smirl
jonsmirl@gmail.com
