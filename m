X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "Alex Riesen" <raa.lkml@gmail.com>
Subject: cygwin, 44k files: how to commit only index?
Date: Thu, 7 Dec 2006 15:27:36 +0100
Message-ID: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Thu, 7 Dec 2006 14:28:43 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Q6DO2MXk1XNFNKsA/boKVutedA50ezveZ6gAAMs72ICMdqaocCgOfZMZMo/KLBjsbF9uiqDTvwF7Rrsu247oGWSRoJlvQLTSVX16HzLmFtq3doClO7t0dpC4TCfQZ2p9sLG9lko9swdQpz9qvDcvRgjcm8BK6wZahwWvPQr0Ge8=
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33581>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsKEp-0006Rq-0m for gcvg-git@gmane.org; Thu, 07 Dec
 2006 15:28:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S936515AbWLGO2f (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 09:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936939AbWLGO2f
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 09:28:35 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:35741 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S936515AbWLGO2f (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec
 2006 09:28:35 -0500
Received: by ug-out-1314.google.com with SMTP id 44so476893uga for
 <git@vger.kernel.org>; Thu, 07 Dec 2006 06:28:33 -0800 (PST)
Received: by 10.78.97.7 with SMTP id u7mr1427810hub.1165501657320; Thu, 07
 Dec 2006 06:27:37 -0800 (PST)
Received: by 10.78.135.3 with HTTP; Thu, 7 Dec 2006 06:27:36 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I have a kind of awkward project to work with (~44k files, many binaries).

The normal "git commit", which seem to be more than enough
for anything and anyone else, is a really annoying procedure
in my context. It spend too much time refreshing index and
generating list of the files for the commit message.

At first I stopped using git commit -a (doing only update-index),
now I'm about to start using write-tree/commit-tree/update-ref
directly. It helps, but sometimes I really miss -F/-C. It's also
ugly: I can (and almost did) commit an unchanged tree.

Is there any simple way to modify git commit for such a workflow?
Failing that, any simple and _fast_ way to find out if the index
