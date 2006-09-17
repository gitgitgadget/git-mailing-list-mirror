From: Dongsheng Song <dongsheng.song@gmail.com>
Subject: git-repack: Outof memory
Date: Sun, 17 Sep 2006 09:31:13 +0800
Message-ID: <450CA561.9030602@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Sep 17 03:32:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GOlWT-00054K-1g
	for gcvg-git@gmane.org; Sun, 17 Sep 2006 03:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964895AbWIQBbZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Sep 2006 21:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964902AbWIQBbZ
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Sep 2006 21:31:25 -0400
Received: from py-out-1112.google.com ([64.233.166.183]:42825 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964895AbWIQBbY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Sep 2006 21:31:24 -0400
Received: by py-out-1112.google.com with SMTP id n25so4719989pyg
        for <git@vger.kernel.org>; Sat, 16 Sep 2006 18:31:24 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:x-enigmail-version:openpgp:content-type:content-transfer-encoding;
        b=eBq2jU9/ybkTFabOK9NS/uAczrbJx4AbHixZ57lI1Z6xhETkWliCjXb3DQjsmJfUtBAS2eaG9wzpivHJ2F8QeAoaFuuNeBwFb+lB5YWqMOl83Fu3+gKYw4EXOgMPOKC+tw9ZxPkXIyC6BD9sOf1oS/MpUapMlzww9XYzwJSB124=
Received: by 10.35.53.18 with SMTP id f18mr20519121pyk;
        Sat, 16 Sep 2006 18:31:23 -0700 (PDT)
Received: from ?202.96.180.210? ( [202.96.180.210])
        by mx.gmail.com with ESMTP id r1sm4292796nzd.2006.09.16.18.31.22;
        Sat, 16 Sep 2006 18:31:23 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: git@vger.kernel.org
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=90A06C7A
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27148>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all:


I'm import from subversion. The problem appears to be git-repack phase using too many memory:

$ git-repack -a -f -d --window=64 --depth=64
Generating pack...
Done counting 123497 objects.
Deltifying 123497 objects.
  24% (29677/123497) done

$ top

  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
 3572 www-data  18   0 2591m 1.9g  528 R   13 94.8  81:48.98 git-pack-object


$ free
             total       used       free     shared    buffers     cached
Mem:       2076308    2029824      46484          0       2760       6800
- -/+ buffers/cache:    2020264      56044
Swap:      1028152     684032     344120


How to compute memory usage of git-repack ?

Thanks and regards,

Dongsheng

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)

iD8DBQFFDKVh90pbDJCgbHoRAlweAJ45DhTXI+bb+nb2Y+JlbIBoFusK8wCgk0U2
XcUc9K/chYiUYq3ZLychzcU=
=NzXf
-----END PGP SIGNATURE-----
