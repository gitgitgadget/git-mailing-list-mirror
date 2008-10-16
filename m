From: "David Tweed" <david.tweed@gmail.com>
Subject: Re: git and filesystem problems (ext3 and vfat)
Date: Thu, 16 Oct 2008 17:22:49 +0100
Message-ID: <e1dab3980810160922n1cbd99c7r40239e0ae10f5657@mail.gmail.com>
References: <d0383f90810160903p6f8ffe77o86fdad5387f82481@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Ian Brown" <ianbrn@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 16 18:24:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KqVeB-0004iK-DY
	for gcvg-git-2@gmane.org; Thu, 16 Oct 2008 18:24:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbYJPQWw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2008 12:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752760AbYJPQWw
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Oct 2008 12:22:52 -0400
Received: from qw-out-2122.google.com ([74.125.92.26]:53473 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750989AbYJPQWv (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2008 12:22:51 -0400
Received: by qw-out-2122.google.com with SMTP id 3so27539qwe.37
        for <git@vger.kernel.org>; Thu, 16 Oct 2008 09:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=k3FUyan8jZxSWpMBC7Qcl6dNUl+9Ka6LQFmjHSsUrt0=;
        b=syxQfQFPTINZvRsq5ICjnXJHlMtA5DnSJKGOGS/Xnr4ZAG3WK8REhigYDzI2qLP5YW
         O41eHkuChVvI6FZNIeDUQaQc22whv4tslsLLOzH4KgwxeG8WCnt5MOqE1ZTox90ny0Ik
         Gz4DUBtgQ8DeNgPBU/ROLIJ5asn0BLjaJPbjc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=orgYj2+3ZPt2CkVI9Om3gC0AowUJPrY5C9oF45s9rN3DEc29B452iiYn1G2k0xYDAW
         4fzk62RdFLR9Q0Q8XzpuAOO9Rxvlrewm3p83UTOSo2tcTrNFX42KnEfkBhLyaR7hwjHW
         ycZdRm42JlxRfTtjS/TYyHiUTJvfpCcn7NGJg=
Received: by 10.214.149.6 with SMTP id w6mr3183227qad.40.1224174169936;
        Thu, 16 Oct 2008 09:22:49 -0700 (PDT)
Received: by 10.214.81.8 with HTTP; Thu, 16 Oct 2008 09:22:49 -0700 (PDT)
In-Reply-To: <d0383f90810160903p6f8ffe77o86fdad5387f82481@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98397>

On Thu, Oct 16, 2008 at 5:03 PM, Ian Brown <ianbrn@gmail.com> wrote:
> Hello, ]
>
>  I have a diskOnKey which has a vfat filesystem.
> I ran there:
> git clone git://git.kernel.org/pub/scm/linux/kernel/git/linville/wireless-2.6.git
> the I copied all the wireless-2.6 folder to an ext3 partition.
> There I ran git diff.
>
> I get many messages like these (probably on all files of the repository):
>
> diff --git a/COPYING b/COPYING
> deleted file mode 100644
> index ca442d3..0000000
> --- a/COPYING
> +++ /dev/null
> @@ -1,356 +0,0 @@
> -
>
> and then all the lines of the file with "-" in the beginning, as if
> they are empty.

The first question is what do the directories on the vfat and ext3
disks look like? Are the files like COPYING present in both directory
trees (so git is wrong at that point of the diff) or has something
gone wrong earlier?

> Why is it so ?
> Is there any way to overcome it ?
> Must I run "git clone" on an ext3 DiskOnKey only ?

I have certainly cloned onto a vfat partition with no problems,
although I've always done it with a --bare clone because a lot of my
repos have had case sensitive filenames and I've had some problems
with the "git dirent reading code reads back different case file names
than it wrote out and gets confused". If you're only transporting the
repo on the stick, I'd definitely do it via "git clone --bare" just to
reduce the potential for problems.

-- 
cheers, dave tweed__________________________
david.tweed@gmail.com
Rm 124, School of Systems Engineering, University of Reading.
"while having code so boring anyone can maintain it, use Python." --
attempted insult seen on slashdot
