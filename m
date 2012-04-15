From: Stefano Lattarini <stefano.lattarini@gmail.com>
Subject: Re: master: t5800-remote-helpers.sh hangs on test "pulling from remote
 remote"
Date: Sun, 15 Apr 2012 10:08:49 +0200
Message-ID: <4F8A8211.2010908@gmail.com>
References: <4F893CD8.5020700@gmail.com> <20120414201446.GB29999@ecki> <4F8A0F96.5060408@gmail.com> <20120415011118.GA4123@ecki>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Sun Apr 15 10:10:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJKXJ-00087B-P9
	for gcvg-git-2@plane.gmane.org; Sun, 15 Apr 2012 10:10:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751509Ab2DOIJY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Apr 2012 04:09:24 -0400
Received: from mail-wg0-f44.google.com ([74.125.82.44]:41560 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751127Ab2DOIJH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2012 04:09:07 -0400
Received: by wgbdr13 with SMTP id dr13so4252720wgb.1
        for <git@vger.kernel.org>; Sun, 15 Apr 2012 01:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:mime-version:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Fb1W6q7bDc8B68LhEENLCpaEzTcPJy8m8mkmRUl/h1k=;
        b=HanCn1m+jO4+VVhdnqYd+qK/F8kjmEcKalG/MoX48MRYa616UFh3i4TSJYPq3YMfWC
         1GL9ABl59cqjC1k86+fBxuI5BeOxMyhVYUSgpHAdUKNSgW4qFFtq2rjEuKTX0E6WKB1I
         jexUHIESGKmCGfrJiFOlW/1DOGV3u8s+BooVSOBYSwZoYPZDfQwCcoycE1XbK2mAKEDC
         +ipeo16l80QqpuFN28UVQmPYNIIqh8zhs347KlW3f/U0L3aGTE7D3Hh4PajNePXEobVd
         TaeKB+Ttf2K+o7hns23O1dNt7IjrR8sNNg8/9kUTviTtmTO/WXk1gxStinmlEsJq99pv
         eSSw==
Received: by 10.180.88.67 with SMTP id be3mr9109202wib.20.1334477345144;
        Sun, 15 Apr 2012 01:09:05 -0700 (PDT)
Received: from [87.8.92.183] (host183-92-dynamic.8-87-r.retail.telecomitalia.it. [87.8.92.183])
        by mx.google.com with ESMTPS id fl2sm16860110wib.2.2012.04.15.01.09.02
        (version=SSLv3 cipher=OTHER);
        Sun, 15 Apr 2012 01:09:03 -0700 (PDT)
In-Reply-To: <20120415011118.GA4123@ecki>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195547>

On 04/15/2012 03:11 AM, Clemens Buchacher wrote:
> But if you want to indulge
> me further, you could try again with GIT_TRACE=1.  That should give you
> the arguments to use for the fast-export and fast-import commands right
> before it hangs.

Here is the output:

-*-*-

expecting success:
        (cd localclone &&
        echo content >>file &&
        git commit -a -m three &&
        GIT_TRACE=1 GIT_TRANSPORT_HELPER_DEBUG=1 GIT_DEBUG_TESTGIT=1 git push) &&
        compare_refs localclone HEAD server HEAD

[master 813bd24] three
 Author: A U Thor <author@example.com>
 1 file changed, 1 insertion(+)
trace: built-in: git 'push'
trace: run_command: 'git-remote-testgit' 'origin' '/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/server'
Debug: Remote helper: -> capabilities
Debug: Remote helper: Waiting...
trace: built-in: git 'ls-remote' '/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/server/.git'
trace: run_command: 'git-upload-pack '\''/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/server/.git'\'''
trace: exec: 'sh' '-c' 'git-upload-pack '\''/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/server/.git'\''' 'git-upload-pack '\''/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/server/.git'\'''
prefix: 'refs/testgit/origin/'
Got arguments ['origin', '/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/server']
Got command 'capabilities' with args ''
Debug: Remote helper: <- import
Debug: Got cap import
Debug: Remote helper: Waiting...
Debug: Remote helper: <- export
Debug: Got cap export
Debug: Remote helper: Waiting...
Debug: Remote helper: <- refspec refs/heads/*:refs/testgit/origin/*
Debug: Got cap refspec refs/heads/*:refs/testgit/origin/*
Debug: Remote helper: Waiting...
Debug: Remote helper: <- *export-marks .git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks
Debug: Got cap export-marks .git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks
Debug: Remote helper: Waiting...
Debug: Remote helper: <- *import-marks .git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks
Debug: Got cap import-marks .git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks
Debug: Remote helper: Waiting...
Debug: Remote helper: <-
Debug: Capabilities complete.
Debug: Remote helper: Waiting...
Got command 'list' with args ''
? refs/heads/master
@refs/heads/master HEAD
Debug: Remote helper: <- ? refs/heads/master
Debug: Remote helper: Waiting...
Debug: Remote helper: <- @refs/heads/master HEAD
Debug: Remote helper: Waiting...
Debug: Remote helper: <-
Debug: Read ref listing.
Debug: Remote helper: -> export
trace: run_command: 'fast-export' '--use-done-feature' '--export-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' '--import-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' '^refs/testgit/origin/master' 'refs/heads/master'
trace: exec: 'git' 'fast-export' '--use-done-feature' '--export-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' '--import-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' '^refs/testgit/origin/master' 'refs/heads/master'
trace: built-in: git 'fast-export' '--use-done-feature' '--export-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' '--import-marks=.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/testgit.marks' '^refs/testgit/origin/master' 'refs/heads/master'
Got command 'export' with args ''
trace: built-in: git 'for-each-ref' 'refs/heads'
Debug: Remote helper: Waiting...
trace: exec: 'git-fast-import' '--quiet' '--export-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks' '--import-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks'
trace: run_command: 'git-fast-import' '--quiet' '--export-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks' '--import-marks=/devel/stefano/src/git/t/trash directory.t5800-remote-helpers/localclone/.git/info/fast-import/c6c0871f9a7f12cd3f51aa290fbed7c49f539a8c/git.marks'

-*-*-

> Then run ./t5800-remote-helpers.sh -i with the
> following change to make it abort right before git push

With this, the I get:

  ok 1 - setup repository
  ok 2 - cloning from local repo
  ok 3 - cloning from remote repo
  ok 4 - create new commit on remote
  ok 5 - pulling from local repo
  ok 6 - pulling from remote remote
  not ok - 7 pushing to local repo
  #
  #               (cd localclone &&
  #               echo content >>file &&
  #               git commit -a -m three &&
  #               false &&
  #               GIT_TRACE=1 GIT_TRANSPORT_HELPER_DEBUG=1 GIT_DEBUG_TESTGIT=1 git push) &&
  #               compare_refs localclone HEAD server HEAD
  #

Thanks,
  Stefano
