From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: bug: sparse config interpretation incorrectness in 2.8.0-rc2
Date: Thu, 17 Mar 2016 21:00:38 +0700
Message-ID: <CACsJy8D1e5zd-b6CsszHGcNjMPedyZSrZpqdWeCUGdMD5UP7qQ@mail.gmail.com>
References: <56E9F5B3.6030903@fb.com> <20160317005632.GA17778@duynguyen-vnpc.dek-tpc.internal>
 <xmqq37rp35k1.fsf@gitster.mtv.corp.google.com> <CACsJy8A2D8CqeWZ6CFdTVXzXiWdonBE=3tWFPpe7-ZmDtNGYNw@mail.gmail.com>
 <alpine.DEB.2.20.1603171402330.4690@virtualbox> <CACsJy8DH297aV2pYL7xGNZ5X24rR5PxvrpJQ+15YxpDNvqgS5Q@mail.gmail.com>
 <alpine.DEB.2.20.1603171444210.4690@virtualbox>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Durham Goode <durham@fb.com>,
	Git Mailing List <git@vger.kernel.org>,
	Mateusz Kwapich <mitrandir@fb.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Mar 17 15:01:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agYUG-00037h-Ch
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 15:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030883AbcCQOBL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 10:01:11 -0400
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34329 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966264AbcCQOBJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Mar 2016 10:01:09 -0400
Received: by mail-lf0-f45.google.com with SMTP id e138so41945515lfe.1
        for <git@vger.kernel.org>; Thu, 17 Mar 2016 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ccZLKAE6+WesMyBgTMQEI1yvNVwRNKmvnrEFKdWAVTU=;
        b=Tr9iqRAFylqJuWu7n5CQC3HdCKvXeQr4ZQbAGvFFMi6qTmCYfR37FtBniSxraa+OxA
         jcRB/93QHQES0ArV7L3CkW72j2NxDl6vIsQjsLUmLmP7IrL6LhlZDtiA3r6q0Glcpy02
         KPRmHcrb7OthC7X9c7nfbxNVMT8IyVZ7XTtMMrd9g4jfVruaqsmfW2QFCbnN1SrtpN1p
         D24c5QkmhhDI2uBFXsFvYpeBM/IvJOt7T8jvzhblmm52RDI+UqMx5ZZTbeXhqfi16n9z
         uolz36SWxdc8qLbPkj31dleQQxCg8fsGK+lHSsniu4hSfccD+KkIc1F16I1nJFROpAyu
         ++MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ccZLKAE6+WesMyBgTMQEI1yvNVwRNKmvnrEFKdWAVTU=;
        b=l0iw5yevvZOh453RmCbcWaC6a2xcIKFrotIngXUr1tF6tAJKFdAySt9RExRYhSAEe9
         yZuQLrfvHsWX13w2WtDVysP4DxUxXjfIAJNSW9dqSqCbumD2N3guKF3wZhDR6xKepPET
         bsPG1CaQa6ZncUXexUPJHP/3ee/l2Av+ybpLhKfRp53HDBH0bC8iHjZx4+fC8pTMoY/b
         bdD4DWUSPc9oPNRXlpv9MP8qnPZmWQeBPLxOQ09WMJIvRnoHsOilLUHImevlohq9YWiT
         arF2tdDM4cF1IkRfLH0TG3+altRvbcTRAOrMDXpx2P0FBjUrMtMIMWFr7kWSGcv7LQvy
         x2jg==
X-Gm-Message-State: AD7BkJKctu9WXYOeChkfnhgUwX6mVJV92H3/qalkxz5ooirXXJJd0M8aN6W7k2OVaMvG9lI8uLJq+IMI9Gympg==
X-Received: by 10.25.24.100 with SMTP id o97mr3953697lfi.112.1458223267763;
 Thu, 17 Mar 2016 07:01:07 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Thu, 17 Mar 2016 07:00:38 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.20.1603171444210.4690@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289116>

On Thu, Mar 17, 2016 at 8:46 PM, Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
> Unfortunately, this does not help me at all. In the use case I am trying
> to get to work fast, we have tons and tons of directories and need *one*
> file in pretty much *all* of those directories, and exclude most of the
> other files.
>
> To make matters even worse, the list of excluded (or included) files is
> constantly changing.

OK very weird use case to me :) There's something you might try. [1]
can help trimming unrelated patterns, fewer patterns to match for a
dir, faster matching.

I knew it might help speed up sparse checkout (because we can't spread
sparse patterns over many .gitignore files,  we only have one place
for all patterns). I did try at some point. I just don't remember if I
gave up because I didn't think it's worth the effort or I found out
something wrong with it for sparse checkout case. It may or may help
your case, depending on the patterns, of course.

[1] http://article.gmane.org/gmane.comp.version-control.git/217958
-- 
Duy
