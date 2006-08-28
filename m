From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Packfile can't be mapped
Date: Sun, 27 Aug 2006 21:04:01 -0400
Message-ID: <9e4733910608271804j762960a8ud83654c78ebe009a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 28 03:04:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHVY8-0007Wt-Ao
	for gcvg-git@gmane.org; Mon, 28 Aug 2006 03:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932108AbWH1BEF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 21:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932254AbWH1BEE
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 21:04:04 -0400
Received: from nz-out-0102.google.com ([64.233.162.202]:63844 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932108AbWH1BEC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 21:04:02 -0400
Received: by nz-out-0102.google.com with SMTP id n1so893792nzf
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 18:04:01 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ctm+2MO/GREfNtuLxNjyUiBjM5Ywnt0qdnP/ojRXHtiEKHqPnian6FC6rSk3H5tWzi44KLPETSpnVrJAWOOcaxwfx4mIUTkVDzFXfpUlP5NB/z6ohMda33ukZw62NxcfxgntDrq+kva8RN375oUc0BRRXENfen15Sb6tyAyNDBY=
Received: by 10.65.250.11 with SMTP id c11mr6122101qbs;
        Sun, 27 Aug 2006 18:04:01 -0700 (PDT)
Received: by 10.65.133.17 with HTTP; Sun, 27 Aug 2006 18:04:01 -0700 (PDT)
To: git <git@vger.kernel.org>, "Shawn Pearce" <spearce@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26134>

git-repack can't handle my 1.75GB pack file. I am running x86 with 3GB
address space.

-rw-rw-r-- 1 jonsmirl jonsmirl    47221712 Aug 27 20:29 testme.idx
-rw-rw-r-- 1 jonsmirl jonsmirl  1754317619 Aug 27 20:29 testme.pack

[jonsmirl@jonsmirl t1]$ git-repack -a -f --window=50 --depth=5000
Generating pack...
Done counting 1963325 objects.
fatal: packfile .git/objects/pack/testme.pack cannot be mapped.
[jonsmirl@jonsmirl t1]$

It is built from Mozilla CVS but it is an intermediate stage of our
work. The fast-import tool isn't diffing directory tree which makes
the pack much bigger than it needs to be. Shawn is working on the
packing code.

---------------------------------------------------
Alloc'd objects:    1968000 (   1892000 overflow  )
Total objects:      1967527 (     41856 duplicates)
      blobs  :       633842 (         0 duplicates)
      trees  :      1131208 (     41856 duplicates)
      commits:       200921 (         0 duplicates)
      tags   :         1556 (         0 duplicates)
Total branches:        1600 (      7985 loads     )
      marks:        1048576 (    200921 unique    )
      atoms:          56803
Memory total:         66908 KiB
       pools:          5408 KiB
     objects:         61500 KiB
Pack remaps:           9501
---------------------------------------------------
Pack size:          1713200 KiB
Index size:           46114 KiB


-- 
Jon Smirl
jonsmirl@gmail.com
