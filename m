From: "Mike.lifeguard" <mike.lifeguard@gmail.com>
Subject: git-tag -s can't find GPG private key
Date: Wed, 27 Jan 2010 17:02:40 -0400
Message-ID: <4B60A9F0.5000904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 27 22:03:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NaF2W-00040I-AT
	for gcvg-git-2@lo.gmane.org; Wed, 27 Jan 2010 22:03:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755888Ab0A0VCu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2010 16:02:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755846Ab0A0VCt
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jan 2010 16:02:49 -0500
Received: from mail-qy0-f182.google.com ([209.85.221.182]:51815 "EHLO
	mail-qy0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755887Ab0A0VCt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2010 16:02:49 -0500
Received: by qyk12 with SMTP id 12so3261260qyk.21
        for <git@vger.kernel.org>; Wed, 27 Jan 2010 13:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:x-enigmail-version:content-type
         :content-transfer-encoding;
        bh=zR6FlC4XeTWmIU5tnJcmh4MSN5M7fCSKRw+RUGYviRQ=;
        b=jmRk69XQxR962xMEHbzEmw9gXz6HGjZk3NjUdIFykBVnBVdDZ9MT0IUDPYr5tO1A6Q
         lNp4yCKkWpsTQB1uG4W/gy0FCspRqhhdcaqxu9Qgr9990XadI1jMy9ipxMZOKttUeUuo
         vigV3m7vMtNKMffxyh8B6gBu9hxtZAzj1Wb7o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :x-enigmail-version:content-type:content-transfer-encoding;
        b=ekBq4/RPvQaDDOl+k/YEXLcMkif6LdT/yX/xTaXRj36sNoFE95E8ctm3xLOIyZ0uVY
         sK7/qPPmFiNmUOb4roVRq5TvIaj/DN/cQ5HkCsOBoRExnEUuw1z/zBvK1Oy2knip9ysL
         sxPcY6hyAsm44RdxTJbfSlDhxcBYT1jx9EosI=
Received: by 10.224.7.194 with SMTP id e2mr5851737qae.291.1264626167899;
        Wed, 27 Jan 2010 13:02:47 -0800 (PST)
Received: from ?192.168.0.3? (hlfxns0169w-142177059085.pppoe-dynamic.High-Speed.ns.bellaliant.net [142.177.59.85])
        by mx.google.com with ESMTPS id 4sm867579qwe.53.2010.01.27.13.02.44
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 Jan 2010 13:02:45 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.23) Gecko/20090817 Thunderbird/2.0.0.23 Mnenhy/0.7.6.0
X-Enigmail-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138195>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

It seems that when the GPG key name and user.name in git's config are
different, git can't find the appropriate private key to sign the tag.
Git should attempt to use user.email to find the key. Setting
user.signingkey is of course a workaround. The relevant code would be in
builtin-tag.c.

- -Mike
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAktgqewACgkQst0AR/DaKHuDZgCgpYHD05aJHKF/Wj/uU8CK5swP
SccAoMjHVKM/OZBhbvSvC+aWCQ123Tje
=ZIo0
-----END PGP SIGNATURE-----
