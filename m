From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: Submodule using different repository URLs
Date: Mon, 13 Jul 2009 12:20:59 +0200
Message-ID: <adf1fd3d0907130320s726bb80at58d454c830c7d5be@mail.gmail.com>
References: <5BE6F3DC-4B00-4D84-8D0E-41057735483F@petervoss.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Voss <info@petervoss.org>
X-From: git-owner@vger.kernel.org Mon Jul 13 12:29:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQImd-0001cA-6e
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 12:29:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755385AbZGMK3N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jul 2009 06:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755383AbZGMK3M
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 06:29:12 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:44294 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755379AbZGMK3M (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 06:29:12 -0400
X-Greylist: delayed 491 seconds by postgrey-1.27 at vger.kernel.org; Mon, 13 Jul 2009 06:29:11 EDT
Received: by bwz28 with SMTP id 28so59194bwz.37
        for <git@vger.kernel.org>; Mon, 13 Jul 2009 03:29:09 -0700 (PDT)
Received: by 10.204.76.129 with SMTP id c1mr5026368bkk.9.1247480459214; Mon, 
	13 Jul 2009 03:20:59 -0700 (PDT)
In-Reply-To: <5BE6F3DC-4B00-4D84-8D0E-41057735483F@petervoss.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123183>

2009/7/13 Peter Voss <info@petervoss.org>:
> Hi,
>
> I want to use the git submodule feature to move part of my code to a
> different repository at github.
>
> The issue is that developers should use different repository URLs for the
> submodule depending on whether they have commit rights or not.
>
> At the beginning I was using the public URL to set-up the submodule:
> git submodule add git://github.com/x/mymodule.git mymodule
>
> The issue is that some developers are working behind a firewall that blocks
> the git protocol. These could only use the git@github.com:x/mymodule.git URL
> to get access.
> But other developers can only go through the public URL
> git://github.com/x/mymodule.git. So whatever I use it won't work for
> everybody.
>
> What's the best way to deal with that? Could I set-up different repository
> URLs for one and the same submodule and use which one is appropriate?

After the "git submodule init" you can customize the url. From "man
git-submodule":

init::
        Initialize the submodules, i.e. register each submodule name
        and url found in .gitmodules into .git/config.
        The key used in .git/config is `submodule.$name.url`.
        This command does not alter existing information in .git/config.
        You can then customize the submodule clone URLs in .git/config
        for your local setup and proceed to 'git submodule update';
        you can also just use 'git submodule update --init' without
        the explicit 'init' step if you do not intend to customize
        any submodule locations.

You can also use the config url."<actual url base>".insteadOf = <other
url base>.
See the git-pull manpage for examples.

HTH,
Santi
