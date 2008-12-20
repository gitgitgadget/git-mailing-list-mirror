From: James Cloos <cloos@jhcloos.com>
Subject: Re: how to check remote git repo for updates without pull/fetch
Date: Sat, 20 Dec 2008 12:32:45 -0500
Message-ID: <m3skoi21m3.fsf@lugabout.jhcloos.org>
References: <494BC89F.9070107@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: Ivan Zorin <ivan.a.zorin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 20 18:42:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LE5pu-0000OM-5K
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 18:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752919AbYLTRju (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Dec 2008 12:39:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752905AbYLTRju
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Dec 2008 12:39:50 -0500
Received: from eagle.jhcloos.com ([207.210.242.212]:53555 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752771AbYLTRjt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Dec 2008 12:39:49 -0500
X-Greylist: delayed 372 seconds by postgrey-1.27 at vger.kernel.org; Sat, 20 Dec 2008 12:39:49 EST
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 8C38440090; Sat, 20 Dec 2008 17:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1229794416; bh=ZoqHAEMAp/rf/aRNY3XeHMvt1ItjAoIHx/rmQSXY7
	rE=; h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BhMqhAP5+4v3szDYGRMddSyIp25ZMG4mfJ8/m
	vhySpeAVLt+fT2FEuX0wq/Pgq1sdD5w4yjgcGyLeNBH6w3bXKx3fuRYTIgNcL2/fYj5
	BtCqigkR5i456ZyMsdh0It+GMxazeoe2x5vmlV7lk3BuQWLdl8dbUJaWV5Hz4oJlMPY
	=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 364C8C556D; Sat, 20 Dec 2008 17:33:11 +0000 (UTC)
In-Reply-To: <494BC89F.9070107@gmail.com> (Ivan Zorin's message of "Fri, 19
	Dec 2008 19:15:27 +0300")
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.60 (gnu/linux)
Face: iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2008 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
X-Hashcash: 1:23:081220:ivan.a.zorin@gmail.com::ch9w8abn/5HMg917:0000000000000000000000000000000000000007fUi
X-Hashcash: 1:23:081220:git@vger.kernel.org::8OJzuw6FrwRKTA9k:00000000000000000000000000000000000000000065fn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103653>

--=-=-=

Here is the script I use:


--=-=-=
Content-Disposition: inline; filename=git-need-pull-p

#!/bin/bash
#
# does this git repo need a pull?
#
l=$(git log|head -1|awk '{print $NF}')
r=$(git ls-remote origin heads/master|awk '{print $1}')
test "${r}" != "${l}"


--=-=-=


-JimC 
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6

--=-=-=--
