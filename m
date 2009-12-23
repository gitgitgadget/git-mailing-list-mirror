From: "NODA, Kai" <nodakai@gmail.com>
Subject: git tag --contains <commit> -n=1 ?
Date: Thu, 24 Dec 2009 01:19:51 +0900
Message-ID: <4B324327.5010809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 17:20:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NNTwO-00016s-8u
	for gcvg-git-2@lo.gmane.org; Wed, 23 Dec 2009 17:20:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbZLWQT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2009 11:19:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750986AbZLWQT4
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Dec 2009 11:19:56 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:47733 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899AbZLWQTz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2009 11:19:55 -0500
Received: by yxe17 with SMTP id 17so6896128yxe.33
        for <git@vger.kernel.org>; Wed, 23 Dec 2009 08:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=GmZrLJzb9hmTxgKcSkxJP17OGmZ9aBGHdDeJ9AZBODk=;
        b=IltZktJkrkfSmMi+agYvx4J+W873E4z0PaXYVVtBPlz8tj5b7bPZw138OBNDN8MVmx
         D8TIN3HXNfL/iFGpYLJ2P9MB2sjqHFr/yI7sJbNzo8KfmygDweTgYQAUCoZOJUMwuqbl
         u22cm1mCChNxpBY0LdyxvYSph0AOqOx/3PxaM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=TWqp+t5PkRjaFj0oRMuHoGuintYNDASm4W1JNJyQPMEElk8dy5jZMbtI8TcaBS1bAj
         1SYrUMkVRzxjL6GZJP2jB97O5u2COoH/4vFXnKexxkuZgdVvmh44XxXxnfHamni7f+k2
         51uN1fWyrWa6YYhZLTX9nLcei+sefqEa/3OtI=
Received: by 10.150.71.42 with SMTP id t42mr15593423yba.219.1261585194418;
        Wed, 23 Dec 2009 08:19:54 -0800 (PST)
Received: from ?192.168.1.50? (i254229.dynamic.ppp.asahi-net.or.jp [61.125.254.229])
        by mx.google.com with ESMTPS id 4sm2826909ywg.28.2009.12.23.08.19.52
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 23 Dec 2009 08:19:53 -0800 (PST)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135622>

Hi,
I'm thinking how to find the oldest tag containing a specified commit.
Eg.
$ cd /usr/src/linux-linus/Documentation
$ for i in *.txt; do
for> echo $i
for> hash=`git log -1 --format=format:%H -- $i`
for> git tag --contains $hash -l 'v2.6.[0-9][0-9]'|head -1
for> done
DMA-API.txt
v2.6.31
DMA-ISA-LPC.txt
v2.6.20
DMA-attributes.txt
v2.6.27
...

Here I wonder whether "head -1" is generally correct or not when I want
the oldest tag.
Moreover, as "git tag --contains ..." takes considerable time, I will
be happy if I can set the maximum number in searching tags containing
a commit.  Or are there already some (better) ways to achieve this?

Any advice is welcome.

Thanks,
Kai
