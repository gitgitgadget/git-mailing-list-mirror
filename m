From: Phillip Susi <psusi@ubuntu.com>
Subject: Clone from shallow bundle bug
Date: Tue, 31 Mar 2015 17:10:15 -0400
Message-ID: <551B0D37.5070407@ubuntu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 23:11:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd3Rc-0000Sb-83
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 23:11:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbbCaVLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 17:11:08 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36016 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751541AbbCaVLD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 17:11:03 -0400
Received: by qgf60 with SMTP id 60so26550113qgf.3
        for <git@vger.kernel.org>; Tue, 31 Mar 2015 14:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=0eREQzDX4N0KGjaVmDLz8uCi2J96EdE+d2vd49WPv+4=;
        b=SgUIoEJ2kKIlGjaYdAnFHTmveiw2SCaroN6bzh/zGU2Ox38CsvQgLzIRX6FzM+/nlm
         cfJKthZAVab1c33XguJmCt2VEkMm+rSDSPj3wkHm9C0zwVl3rlLA/pzNUlGsClod+8bn
         s10GXyYmuuARe46Ow4zXLuY1GfeIkRtxXFOBhYuSVAIsD6q3k9EzstMoqH+PZq7G2MEf
         h3SIu98Y94Gg9zqM4JlOiMGDe34kUfK10OPk4aBeYm/ZlhFm+U3Ji/rzbWKJXNEKbXZ/
         xe71sMwr1+kEetbm5wUk7LSEHHogcjOBDZf6JDnfBYV0R5dy05Ewur5LzH15/eFL2WBI
         vqCQ==
X-Received: by 10.55.23.82 with SMTP id i79mr82640778qkh.15.1427836262054;
        Tue, 31 Mar 2015 14:11:02 -0700 (PDT)
Received: from [10.1.1.228] (fl-67-77-88-12.sta.embarqhsd.net. [67.77.88.12])
        by mx.google.com with ESMTPSA id k81sm7656530qkh.48.2015.03.31.14.11.01
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Mar 2015 14:11:01 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266557>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I made a shallow clone of my repo, then used git bundle create to pack
it all into a bundle file, then cloned from that bundle.  The initial
shallow clone has a .git/shallow file that identifies it as a shallow
clone ( and I guess keeps things from complaining about the missing
history ), but the the repo cloned from the bundle does not, so gitk
run in that clone complains about not being able to find the objects
referenced by the oldest commit in the repo.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (MingW32)

iQEcBAEBAgAGBQJVGw03AAoJENRVrw2cjl5R4aQIAKxddA+eneEEchuygYwA8zFK
4O+LuEXbJ09JR196Zj535jbJ3NLre8KLX8l7gxVRFQ5FscG0+ylvawAZ2VCUrl+6
dfTXOTfzmu36GGKJ+wG7SFIIEAzjFyLk8bj5qtJgF3F3PZqkgxmBGmQskGK1Dlet
VUqXL0IndMTDnb5//pFGyF2L5aPvBfXcC6pZAUBjKz4dl7MfFVXbuzCMe2TqN+l6
dPPjqANGb8MiAdhoVQ69c0uI2XH9dvmpRJTOX1Yr1IMW/AvKKM/w/A9MDKkhsab3
ccgeYDUjtUioaplnMcDwkSj4jQfQedgmIUdHeMbT0WOiKvHRArlroRVcjQS8pps=
=kPAv
-----END PGP SIGNATURE-----
