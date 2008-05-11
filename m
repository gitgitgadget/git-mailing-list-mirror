From: =?utf-8?q?=E3=81=97=E3=82=89=E3=81=84=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93?= 
	<nanako3@bluebottle.com>
Subject: "git log --first-parent" shows parents that are not first
Date: Sun, 11 May 2008 16:03:20 +0900
Message-ID: <200805110706.m4B76eLE006432@mi0.bluebottle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun May 11 09:07:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jv5f3-0007gP-RM
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 09:07:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbYEKHGm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 May 2008 03:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750914AbYEKHGm
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 03:06:42 -0400
Received: from mi0.bluebottle.com ([206.188.25.15]:55857 "EHLO
	mi0.bluebottle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbYEKHGl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 03:06:41 -0400
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by mi0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m4B76eLE006432
	for <git@vger.kernel.org>; Sun, 11 May 2008 00:06:40 -0700
DomainKey-Signature: a=rsa-sha1; s=mail; d=bluebottle.com; c=nofws; q=dns;
	h=received:from:to:cc:subject:date:mime-version:
	content-type:content-transfer-encoding:x-trusted-delivery;
	b=iIv8eGSEX2VBA8yZ6g+4qust7+hJ+YPrRTqRtTOQYMmpwQr0XlhpTjxQEND7OKSzW
	3BC1qZJryztbCQCczOEUAjKNPpLxXo9ifgVVzZY7P5DN1tSIESRTIBc6TDbnq7c
Received: from nanako3.mail.bluebottle.com ([212.62.97.23])
	(authenticated bits=0)
	by fe0.bluebottle.com (8.13.1/8.13.1) with ESMTP id m4B76VTD031918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 11 May 2008 00:06:38 -0700
X-Trusted-Delivery: <9ef7e0d1af4b05007b212503bf28671a>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81744>

Quoting =E3=E3=E3=E3=E3=AA=E3=AA=E3  <nanako3@bluebottle.com>:

> The result given by "git log --first-parent" ('next' version) is
> unexpected to me.
>
>   % git rev-parse origin/next
>   4eddac518225621c3e4f7285beb879d2b4bad38a
>   % git log --abbrev-commit --pretty=3Doneline --first-parent origin/=
next^..origin/next
>   4eddac5... Merge branch 'master' into next
>   1f8115b... Merge branch 'maint'
>   ca1c991... Merge branch 'sg/merge-options' (early part)
>   31a3c6b... Merge branch 'db/learn-HEAD'
>   a064ac1... Merge branch 'jn/webfeed'
>   d576c45... Merge branch 'cc/help'
>   ca1a5ee... Merge branch 'dm/cherry-pick-s'
>   4c4d3ac... Merge branch 'lt/dirmatch-optim'
>   c5445fe... compat-util: avoid macro redefinition warning
>   eb120e6... compat/fopen.c: avoid clobbering the system defined fope=
n macro
>   bac59f1... Documentation: bisect: add a few "git bisect run" exampl=
es
>   d84ae0d... Documentation/config.txt: Add git-gui options
>   921177f... Documentation: improve "add", "pull" and "format-patch" =
examples
>   c904bf3... Be more careful with objects directory permissions on cl=
one
>
> I asked for the log between one commit before the tip of "origin/next=
" and the tip of the branch, following only the first-parent links.  v1=
=2E5.5 is not broken and shows the expected result:
>
>   % ~/git-v1.5.5/bin/git log --abbrev-commit --pretty=3Doneline --fir=
st-parent origin/next^..origin/next
>   4eddac5... Merge branch 'master' into next

Could you please revert d9c292e8bbd51c84cb9ecd86cb89b8a1b35a2a82?  With
that patch reverted from 'next', the problem disappears.

--=20
Nanako Shiraishi
http://ivory.ap.teacup.com/nanako3/

----------------------------------------------------------------------
=46ree pop3 email with a spam filter.
http://www.bluebottle.com/tag/5
