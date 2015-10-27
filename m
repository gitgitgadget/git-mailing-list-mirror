From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 3/6] Facilitate debugging Git executables in tests with gdb
Date: Tue, 27 Oct 2015 19:09:12 +0100
Message-ID: <CACsJy8C94gzE0CQH=f5=qeMj=DnE3bJ3EnLYbhxgrTG=W4r89A@mail.gmail.com>
References: <cover.1445865176.git.johannes.schindelin@gmx.de> <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 27 19:09:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr8gx-0006YI-6u
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 19:09:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965030AbbJ0SJp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 14:09:45 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36769 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbbJ0SJn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 14:09:43 -0400
Received: by lbcao8 with SMTP id ao8so69809713lbc.3
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 11:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RP8wIZzyOcoikHmN6gpyzh/30TLtE31iTyYPJma7xQM=;
        b=fAK5SRhPrYLSdchRYd+y86q684lewMDTcjRC8m+7nMEfY0WhPqqW0NZVu2n3KWp+XJ
         8c010p7+ZQ68mYv6G6LtgknjnMd8g0fvQS9EB432qc2lpNNqjz7VuuzNN6K705GickkM
         +63Kaza87m6iHeXhZ/1yqka9V39I3ESkqTqIjZOdt2SYQ/PxmJWNMLIesRdF8dpcDDs7
         chlKL0c1T35yNm6zfD97r7wFMKNZORx5dvpYqycYvp/tKak+PrnS10N2Me6NS7oa0OYN
         +2cRB2bqM2mNCA/m2EUhCSb7pAQvtPXNVXkE67Xfh3FlBsVTJjsHiSqeMB+kgeA9RzzO
         VC2Q==
X-Received: by 10.112.16.67 with SMTP id e3mr20588847lbd.5.1445969381988; Tue,
 27 Oct 2015 11:09:41 -0700 (PDT)
Received: by 10.112.255.229 with HTTP; Tue, 27 Oct 2015 11:09:12 -0700 (PDT)
In-Reply-To: <082d6474a31c405b16087f76de7bc5d01faba529.1445865176.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280274>

On Mon, Oct 26, 2015 at 2:15 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> When prefixing a Git call in the test suite with 'TEST_GDB_GIT=1 ', it
> will now be run with GDB, allowing the developer to debug test failures
> more conveniently.

I'm very slowly catching up with git traffic. Apologies if it's
already mentioned elsewhere since I have only read this mail thread.

Is it more convenient to add a sh function "gdb" instead? Most of the
time I only want to stop one command, and I put "gdb /path/..../" in
front of "git ...". This gdb function could just expand to that THis
would make it a lot more convenient to debug (single command, not full
.sh file).

We can even go further with supporting gdbserver function, to launch
gdbserver, then I can debug from outside, works even without -v -i.
-- 
Duy
