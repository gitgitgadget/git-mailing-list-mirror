From: "Lars Hjemli" <hjemli@gmail.com>
Subject: Re: [PATCH 0/5 v2] Introduce the .gitfile
Date: Mon, 18 Feb 2008 13:56:37 +0100
Message-ID: <8c5c35580802180456s75c9f857of1f727aca4673374@mail.gmail.com>
References: <1203331463-13857-1-git-send-email-hjemli@gmail.com>
	 <alpine.LSU.1.00.0802181214400.30505@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <gitster@pobox.com>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 18 13:57:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR5YY-00036D-Ld
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 13:57:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbYBRM4j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 07:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751185AbYBRM4j
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 07:56:39 -0500
Received: from wa-out-1112.google.com ([209.85.146.182]:18890 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751443AbYBRM4i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 07:56:38 -0500
Received: by wa-out-1112.google.com with SMTP id v27so2787097wah.23
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 04:56:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=0yzPYz/f9aOGmBH0XNCIoZq7Uyyd5TDIL0ycEhxk3Qo=;
        b=MvMbTJOclJOTDkQ/n6HROT2FWLwdahEXvRq2v7lWZxcEdYcIySXxX+GYhuE+wsGGbqQBF0NwMSrApkmxdDxeb8gteOdcL7EGMWTcpO6afgRfev+UQ9ad0+Ff+uk+TTXiXhAz9XXe2wH5grmgZqILWHjFScDGpFy4YzR4sUQawbA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HxLEGa9KHyxkrFzWL+5BHTF3AtgqfdYReCad7XkzwfCsvBumE6G5ycj5GmUs5AUh8en1SC6cl2wq5HvtEHs//USzMXvytyk+yX7jRFdulUfgCz5DjeSj8GOugXG9WOVyTzjGCcHFTiWeLI9lmqyxgYxDs2CrLaIe8OVuqmK5kPY=
Received: by 10.115.90.1 with SMTP id s1mr3271568wal.50.1203339397521;
        Mon, 18 Feb 2008 04:56:37 -0800 (PST)
Received: by 10.115.92.8 with HTTP; Mon, 18 Feb 2008 04:56:37 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802181214400.30505@racer.site>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74278>

On Feb 18, 2008 1:17 PM, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Mon, 18 Feb 2008, Lars Hjemli wrote:
>
> > The patch-series has been reordered and updated according to comments on
> > the earlier series.
>
> It would be easier on a stupid reviewer like me, if you summarised what
> you changed.

Ok, I'll keep that in mind next time, and here's a quick summary (from
the top of my head) of this series vs. the previous:
* patch 1 and 2 are swapped, since the changes to git-sh-setup.sh can
be applied onto master regardless of the rest of the patch series
(while the other patches still rely on 1/5).
* git-sh-setup.sh is simplified even further, and relies on
git-rev-parse to produce the error message when no gitdir can be
found.
* read_gitfile_gently() is moved from environment.c into setup.c since
it now invokes is_git_directory().
* read_gitfile_gently() will gently ignore a 'missing' .git or a .git
which isn't a regular file, but die()s on all other errors.


> In the case of patch "1/5 => 2/5", I would even have
> appreciated an interdiff...

Sorry, but I don't think I understand what you mean by interdiff.


>
> Oh, and I was kind of surprised to learn that it is the ".gitfile", not
> the ".git file"... I ran to your patch straight away, and was relieved
> when I found out that you still call it ".git".

Yeah, I suck really bad on consistency ;-)


--
lh
