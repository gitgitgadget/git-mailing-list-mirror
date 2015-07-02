From: Igevorse Otonnoleare <igevorse@gmail.com>
Subject: Wrong graph output of 'git log --graph --date-order --all' command
Date: Thu, 2 Jul 2015 15:41:00 +0500
Message-ID: <CADk_vu1rydigy4png-zuHfMbtrR8f-4fzZ-jdviYWYqfx4kGpg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 12:41:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZAbvX-0000V6-De
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jul 2015 12:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753121AbbGBKlD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Jul 2015 06:41:03 -0400
Received: from mail-vn0-f45.google.com ([209.85.216.45]:33171 "EHLO
	mail-vn0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752737AbbGBKlB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Jul 2015 06:41:01 -0400
Received: by vnbf190 with SMTP id f190so10660166vnb.0
        for <git@vger.kernel.org>; Thu, 02 Jul 2015 03:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=u6R6JCSSZwSf+9kxRMd7Jnr93AsrlgDLpkGoEVz/5Do=;
        b=iSqVgxT1cqd4g7qF2QSzj6Yg5JFwpFECA7toh4i+tXGNuSHNSAw5hdFqLlmmbU4gDQ
         TFoa6VZbGKl8ZxHtGXQTzFasEqOAwhtLQGQtvonmL7BkE+0H5xzxm0SaIg9gxcjtZS5R
         jG699fiq5iNZ1eaGv99gnlmAPRsLqjBC/Q8LFvs+3IaP3lQFDkYa2oObfquySuFb9sI4
         ao41hD6Wt/zYXVSqTHVuQuyM3SxiX27Cq0Y8MiZLZjQX8qAvb3Z47WCgtmDSwKi/SWs1
         dtG0lPtVXtiB9p4sBT04zoBoKhzP7P9tuTT4toFWsxkfL+eDzncEYdgksmmgFuVgllAX
         5HGQ==
X-Received: by 10.52.122.52 with SMTP id lp20mr29811107vdb.64.1435833660164;
 Thu, 02 Jul 2015 03:41:00 -0700 (PDT)
Received: by 10.31.224.65 with HTTP; Thu, 2 Jul 2015 03:41:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273224>

Hello.
Command:
git log --graph --date-order --all
Tested in 2.0.0.rc2, 2.1.4 and latest
master(cbed29f37b690e0a497bd2b6ca9a5bdd7e6ea5aa Git 2.5.0-rc1)
Importance: some software that works with generated tree could crash.
(For example, https://github.com/bluef/gitgraph.js crashes)

When I execute this command, I get a wrong graph:

root@Repserv# git log --graph --date-order --all --pretty=3Doneline |
grep Versioning --context=3D5
 1:| | | | | | | | | | | *   28935fe44c21117970d229a813612b03fc373304
Merge branch 'stable' into EditFinPlan
 2:| | | | | | | | | | | |\
 3:| | | | | | | | | | |/ /
 4:| |_|_|_|_|_|_|_|_|_| /      <--- Here it is
 5:|/| | | | | | | | | |
 6:* | | | | | | | | | |   4ebbb6d9af1db1ddeb7a9bee120ba62d3f6ca92d
Merge branch 'Versioning' into stable
 7:|\ \ \ \ \ \ \ \ \ \ \
 8:| * | | | | | | | | | | 9cafe4d5c9fa6231fc99613e183c5d1620c36624
=D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D0=BB GitVersion - =D0=B7=D0=B0=D1=
=85=D0=B0=D1=80=D0=B4=D0=BA=D0=BE=D0=B4=D0=B8=D0=BB
 9:| * | | | | | | | | | | c388f7ea6bc59e9c908b14fb8b81ad06c8d0bfd8 =D0=
=9E=D0=B1=D0=BD=D0=BE=D0=B2=D0=B8=D0=BB =D1=85=D1=83=D0=BA
10:| * | | | | | | | | | | e2f94b3978b7eb9e7d6ed6bce9c7741f99fc0f16
=D0=9D=D0=BE=D0=B2=D1=8B=D0=B9 =D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=82 =D0=
=B2=D0=B5=D1=80=D1=81=D0=B8=D0=B8 =D0=B2=D1=8B=D0=B2=D0=BE=D0=B4=D0=B8=D1=
=82=D1=81=D1=8F =D0=BD=D0=B0 =D0=B3=D0=BB=D0=B0=D0=B2=D0=BD=D0=BE=D0=B9
11:| * | | | | | | | | | | 7184b727e024ba298f78f92626e7c9d5c630d806
Additional version to assembly

Take a look at the line 4: new line starts from nowhere, although it
is a part of other branch.

Here are correct outputs of 'git log' with other parameters:

root@Repserv# git log --graph --all --pretty=3Doneline | grep Versionin=
g
--context=3D5
| | | | | | | | | | | | | | | * |
3c183e987ba101c62a4a52ee1314d5461cc3fc78 Merge branch 'stable' of
//10.0.0.92/ER into EditFinPlan
| | | | | | | | | | | | | | | |\ \
| |_|_|_|_|_|_|_|_|_|_|_|_|_|_|/ /
|/| | | | | | | | | | | | | | | /
| | | | | | | | | | | | | | | |/
* | | | | | | | | | | | | | | |
4ebbb6d9af1db1ddeb7a9bee120ba62d3f6ca92d Merge branch 'Versioning'
into stable
|\ \ \ \ \ \ \ \ \ \ \ \ \ \ \ \
| * | | | | | | | | | | | | | | |
9cafe4d5c9fa6231fc99613e183c5d1620c36624 =D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=
=D0=B8=D0=BB GitVersion -
=D0=B7=D0=B0=D1=85=D0=B0=D1=80=D0=B4=D0=BA=D0=BE=D0=B4=D0=B8=D0=BB
| * | | | | | | | | | | | | | | |
c388f7ea6bc59e9c908b14fb8b81ad06c8d0bfd8 =D0=9E=D0=B1=D0=BD=D0=BE=D0=B2=
=D0=B8=D0=BB =D1=85=D1=83=D0=BA
| * | | | | | | | | | | | | | | |
e2f94b3978b7eb9e7d6ed6bce9c7741f99fc0f16 =D0=9D=D0=BE=D0=B2=D1=8B=D0=B9=
 =D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=82 =D0=B2=D0=B5=D1=80=D1=81=D0=B8=D0=
=B8 =D0=B2=D1=8B=D0=B2=D0=BE=D0=B4=D0=B8=D1=82=D1=81=D1=8F
=D0=BD=D0=B0 =D0=B3=D0=BB=D0=B0=D0=B2=D0=BD=D0=BE=D0=B9
| * | | | | | | | | | | | | | | |
7184b727e024ba298f78f92626e7c9d5c630d806 Additional version to
assembly

root@Repserv# git log --graph  --pretty=3Doneline | grep Versioning --c=
ontext=3D5
|\
| *   74adc31c6c08a0d3524a6ed1bebeb7f6c79447d7 Merge branch 'stable'
of //10.0.0.92/ER.git into 196_ErrorOnSaveSessionRegBuilding
| |\
* | \   4d06b0cea208865b983ce3b678276d28d51d5fc8 Merge branch 'stable'
|\ \ \
| * \ \   4ebbb6d9af1db1ddeb7a9bee120ba62d3f6ca92d Merge branch
'Versioning' into stable
| |\ \ \
| | * | | 9cafe4d5c9fa6231fc99613e183c5d1620c36624 =D0=9E=D0=B1=D0=BD=D0=
=BE=D0=B2=D0=B8=D0=BB GitVersion
- =D0=B7=D0=B0=D1=85=D0=B0=D1=80=D0=B4=D0=BA=D0=BE=D0=B4=D0=B8=D0=BB
| | * | | c388f7ea6bc59e9c908b14fb8b81ad06c8d0bfd8 =D0=9E=D0=B1=D0=BD=D0=
=BE=D0=B2=D0=B8=D0=BB =D1=85=D1=83=D0=BA
| | * | | e2f94b3978b7eb9e7d6ed6bce9c7741f99fc0f16 =D0=9D=D0=BE=D0=B2=D1=
=8B=D0=B9 =D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=82 =D0=B2=D0=B5=D1=80=D1=81=
=D0=B8=D0=B8
=D0=B2=D1=8B=D0=B2=D0=BE=D0=B4=D0=B8=D1=82=D1=81=D1=8F =D0=BD=D0=B0 =D0=
=B3=D0=BB=D0=B0=D0=B2=D0=BD=D0=BE=D0=B9
| | * | | 7184b727e024ba298f78f92626e7c9d5c630d806 Additional version
to assembly


root@Repserv# git log --graph --date-order  --pretty=3Doneline | grep
Versioning --context=3D5
*   121a658305e26386b946a4eac194514ba7dfa827 Merge remote-tracking
branch 'origin/196_ErrorOnSaveSessionRegBuilding'
|\
* \   4d06b0cea208865b983ce3b678276d28d51d5fc8 Merge branch 'stable'
|\ \
| * \   4ebbb6d9af1db1ddeb7a9bee120ba62d3f6ca92d Merge branch
'Versioning' into stable
| |\ \
| | * | 9cafe4d5c9fa6231fc99613e183c5d1620c36624 =D0=9E=D0=B1=D0=BD=D0=BE=
=D0=B2=D0=B8=D0=BB GitVersion -
=D0=B7=D0=B0=D1=85=D0=B0=D1=80=D0=B4=D0=BA=D0=BE=D0=B4=D0=B8=D0=BB Ereg=
ion.Web/App_code/AssemblyInfo.cs
| | * | c388f7ea6bc59e9c908b14fb8b81ad06c8d0bfd8 =D0=9E=D0=B1=D0=BD=D0=BE=
=D0=B2=D0=B8=D0=BB =D1=85=D1=83=D0=BA
| | * | e2f94b3978b7eb9e7d6ed6bce9c7741f99fc0f16 =D0=9D=D0=BE=D0=B2=D1=8B=
=D0=B9 =D1=84=D0=BE=D1=80=D0=BC=D0=B0=D1=82 =D0=B2=D0=B5=D1=80=D1=81=D0=
=B8=D0=B8
=D0=B2=D1=8B=D0=B2=D0=BE=D0=B4=D0=B8=D1=82=D1=81=D1=8F =D0=BD=D0=B0 =D0=
=B3=D0=BB=D0=B0=D0=B2=D0=BD=D0=BE=D0=B9
| | * | 7184b727e024ba298f78f92626e7c9d5c630d806 Additional version to =
assembly


=46eel free to write me if you need additional information.
Thanks.
