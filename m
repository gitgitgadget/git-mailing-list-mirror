From: "Todd A. Jacobs" <nospam@codegnome.org>
Subject: Re: PEBKAC or bug: unable to create path-like branch names
Date: Sat, 14 Nov 2009 23:36:28 -0800
Message-ID: <20091115073628.GE5934@penguin.codegnome.org>
References: <20091115020605.GE15966@cl.cam.ac.uk>
	<20091115050227.GD5934@penguin.codegnome.org>
	<8c9a060911142136s68a08892ifa27989f3a5bfdfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 15 08:41:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9Zjq-0004Cp-FY
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 08:41:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751892AbZKOHga (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 02:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751887AbZKOHg3
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 02:36:29 -0500
Received: from mta21.charter.net ([216.33.127.81]:55841 "EHLO
	mta21.charter.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751611AbZKOHg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 02:36:29 -0500
X-Greylist: delayed 9241 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Nov 2009 02:36:29 EST
Received: from imp09 ([10.20.200.9]) by mta21.charter.net
          (InterMail vM.7.09.02.04 201-2219-117-106-20090629) with ESMTP
          id <20091115073634.OJGJ21519.mta21.charter.net@imp09>
          for <git@vger.kernel.org>; Sun, 15 Nov 2009 02:36:34 -0500
Received: from penguin.codegnome.org ([71.83.124.90])
	by imp09 with smtp.charter.net
	id 5KcW1d0051x8DgP05KcXLU; Sun, 15 Nov 2009 02:36:31 -0500
X-Authority-Analysis: v=1.0 c=1 a=rB_BUOY0O9EA:10 a=-cGxoi5oWMdkFZ1Ccb8A:9
 a=zX2xlHunsvAbBXVhFmkA:7 a=v0MGLk0XZdDg1FPIfgUqj_TW9oAA:4
Received: by penguin.codegnome.org (Postfix, from userid 1000)
	id E95B637CBC; Sat, 14 Nov 2009 23:36:28 -0800 (PST)
Received: by penguin.codegnome.org (tmda-sendmail, from uid 1000);
	Sat, 14 Nov 2009 23:36:28 -0800
Content-Disposition: inline
In-Reply-To: <8c9a060911142136s68a08892ifa27989f3a5bfdfb@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Delivery-Agent: TMDA/1.1.12 (Macallan)
Mail-Followup-To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132913>

On Sat, Nov 14, 2009 at 09:36:47PM -0800, Jacob Helwig wrote:

> What version of git are you using?  git checkout -b foo/bar/baz works

I'm using 1.6.5.2 as well. Okay, try this in a temp directory, and
you'll see what I mean:

    git init
    echo foo > foo
    git add foo
    git commit -m testing foo
    git checkout -b dev
    git checkout -b dev/feature/foobar

The first branch works fine, but after attempting the nested branch the
message reappears:

    error: unable to resolve reference refs/heads/dev/feature/foobar: Not a directory
    fatal: Failed to lock ref for update: Not a directory

I can recreate this behavior at any time; it isn't just a problem with
an existing repository.

-- 
"Oh, look: rocks!"
	-- Doctor Who, "Destiny of the Daleks"
