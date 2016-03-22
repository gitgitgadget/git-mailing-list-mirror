From: Marcus T <maddimax@googlemail.com>
Subject: git fails updating submodule only if --quiet is specified
Date: Tue, 22 Mar 2016 16:02:24 +0100
Message-ID: <3E1D841C-7665-43DB-A0F8-99999C59C28D@googlemail.com>
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Content-Type: multipart/signed; boundary="Apple-Mail=_1C8D9ADC-9C20-4075-9D76-BDE0CDE165D7"; protocol="application/pgp-signature"; micalg=pgp-sha512
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 22 16:02:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiNpM-0005ws-MU
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 16:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751593AbcCVPCc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Mar 2016 11:02:32 -0400
Received: from mail-qg0-f43.google.com ([209.85.192.43]:33217 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303AbcCVPCa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Mar 2016 11:02:30 -0400
Received: by mail-qg0-f43.google.com with SMTP id 51so14945398qgy.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:subject:date:message-id:to:mime-version;
        bh=KxJMNl6mzKUqhCGZYiYKJGDuH4OnbPNdtDPrsUEDJ5E=;
        b=jxeNFLey57mS6yfn92hy5hs5+YZTiuQqUedPo4Z9VRW4sWSNyzpX0/W57Un5UtIk5X
         MrDrzCd7+GljcJvKV8d4D+A+3e3DV3FtDTPSf/S5N7zPYhF+bXyC2FsMjUQ3QHHTnd4q
         P5Y2AQ28Zd89UFqD+gbpI5VrsqJaaTguXgb/XKW3b/0DC6YTOzn/2Hgt4PtkujI8FDUU
         6cL4mV+aS4ZfUrsLGQKaVq4S+QuJngrNCeIfRFEi43+4wCG9lmpyb4aroqwdjkZbpxBC
         k5rfUuqOU0fdHwkVbF7VV1JG2xcVy2ag7QTHAMg723R5NwZhb2NIo3s8JqNNwXRtBH3K
         yS7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:subject:date:message-id:to:mime-version;
        bh=KxJMNl6mzKUqhCGZYiYKJGDuH4OnbPNdtDPrsUEDJ5E=;
        b=hzLy0eQ8XmMo1fXYToj93JU3KAsXM7sYjpyoPlBjFFZ7Wz4CedMNpBUR3TvgB15SzF
         YToo1Jn2kvkmyTrB6rc3qJsShLVdlT1ztbvoGLKJxytD05SLNV02DtATTnNFvrLyRwis
         q38arU5OKZJMvYF7mNB/9cTdUiTHKyR7btSnQvA48KXDR2qxxLlPKerEyYZXlHDcW1d3
         /5SMlce7dFNBv5xetIWAAOlhl3+gtzQh5hn5CYJZZEVtyNsaAXQYPYyKazuWhCKuniD+
         G9BcFhMAP9NaFEMhmHYcSVpBqHWZiAW8yBrUoSZKJP2l7ZBCQrjlClT101TUg9usSnkc
         F4tg==
X-Gm-Message-State: AD7BkJIPGJljGKPMlMyynJsMJccqjFIyREKf5K50E918OMyo4tpuEn7/VW4yInHi/Oa9MA==
X-Received: by 10.140.104.234 with SMTP id a97mr47599017qgf.57.1458658949366;
        Tue, 22 Mar 2016 08:02:29 -0700 (PDT)
Received: from [10.15.0.148] (82-198-216-115.briteline.de. [82.198.216.115])
        by smtp.googlemail.com with ESMTPSA id w1sm14734123qha.3.2016.03.22.08.02.27
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Mar 2016 08:02:28 -0700 (PDT)
X-Pgp-Agent: GPGMail 2.5.2
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289506>


--Apple-Mail=_1C8D9ADC-9C20-4075-9D76-BDE0CDE165D7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hello,

I=E2=80=99m running into a nasty issue where =E2=80=9Cgit submodule =
update =E2=80=94init=E2=80=9D fails if I add =E2=80=9C=E2=80=94quiet=E2=80=
=9D

Following you can find the output with GIT_TRACE=3D1:

WITHOUT --quiet:

GIT_TRACE=3D1 git submodule update --init --recursive
15:51:48.248945 git.c:561               trace: exec: 'git-submodule' =
'update' '--init' '--recursive'
15:51:48.249023 run-command.c:334       trace: run_command: =
'git-submodule' 'update' '--init' '--recursive'
15:51:48.256626 git.c:344               trace: built-in: git 'rev-parse' =
'--git-dir'
15:51:48.258494 git.c:344               trace: built-in: git 'rev-parse' =
'--git-path' 'objects'
15:51:48.260406 git.c:344               trace: built-in: git 'rev-parse' =
'-q' '--git-dir'
15:51:48.262940 git.c:344               trace: built-in: git 'rev-parse' =
'--show-prefix'
15:51:48.264156 git.c:344               trace: built-in: git 'rev-parse' =
'--show-toplevel'
15:51:48.266637 git.c:344               trace: built-in: git =
'submodule--helper' 'list' '--prefix' ''
15:51:48.268074 git.c:344               trace: built-in: git =
'submodule--helper' 'name' 'buildroot'
15:51:48.269913 git.c:344               trace: built-in: git 'config' =
'submodule.buildroot.url'
15:51:48.271168 git.c:344               trace: built-in: git 'config' =
'-f' '.gitmodules' 'submodule.buildroot.update'
15:51:48.272422 git.c:344               trace: built-in: git =
'submodule--helper' 'name' 'dl'
15:51:48.274179 git.c:344               trace: built-in: git 'config' =
'submodule.dl.url'
15:51:48.275445 git.c:344               trace: built-in: git 'config' =
'-f' '.gitmodules' 'submodule.dl.update'
15:51:48.276779 git.c:344               trace: built-in: git =
'submodule--helper' 'list' '--prefix' ''
15:51:48.278362 git.c:344               trace: built-in: git =
'submodule--helper' 'name' 'buildroot'
15:51:48.279819 git.c:344               trace: built-in: git 'config' =
'submodule.buildroot.url'
15:51:48.281192 git.c:344               trace: built-in: git 'config' =
'submodule.buildroot.branch'
15:51:48.282473 git.c:344               trace: built-in: git 'config' =
'-f' '.gitmodules' 'submodule.buildroot.branch'
15:51:48.283788 git.c:344               trace: built-in: git 'config' =
'submodule.buildroot.update'
15:51:48.285269 git.c:344               trace: built-in: git =
'submodule--helper' 'clone' '--prefix' '' '--path' 'buildroot' '--name' =
'buildroot' '--url' 'git://git.busybox.net/buildroot' '' ''
15:51:48.285337 run-command.c:334       trace: run_command: 'clone' =
'--no-checkout' '--separate-git-dir' '.git/modules/buildroot' =
'git://git.busybox.net/buildroot' 'buildroot'
15:51:48.285687 exec_cmd.c:120          trace: exec: 'git' 'clone' =
'--no-checkout' '--separate-git-dir' '.git/modules/buildroot' =
'git://git.busybox.net/buildroot' 'buildroot'
15:51:48.286453 git.c:344               trace: built-in: git 'clone' =
'--no-checkout' '--separate-git-dir' '.git/modules/buildroot' =
'git://git.busybox.net/buildroot' 'buildroot'
Cloning into 'buildroot'...
15:51:49.177856 run-command.c:334       trace: run_command: 'index-pack' =
'--stdin' '-v' '--fix-thin' '--keep=3Dfetch-pack 15895 on =
bre-build-linux' '--check-self-contained-and-connected'
15:51:49.178244 exec_cmd.c:120          trace: exec: 'git' 'index-pack' =
'--stdin' '-v' '--fix-thin' '--keep=3Dfetch-pack 15895 on =
bre-build-linux' '--check-self-contained-and-connected'
15:51:49.179806 git.c:344               trace: built-in: git =
'index-pack' '--stdin' '-v' '--fix-thin' '--keep=3Dfetch-pack 15895 on =
bre-build-linux' '--check-self-contained-and-connected'
remote: Counting objects: 200277, done.
remote: Compressing objects: 100% (62420/62420), done.
...

WITH --quite:

GIT_TRACE=3D1 git submodule update --init --recursive --quiet
15:52:26.900568 git.c:561               trace: exec: 'git-submodule' =
'update' '--init' '--recursive' '--quiet'
15:52:26.900652 run-command.c:334       trace: run_command: =
'git-submodule' 'update' '--init' '--recursive' '--quiet'
15:52:26.907761 git.c:344               trace: built-in: git 'rev-parse' =
'--git-dir'
15:52:26.909877 git.c:344               trace: built-in: git 'rev-parse' =
'--git-path' 'objects'
15:52:26.911766 git.c:344               trace: built-in: git 'rev-parse' =
'-q' '--git-dir'
15:52:26.914279 git.c:344               trace: built-in: git 'rev-parse' =
'--show-prefix'
15:52:26.915488 git.c:344               trace: built-in: git 'rev-parse' =
'--show-toplevel'
15:52:26.917983 git.c:344               trace: built-in: git =
'submodule--helper' 'list' '--prefix' ''
15:52:26.919504 git.c:344               trace: built-in: git =
'submodule--helper' 'name' 'buildroot'
15:52:26.921244 git.c:344               trace: built-in: git 'config' =
'submodule.buildroot.url'
15:52:26.922619 git.c:344               trace: built-in: git 'config' =
'-f' '.gitmodules' 'submodule.buildroot.update'
15:52:26.923888 git.c:344               trace: built-in: git =
'submodule--helper' 'name' 'dl'
15:52:26.925650 git.c:344               trace: built-in: git 'config' =
'submodule.dl.url'
15:52:26.926892 git.c:344               trace: built-in: git 'config' =
'-f' '.gitmodules' 'submodule.dl.update'
15:52:26.928230 git.c:344               trace: built-in: git =
'submodule--helper' 'list' '--prefix' ''
15:52:26.929709 git.c:344               trace: built-in: git =
'submodule--helper' 'name' 'buildroot'
15:52:26.931220 git.c:344               trace: built-in: git 'config' =
'submodule.buildroot.url'
15:52:26.932597 git.c:344               trace: built-in: git 'config' =
'submodule.buildroot.branch'
15:52:26.933867 git.c:344               trace: built-in: git 'config' =
'-f' '.gitmodules' 'submodule.buildroot.branch'
15:52:26.935170 git.c:344               trace: built-in: git 'config' =
'submodule.buildroot.update'
15:52:26.936660 git.c:344               trace: built-in: git =
'submodule--helper' 'clone' '--quiet' '--prefix' '' '--path' 'buildroot' =
'--name' 'buildroot' '--url' 'git://git.busybox.net/buildroot' '' ''
15:52:26.936732 run-command.c:334       trace: run_command: 'clone' =
'--no-checkout' '--quiet' '--separate-git-dir' '.git/modules/buildroot' =
'git://git.busybox.net/buildroot' 'buildroot'
15:52:26.936965 exec_cmd.c:120          trace: exec: 'git' 'clone' =
'--no-checkout' '--quiet' '--separate-git-dir' '.git/modules/buildroot' =
'git://git.busybox.net/buildroot' 'buildroot'
15:52:26.937803 git.c:344               trace: built-in: git 'clone' =
'--no-checkout' '--quiet' '--separate-git-dir' '.git/modules/buildroot' =
'git://git.busybox.net/buildroot' 'buildroot'
15:52:27.958503 run-command.c:334       trace: run_command: 'index-pack' =
'--stdin' '--fix-thin' '--keep=3Dfetch-pack 15936 on bre-build-linux' =
'--check-self-contained-and-connected'
15:52:27.958870 exec_cmd.c:120          trace: exec: 'git' 'index-pack' =
'--stdin' '--fix-thin' '--keep=3Dfetch-pack 15936 on bre-build-linux' =
'--check-self-contained-and-connected'
15:52:27.960447 git.c:344               trace: built-in: git =
'index-pack' '--stdin' '--fix-thin' '--keep=3Dfetch-pack 15936 on =
bre-build-linux' '--check-self-contained-and-connected'
fatal: The remote end hung up unexpectedly
fatal: early EOF
fatal: index-pack failed
fatal: clone of 'git://git.busybox.net/buildroot' into submodule path =
'buildroot' failed

---------
git --version
git version 2.7.4

Any help in tracking down the reason for this would be greatly =
appreciated.

Thanks,
Marcus


--Apple-Mail=_1C8D9ADC-9C20-4075-9D76-BDE0CDE165D7
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJW8V6BAAoJEK5MaPYXd0Y0D5MIAM0iBjZ8161AJ/Y+ORGSLet0
tnkbb1yIYj36evxE+Vbwh1GGPVCbonsinEsODsgqRbKLkFuPP0RiS3u7X40Z9F3u
W5GfyVazzmd66LVI/MZVDiMRIMY3VmVDrOZc5dLpNWqutc5+eThF3AOE8t4AQkmw
TOYmwgnx6PgeUhtBZgjjEiEOEe8s/Gqmvb7XkLvsyWRmzHKFQhopjkuTb530ffcx
blBm/WGRQrSjgZoAAPJ7AN6/68nHSaGRW3uDOJUoCOYvx3cpJS0+e4B61VRCKYis
L9DYBEkQIooArmDsnaFYjiLvRYClFipoUiiPuYGGLixqR6tS3k/rexbvchWoOaM=
=x8eG
-----END PGP SIGNATURE-----

--Apple-Mail=_1C8D9ADC-9C20-4075-9D76-BDE0CDE165D7--
