X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Alexander Litvinov <litvinov2004@gmail.com>
Subject: Does pushing to git demon works ?
Date: Mon, 11 Dec 2006 15:13:05 +0600
Message-ID: <200612111513.05752.litvinov2004@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
NNTP-Posting-Date: Mon, 11 Dec 2006 09:13:22 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nKFYyY1zIi1phkl7TIS5uguGV1ZyeKd4W0oKJsu2HpKyhSNKrX3Wmo0PuEXn7fEw6TDmTO4NzUDafOccI8fVc/FkDMqV2f3T4nK5izxPBKHYoZ1Yx3h5Xovt4Kqa7g/8kHJEcbAOyPA/FfPuLtM1dldvjiV1Y5hUtFwfbatbih4=
User-Agent: KMail/1.8
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33982>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GthDr-0005BV-NZ for gcvg-git@gmane.org; Mon, 11 Dec
 2006 10:13:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1762654AbWLKJNQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 11 Dec 2006
 04:13:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762656AbWLKJNQ
 (ORCPT <rfc822;git-outgoing>); Mon, 11 Dec 2006 04:13:16 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:43114 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1762654AbWLKJNP (ORCPT <rfc822;git@vger.kernel.org>); Mon, 11 Dec
 2006 04:13:15 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1268327uga for
 <git@vger.kernel.org>; Mon, 11 Dec 2006 01:13:14 -0800 (PST)
Received: by 10.78.138.6 with SMTP id l6mr1286675hud.1165828393831; Mon, 11
 Dec 2006 01:13:13 -0800 (PST)
Received: from lan.ac-sw.lcl ( [81.1.223.2]) by mx.google.com with ESMTP id
 c18sm2192865hub.2006.12.11.01.13.12; Mon, 11 Dec 2006 01:13:12 -0800 (PST)
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org

I tried pushing without success:
> git version
git version 1.4.4.2
> mkdir 1 && cd 1 && git init-db
defaulting to local storage area
> date >> a && git add a && git commit -m "add a" a
Committing initial tree 359e888a2d88e9dfcc9b269bc0b2fb1d9ba0013e
> date >> a && git commit -m "edit a" a
> touch .git/git-daemon-export-ok
> git daemon --verbose --reuseaddr --listen=127.0.0.1
... log here ...
[21607] Extended attributes (16 bytes) exist <host=127.0.0.1>
[21607] Request upload-pack for '/tmp/1'
[21607] Disconnected
[21669] Connection from 127.0.0.1:49875
[21669] Extended attributes (16 bytes) exist <host=127.0.0.1>
[21669] Protocol error: 'git-receive-pack /tmp/1'
[21669] Disconnected (with error)

at another conole:
> git clone git://127.0.0.1/tmp/1 2
remote: Generating pack...
remote: Done counting 6 objects.
remote: Deltifying 6 objects.
remote:  100% (6/6) done
remote: Total 6, written 6 (delta 0), reused 0 (delta 0)
Indexing 6 objects.
 100% (6/6) done
> cd 2
> date >> a && git commit -a -m "2"
> git push
fatal: unexpected EOF
> 

What should I do to make it work ?

Thanks for help,
