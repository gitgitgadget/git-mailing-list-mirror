From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 00/20] refs backend rebase on pu
Date: Thu, 4 Feb 2016 17:09:48 +0700
Message-ID: <CACsJy8Cw9CM+EBw85KM1RcDAsRY8LbTFWFUq0dLSHWY0NLPZMA@mail.gmail.com>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com> <1454443734.5545.1.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 11:10:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRGru-0007IA-Vn
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 11:10:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753327AbcBDKKZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 05:10:25 -0500
Received: from mail-lf0-f45.google.com ([209.85.215.45]:33708 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355AbcBDKKT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 05:10:19 -0500
Received: by mail-lf0-f45.google.com with SMTP id m1so33275628lfg.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 02:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=135YvpoO4e5hkgm9UaT1sgaU0hZxz+wHY0aFTft14sM=;
        b=ogofD6XjHYIgLKpw9zGh52x2n590CDBOBDmtj1c96SyUOIzx16wt6U2emCVRoLWmEt
         pDWX6MABciEgKoiTpI7YJ4RMEsRX8ss4aCXFRZj1aSXHWU/TyL/d6K8pvMDYzDVMzqFh
         JMVEjmr1QzSs+usfVhIKJTZIt2EO7uWzAE3UyxToIQw1g4R1FkZ0xcZvpHqtuYwFcNzT
         JbKCRnXecbJzplyPEX/d+o2avo/H5fkJMm6ObaEGlqq08Bk9GAVRpFcORvY9QJ9hHovv
         tSngPX47q3XZ/+7SbuQetUe3avK0BZTcuKc9qYDi7hB3cUh5L7NtJOInqtODbRkGOtQJ
         Hezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=135YvpoO4e5hkgm9UaT1sgaU0hZxz+wHY0aFTft14sM=;
        b=eL7eBmrTsDK+ZO/MPSOxr2N777VlGwHdRB4ke7TAfS9rzdVuMERgrh2SzYqjAG73ff
         GPI+kVri6q6nWbh/+XYLJ50PriyC/wnRxSbizWPvmCcqU+sh4c8mB54imQl3TYRIF8SZ
         /N1E4cce+Rnyo+45P/1Va2xyT2p+k5CzqwJf62zM1WDemtHNslxvh9CuJFh7iWKWM2uL
         /Qq5YezGQqfiHCf9BuCqxRaoBvHzO5/tr+IwTZg2lLbd2pB/31aLRpdqBcUbCma7ukQr
         RaQpyYDls+kB6arq1iIIVvVYZmn7N4HXSY2I3amIktz6Ck99xwUxHUFalTHChuEbyBxv
         UHNw==
X-Gm-Message-State: AG10YOSys2HmmCVhQOMSlQr2NQ20CHknn1+Mp9pzjGXeq+vy3MRf0uXGsK4koai1REWqpGDYErQ7krzauh/Mwg==
X-Received: by 10.25.43.212 with SMTP id r203mr3155945lfr.162.1454580617696;
 Thu, 04 Feb 2016 02:10:17 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Thu, 4 Feb 2016 02:09:48 -0800 (PST)
In-Reply-To: <1454443734.5545.1.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285447>

On Wed, Feb 3, 2016 at 3:08 AM, David Turner <dturner@twopensource.com> wrote:
> Are there any more reviews on this?  I do have some changes from this
> set, but they're pretty minor so I don't want to post a new one (unless
> folks would rather see those changes before reviewing).  Let me know.

I think you need to keep "refs" directory back somehow. Without it
(e.g. "git init --ref-storage=lmdb" does not create "refs"),
is_git_directory() from _old_ git versions fails to recognize this is
a good repository. So instead of dying on finding an unsupported
repository, setup code keeps on looking for another repository in
parent directories. If I accidentally run "git add something" with an
old binary, "something" could be added to a wrong repository. Very
confusing.
-- 
Duy
