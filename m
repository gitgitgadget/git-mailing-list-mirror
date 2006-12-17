X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Vincent Legoll" <vincent.legoll@gmail.com>
Subject: git-diff & cg-diff behavior difference
Date: Sun, 17 Dec 2006 18:11:35 +0100
Message-ID: <4727185d0612170911l52fab839x694399db729fd62d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Sun, 17 Dec 2006 17:11:59 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=DOD4Naj/XTzLFRkNGl012LJGsDR7JrdGQydPuW+s4V18os7RA7Mb1ha0GaTgunO62KrkepBmQh713h5VfJr+pkcx3s7OJ1cxDGttxcrrP3pmcTwcsDm/Tec0j4HiCtQjsXfFOdvd2kIgNYHHpjHePSJn7KsyVKwimjHH9qIf928=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34695>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvzYG-00030H-Ct for gcvg-git@gmane.org; Sun, 17 Dec
 2006 18:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753015AbWLQRLh (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 17 Dec 2006
 12:11:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753009AbWLQRLh
 (ORCPT <rfc822;git-outgoing>); Sun, 17 Dec 2006 12:11:37 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:46182 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1753015AbWLQRLh (ORCPT <rfc822;git@vger.kernel.org>); Sun, 17 Dec
 2006 12:11:37 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1295897uga for
 <git@vger.kernel.org>; Sun, 17 Dec 2006 09:11:35 -0800 (PST)
Received: by 10.78.20.13 with SMTP id 13mr2211183hut.1166375495219; Sun, 17
 Dec 2006 09:11:35 -0800 (PST)
Received: by 10.78.177.13 with HTTP; Sun, 17 Dec 2006 09:11:35 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I did not find something relevant in the docs, so I'll ask here.

git-diff works from everywhere in the tree, whereas cg-diff
does not, is that intentional ?

steps to reproduce:
--------------------
mkdir tmp
cd tmp
touch titi.txt
mkdir tutu
touch tutu/toto.txt
cg-init -I
cg-add -r .
cg-commit -C -m INIT
echo "tata" > titi.txt
git-diff
cg-diff
cd tutu
git-diff
cg-diff
--------------------

The 2 git-diff & 1st cg-diff outputs are the same, whereas the 2nd
cg-diff one is empty...

Quite a minor thing, but this could be added in the cg-diff man-page as a
difference of behavior.

-- 
