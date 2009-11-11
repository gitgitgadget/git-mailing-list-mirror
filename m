From: Sam Vilain <sam@vilain.net>
Subject: Re: Bug: "git svn clone" does not honor svn.authorsfile setting
Date: Wed, 11 Nov 2009 17:26:44 +1300
Message-ID: <4AFA3D04.3050109@vilain.net>
References: <20091110130913.GR19475@poetic.cynic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Curt Sampson <cjs@cynic.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 11 05:27:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N84nl-0005UW-TA
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 05:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754642AbZKKE0l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 23:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753161AbZKKE0l
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 23:26:41 -0500
Received: from bertrand.catalyst.net.nz ([202.78.240.40]:47018 "EHLO
	mail.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752175AbZKKE0k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 23:26:40 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.catalyst.net.nz (Postfix) with ESMTP id 8D7E631DA4;
	Wed, 11 Nov 2009 17:26:44 +1300 (NZDT)
X-Virus-Scanned: Debian amavisd-new at catalyst.net.nz
Received: from mail.catalyst.net.nz ([127.0.0.1])
	by localhost (bertrand.catalyst.net.nz [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1vGCy5hfQ+PG; Wed, 11 Nov 2009 17:26:44 +1300 (NZDT)
Received: from [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0] (unknown [IPv6:2404:130:0:1000:21d:7dff:fe90:5fe0])
	(Authenticated sender: samv)
	by mail.catalyst.net.nz (Postfix) with ESMTPSA id 2113231D83;
	Wed, 11 Nov 2009 17:26:44 +1300 (NZDT)
User-Agent: Mozilla-Thunderbird 2.0.0.19 (X11/20090103)
In-Reply-To: <20091110130913.GR19475@poetic.cynic.net>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132615>

Curt Sampson wrote:
> When using "git svn fetch" or "git svn clone", the --authors-file
> command line parameter does what it claims in the docs. Additionally,
> for "git svn fetch", an svn.authorsfile configuration parameter in
> ~/.gitconfig is used, if no command line argument is specified. However,
> svn.authorsfile is ignored by "git svn clone", though the documentation
> claims that clone "runs init and fetch."
>
> I have confirmed this bug is present in git versions 1.6.0.4 and 1.6.5.1.
>   

Does moving the line:

command_oneline('config', 'svn.authorsfile', $_authors) if $_authors;

Immediately prior to the "fetch_all" line before it fix the problem? It
looks strange for it to set it afterwards...

Sam
