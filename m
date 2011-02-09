From: Francis Moreau <francis.moro@gmail.com>
Subject: Advices to imlement update hook
Date: Wed, 9 Feb 2011 17:27:07 +0100
Message-ID: <AANLkTimdsCgNBAnJmnzGj3M3Q4RPb==fiWu1+ZQhWenO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 09 17:27:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PnCss-00086T-Eq
	for gcvg-git-2@lo.gmane.org; Wed, 09 Feb 2011 17:27:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062Ab1BIQ1J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Feb 2011 11:27:09 -0500
Received: from mail-px0-f174.google.com ([209.85.212.174]:40209 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752586Ab1BIQ1I (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Feb 2011 11:27:08 -0500
Received: by pxi15 with SMTP id 15so59121pxi.19
        for <git@vger.kernel.org>; Wed, 09 Feb 2011 08:27:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=EWAbPQ5uHOrkGhrrhX/ABFEpbbYDaWuFiq2zyLNJ3Jw=;
        b=xAxCIeBvKRbX0llNMa+h1SuGPDOBXez4+fWRP0Vlbc2YmFvkLPCtPEqPPiCe+L9ETQ
         HhYKBwN81g8DKihZJkR6npv6Gsl/qiTmxI1xkUGMEXadapiWTu+1SLN3Bht7O4TbFirq
         sWydTgLuaNLGkw0Upah6yrj+MkP7apMDkS3xE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=mbEilYr2vX9KL61HQvj4s1YsMTz51BfgUYmhAHQq14+5+HLZpUnSVC4cvYpde5M9n3
         JcNHxre+QTaxoSlPSuqsipmaFprsWdllqLvRvDQVif8AdIaO7ZnqbPKsIQEOrBHumPuX
         0pTJUhUbKs7JmmzP4B6ZWCxwV05KTFnXsTW64=
Received: by 10.142.126.13 with SMTP id y13mr18682252wfc.410.1297268827790;
 Wed, 09 Feb 2011 08:27:07 -0800 (PST)
Received: by 10.142.44.3 with HTTP; Wed, 9 Feb 2011 08:27:07 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166428>

Hi !

I'd like to restrict access to one of my repos: the project tracked by
it has several directories: a/ b/ c/ and I'd like to allow only
modifications happen in b/ directory.

I'm planning to use git hooks, not sure which one I should use: if the
check should happen at the commit or push time or both.

For now I'm going to use the update hook, so it will happen when pushing.

Now the question is: what is the best way to do this ?

I'm planning to use something equivalent to "git-diff-tree oldref
newref | { grep -v b || exit 1; }" but doesn't look like the best git
way.

BTW, from the git-diff-tree manpage:

	<path>...
	    If provided, the results are limited to a subset of
	    files matching one of these prefix strings. i.e., file
	    matches /^<pattern1>|<pattern2>|.../ Note that this
	    parameter does not provide any wildcard or regexp
	    features.

What does it mean exactly ? what does 'pattern' word mean if wildcard
or regexp is not supported ?
I also tried:

   git diff-tree <oldref> <newref> -- ^b || exit 1

but it doesn't work.

Could anybody give me some advices ?

Thanks
-- 
Francis
