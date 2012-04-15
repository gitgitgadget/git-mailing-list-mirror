From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: master: t5800-remote-helpers.sh hangs on test "pulling from remote
 remote"
Date: Sun, 15 Apr 2012 13:18:20 +0200
Message-ID: <4F8AAE7C.1020507@gmail.com>
References: <4F893CD8.5020700@gmail.com> <20120414201446.GB29999@ecki> <4F8A0F96.5060408@gmail.com> <20120415011118.GA4123@ecki> <4F8A8211.2010908@gmail.com> <20120415105943.GD6263@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Apr 15 13:18:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJNTh-0007m0-B3
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 13:18:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426Ab2DOLSg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 07:18:36 -0400
Received: from mail-wi0-f170.google.com ([209.85.212.170]:53226 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116Ab2DOLS0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 07:18:26 -0400
Received: by wibhr17 with SMTP id hr17so6964381wib.1
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 04:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=91j0L8pfCbJXJTZFOXL5F8HIjk/0GmoiEa22xkCwuWg=;
        b=nN8dreDCSQbOL2os03MsjSx3/q0dxqN5WEP3flVtp3FuWk0Zq5DHgJ0Ky4gDWOVxZo
         lvDrQVONwkJIHssdWX48sZO/QqMkOQSlc49pMEHCELiuKS/wuzk1iZpfhqR4IyRp1aKy
         gMvHe8/XwuUWhcgImSLQdNQnVVrnXvNl9azgR3bkzKtdmZTySIpw4v/q/UtmhKLT1gIb
         RNmF+VBEIV+jEkz+D2QbAEbtg/Myq/8+wyWz68wx5gsea+z9c4dERrFyog46cxMV9Lt+
         P4st9mg9mVmUilXGb8nA+2pGIbwooAfaGb/WpE1wZb4GB+ZiC5HZ66zcbXB2thUrGsoS
         /yIg==
Received: by 10.180.95.129 with SMTP id dk1mr11608460wib.3.1334488705309;
        Sun, 15 Apr 2012 04:18:25 -0700 (PDT)
Received: from [87.8.92.183] (host183-92-dynamic.8-87-r.retail.telecomitalia.it. [87.8.92.183])
        by mx.google.com with ESMTPS id j3sm18574294wiw.1.2012.04.15.04.18.22
        (version=SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 04:18:24 -0700 (PDT)
In-Reply-To: <20120415105943.GD6263@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195560>

On 04/15/2012 12:59 PM, Clemens Buchacher wrote:
> On Sun, Apr 15, 2012 at 10:08:49AM +0200, Stefano Lattarini wrote:
>>
>> trace: run_command: 'fast-export' '--use-done-feature' '--export-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' '--import-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' '^refs/testgit/origin/master' 'refs/heads/master'
>>
>> trace: run_command: 'git-fast-import' '--quiet' '--export-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks' '--import-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks'
> 
> Ok, so the above two commands seem to be deadlocking for you.  Could you
> please run git fast-export with the arguments above from the directory
> t/trash directory.t5800-remote-helpers/server and check the output?
>

>From the 'localclone' subdirectory:

$ git 'fast-export' '--use-done-feature' \
  '--export-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
  '--import-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
  '^refs/testgit/origin/master' 'refs/heads/master')

  feature done
  blob
  mark :5
  data 24
  content
  content
  content

  commit refs/heads/master
  mark :6
  author A U Thor <author@example.com> 1334477289 +0000
  committer C O Mitter <committer@example.com> 1334477289 +0000
  data 6
  three
  from :4
  M 100644 :5 file

  done

$ git 'fast-export' '--use-done-feature' \
      '--export-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
      '--import-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' \
      '^refs/testgit/origin/master' 'refs/heads/master' \
   | git 'fast-import' \
         '--export-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks' \
         '--import-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks'

  git-fast-import statistics:
  ---------------------------------------------------------------------
  Alloc'd objects:       5000
  Total objects:            0 (         0 duplicates                  )
        blobs  :            0 (         0 duplicates          0 deltas of          0 attempts)
        trees  :            0 (         0 duplicates          0 deltas of          0 attempts)
        commits:            0 (         0 duplicates          0 deltas of          0 attempts)
        tags   :            0 (         0 duplicates          0 deltas of          0 attempts)
  Total branches:           0 (         0 loads     )
        marks:           1024 (         4 unique    )
        atoms:              0
  Memory total:          2243 KiB
         pools:          2048 KiB
       objects:           195 KiB
  ---------------------------------------------------------------------
  pack_report: getpagesize()            =       4096
  pack_report: core.packedGitWindowSize =   33554432
  pack_report: core.packedGitLimit      =  268435456
  pack_report: pack_used_ctr            =          4
  pack_report: pack_mmap_calls          =          2
  pack_report: pack_open_windows        =          2 /          2
  pack_report: pack_mapped              =        471 /        471
  ---------------------------------------------------------------------

Both the commands are successful.

Thanks,
  Stefano
