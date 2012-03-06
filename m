From: BJ Hargrave <bj@bjhargrave.com>
Subject: Re: [ANNOUNCE] Git 1.7.9.3
Date: Tue, 6 Mar 2012 09:35:48 -0500
Message-ID: <A518E7E7-25D5-429C-A1C1-35F94EC8F043@bjhargrave.com>
References: <7vliney6k7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org, trast@student.ethz.ch
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 06 15:36:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4vUb-0000sM-Pc
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 15:35:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030771Ab2CFOfx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 09:35:53 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:46269 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030750Ab2CFOfw convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Mar 2012 09:35:52 -0500
Received: by ghrr11 with SMTP id r11so2234491ghr.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 06:35:51 -0800 (PST)
Received-SPF: pass (google.com: domain of bj@bjhargrave.com designates 10.236.170.198 as permitted sender) client-ip=10.236.170.198;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of bj@bjhargrave.com designates 10.236.170.198 as permitted sender) smtp.mail=bj@bjhargrave.com
Received: from mr.google.com ([10.236.170.198])
        by 10.236.170.198 with SMTP id p46mr34009174yhl.63.1331044551635 (num_hops = 1);
        Tue, 06 Mar 2012 06:35:51 -0800 (PST)
Received: by 10.236.170.198 with SMTP id p46mr26876710yhl.63.1331044551558;
        Tue, 06 Mar 2012 06:35:51 -0800 (PST)
Received: from macbookpro2.hargrave.local ([68.205.24.12])
        by mx.google.com with ESMTPS id l2sm30573450anq.12.2012.03.06.06.35.49
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 06 Mar 2012 06:35:50 -0800 (PST)
In-Reply-To: <7vliney6k7.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1257)
X-Gm-Message-State: ALoCoQkmiqwhzz2AAACMqLn8n3g/r8E31Dz8r+mCgSRcXVlV7bffSWGBb8rsqfG7YeaMdiW6vPaI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192352>


On Mar 5, 2012, at 18:24 , Junio C Hamano wrote:

> Thomas Rast (6):
>      bundle: use a strbuf to scan the log for boundary commits

This fix (bc2fed496baa54ae99dede7da23dec938adbf0eb) modified test t5704 which now fails on my Mac (10.7.3)

*** t5704-bundle.sh ***
ok 1 - setup
ok 2 - tags can be excluded by rev-list options
ok 3 - die if bundle file cannot be created
not ok 4 - bundle --stdin # TODO known breakage
not ok 5 - bundle --stdin <rev-list options> # TODO known breakage
ok 6 - empty bundle file is rejected
not ok - 7 ridiculously long subject in boundary
#	
#		: >file4 &&
#		test_tick &&
#		git add file4 &&
#		printf "%01200d
#	" 0 | git commit -F - &&
#		test_commit fifth &&
#		git bundle create long-subject-bundle.bdl HEAD^..HEAD &&
#		git bundle list-heads long-subject-bundle.bdl >heads &&
#		test -s heads &&
#		git fetch long-subject-bundle.bdl &&
#		sed -n "/^-/{p;q}" long-subject-bundle.bdl >boundary &&
#		grep "^-$_x40 " boundary
#	
# still have 2 known breakage(s)
# failed 1 among remaining 5 test(s)
1..7
make[3]: *** [t5704-bundle.sh] Error 1


-- 

BJ Hargrave
