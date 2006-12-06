X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Liu Yubao <yubao.liu@gmail.com>
Subject: how to revert changes in working tree?
Date: Wed, 06 Dec 2006 14:49:47 +0800
Message-ID: <4576680B.7030500@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 6 Dec 2006 06:51:19 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:subject:content-type:content-transfer-encoding;
        b=SqDPgN4V2U+x2owbIBSMWrPq9yv2QG8OkH7rVhrQ3WPy5atczlvIiztrhxlP5IP7MFvBsBNVVNSlYZesNz2qBrNgx0pOB87nF0oG6Kts3PhhKkoCJ2jq/zLALepgLvSwxLEIs+VP4Q98iN1tLPAqJn73tkIPwIzAYVebt6GUYGw=
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8.0.7) Gecko/20060909 Thunderbird/1.5.0.7 Mnenhy/0.7.4.666
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33405>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grqcd-00058z-Vr for gcvg-git@gmane.org; Wed, 06 Dec
 2006 07:51:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760270AbWLFGvN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 6 Dec 2006
 01:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760271AbWLFGvM
 (ORCPT <rfc822;git-outgoing>); Wed, 6 Dec 2006 01:51:12 -0500
Received: from wx-out-0506.google.com ([66.249.82.229]:32033 "EHLO
 wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1760270AbWLFGvM (ORCPT <rfc822;git@vger.kernel.org>); Wed, 6 Dec
 2006 01:51:12 -0500
Received: by wx-out-0506.google.com with SMTP id h27so120558wxd for
 <git@vger.kernel.org>; Tue, 05 Dec 2006 22:51:11 -0800 (PST)
Received: by 10.70.111.2 with SMTP id j2mr760053wxc.1165387871522; Tue, 05
 Dec 2006 22:51:11 -0800 (PST)
Received: from ?192.168.88.85? ( [221.122.47.70]) by mx.google.com with ESMTP
 id i20sm18999335wxd.2006.12.05.22.51.08; Tue, 05 Dec 2006 22:51:11 -0800
 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I'm confused how to revert changes in working tree:

$ git fetch
$ git merge "sync with origin" HEAD origin
....conflict....

$ git branch
* master
  origin

$ git status
# .....: needs update
# .....: needs update
(In fact I never modified anything in this tree, and "git diff"
showed many difference indeed, very strange).

I tried "git update-index --refresh", "git reset --hard",
"git reset --hard master", "git checkout master", 
"git checkout -f master", but "git status" still said same
as above.

At last, I deleted all files that were reported to be updated
with "rm -rf", ran "git checkout master" and "git status", then
git reported:
#       deleted:    ....
#       deleted:    ....

