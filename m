From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 2/5] Documentation/urls: Rewrite to accomodate <transport>::<address>
Date: Sun, 18 Apr 2010 10:33:16 +0530
Message-ID: <1271566767-sup-7167@kytes>
References: <1271552047-sup-9523@kytes> <20100418025940.GA2249@progeny.tock>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Gabriel Filion <lelutin@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 18 07:05:33 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O3MhJ-0007Pq-7m
	for gcvg-git-2@lo.gmane.org; Sun, 18 Apr 2010 07:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434Ab0DRFF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Apr 2010 01:05:28 -0400
Received: from mail-pz0-f204.google.com ([209.85.222.204]:39675 "EHLO
	mail-pz0-f204.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751119Ab0DRFF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Apr 2010 01:05:27 -0400
Received: by pzk42 with SMTP id 42so2764801pzk.4
        for <git@vger.kernel.org>; Sat, 17 Apr 2010 22:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:content-type:cc:subject:from
         :to:in-reply-to:references:date:message-id:user-agent
         :content-transfer-encoding;
        bh=G3SiaEL2r1vzInURgyf+aarAlRVSbLWOLTY7t/VcKvY=;
        b=So/59kTzeVzP2+xHEOf+kY/VuXZ7CyjHQpUTGB9gxBE20sxtgE5e0dnMEKQsppcwKZ
         k7zUbh/c4LrXgNGl4ecGCdymadyFa2WtROKpRIWurDSZvu5z63sCeqtMjVU8ktvq6Rc2
         3KslsPXN0+NxAxjQ5an9k43a+beXGl1Gm/2vI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=content-type:cc:subject:from:to:in-reply-to:references:date
         :message-id:user-agent:content-transfer-encoding;
        b=hkzztLpMU0hPs8Y0LGTtiAwXbQi8ddhhj+kgJdPzQ482M9zfliBj7FaSaXf74AvzIz
         ypDRkWJpMVw8GLLkUh4Kyg4JjcDS2FAicmHKbqboc3T8rtYcehJJD3rJ32LU3XyXmdXR
         2k6F0kfgcQ40YDGK1LLDV/hW0nYn7r+UMe/vY=
Received: by 10.141.90.19 with SMTP id s19mr3104507rvl.80.1271567127273;
        Sat, 17 Apr 2010 22:05:27 -0700 (PDT)
Received: from localhost ([203.110.240.41])
        by mx.google.com with ESMTPS id 22sm4027785pzk.1.2010.04.17.22.05.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 17 Apr 2010 22:05:26 -0700 (PDT)
In-reply-to: <20100418025940.GA2249@progeny.tock>
User-Agent: Sup/git
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145212>

Here's the fixup.

diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index a473da6..8f442ba 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -11,8 +11,8 @@ protocols. The following syntaxes may be used with them:
 
 - ssh://{startsb}user@{endsb}host.xz{startsb}:port{endsb}/path/to/repo.git/
 - git://host.xz{startsb}:port{endsb}/path/to/repo.git/
-- rsync://host.xz/path/to/repo.git/
 - http{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git/
+- rsync://host.xz/path/to/repo.git/
 - ftp{startsb}s{endsb}://host.xz{startsb}:port{endsb}/path/to/repo.git/
 
 An alternative scp-like syntax may also be used with the ssh protocol:
@@ -37,6 +37,11 @@ the former implies --local option. See linkgit:git-clone[1] for
 details.
 endif::git-clone[]
 
+ifdef::git-clone[]
+These two syntaxes are mostly equivalent, except the former implies
+--local option.
+endif::git-clone[]
+
 When git doesn't know how to handle a certain transport protocol, it
 attempts to use the 'remote-<transport>' remote helper, if one
 exists. To explicitly request a remote helper, the following syntax
