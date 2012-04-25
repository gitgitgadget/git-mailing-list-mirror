From: Mike Doherty <doherty@pythian.com>
Subject: git-svn 1.7.0.4 doesn't report that a directory isn't under version
 control
Date: Wed, 25 Apr 2012 15:17:38 -0400
Message-ID: <4F984DD2.2030804@pythian.com>
Reply-To: doherty@cs.dal.ca
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 25 21:23:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN7np-0007zb-Vm
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 21:23:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757352Ab2DYTW4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Apr 2012 15:22:56 -0400
Received: from na3sys009aog117.obsmtp.com ([74.125.149.242]:59307 "HELO
	na3sys009aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1757067Ab2DYTW4 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 15:22:56 -0400
Received: from mail-yx0-f179.google.com ([209.85.213.179]) (using TLSv1) by na3sys009aob117.postini.com ([74.125.148.12]) with SMTP
	ID DSNKT5hPD7xfGuyGCENzNXT/jZodpk3SAQM9@postini.com; Wed, 25 Apr 2012 12:22:55 PDT
Received: by yenl1 with SMTP id l1so438859yen.10
        for <git@vger.kernel.org>; Wed, 25 Apr 2012 12:22:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:reply-to:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding:x-gm-message-state;
        bh=d5XUMIH+vizsJhx2IBm0qXBciGaydUho+M0lrb6K3lA=;
        b=mLSr+rjFfJj8S++lMdpYhuVkp5XXIJHeWuGgq941aYyVkZfmL04PuQ/5hpW/sjra2+
         kReUJ4DItR4GvKP1mgahbpLhdt+a9rGrMk68PY4OgOMcSKX8QBuhwoPOhIAKoeGMAzev
         2Xl7UaGYbX0O4OQHfE1KDsHuCFGQlvHo8l4X1SBxNHAKw+Ima+xn/vj/a5m+sNIKj01v
         /T9cMpb75kUUZPNZmcdMFcjN2O7EO3Nh97KsW7s3oiepctX15alrk7D2QZ6DP22lwcHY
         H8WZuoT+9uvT4v7c8GGKjJgMrlos0asE+YIEqG4OFek9077PEhx/qwSDzmOFaENAgDWs
         8x0A==
Received: by 10.60.30.199 with SMTP id u7mr4950494oeh.53.1335381457025;
        Wed, 25 Apr 2012 12:17:37 -0700 (PDT)
Received: by 10.60.30.199 with SMTP id u7mr4950485oeh.53.1335381456903;
        Wed, 25 Apr 2012 12:17:36 -0700 (PDT)
Received: from [10.237.236.177] (host7.pythian.com. [209.217.100.70])
        by mx.google.com with ESMTPS id ch5sm718287obb.16.2012.04.25.12.17.36
        (version=SSLv3 cipher=OTHER);
        Wed, 25 Apr 2012 12:17:36 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120412 Thunderbird/11.0.1
X-Gm-Message-State: ALoCoQnjwelk/hqexJtZaWC86ofaPTDZqQFoB4OOK9uyZNAmHbTICkiSS5V5K4/7iWDniNcdGTVHW7YFADCypbl8ttlBFxnBdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196331>

Hello,

I noticed today that git-svn doesn't handle the case where a directory=20
isn't under version control in subversion, but you're still within your=
=20
git tree:

doherty@mdd:~/code/libs_shared/t (my-py-2523)$ git svn info
Use of uninitialized value $lc_author in concatenation (.) or string at=
=20
/usr/lib/git-core/git-svn line 1135.
Use of uninitialized value $lc_rev in concatenation (.) or string at=20
/usr/lib/git-core/git-svn line 1136.
Path: .
URL: svn://svn..../libs_shared/branches/PY-2523/t
Repository Root: svn://svn....
Repository UUID: ...
Revision: 8045
Node Kind: directory
Schedule: normal
Last Changed Author:
Last Changed Rev:
Last Changed Date: 2012-04-25 15:10:51 -0400 (Wed, 25 Apr 2012)

doherty@mdd:~/code/libs_shared/t (my-py-2523)$ svn ls=20
svn://svn.pythian.com/pythian/procter/dispatcher_repo/libs_shared/branc=
hes/PY-2523/t
svn: URL 'svn://svn..../libs_shared/branches/PY-2523/t' non-existent in=
=20
that revision
doherty@mdd:~/code/libs_shared/t (my-py-2523)$ svn ls=20
svn://svn..../libs_shared/branches/PY-2523
Class/
Data/
README
Util.pm
VERSION
XML/
doherty@mdd:~/code/libs_shared/t (my-py-2523)$ git --version
git version 1.7.0.4

I expected git to report that the directory (t) was not under version=20
control, as svn did.

Thanks,
-Mike Doherty

--=20


--

Attending Collaborate12 Apr 22-26? Catch Pythian=92s stellar roster of=20
speakers presenting on a wide array of hot Oracle technology topics. Mo=
re=20
at pythian.com/news
