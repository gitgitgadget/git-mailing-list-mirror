From: Thomas Adam <thomas@xteddy.org>
Subject: Merging topic branches -- changed file locations.
Date: Thu, 2 Sep 2010 10:51:49 +0100
Message-ID: <AANLkTim_UkTMJdZCBpzGrXvo2L2uzL5H4QY2aYaLZw-3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Sep 02 11:52:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Or6T4-0001ue-0u
	for gcvg-git-2@lo.gmane.org; Thu, 02 Sep 2010 11:52:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893Ab0IBJwI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Sep 2010 05:52:08 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:61180 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365Ab0IBJwG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Sep 2010 05:52:06 -0400
Received: by qyk33 with SMTP id 33so378537qyk.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 02:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=NoH7pLfozvsqwcmGo/MM8yEf1dQ7Z+p9akP0yB9dXPQ=;
        b=Rzi3qD+XlXKN0526t4JgcRQ36y87y2J9PuZF8ibUVhBo05GY3Rrs8T8X79ReO5JT5V
         BkoejknUtjh4FpKb/NFEA1ds6baKAfMewnq82ANExFxqj/IKD4vI0Jw+obgXAM0OB5cm
         EWGm4mWkKbdFRhIu4pbnet6FcPBBiT2Qkb1qs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=oD5u/Bh4pSRrqDBCubVY75kU4XcpL9kCoZWAHOjy4Zpxz0tLJPEas7pvtc6wT69PMH
         S1veF/PrtwCigGSrHIZL4TiXm0c0C8Fzu5g8BW5KxCUNUPyh4rjqVt4XaIpehgcWpjL8
         Icfi8hYlZI7LAhadQmC81wk+xDALr8ZiFmo/8=
Received: by 10.229.246.134 with SMTP id ly6mr7043346qcb.109.1283421125768;
 Thu, 02 Sep 2010 02:52:05 -0700 (PDT)
Received: by 10.229.21.198 with HTTP; Thu, 2 Sep 2010 02:51:49 -0700 (PDT)
X-Google-Sender-Auth: xThFr9hz0sCyK5ZkxQEjaZ-wERI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155120>

Hello all,

I'm wondering what people do in the following situation, involving
integration branches, topic branches, and directory renames.

We use a workflow, whereby people develop features in local topic
branches, and then merge them into designate integration branches.  So
for instance, given a public integration branch:

integration/foo

and a local topic branch of:

topic/foo

That topic/foo branch would get merged into integration/foo with:

git merge --no-ff integration/foo

... and the result pushed out.

This is working just fine -- except that recently, we had cause to
"git mv" a directory -- the result of which has been merged and pushed
out on "integration/foo".  So for example, throughout the lifetime of
"integration/foo", there has been a directory called:

modules/foo

Which has been renamed to:

modules/foo2

That's fine.  But now, we've run into a problem, whereby people have
local topic branches with outstanding changes on them that need
merging to integration/foo.  But the commits on these topic branches
still have references to "modules/foo", which makes merging them in to
the integration/foo branch almost impossible.

What's the best way of solving this?  I blindly tested this, by doing
a "git mv modules/foo modules/foo2" on "topic/foo" and trying to then
merge the result of that to integration/foo -- but that didn't work
very well either.

Any insight would be greatly appreciated.  I hope my ramblings make sense.

Kindly,

-- Thomas Adam
