From: Nicolas Vilz 'niv' <niv@iaglans.de>
Subject: Re: [PATCH 0/2] More git-send-email updates
Date: Mon, 13 Feb 2006 16:58:16 +0100
Message-ID: <43F0AC98.4010501@iaglans.de>
References: <11398189232404-git-send-email-ryan@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Feb 13 17:00:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8g7X-0005YX-9f
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 17:00:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750783AbWBMQAH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 11:00:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbWBMQAG
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 11:00:06 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:39179 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S1750783AbWBMQAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 11:00:05 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id B5FB44224
	for <git@vger.kernel.org>; Mon, 13 Feb 2006 16:59:46 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 11470-04 for <git@vger.kernel.org>;
	Mon, 13 Feb 2006 16:59:45 +0100 (CET)
Received: from [192.168.100.26] (unknown [10.0.0.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id A02064221
	for <git@vger.kernel.org>; Mon, 13 Feb 2006 16:59:43 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051204)
X-Accept-Language: en-us, en
To: git@vger.kernel.org
In-Reply-To: <11398189232404-git-send-email-ryan@michonline.com>
X-Enigmail-Version: 0.92.0.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16072>

Ryan Anderson wrote:
> To follow up on some conversations related to git-send-email this week, here are two updates:
> 
> The first adds a command line option to suppress adding the "From" address to
> the list of addresses to Cc, when it appears in a From: header line.  (Note
> that git-send-email never looked for From: lines inside the body of a message
> to use as a source for Cc: addresses, which, given the patch formats Linus has
> previously talked about, is probably a bug.)
> 
> The second patch adds the mythical "--cc" option.  I say "mythical" because it
> has never existed, but both Junio and I have mentioned it (or used it)
> recently, so we both *assumed* that it existed.  I think that's justification
> for adding it.
> 

it is a very nice idea to use git-send-email together with
git-format-patch --stdout, but i think, maybe i do something wrong... I
tried that cli-syntax Junio mentioned in "Whats in git.git"

git format-patch --stdout <branch_01>..<branch_02>|git send-email --to
<email_address>


and got a "Error: Please specify a file or a directory on the command
line.".

Besides, git asks me for a From-Header (which is fixed with this patch,
I suppose)

I use git 1.2.0 directly from your git-repository.

so actually git-send-email does not work with this syntax above.

If I first produce the patches, save them into another directory and
afterwards give git-send-email that directory for lunch, it works...

is there any other work-around for this everyday-task but a shellscript
which temporarily creates a patch-dir which contains the patches and
removes it after git-send-email is done with it?

Sincerly
Nicolas
