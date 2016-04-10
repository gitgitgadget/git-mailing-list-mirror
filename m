From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: A small Git bug
Date: Sun, 10 Apr 2016 21:31:57 +0530
Message-ID: <CAOLa=ZTJydx5iXVRz0nxrQM0RgzN-xgTO-6KUjVDck5ApXe1Pw@mail.gmail.com>
References: <1460301449.7971.4.camel@narod.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git <git@vger.kernel.org>
To: Victor Porton <porton@narod.ru>
X-From: git-owner@vger.kernel.org Sun Apr 10 18:02:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1apHp7-0003Jm-Eq
	for gcvg-git-2@plane.gmane.org; Sun, 10 Apr 2016 18:02:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755414AbcDJQC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Apr 2016 12:02:29 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:34703 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755385AbcDJQC2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Apr 2016 12:02:28 -0400
Received: by mail-qg0-f43.google.com with SMTP id c6so126971060qga.1
        for <git@vger.kernel.org>; Sun, 10 Apr 2016 09:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=wKZsAzRlrNIvPs0hwbEc3FZdFUk2e4bGJD8JmZzujKg=;
        b=o9IAvrCRJkMNd02igcVWvJ7yiDcYvwM9SVtunKXFF3RV3/TMMB+AI3HwTLVMtxPiKC
         l81B4XSsm2oY2pFMU7dccT/yb7af7yWGmw1NVNugihP1n6hwMOmQaedOoNQ3fDA6ipSu
         re7rcDmb+QnDlfx6PXkp2fmQq7H4wJ5ZXQvPvZOBghE/Zh2O/7IWmYpSrrjjGlFUppXt
         iZs1HhsgOubLiJlcjvBfhCCRPn3AJJtBogTtPPdNNWGDn+bEGXiMYG6OD3DCHxmHiHzv
         +Z0z2kij7XUfRl5HxxDobLSLO4J2OVlogqrLZDnlU/ZrJzBfeJfirc7MX1JFZLh7RVnS
         OnzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=wKZsAzRlrNIvPs0hwbEc3FZdFUk2e4bGJD8JmZzujKg=;
        b=AA68s855t6Nn1JWr42C4eoEPKct05lsQsmc6PwDTt211eIsYMEufn0jrqIYaKJrjSn
         +gRDFSLvJGAdHb8gprSthDrCxndye0R9oFxay6CxrHZ3M0xj40vbcPHiRsV/txuq44Fn
         s+ddCsDs+9LEZRSfEZ805SW0CtItHI3RtgvLSkHxMVBvNx6Q7xu6We9M0da8NApR/vZP
         ZF56oAjSY3BUdq79JXKQtXqV0fqweSgwiFMf0vWgu76K+75quQHTxxdPMJ/JYn7DPK/g
         FRMr87ogYWZi3nVt8Ca5infy8e5IAkXt8EXF6d+R6EOtCGsLE8+Aj8N3bFG8oRaq7OzR
         ND6w==
X-Gm-Message-State: AD7BkJK0eMQy0nYIRPtEiZlhKO/ftrR2OT9p0Uvg0J+VlICIb63WUnVCWYBL9ntIphBCBAwBIEqzXByp74RU5A==
X-Received: by 10.140.218.134 with SMTP id o128mr24763091qhb.33.1460304147279;
 Sun, 10 Apr 2016 09:02:27 -0700 (PDT)
Received: by 10.140.92.238 with HTTP; Sun, 10 Apr 2016 09:01:57 -0700 (PDT)
In-Reply-To: <1460301449.7971.4.camel@narod.ru>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291178>

Hello,

On Sun, Apr 10, 2016 at 8:47 PM, Victor Porton <porton@narod.ru> wrote:
> I have three branches: master, prerelease, and devel.
>
> Suppose now we are in master.
>
> I often run the following command (in fact it is an alias, to save
> typing):
>
> git push && git checkout prerelease && git merge master && git push &&
> git checkout devel && git merge prerelease && git push && git checkout
> master
>
> There is a small problem: After running this command my text editor
> proposes me to reload changed files.
>
> So, it seems that the above command marks some files as changed. It is
> wrong, because it is inconvenient a little to reload a file or two
> every time after I submit the changes.

Its more of intentional behavior than a bug. When you merge branches, the
timestamp of the files involved are updated to reflect the merge.

Your text editor seems to have picked up this change in the file's timestamp as
changes made to the content of the file.

-- 
Regards,
Karthik Nayak
