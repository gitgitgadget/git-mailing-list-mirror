From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Enhancements to git-protocoll
Date: Sat, 28 Jul 2012 23:41:16 +0200
Message-ID: <20120728214116.GA3591@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jul 28 23:41:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvElP-00064M-Nn
	for gcvg-git-2@plane.gmane.org; Sat, 28 Jul 2012 23:41:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176Ab2G1VlO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 28 Jul 2012 17:41:14 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:58788 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751632Ab2G1VlO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 28 Jul 2012 17:41:14 -0400
Received: by lahd3 with SMTP id d3so2823193lah.19
        for <git@vger.kernel.org>; Sat, 28 Jul 2012 14:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:content-transfer-encoding:user-agent;
        bh=7wcFMlU9PHOGFXyD5wkL5knX207wJggu8kM4QtpAftE=;
        b=lBwo5xueFoJI/TprlQqFZNE4WJPTAhi3f5JncCWwdmG9GxmfHm2isRbwmdDOvTjto7
         TAgznv2Aywf1RW2hIYcxE7pRkGPrZJqyXJx6eiapa9lLQUKaz3SUvS/iWSwUaYaI0F4l
         tY+nKN+9+d4Ep7fWv0G5BSc0DIdUCLdrTefnFmnoa8/azxeMNLNd6R/bSPhMFrSAt1G9
         KGq5AuVQROQvDhFfOohYhuwy0fu/In1MMz/04E/vLHbigs9U3tiGofQcR/dRvv6dL2pC
         k8hHH1ieMk+HotXDbgEW1TxJDx/ZVsIeAY6nYOZDQAe3gzt2G+5v95Q8rin3dyM7a6Ak
         hBBQ==
Received: by 10.152.109.198 with SMTP id hu6mr6831689lab.21.1343511672498;
        Sat, 28 Jul 2012 14:41:12 -0700 (PDT)
Received: from paksenarrion.iveqy.com (h-235-111.a189.priv.bahnhof.se. [81.170.235.111])
        by mx.google.com with ESMTPS id pp2sm5976864lab.3.2012.07.28.14.41.10
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 28 Jul 2012 14:41:11 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1SvElA-00014m-Qe; Sat, 28 Jul 2012 23:41:16 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202465>

Hi,
sometimes git communicates with something that's not git on the other
side (gitolite and github for example).

Sometimes the server wants to communicate directly to the git user.

git isn't really designed for this. gitolite solves this by do user
interaction on STDERR instead. The bad thing about this is that it can
only be one-direction communication, for example error messages.

If git would allow for the user to interact direct with the server, a
lot of cool and and userfriendly features could be developed.

=46or example:
gitolite has something called wild repos[1]. The management is
cumbersome and if you misspell when you clone a repo you might instead
create a new repo.

This could have been avoided with a simply:
"Do you want to create a new repo[Yn]"

To fix this, git protocol should have a command for printing input to
STDOUT and accepting input on STDIN which should be sent to the server.
And a command to switch back to orginal of course.

The server could then switch to user interaction, do that and then
switch back to normal operation.

Before eventually starting to implement this, I would know your
opinions. This feature would be wortless if it's not in the official gi=
t.

[1] http://sitaramc.github.com/gitolite/wild.html
--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
