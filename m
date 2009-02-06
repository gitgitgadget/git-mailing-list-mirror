From: Josh Sharpe <josh.m.sharpe@gmail.com>
Subject: Malformed network data
Date: Fri, 6 Feb 2009 10:29:27 -0500
Message-ID: <6a7129610902060729ta73d8d6leb4dc64ce2bb7fe3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 06 16:31:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVSg7-0005zN-2P
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 16:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758728AbZBFP3a (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 10:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758839AbZBFP33
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 10:29:29 -0500
Received: from rv-out-0506.google.com ([209.85.198.230]:57285 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758264AbZBFP32 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 10:29:28 -0500
Received: by rv-out-0506.google.com with SMTP id k40so836220rvb.1
        for <git@vger.kernel.org>; Fri, 06 Feb 2009 07:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=djgqVFipiiE0T9Qza0zL9utbvgPR1nrwvMkdxYlpOpc=;
        b=FPw4QuVEUYOhIxSJSXWds6dv8YFQ9s0k51xO0Bc5tf4+o5P3476HMAaEjjlSQfKlKz
         5yJEigJGxc2fpsGAcllPAua5clKOjbor8Qsz1giJE8ViIKkc0oglaucHNusHm3RlMRyf
         uoQL0WcK7y//cLV3k+BsZSU9U5TS4tE3Mvcko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=xKL7qOVAsIjyYFuishL3xOyZpoPXmZ952UJgYCPjA3fTc3YbzdlI5mjQs7LxXbjVCR
         5z8+vx0L0P864JeW0v3bCofrgO+YyaK7GCX+zu05Wv55nWJ5AgAqQTTHIPXJg8dN8xU3
         m3ce2JqrgbLECpmkVQFp2Z2y6hziIYI3Zkdis=
Received: by 10.141.168.16 with SMTP id v16mr1342447rvo.147.1233934167369; 
	Fri, 06 Feb 2009 07:29:27 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108732>

I was originally using ubuntu's package of git and git-svn (1.5.6.3)
and had the following Malformed Network Data error occuring at the
same spot.

I've since built svn and git so that I'm using the latest versions of
each svn: 1.5.5 and git: 1.6.1.2.390.gba743

With the latest version I got a new error during the initial clone
followed by the original error.

One thing to note that I thought was odd.  The clone starts at ~r977
and proceeded through about ~r1100 before starting over at r1 and
running all the way up to the code you see below (r1116)

Is this a git issues or is it possible the svn repo is corrupted
somehow?  Any way I can get around this?

Thanks!

$ git svn clone -s svn+ssh://.../community_
service

r1116 = 890ff1e819be8ae0a752f53ba2103171de41fc69 (trunk)
    M    sample_data/activities.yml
r1117 = ab725a6c32905b6d007fcd8fd4723058d9487706 (trunk)
Found possible branch point: svn+ssh://.../community_service/trunk =>
svn+ssh://.../community_service/branches/current_demo, 1118
Found branch parent: (current_demo) ab725a6c32905b6d007fcd8fd4723058d9487706
Index mismatch: e8075b5d0694a738392d84016922eca87db65dcd !=
44b21b4a4fa70455621da3ac159cdf42c8c59987
rereading ab725a6c32905b6d007fcd8fd4723058d9487706
Following parent with do_switch
Filesystem has no item: File not found: revision 1036, path
'/branches/current_demo/sample_data/email_templates.yml' at
/usr/local/libexec/git-core/git-svn line 3288

$ cd community_service/
$ git svn fetch

Found possible branch point: svn+ssh://.../community_service/trunk =>
svn+ssh://.../community_service/branches/current_demo, 1118
Found branch parent: (current_demo) ab725a6c32905b6d007fcd8fd4723058d9487706
Index mismatch: e8075b5d0694a738392d84016922eca87db65dcd !=
44b21b4a4fa70455621da3ac159cdf42c8c59987
rereading ab725a6c32905b6d007fcd8fd4723058d9487706
Following parent with do_switch
Malformed network data: Malformed network data at
/usr/local/libexec/git-core/git-svn line 3288
