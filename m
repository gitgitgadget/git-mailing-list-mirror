From: Tor Arntsen <tor@spacetec.no>
Subject: Re: [PATCH 3/5] Dangling commas in enum is not portable (resend)
Date: Sun, 25 Apr 2010 15:12:37 +0200
Message-ID: <l2od2d39d861004250612g9ac6c7b4qdaa8ce0f973846e7@mail.gmail.com>
References: <20100311163235.GC7877@thor.il.thewrittenword.com>
	 <94a0d4531003120118l2a5c69ebh7e62ea8630f94738@mail.gmail.com>
	 <20100315031718.GA21130@thor.il.thewrittenword.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: "Gary V. Vaughan" <git@mlists.thewrittenword.com>
X-From: git-owner@vger.kernel.org Sun Apr 25 15:12:54 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O61dk-00036d-IL
	for gcvg-git-2@lo.gmane.org; Sun, 25 Apr 2010 15:12:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab0DYNMk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Apr 2010 09:12:40 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:7098 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752760Ab0DYNMj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Apr 2010 09:12:39 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1937891fga.1
        for <git@vger.kernel.org>; Sun, 25 Apr 2010 06:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=FG9VLceU6/OD/+iHHn4qX0JyF5Z8fI2foq6vNE1wCjo=;
        b=rdaq+zXoWlMpgsIpQ4UqrGnsF2dJIs25RZd8bSSyLjd3GVO7xtZHVdtdVm3bgDkkt2
         AQGmuqDd4o6AtYspKbLNQo4IceW0ZzM2Ou+C+iUCm/tDPC9k2BpQmgYWuP7WySuABGVd
         TCBFqRyPOHtDsYHeG8CeE7ZQUzK4IhekL2mEU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=JmzPxYU3ThB6cELCYe8uoUt1CKgc6mZRdnT9JGRkN025CbJLaHsuMFza6dO0sF9VEs
         xRzizSB9jqXnY5QhPLM5cNMdnJVkc6HdGcabQyfh4iJqFTn8PM1ybC2CTOklDR2pq9uw
         OuEqfHOLnQWt/HUZcE9UmpOxwCuoRxgd6RpeE=
Received: by 10.239.193.147 with SMTP id j19mr223429hbi.147.1272201157870; 
	Sun, 25 Apr 2010 06:12:37 -0700 (PDT)
Received: by 10.239.179.197 with HTTP; Sun, 25 Apr 2010 06:12:37 -0700 (PDT)
In-Reply-To: <20100315031718.GA21130@thor.il.thewrittenword.com>
X-Google-Sender-Auth: 639beef776a4e744
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145739>

On Sun, Apr 25, 2010 at 10:35, Gary V. Vaughan
<git@mlists.thewrittenword.com> wrote:

> I take it back. =A0I've been porting this patch forward from our buil=
ds
> of previous releases, and at some point it certainly was necessary
> (otherwise I wouldn't have written the patch)... and yet, all of our
> platforms are now able to compile a minimal test program in C.
> Either the offending vendor compilers have issued an update to accept
> the dangling comma syntax, or we have retired the machines that used
> to have this problem since I originally wrote the patch.
>
> It's notable that aCC (the HP C++ compiler) and CC (the SunOS C++
> compiler) both issue a warning on dangling enum commas, but even they
> still compile successfully.
>
> Sorry for the noise,

The SGI MIPS Compiler v6.2 on IRIX 6.2 compiles, but with a warning.
Later MIPSPro 7.2 and 7.4 versions (on 6.5) are OK (silent)
Unfortunately IBM VisualAge C 5.0 (I have 5.0.2) on AIX 5.1 fails to
compile with a trailing comma.
IBM XLC V10.1 (I have one on AIX 6.1) is OK (silent)
Native compiler on Tru64 V5.1 is OK (silent)

So, from the boxes I have access to the IBM XLC V5 version is the one
which has a problem.

-Tor
