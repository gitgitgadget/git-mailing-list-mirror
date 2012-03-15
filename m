From: Neal Kreitzinger <nkreitzinger@gmail.com>
Subject: Re: How to git diff files in renamed directories
Date: Thu, 15 Mar 2012 05:30:19 -0500
Message-ID: <4F61C4BB.20908@gmail.com>
References: <CAGATVH7KCr+dJNpx18==3BT8pzsvKeV5aYRWKts7xH0YZ8yaKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Patrick Sabin <patrick.just4fun@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 11:30:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S87xB-0003QT-Mt
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 11:30:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753157Ab2COKa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 06:30:26 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:48483 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751278Ab2COKaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 06:30:25 -0400
Received: by yenl12 with SMTP id l12so2840849yen.19
        for <git@vger.kernel.org>; Thu, 15 Mar 2012 03:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VgUFfPDaXHyWyzreUzIzusXFTvZNl1Ph/666CKQFLOc=;
        b=Tc44LBaCEwBEi3Dpbra4TnPwq7syOFzUOnWp3Uesc/ATTKnlAok8uvE3TabwBS3OoK
         /ENr/Tax59Yzcb5VtyDgcw0mUt+plz3ZSvou1ecT1poBka7W//GQtvKB2gS73evMDKnE
         6DvNx4z4IKp0S6Z6ZJSYFyJIubPKiN1fJ1EcgzJQhfTWyUdJ9sKdfLDTX3abJbeUiglf
         mAxa0c3qHnkRWyZCwfzS1E5PuE2yD3jzttCyv2AxYNbzcr+iwqAkgYfqiIzUwGfTKZ+X
         yYfXzlZlAeYUOYA5Ehm4NG0Bbuol2UN0v8OBCZqGnGN8aSWtBqk+YDCygb5D2kRPtPiT
         RnDw==
Received: by 10.60.9.232 with SMTP id d8mr6940425oeb.66.1331807424506;
        Thu, 15 Mar 2012 03:30:24 -0700 (PDT)
Received: from [172.25.2.210] ([67.63.162.200])
        by mx.google.com with ESMTPS id b6sm1461786obe.12.2012.03.15.03.30.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Mar 2012 03:30:22 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.28) Gecko/20120306 Thunderbird/3.1.20
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <CAGATVH7KCr+dJNpx18==3BT8pzsvKeV5aYRWKts7xH0YZ8yaKw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193207>

On 3/15/2012 3:32 AM, Patrick Sabin wrote:
>
> I want to diff a renamed file (to a different directory) in different commits.
>
> File a was moved to the file subdir/c
>
> I tried:
>
> $ git diff b616d 0aa0 -- subdir/c a
>
> but git seems to always diff against /dev/null:
>
> diff --git a/a b/a
> new file mode 100644
> index 0000000..2e5ada8
> --- /dev/null
> +++ b/a
> @@ -0,0 +1 @@
> +File a
> diff --git a/subdir/c b/subdir/c
> deleted file mode 100644
> index 24c846c..0000000
> --- a/subdir/c
> +++ /dev/null
> @@ -1,2 +0,0 @@
> -File b
> -Another b change.
>
> git log --follow subdir/c   recognizes that the file has been renamed
> and moved to subdirectory.
>
> Is there any way to get such a diff in git?
>
git diff b616d:a 0aa0:subdir/c is one way to do it.

v/r,
neal
