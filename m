From: "Machiels, Brecht" <Brecht.Machiels@kla-tencor.com>
Subject: BUG: git subtree split - revert commit followed by a merge
Date: Tue, 27 Aug 2013 13:09:30 +0000
Message-ID: <E71F820BDC168F4B91A464A8FD8ABBD8389BD9C7@CH1PRD0310MB391.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Aug 27 15:46:42 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEJbW-0000Ai-HX
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 15:46:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667Ab3H0Nqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 09:46:35 -0400
Received: from mailout04.kla-tencor.com ([192.146.1.174]:33240 "EHLO
	ca1mailout01.kla-tencor.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752028Ab3H0Nqe convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 09:46:34 -0400
X-Greylist: delayed 2210 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2013 09:46:34 EDT
Received: from CA1EXBH01.adcorp.kla-tencor.com (ca1exbh01.kla-tencor.com [10.60.33.3])
	by ca1mailout01.kla-tencor.com (8.14.4/8.14.4) with ESMTP id r7RD9R0V026126
	for <git@vger.kernel.org>; Tue, 27 Aug 2013 06:09:44 -0700
Received: from CA1VMEXCAHU01.adcorp.kla-tencor.com ([10.39.10.73]) by CA1EXBH01.adcorp.kla-tencor.com with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 27 Aug 2013 06:09:43 -0700
Received: from db9outboundpool.messaging.microsoft.com (10.39.11.6) by
 tlsmail.kla-tencor.com (10.39.10.73) with Microsoft SMTP Server (TLS) id
 14.3.123.3; Tue, 27 Aug 2013 06:09:42 -0700
Received: from mail94-db9-R.bigfish.com (10.174.16.249) by
 DB9EHSOBE035.bigfish.com (10.174.14.98) with Microsoft SMTP Server id
 14.1.225.22; Tue, 27 Aug 2013 13:09:40 +0000
Received: from mail94-db9 (localhost [127.0.0.1])	by mail94-db9-R.bigfish.com
 (Postfix) with ESMTP id 7EC16260082	for
 <git@vger.kernel.org.FOPE.CONNECTOR.OVERRIDE>; Tue, 27 Aug 2013 13:09:40
 +0000 (UTC)
X-Forefront-Antispam-Report: CIP:157.56.244.37;KIP:(null);UIP:(null);(null);H:CH1PRD0310HT002.namprd03.prod.outlook.com;R:internal;EFV:INT
X-SpamScore: 0
X-BigFish: PS0(zzzz208ch1ee6h1fdah2073h1202h1e76h1d2ah1fc6hzz177df4h17326ah186068h8275bh8275dh1de097hz2dh2a8h839h944hd25hf0ah1220h1288h12a5h12a9h12bdh137ah13b6h1441h1504h1537h153bh15d0h162dh1631h1758h18e1h1946h19b5h19ceh1ad9h1b0ah1d07h1d0ch1d2eh1d3fh1dc1h1de9h1dfeh1dffh1e1dh1fe8h1ff5h1155h)
Received: from mail94-db9 (localhost.localdomain [127.0.0.1]) by mail94-db9
 (MessageSwitch) id 1377608978152123_23315; Tue, 27 Aug 2013 13:09:38 +0000
 (UTC)
Received: from DB9EHSMHS018.bigfish.com (unknown [10.174.16.234])	by
 mail94-db9.bigfish.com (Postfix) with ESMTP id 1865F8004B	for
 <git@vger.kernel.org>; Tue, 27 Aug 2013 13:09:38 +0000 (UTC)
Received: from CH1PRD0310HT002.namprd03.prod.outlook.com (157.56.244.37) by
 DB9EHSMHS018.bigfish.com (10.174.14.28) with Microsoft SMTP Server (TLS) id
 14.16.227.3; Tue, 27 Aug 2013 13:09:32 +0000
Received: from CH1PRD0310MB391.namprd03.prod.outlook.com ([169.254.4.35]) by
 CH1PRD0310HT002.namprd03.prod.outlook.com ([10.255.137.37]) with mapi id
 14.16.0347.000; Tue, 27 Aug 2013 13:09:30 +0000
Thread-Topic: BUG: git subtree split - revert commit followed by a merge
Thread-Index: Ac6jJkri9L4QtmNJQdaDLOtBwrLC2g==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.146.11.2]
X-FOPE-CONNECTOR: Id%0$Dn%*$RO%0$TLS%0$FQDN%$TlsDn%
X-FOPE-CONNECTOR: Id%116$Dn%VGER.KERNEL.ORG$RO%2$TLS%5$FQDN%192.146.1.205$TlsDn%tlsmail.kla-tencor.com
X-OriginatorOrg: kla-tencor.com
X-OriginalArrivalTime: 27 Aug 2013 13:09:43.0052 (UTC) FILETIME=[B1FC74C0:01CEA326]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.10.8794,1.0.431,0.0.0000
 definitions=2013-06-19_09:2013-06-19,2013-06-19,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 suspectscore=0
 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=6.0.2-1305240000 definitions=main-1306190271
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233087>

Hello:

I'm running into the problem described in this mailing list post:
	http://thread.gmane.org/gmane.comp.version-control.git/202645

 'git subtree split' fails to reconstruct the history when a revert commit is followed by a merge commit. I have slightly adjusted the test script provided by Fabien in his mailing list post:

    git init
    
    # create a directory that is going to be split
    mkdir doc
    echo "TEST" > doc/README
    git add doc
    # commit A
    git commit -a -m"first version"
    
    # create a branch with a new commit (Z)
    git checkout -b test
    echo "TEST" > doc/README1
    git add doc/README1
    git commit -a -m"added README1"
    git checkout master
    
    # modify the README file (commit B)
    echo "TEST_" > doc/README
    git commit -a -m"second version"
    
    # revert the change (commit C)
    echo "TEST" > doc/README
    git commit -a -m"revert second version"
    # or use git revert HEAD^
    
    # split
    git subtree split --prefix="doc" --branch=TARGET
    
    # add another commit (to a file *not* in the subtree dir)
    echo "BLA" > BLA
    git add BLA
    git commit -a -m"third version"
    
    # adding another commit to a file in the subtree dir will "fix" things
    #echo "MEH" > doc/MEH
    #git add doc
    #git commit -a -m"fourth version"

    # the log will show the 3 commits as expected (including B and C)
    GIT_PAGER= git log --oneline TARGET
    
    # merge the test branch
    git merge -m"merged test" test
    
    # attempt to re-split; this will fail
    git subtree split --prefix="doc" --branch=TARGET
    
    # see what history split generates
    git subtree split --prefix="doc" --branch=TARGET2

I have discovered that if the revert commit is followed by another commit that makes changes in the subtree directory, the split will work as expected (see "fourth version" above).

See also this related SO question where I ask for a workaround: http://stackoverflow.com/questions/18465867

Best regards,
Brecht
