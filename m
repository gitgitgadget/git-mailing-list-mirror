From: =?UTF-8?Q?Torsten_B=c3=b6gershausen?= <tboegi@web.de>
Subject: t6044 broken on pu
Date: Sat, 7 May 2016 14:00:08 +0200
Message-ID: <7d747193-7ba1-e274-86dc-427ed0f124c9@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: newren@gmail.com, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 07 14:00:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1az0uk-00023a-Jf
	for gcvg-git-2@plane.gmane.org; Sat, 07 May 2016 14:00:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752721AbcEGMAc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 May 2016 08:00:32 -0400
Received: from mout.web.de ([212.227.15.3]:56888 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752640AbcEGMAW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 May 2016 08:00:22 -0400
Received: from macce.local ([195.252.60.88]) by smtp.web.de (mrweb001) with
 ESMTPSA (Nemesis) id 0LbIiI-1bNeUV2hT8-00ksw2; Sat, 07 May 2016 14:00:17
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:45.0)
 Gecko/20100101 Thunderbird/45.0
X-Provags-ID: V03:K0:/VGxd8IeJ+D0XmH04axVCLTA53tXx4pKelerIHiWcN210mcRHUb
 GIEoNUC5yUoHDz8g8EV/L2SvOSkxkk+gup8GtM5WOOToH28nHp3UyH/f2F3ckZ98WO0Uw72
 i5hGvDughuYY/27OfkJSKyACCtKby0V+r7DySycEdhW0HIX8Brsk5RVoaKRVmJGAuvtsoAG
 WQddDcm1/ziagwKMjn7Rw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2SVI7S8cZ2o=:7FUWEqnVtGw0p8fg32VQgg
 Tnan1/GOLcxadIGdpbnyoQYbiLUT5iIbBBZNtMumtUySS/o+nN+EAqhD4rBhuY25DLWwASz6h
 3lNQJG25/xR9iy2q42VDAchNyzcqNycMdz9Y98Wdz9TeCnmkPqnHy1ML3g39f6vCpxKgcRP0P
 4ZkAv4RoFdGk3fxKH4H+Wdz6SIAmPg3gIa3oI8BboJZhJI+Y5luXk9u0qpOqtlQJ+cL5z5AZb
 Qy1cOPkr4iDxe9MEVVPDrLq0tEw3lmXDhbkTsglIkq3nBxNEL0UErxNIzhPFhSIqV+RFSfXXr
 HuYnl0l84iwhEJfMSU+pzxHOnOPuMuUIwJyqmB968XWmnYvy0lcqZNVUiwaufHfKjYKQoyo51
 p9aHvgO9Nq29ERP9Or6AM4nVPXXPaPcEb3ikUVT3A/lavJbo2j4Beq0z88jQLEscSIPU7FiOz
 o3pgxbZpHk5q9RzzcZzmB91pLRTqAztW0yaoLoSVyzRHBOVqWBXVU8GwRHEbdpFsUhciMBhbS
 vz9yQjJmHhGYDttOeqjtJKr9kQYuPhr5voFxxDg91zsDOMSTLU4bWGEo95RVcHyMeHMozAdrh
 VuTVJLQw7GlBVY4J4dOpB+cD1trQ4kU4tlpQRELW322QWTGqytpHLYHfVByRSPatUIi7wXJ/w
 ZObr95WXADqE8qPSJjm7aU1Xn7rMZq7YCKOsQ/NoPHAlr9tGwQQMlRT5AJtC6ibQh7e/moFO7
 BE7+NmPLf4pVPW2Nd4m8F2FOaVSzeQEWg45Ll7LCk5yhGpO8TEgnqLVYnzmmpEDxHEQEdd/S 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293891>

The "seq" is not understood by all shells,
using printf fixes this,

index 20a3ffe..48d964e 100755
--- a/t/t6044-merge-unrelated-index-changes.sh
+++ b/t/t6044-merge-unrelated-index-changes.sh
@@ -20,7 +20,7 @@ test_description="merges with unrelated index changes"
 #   Commit E: renames a->subdir/a, adds subdir/e

 test_expect_success 'setup trivial merges' '
-       seq 1 10 >a &&
+       printf 1 2 3 4 5 7 8 9 10 >a &&
        git add a &&
        test_tick && git commit -m A &&

@@ -42,7 +42,7 @@ test_expect_success 'setup trivial merges' '
        test_tick && git commit -m C &&

        git checkout D &&
-       seq 2 10 >a &&
+       printf 2 3 4 5 7 8 9 10 >a &&
