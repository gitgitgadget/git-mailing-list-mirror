From: Pete/Piet Delaney <pete@bluelane.com>
Subject: Re: Object Permissions - trying git-init --shared=group parameters
Date: Thu, 21 Feb 2008 14:06:39 -0800
Organization: Bluelane
Message-ID: <47BDF5EF.9030707@bluelane.com>
Reply-To: pete@bluelane.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: Git Mailing List <git@vger.kernel.org>,
	piet.delaney@gmail.piet.net, Piet Delaney <piet.delaney@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 21 23:07:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSJZY-0001C5-90
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 23:07:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbYBUWGo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 17:06:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755146AbYBUWGo
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 17:06:44 -0500
Received: from outbound.mse2.exchange.ms ([69.25.50.247]:2646 "EHLO
	mse2fe1.mse2.exchange.ms" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753708AbYBUWGn (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Feb 2008 17:06:43 -0500
Received: from piet2.bluelane.com ([64.94.92.242]) by mse2fe1.mse2.exchange.ms with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 21 Feb 2008 17:06:42 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
X-Enigmail-Version: 0.95.6
X-OriginalArrivalTime: 21 Feb 2008 22:06:42.0415 (UTC) FILETIME=[0A4497F0:01C874D6]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74670>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Junio C Hamano wrote:
| Pete/Piet Delaney <pete@bluelane.com> writes:
|
|> I've been trying to us the git repo in a
|> centralize pull, push model where the
|> developers pull the repo, checkout a
|> branch, commit and then push back to the
|> common repo.
|>
|> Problem is that the objects get set with
|> the ownership of the user (at least when
|> pulling with this format:
|>
|> ~    git clone git:/home/git/blux
|>
|> Amy suggestions on how to do this?
|
| "man git-config" and look for core.sharedrepository, perhaps?

That's kinda what I'm trying. I did a git-init --shared=group
and found that it set:


	[core]
~        	repositoryformatversion = 0
~        	filemode = true
~        	bare = false
~        	logallrefupdates = true
~        	sharedrepository = 1

	[receive]
~        	denyNonFastforwards = true

So I looked int the meaning of these config prams and
thought I tried adding:

	sharedrepository = 1

	denyNonFastforwards = true

to the bare repo on the git server. I'm not sure if
existing repo that have been cloned will have to be
updated, hopefully not.

- -piet

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHvfXuJICwm/rv3hoRAl+PAJ9M/dRAuWRjs8gUvq1w3JqeH8/tNgCdFbto
iaqrDyOefH4zTEK8Zzximu4=
=xJM3
-----END PGP SIGNATURE-----
