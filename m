From: Drew Northup <n1xim.email@gmail.com>
Subject: Re: git push tags
Date: Thu, 25 Oct 2012 13:19:05 -0400
Message-ID: <CAM9Z-nkxCOyrtJ8vCF=00vrA_1eFr2-Fk7PXjYEx0HbVt0GPkQ@mail.gmail.com>
References: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>
To: Angelo Borsotti <angelo.borsotti@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 25 19:19:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TRR5V-00013h-6S
	for gcvg-git-2@plane.gmane.org; Thu, 25 Oct 2012 19:19:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759668Ab2JYRTI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Oct 2012 13:19:08 -0400
Received: from mail-bk0-f46.google.com ([209.85.214.46]:37687 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757202Ab2JYRTH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Oct 2012 13:19:07 -0400
Received: by mail-bk0-f46.google.com with SMTP id jk13so932108bkc.19
        for <git@vger.kernel.org>; Thu, 25 Oct 2012 10:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=mkgwmF4VbovZN6c6dPUcpYl7tXotLfn4f4+1HMxZoek=;
        b=GbBH2z1v40s2IJ3W+WUVaGyNtTSSIWNRbmJmwLRi6PFPEfBfTbZ0A18WfqAgsrNJAr
         qxExfIcTvFP9O+Ap2CvRjTG6wXzb2Fmv33a1cB9mH+KsgQjHcGn9zI+mq4PnetCRiV64
         7IkMFUcKheEHdaobuuAv0ZIuMmJJ+U+Sl6ZBkB9YYzOJV0GEZiN98h1iS7F8Qy75XKeZ
         nZgWjlcBRUlPutFUno9Yr4cL3n7mfKFAPRw4S/fJyqHok6usAXzDM9x5qvMOZP+/qNS9
         bVLNODRUIohoBUmMhOQGCdyoIFnrnJiQKRm3NUmB+YaxwzxbWAHBLunLBwTHD+L0HNpI
         f9zw==
Received: by 10.204.11.70 with SMTP id s6mr6488950bks.63.1351185545828; Thu,
 25 Oct 2012 10:19:05 -0700 (PDT)
Received: by 10.205.122.144 with HTTP; Thu, 25 Oct 2012 10:19:05 -0700 (PDT)
In-Reply-To: <CAB9Jk9DMOwhDf3SvMzTmTZiyZg_4pgXx-evrfWkB3U4w-KqtVw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208410>

On Thu, Oct 25, 2012 at 2:58 AM, Angelo Borsotti
<angelo.borsotti@gmail.com> wrote:
> Hello,
>
> git push tag updates silently the specified tag. E.g.
>
> git init --bare release.git
> git clone release.git integrator
> cd integrator
> git branch -avv
> touch f1; git add f1; git commit -m A
> git tag v1
> git push origin tag v1
> touch f2; git add f2; git commit -m B
> git tag -f v1
> git push origin tag v1
>
> the second git push updates the tag in the remote repository. This is
> somehow counterintuitive because tags normally do not move (unless
> forced to that), and is not documented.

You specified "-f" (force) and it did exactly what you asked. That is
fully documented (git help tag).

> This is also harmful because it allows to change silently something
> (tags) that normally must not change.

Tags have many uses. Some of those uses are harmed when tags change
and some aren't. That's a philosophical argument and Git is a computer
program, not a philosopher. It is not the job of the machine to
prevent the user from shooting himself in the foot when he clearly
expressed an interest in doing so.

-- 
-Drew Northup
--------------------------------------------------------------
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
