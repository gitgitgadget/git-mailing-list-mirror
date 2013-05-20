From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-diff-index man page
Date: Sun, 19 May 2013 23:27:43 -0700
Message-ID: <20130520062743.GA2919@elie.Belkin>
References: <CAKEGsXQDB1=hizNqM6D=uuP6PXT4ytUiTgB5fvO-gVSsPqQkLQ@mail.gmail.com>
 <7vhahzza2v.fsf@alter.siamese.dyndns.org>
 <CAKEGsXRry_=BuPRPK_syW7_W+_Bh+A1bB9U5YC02=a+Z+SHv1w@mail.gmail.com>
 <7vr4h2w8gv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Albert Netymk <albertnetymk@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 20 08:27:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UeJZc-0007dI-7p
	for gcvg-git-2@plane.gmane.org; Mon, 20 May 2013 08:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934Ab3ETG1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 02:27:52 -0400
Received: from mail-da0-f47.google.com ([209.85.210.47]:40203 "EHLO
	mail-da0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457Ab3ETG1v (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 02:27:51 -0400
Received: by mail-da0-f47.google.com with SMTP id k13so3695621dae.34
        for <git@vger.kernel.org>; Sun, 19 May 2013 23:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=ubZUJgTs9ICNm6V5FIBOSj6ReeZBW2RV9wOaKiJ7BXI=;
        b=fXfPV2N53xyJKPP64IYNyuafUKZuAR7faEgiRLua8nYwg/xatu1CA24lo/GOZKetZt
         pPiqHSKxBI8/er0HiUNWMWuS10Wl4QuMz0NEoEyXSwtUCZ6pZY4k9EbQGbj5lmBqYqPK
         eFfYsMy8OCaCLOIhuKUj20n3z8EHN/wepta+QZutgcUy7L3ijYKu8q3oYDG7lb8KjIh3
         HJBm0ghwNo2DbAY29t1djRr1DFDbh6a3inE6vu02qhBA1OVcuSueSnjkZBHp1VWG69Sw
         GjrYVp6izovU4Py705QKBZZkn36TQU3sp1Wq/hX5UK69hbfweAlIm/tOxwWnCl0aEIJw
         kMYg==
X-Received: by 10.68.164.226 with SMTP id yt2mr59216243pbb.203.1369031271149;
        Sun, 19 May 2013 23:27:51 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id dr6sm24397923pac.11.2013.05.19.23.27.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 19 May 2013 23:27:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vr4h2w8gv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224939>

Junio C Hamano wrote:

> --- a/Documentation/git-diff-index.txt
> +++ b/Documentation/git-diff-index.txt
> @@ -3,7 +3,7 @@ git-diff-index(1)
>  
>  NAME
>  ----
> -git-diff-index - Compares content and mode of blobs between the index and repository
> +git-diff-index - Compare a tree and the working tree or the index

Looks good.  I think it scans better with the second "the" left out:

	git diff-index - Compare a tree to the working tree or index

[...]
> @@ -13,11 +13,12 @@ SYNOPSIS
>  
>  DESCRIPTION
>  -----------
> -Compares the content and mode of the blobs found via a tree
> +Compare the content and mode of the blobs found in a tree object

I think this s/Compares/Compare/ is a regression: traditionally
the DESCRIPTION sections of manpages describe what a command does in
the present indicative ("When paths are specified, compares only those
named paths"), freeing up the imperative for cases where it is useful
to instruct the user about what to do.

The s/via/in/ looks fine.

> -object with the content of the current index and, optionally
> +with the corresponding tracked file in the working tree, or with the

Since they are being compared to blobs, "file" should be "files" here.

> -ignoring the stat state of the file on disk.  When paths are
> -specified, compares only those named paths.  Otherwise all
> -entries in the index are compared.
> +corresponding paths in the index.  When paths are specified,
> +compares only those named paths.  Otherwise all entries in the index
> +are compared.

The <path> parameters to git diff-index are pathspecs and not literal
paths.

This should say somewhere that this only looks at paths in the index
and that untracked files are ignored.  Perhaps something as simple
as s/entries in the index/tracked files/ would do the trick.

Thanks and hope that helps,
Jonathan

diff --git i/Documentation/git-diff-index.txt w/Documentation/git-diff-index.txt
index 58308e15..a86cf62e 100644
--- i/Documentation/git-diff-index.txt
+++ w/Documentation/git-diff-index.txt
@@ -3,7 +3,7 @@ git-diff-index(1)
 
 NAME
 ----
-git-diff-index - Compare a tree and the working tree or the index
+git-diff-index - Compare a tree to the working tree or index
 
 
 SYNOPSIS
@@ -13,12 +13,11 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-
-Compare the content and mode of the blobs found in a tree object
-with the corresponding tracked file in the working tree, or with the
-corresponding paths in the index.  When paths are specified,
-compares only those named paths.  Otherwise all entries in the index
-are compared.
+Compares the content and mode of the blobs found in a tree object
+with the corresponding tracked files in the working tree, or with the
+corresponding paths in the index.  When <path> arguments are present,
+compares only paths matching those patterns.  Otherwise all tracked
+files are compared.
 
 OPTIONS
 -------
