X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: rebasing, git-am and whitespace cleanup conundrims
Date: Thu, 26 Oct 2006 11:49:36 +1300
Message-ID: <46a038f90610251549u46af5ab9gefb56423fb663e96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Wed, 25 Oct 2006 22:49:45 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=dbovtYgh4rv5r6O9p0HH/wBPVsOqOD/YwJY1M8SYjDBl6hFKTyVDT8KlQzEmWvlSlZa4a9aX3K75mNQDq8Dzc4KpZJUzubthJQ/kUKBl+JKV5tgVq8Rq+wleBPmvPb/FGJ1rE1hb08sbF23aXRkztBJx2c85+TQ5uUjggek6SHU=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30120>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GcrZ8-000344-P3 for gcvg-git@gmane.org; Thu, 26 Oct
 2006 00:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161052AbWJYWtj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 18:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161062AbWJYWtj
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 18:49:39 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:457 "EHLO
 nf-out-0910.google.com") by vger.kernel.org with ESMTP id S1161052AbWJYWti
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 18:49:38 -0400
Received: by nf-out-0910.google.com with SMTP id c2so745380nfe for
 <git@vger.kernel.org>; Wed, 25 Oct 2006 15:49:37 -0700 (PDT)
Received: by 10.49.19.18 with SMTP id w18mr4254483nfi; Wed, 25 Oct 2006
 15:49:36 -0700 (PDT)
Received: by 10.49.11.5 with HTTP; Wed, 25 Oct 2006 15:49:36 -0700 (PDT)
To: "Git Mailing List" <git@vger.kernel.org>
Sender: git-owner@vger.kernel.org

Hola!

i'm going through a rebase of a long series of patches (~50) that have
quite a bit of trailing whitespace. Once the rebase is done on my repo
(resolving all the code level conflicts), I want to re-rebase it on
top of the same commit but cleaning up trailing whitespace.

The problem is that upstream has 'some' trailing whitespace. The
policy is to reject "new" trailing whitespace and cleanup in stages to
avoid big merge conflicts and stuff.

Now, once the early patches are "in" with --whitespace=trim, the
following patches don't apply anymore :-/ and I can't just trim
whitespace in the whole patch series automatically.

Is there any way to get git-apply to ignore whitespace differences
when applying like GNU patch -l?

When -3 is passed, it must be calling the merge utility from
merge_file() -- which doesn't do 'ignore-whitespace'. But if it's a
straight patch application, it should be possible to do something like
that... maybe?

cheers,


