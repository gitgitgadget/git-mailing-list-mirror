From: Drew Gross <drew.a.gross@gmail.com>
Subject: Fwd: Delivery Status Notification (Failure)
Date: Sat, 6 Apr 2013 00:15:33 -0400
Message-ID: <CAECh7fD6SKtfZudByeVD_HUjxN-fHBF1bA+pVM6=gV=Jy5Uhwg@mail.gmail.com>
References: <CAECh7fANnQDfSNHvOUH7AhyVNciypCKLXadY-jFxso4etCuvrg@mail.gmail.com>
 <047d7b3a85a201067604d9a948e8@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:58:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWSI-0001b9-6z
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:59:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897Ab3DFEP4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Apr 2013 00:15:56 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:51462 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750845Ab3DFEPz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Apr 2013 00:15:55 -0400
Received: by mail-la0-f47.google.com with SMTP id fj20so4039807lab.34
        for <git@vger.kernel.org>; Fri, 05 Apr 2013 21:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:content-type;
        bh=0USdSwJgxN1CtmVR5ejWw7Ueb4t/onFhSpodOjw0DAQ=;
        b=TCzLPf/FRJ1woZ6kw91BCnrIkhFU8wkcrXcY8YhtqXN1eHmMs6XL3fCO1nE7SxM4CD
         Z4agicg0+iSg24W9CvWvKMQPoXFHduXTFseBfHlfyg0gJ45yzePe3j+ko/w8/hwT7tTq
         njXFCm7h1UHq+xxyy5G20avW70pPRD+G3BxWVH/ep/g4JbaO0j7p0eX1jb+h/GF3hdeN
         /aY/Hv8RIBkq143e+ilXQPg5YVMHxZ/u2KUMxiqIFwyts36Nr89p8iHCRLPiAQ+s5o6+
         eHFznJVzjKoRw32X3AUnbtzBeucqrrESH8pMw7MxczeKBbvcPTPr9L164Iamm2B6oB78
         XHlQ==
X-Received: by 10.112.18.168 with SMTP id x8mr7526699lbd.102.1365221753770;
 Fri, 05 Apr 2013 21:15:53 -0700 (PDT)
Received: by 10.114.28.130 with HTTP; Fri, 5 Apr 2013 21:15:33 -0700 (PDT)
In-Reply-To: <047d7b3a85a201067604d9a948e8@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220247>

Hello,

I'm am trying to patch git to refuse to commit if there are both staged and
unstaged changes, and I pass the -a flag. I expected this simple addition
to parse_and_validate_options() in commit.c to accomplish most of what I
want:

if (all && s->workdir_dirty)
    die(_("Cannot commit with -a if there are staged and unstaged changes"));

But when compiled, this will commit anyway even with staged and unstaged
files. I think I misunderstanding the workdir_dirty flag. Can someone help
me?

Drew Gross
