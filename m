Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 66824200B9
	for <e@80x24.org>; Thu,  3 May 2018 00:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751741AbeECA1q convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Wed, 2 May 2018 20:27:46 -0400
Received: from mail.pdinc.us ([67.90.184.27]:38080 "EHLO mail1.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751561AbeECA1p (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 20:27:45 -0400
X-Greylist: delayed 1759 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 May 2018 20:27:45 EDT
Received: from blackfat (nsa1.pdinc.us [67.90.184.2])
        (authenticated bits=0)
        by mail1.pdinc.us (8.14.4/8.14.4) with ESMTP id w42NwP79009744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Wed, 2 May 2018 19:58:25 -0400
Reply-To: <git@vger.kernel.org>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
Subject: Blame / annotate with mixed mac line endings?
Date:   Wed, 2 May 2018 19:57:28 -0400
Organization: PD Inc
Message-ID: <B8114616E07247C7A78F1DFF91E16A63@ad.pdinc.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdPicVNW81OhiBooTe6NvLiSxUt4Uw==
X-MimeOLE: Produced By Microsoft MimeOLE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think this file may have been from a mac at one point. Note the lone CR (0x0d) line endings, with CRLFs later.

$ cat src/htdocs/hr/ats/rpts/incl/slt_org.cfm | sed 's/[a-zA-Z]/x/g;s/[0-9]/8/g' | hexdump -C
00000000  3c 21 2d 2d 2d 0d 78 78  78 78 78 78 78 78 3a 20  |<!---.xxxxxxxx: |
00000010  78 78 78 5f 78 78 78 2e  78 78 78 0d 78 78 78 78  |xxx_xxx.xxx.xxxx|
00000020  78 78 3a 0d 78 78 78 78  78 78 78 3a 20 38 38 2f  |xx:.xxxxxxx: 88/|
00000030  38 38 2f 38 38 38 38 20  38 38 3a 38 38 3a 38 38  |88/8888 88:88:88|
00000040  20 78 78 0d 78 78 78 78  78 78 78 78 3a 20 38 38  | xx.xxxxxxxx: 88|
00000050  2f 38 38 2f 38 38 38 38  20 38 38 3a 38 38 3a 38  |/88/8888 88:88:8|
00000060  38 20 78 78 0d 78 78 78  78 78 78 78 78 78 78 78  |8 xx.xxxxxxxxxxx|
00000070  3a 0d 2d 2d 2d 3e 0d 0d  3c 78 78 78 78 78 78 20  |:.--->..<xxxxxx |
00000080  78 78 78 78 3d 22 78 78  78 5f 78 78 78 5f 78 78  |xxxx="xxx_xxx_xx|
00000090  78 78 22 20 78 78 78 78  3d 22 38 22 20 78 78 78  |xx" xxxx="8" xxx|
000000a0  78 78 78 78 78 3e 0d 0a  09 3c 78 78 78 78 78 78  |xxxxx>...<xxxxxx|
000000b0  20 78 78 78 78 78 3d 22  22 3e 2d 20 78 78 78 78  | xxxxx="">- xxxx|
000000c0  78 78 20 78 78 78 20 78  78 20 78 78 78 78 2d 3c  |xx xxx xx xxxx-<|
000000d0  2f 78 78 78 78 78 78 3e  0d 0a 09 3c 78 78 78 78  |/xxxxxx>...<xxxx|
000000e0  20 78 78 78 2e 78 78 78  78 78 78 78 78 78 78 20  | xxx.xxxxxxxxxx |
000000f0  78 78 78 20 38 20 78 78  20 78 78 78 78 2e 78 78  |xxx 8 xx xxxx.xx|
00000100  78 78 78 78 78 78 78 20  78 78 20 27 78 78 38 78  |xxxxxxx xx 'xx8x|
00000110  27 3e 0d 0a 09 3c 78 78  78 78 78 78 20 78 78 78  |'>...<xxxxxx xxx|
00000120  78 78 3d 22 3c 78 78 78  78 78 78 78 78 20 78 78  |xx="<xxxxxxxx xx|
00000130  78 78 78 3d 22 78 78 78  78 78 78 78 78 78 78 22  |xxx="xxxxxxxxxx"|
00000140  3e 23 78 78 78 5f 78 78  78 23 2c 3c 2f 78 78 78  |>#xxx_xxx#,</xxx|
00000150  78 78 78 78 78 3e 78 78  78 22 3e 78 78 78 3c 2f  |xxxxx>xxx">xxx</|
00000160  78 78 78 78 78 78 3e 0d  0a 09 3c 2f 78 78 78 78  |xxxxxx>...</xxxx|
00000170  3e 0d 0a 3c 78 78 78 78  78 78 78 78 20 78 78 78  |>..<xxxxxxxx xxx|
00000180  78 78 3d 22 78 78 78 78  78 78 78 78 78 78 22 3e  |xx="xxxxxxxxxx">|
00000190  0d 0a 09 3c 78 78 78 78  78 78 20 78 78 78 78 78  |...<xxxxxx xxxxx|
000001a0  3d 22 23 78 78 78 5f 78  78 78 23 22 3e 23 78 78  |="#xxx_xxx#">#xx|
000001b0  78 5f 78 78 78 23 3c 2f  78 78 78 78 78 78 3e 0d  |x_xxx#</xxxxxx>.|
000001c0  0a 3c 2f 78 78 78 78 78  78 78 78 3e 0d 0a 3c 2f  |.</xxxxxxxx>..</|
000001d0  78 78 78 78 78 78 3e 0d  0a 0d 0a                 |xxxxxx>....|
000001db

$ git annotate -L 13,17 --line-porcelain 'src/htdocs/hr/ats/rpts/incl/slt_org.cfm'
fatal: file src/htdocs/hr/ats/rpts/incl/slt_org.cfm has only 10 lines

$ cat src/htdocs/hr/ats/rpts/incl/slt_org.cfm | wc -l
10

$ cat src/htdocs/hr/ats/rpts/incl/slt_org.cfm | mac2unix | wc -l
18

$ git -c core.autocrlf=false -c core.eol=cr annotate -L 13,17 --line-porcelain 'src/htdocs/hr/ats/rpts/incl/slt_org.cfm'
fatal: file src/htdocs/hr/ats/rpts/incl/slt_org.cfm has only 10 lines

Any way to hit git with a stick to treat lone CR as a line break for blame/annotate?

-Jason

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

