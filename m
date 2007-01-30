From: "Mike Coleman" <tutufan@gmail.com>
Subject: newbie questions about git design and features (some wrt hg)
Date: Tue, 30 Jan 2007 10:20:30 -0600
Message-ID: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 30 17:23:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBvin-00021n-1k
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 17:20:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752097AbXA3QUd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 11:20:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbXA3QUd
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 11:20:33 -0500
Received: from nf-out-0910.google.com ([64.233.182.186]:52944 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752109AbXA3QUc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 11:20:32 -0500
Received: by nf-out-0910.google.com with SMTP id o25so252357nfa
        for <git@vger.kernel.org>; Tue, 30 Jan 2007 08:20:31 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=ghjpWy59xrJEKcUAwGBaBVRA0DMLmASYRmAS0G0nhJPq++j0voBW4KROWoa3WywXomVJfNXVIRbwkD//AhWhnMo3W/qs43H651hcM2B9Cbz5BBEFUuKU5Ek8ivZWguVUaz6hJ10hycIQ+J0kNFfS4ayN8hdfJfPG+Mdta1FFIpU=
Received: by 10.49.92.18 with SMTP id u18mr1047146nfl.1170174030956;
        Tue, 30 Jan 2007 08:20:30 -0800 (PST)
Received: by 10.48.246.15 with HTTP; Tue, 30 Jan 2007 08:20:30 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38164>

Hi,

I recently decided to jump into the DVCS pool, and I've been studying
what seem to me to be the two leading candidates--git and
mercurial--to try to understand the differences between them in design
and features.  I have some questions that I hope you can enlighten me
on.

1.  As of today, is there any real safety concern with either tool's
repo format?  Is either tool significantly better in this regard?
(Keith Packard's post hints at a problem here, but doesn't really make
the case.)

2.  Does the git packed object format solve the performance problem
alluded to in posts from a year or two ago?

3.  Someone mentioned that git bisect can work between any two
commits, not necessarily just one that happens to be an ancestor of
the other.  This sounds really cool.  Can hg's bisect do this, too?

4.  What is git's index good for?  I find that I like the idea of it,
but I'm not sure I could justify it's presence to someone else, as
opposed to having it hidden in the way that hg's dircache (?) is.  Can
anyone think of a good scenario where it's a pretty obvious benefit?

5.  I think I read that there'd been just one incompatible change over
time in the git repo format.  What was it?

6.  Does either tool use hard links?  This matters to me because I do
development on a connected machine and a disconnected machine, using a
usb drive to rsync between.  (Perhaps there'll be some way to transfer
changes using git or hg instead of rsync, but I haven't figured that
out yet.)

7.  I'm a fan of Python, and I'm really a fan of using high-level
languages with performance-critical parts in a lower-level language,
so in that regard, I really like hg's implementation.  If someone
wanted to do it, is a Python clone of git conceivable?  Is there
something about it that just requires C?

8.  It feels like hg is not really comfortable with parallel
development over time on different heads within a single repo.
Rather, it seems that multiple repos are supposed to be used for this.
 Does this lead to any problems?  For example, is it harder or
different to merge two heads if they're in different repo than if
they're in the same repo?

Thanks in advance,
Mike

(I'll probably post this on the hg list as well.)
