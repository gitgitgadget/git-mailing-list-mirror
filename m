From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick
 failed
Date: Tue, 3 Apr 2012 16:08:15 -0500
Message-ID: <20120403210815.GB19858@burratino>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com>
 <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com>
 <CALkWK0nmNWaOKcyGH2N0s3B1AFD-+3vHz1BBc3U=RMEFLNuc7A@mail.gmail.com>
 <20120403144505.GE15589@burratino>
 <4F7B650C.9060800@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Jay Soffian <jaysoffian@gmail.com>
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 23:08:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SFAxw-0000F8-6c
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 23:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754574Ab2DCVIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Apr 2012 17:08:31 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:51396 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753684Ab2DCVIa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2012 17:08:30 -0400
Received: by iagz16 with SMTP id z16so172142iag.19
        for <git@vger.kernel.org>; Tue, 03 Apr 2012 14:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=vI+jEt5rBkb9aCQZ5ZbGUEAvZr5uO48f0sRySdHaGsM=;
        b=bepXxr7W1u1Pdwl+s1XkUZKxUxYMo4GOXM1Z1aZPLNOHWwEaY6BBeBEtfd7w5q1q7W
         tdD5QJXcrqM73qE08NETn3h7FO3zr0zPY4n9Dc+6EWIoRJBYCYtzzgjBNcW1S4LJgAPv
         92CNM8tjexZSoxcK8jF66ksLSyiD0vdcc5+IDmW1/6kFd9kEJQA/ZU838IjlyPx1hnA7
         LA1cQu6Fdh6kiLZP+aZPpQ7gdLHl9nCuYfDduYYKoJD8z3LQTgiLyoUc7XIIlHS1nAhG
         p+S8sF/RTEX5QVRDr0IqXlS9Xa7TmwCLVFTbD2u7pXZ9zSUW/qRAYoghUvKG8r2js19J
         +uOQ==
Received: by 10.42.158.71 with SMTP id g7mr8480835icx.38.1333487310203;
        Tue, 03 Apr 2012 14:08:30 -0700 (PDT)
Received: from burratino (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id p5sm12090553igl.2.2012.04.03.14.08.29
        (version=SSLv3 cipher=OTHER);
        Tue, 03 Apr 2012 14:08:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F7B650C.9060800@sohovfx.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194647>

Andrew Wong wrote:

> Besides the "empty commit" failure, "cherry-pick" can still run into
> various errors, such as merge conflict.

Cherry-pick does the merge, so it is what notices the merge conflict.
If you search for CHERRY_PICK_HELP in builtin/revert.c, the relevant
code should show up.
