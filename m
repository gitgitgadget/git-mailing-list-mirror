From: Nikolaj Shurkaev <snnicky@gmail.com>
Subject: Re: git log -z doesn't separate commits with NULs
Date: Sat, 03 Mar 2012 16:41:02 +0300
Message-ID: <4F521F6E.2040602@gmail.com>
References: <4F462E61.4020203@gmail.com> <m34nuhelnf.fsf@localhost.localdomain> <4F4643BB.8090001@gmail.com> <20120223193451.GB30132@sigill.intra.peff.net> <7vy5rt2u0c.fsf@alter.siamese.dyndns.org> <4F475689.4040203@gmail.com> <20120224095253.GC11846@sigill.intra.peff.net> <7vsji0xalg.fsf@alter.siamese.dyndns.org> <20120224204615.GB21447@sigill.intra.peff.net> <7vk43cx7c2.fsf@alter.siamese.dyndns.org> <20120224211658.GA30922@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: unlisted-recipients:; (no To-header on input)
X-From: git-owner@vger.kernel.org Sat Mar 03 14:41:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3pD4-0004qT-Sy
	for gcvg-git-2@plane.gmane.org; Sat, 03 Mar 2012 14:41:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752600Ab2CCNlG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Mar 2012 08:41:06 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62008 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752465Ab2CCNlE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Mar 2012 08:41:04 -0500
Received: by eaaq12 with SMTP id q12so897150eaa.19
        for <git@vger.kernel.org>; Sat, 03 Mar 2012 05:41:03 -0800 (PST)
Received-SPF: pass (google.com: domain of snnicky@gmail.com designates 10.213.20.76 as permitted sender) client-ip=10.213.20.76;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of snnicky@gmail.com designates 10.213.20.76 as permitted sender) smtp.mail=snnicky@gmail.com; dkim=pass header.i=snnicky@gmail.com
Received: from mr.google.com ([10.213.20.76])
        by 10.213.20.76 with SMTP id e12mr1832696ebb.31.1330782063145 (num_hops = 1);
        Sat, 03 Mar 2012 05:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=SQq2Hwb/eggNP2Jkv6sZJXympstfIwVSb5xFepH6gEM=;
        b=YSbx3Q5MUN7q5Xko6yjw8sA2nbvM/GNAt0O257Rr7qhpYNWjRn/WB/7AN1B09ngCHF
         08+MHDQXazqqIh67H55ht9bmypQrECRf7gniytg+5RjTDSp7BDIeGH0minpSim7tUy7G
         JxVc9TfZcfNF/n7padCusKL5Wg0xcdhheuaNqjMp/cHAi9iGgiJZ5HdG2o66OGmeyC68
         0JxB9heULHQRuK4XnGNg0yz3jgC0PhOfEW3/6DhxI6Xlqtzy9fNFv/+5ZgDOWcVBPioC
         dMgRsmSACm6p8BPazT/gRx1wmbHYXR6O+JiiWQxwgzNCN+DxATn0+QWQAcz038EduuCh
         UC0w==
Received: by 10.213.20.76 with SMTP id e12mr1408168ebb.31.1330782063054;
        Sat, 03 Mar 2012 05:41:03 -0800 (PST)
Received: from [192.168.1.131] ([178.121.129.252])
        by mx.google.com with ESMTPS id o49sm34188257eeb.7.2012.03.03.05.41.01
        (version=SSLv3 cipher=OTHER);
        Sat, 03 Mar 2012 05:41:01 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
In-Reply-To: <20120224211658.GA30922@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192108>

As far as I understood from what I read and from a brief look at source=
=20
code of git (builtin/log.c file) the best what we can do is just mentio=
n=20
that a lot of log options are applicable and warn user to use them with=
=20
understanding of the consequences. I do not think that documentation of=
=20
some of options in Documentation/git-format-patch.txt makes sense=20
because some of the options are connected one with another. For example=
=20
--full-diff and <path> are connected as Junio C Hamano wrote. And that=20
dependency is already explained in Documentation/git-log.txt.

Another option that I see is to put git-log options description into a=20
separate file and include that from git-log.txt and from=20
git-format-patch.txt like that is done with rev-list-options.txt. That=20
could be useful in a long term. Because new options may appear or some=20
may disappear. Some dependency between options may be documented.=20
However for me that would require to get better understanding how all=20
that documentation is built. And that could require modifications of=20
git-log help also.

Please let me know how to proceed with that properly. Perhaps I should=20
start a separate discussion thread devoted to the documentation=20
enhancement. Does thread subject matter?

Thank you.
----------------------
diff --git a/Documentation/git-format-patch.txt=20
b/Documentation/git-format-patch.txt
index 6ea9be7..d49ec80 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -68,6 +68,15 @@ If given `--thread`, `git-format-patch` will generat=
e=20
`In-Reply-To` and
  as replies to the first mail; this also generates a `Message-Id` head=
er to
  reference.

+NOTES
+-----
+
+`git format-patch` and `git log` share significant part of their
+implementations. As a result a lot of options available and described =
for
+`git log` will work for `git format-patch` also. However it's required=
 to
+use them carefully with understanding of the consequences. For example
+applying `<path>` option may make log messages irrelevant.
+
  OPTIONS
  -------
  :git-format-patch: 1


25.02.2012 0:16, Jeff King =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> On Fri, Feb 24, 2012 at 01:14:05PM -0800, Junio C Hamano wrote:
>
>>> True. That is also a slightly dangerous thing to do, though, becaus=
e you
>>> are omitting full patches in the middle that touch the same paths a=
s the
>>> patches you include....
>>> ... So
>>> perhaps we are better off to refer the user to git-log(1), say that
>>> commit limiting options in general would work, but be careful with
>>> sending a partial result.
>> You seem to have spelled out everything I originally wrote in my rep=
ly
>> that I later deleted before sending it out, and I think the reason t=
hat
>> brought you to the three-line conclusion is the same one that made m=
e I
>> delete them ;-).
> OK, good. :)
>
> Nikolaj, have you followed all of this? Do you want to try to improve
> your patch in this direction?
>
> -Peff
>
