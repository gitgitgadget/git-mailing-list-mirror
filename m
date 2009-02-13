From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Unexpected local changes immediately after fresh clone
Date: Fri, 13 Feb 2009 00:56:28 -0500
Message-ID: <76718490902122156l547a5bd8j56e48d7d3c7c4438@mail.gmail.com>
References: <3D94CDCE-88EB-479A-9D36-6B92FCFCBAF4@hoskings.net>
	 <76718490902122141h578a72e3k70366d6583d6c8c3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ben Hoskings <ben@hoskings.net>
X-From: git-owner@vger.kernel.org Fri Feb 13 06:58:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXr3m-0007tS-MF
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 06:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750939AbZBMF4a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 00:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbZBMF4a
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 00:56:30 -0500
Received: from rv-out-0506.google.com ([209.85.198.235]:34625 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750828AbZBMF43 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 00:56:29 -0500
Received: by rv-out-0506.google.com with SMTP id g37so573346rvb.1
        for <git@vger.kernel.org>; Thu, 12 Feb 2009 21:56:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ott1oKjwnkAB0Zq8Wp5ENVQa+wY/0jK2g4cZEWT1qLQ=;
        b=c5DiiuXOKxPNJULQLK5R7y7uxCvlE08BbzoiGqG+szLwM32ESg2jch5LMhMUGtqvNf
         xeSXD0apu5LCPveq03q9a/uFKfXHhs2yGnZwvDSEj58sqMhr218jdQUJfLSipUL3KDRU
         rtz9ybB6pBcNr2f0E05i/pRzGnhyNnjedsEXM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=kIFrb73P2G2bi4p7at2N0OZtKilwPH5q2yRIIUGmNehaUvBK7nBu1be8lVPsQfrEZa
         16QC+ImGNU+mIPrO1DS+GlZRfCmhk9ewRhOeXvbUSV2pPaQHnA9I4/43r3LGolWRQ098
         xcs9I/MVW0xL1xRISg71tRt0BAYkIY0GCbteI=
Received: by 10.140.247.11 with SMTP id u11mr962919rvh.123.1234504588691; Thu, 
	12 Feb 2009 21:56:28 -0800 (PST)
In-Reply-To: <76718490902122141h578a72e3k70366d6583d6c8c3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109708>

On Fri, Feb 13, 2009 at 12:41 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> On Thu, Feb 12, 2009 at 11:08 PM, Ben Hoskings <ben@hoskings.net> wrote:
>> My system is a Mac OS X 10.5.6 box (aluminium MacBook); some details are
>> below.
>
> HFS+ is case-insensitive by default. The Linux kernel has files which
> collide on a case-insensitive filesystem, which is what you're seeing.
>
> Create a disk image using Disk Utility, you can use "Mac OS Extended
> (Case-sensitive)". Check-out the repo to the disk-image.

Or:

$ hdiutil create -size 1g -fs UFS -type SPARSEBUNDLE -nospotlight
-attach -volname linux-2.6 linux-2.6
$ cd /Volume/linux-2.6
$ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

I think SPARSEBUNDLE will be a little friendlier to Time Machine.
Using UFS isn't strictly needed for checking out the kernel repo, but
it's not brain-damaged like HFS+ w/respect to Unicode.

j.
