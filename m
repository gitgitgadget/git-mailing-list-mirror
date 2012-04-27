From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: ref-format checking regression
Date: Fri, 27 Apr 2012 14:57:53 +0200
Message-ID: <CACBZZX6i9C-RyB9-jtJkHjYOpqgDmDcBFwe10RP+bu5PGTmP9Q@mail.gmail.com>
References: <20120427115000.GA8126@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 27 14:58:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SNkkd-0002cx-LI
	for gcvg-git-2@plane.gmane.org; Fri, 27 Apr 2012 14:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759980Ab2D0M6P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Apr 2012 08:58:15 -0400
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41682 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758539Ab2D0M6O (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2012 08:58:14 -0400
Received: by eekc41 with SMTP id c41so185910eek.19
        for <git@vger.kernel.org>; Fri, 27 Apr 2012 05:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=jLXbVyyJNhcBmyO3oZ6CctBzdUNO3VC4qIaN4ZqSA9A=;
        b=Oz6xJLpUuJh9ucziqcgGE6wDY4Jy9JObZUCL1aBRf/GGapnJvyNtKdyyCXtET1+G8U
         rCPMV7ZsGsQ7pHo1c9491Xs9Y8bQZdwwMqqH7f+8HzTKG4lA7tW8GaNjaTZbOhdXT8/b
         Caxfs9XQ2pGmSDt4Q5AdUY1wUlntOTWJGVTKrq21n95TClKjvbz0YvsZNTWA/zjUIU3Y
         PUyPlVBCIMSFDnPALApSEA4mH+uejDo5bJ4pXd7Py7k4Ar9+orfBpwSKlGGWx+aNbcN6
         yItTTGhzESTz5n2fI8ZLrvBLsMUnuuS4TVlbpvnb7w48yXOjnCV1zRFRZscDy9WfG8/o
         W9/A==
Received: by 10.14.136.10 with SMTP id v10mr986487eei.76.1335531493320; Fri,
 27 Apr 2012 05:58:13 -0700 (PDT)
Received: by 10.213.108.81 with HTTP; Fri, 27 Apr 2012 05:57:53 -0700 (PDT)
In-Reply-To: <20120427115000.GA8126@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196469>

On Fri, Apr 27, 2012 at 13:50, Jeff King <peff@peff.net> wrote:
> I seem to recall discussing this format-tightening and trying to be sure
> that users were left with a way forward for fixing their repos. But I
> can't find the discussion, and I don't recall any conclusion we came to.
> So maybe we decided not to worry about it. But I thought I'd mention it
> as a data point.

Wasn't that the one about the tightening of the ref checks breaking
git clone --mirror?

In any case we should be strict on input and loose when going over
existing data. It seems to me that we're using one function now to
check the validity of refs when we should be using two, one for new
refs, and one for reading existing data.
