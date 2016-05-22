From: Pranit Bauva <pranit.bauva@gmail.com>
Subject: [GSoC Update] Week 3
Date: Mon, 23 May 2016 01:28:23 +0530
Message-ID: <1463947103-28464-1-git-send-email-pranit.bauva@gmail.com>
References: <1463334359-14033-1-git-send-email-pranit.bauva@gmail.com>
Cc: larsxschneider@gmail.com, chriscool@tuxfamily.org,
	christian.couder@gmail.com, Pranit Bauva <pranit.bauva@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 22 22:00:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b4ZXu-0006a2-8J
	for gcvg-git-2@plane.gmane.org; Sun, 22 May 2016 22:00:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbcEVUAF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 May 2016 16:00:05 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36355 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752529AbcEVUAE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 May 2016 16:00:04 -0400
Received: by mail-pa0-f54.google.com with SMTP id bt5so55133777pac.3
        for <git@vger.kernel.org>; Sun, 22 May 2016 13:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3eikgx8HzwMiZArbniLYEQVgUQZbboUau1FKo6n/sqY=;
        b=QmEAtpv4RvxhXMMmhHwRPGNHaz4Ab8eq0fMyXPSgTOTITdQ4oC1XVexo5HYh8EsfQX
         zRVslgEP/Dg6VHZLaa7qX4QdNuVA+4FSnUREYfbadgCP6uZ3ChaCZCOEOq6vEV09b3uC
         ah+bQGHWFKuEBH67V80eHc3dtpekKkp4Wz3EGurBb/ooCrY8rOv1mOoSrUcpQ04eK9yg
         eBrhszbY926R26Bjin2xtdfWaJ9xZ3+nL4bOHGugziDDel3AGO4iFwEKjGuEJruv3Xu4
         uA8VDMB7lpXiNYV5670oWXppfPAoroo3ywE10w/TBSJhy4ze+bakWngpRHkuGuMJOhfI
         EVDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3eikgx8HzwMiZArbniLYEQVgUQZbboUau1FKo6n/sqY=;
        b=SItYD6FMe+4PlWXzSFExcEX2Hjy1CgmdiKSGzsQg+eHf/cPOtPPX38VUYob10APj83
         mOJiqBhCm1VwkCaK0qlISE0lFVWWCCvrNg6C0VIasz6rxMeZqb6HvqHpeD2M/sMb8mVh
         a7d+bQtwzFFLNDp85xl8bqYImocgDNTiVGeX6MFrHIEiHMSvEl0gNOS3Af0dt6V/XLC8
         ims4V5NiKw7Smb/UBEP6gbTvj7o9HTWtEH7qc8+BIAo0qpkS28qbeZN7DK4KKoKNMsd+
         rsDocZG5DEhMAfSkaXd4filisJD/Vk0tvfX5WjOtz3Iviu2zy/cPyY4dv57hPJU1+7hl
         siQA==
X-Gm-Message-State: AOPr4FW0I7S3ISmvJ6kWGS2RCCIqYcGTXOM03itKFgaOxfO/aSvtbCWvaYAv44LQtWv7EQ==
X-Received: by 10.67.21.177 with SMTP id hl17mr21904556pad.39.1463947203078;
        Sun, 22 May 2016 13:00:03 -0700 (PDT)
Received: from localhost.localdomain ([183.87.83.48])
        by smtp.gmail.com with ESMTPSA id vw1sm26889562pab.35.2016.05.22.12.59.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 May 2016 13:00:02 -0700 (PDT)
X-Mailer: git-send-email 2.8.2
In-Reply-To: <1463334359-14033-1-git-send-email-pranit.bauva@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295290>

============================ INTRODUCTION ==============================
The purpose of this project is to convert the git-bisect utility which
partly exists in the form of shell scripts to C code so as to make it more
portable. I plan to do this by converting each function to C and then
calling it from git-bisect.sh so as to use the existing test suite to test
the function which is converted.

Mentors:
Christian Couder <chriscool@tuxfamily.org>
Lars Schneider <larsxschneider@gmail.com>

============================== UPDATES =================================
Things which were done in this week:

 * My patches for write_terms()[1] and bisect_log()/voc()[2] have collected
   some reviews from Eric Sunshine and Johannes Schindelin.

 * As advised in the reviews I have mainly read about git_path() and other
   related functions from cache.h

 * Also read up on the refs stuff like for_each_ref_in() which Junio
   mentioned in the previous update email.

 * I have made 2 commits[3] which I am keeping on hold for now as they are
   followup for a commit made by Jeff King which I came across while
   reading about git_path() and related stuff.

 * I have kind of finished writing bisect_clean_state() function. But I
   am still working on that as I suspect there might be something missing.

============================ NEXT STEPS ================================
Since I wasn't able to cover up many things this week (which I had
initially planned), those things have now been carried forward along with
a few other stuff. I plan to work more this week and the coming few ones
to make up for the lost time.

Things which would be done in the coming week:

 * Finish off (finally) bisect_clean_state() conversion.

 * Convert the function bisect_head(). I plan to convert this function and
   add it as a subcommand to test the implementation but I will only send
   the function without the subcommand to the mailing list because its a
   too small function. Though the subcommand version will be put up on
   github for everyone to verify whether it is passing the test suite like
   I have done it for bisect_voc().

 * Convert the function bisect_write(). I plan to convert this function
   and add it as a subcommand.

 * Investigate why test no. 43 and 44 are failing in t6030 with `|| exit`
   in --write-terms.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/294388
[2]: http://thread.gmane.org/gmane.comp.version-control.git/294571
