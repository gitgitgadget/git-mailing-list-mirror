From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: building git ; need suggestion
Date: Fri, 15 Mar 2013 13:44:15 +0100
Message-ID: <20130315124415.GA23122@paksenarrion.iveqy.com>
References: <868B103B-690E-477B-BF75-8F954F893E6F@infoservices.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Joydeep Bakshi <joydeep.bakshi@infoservices.in>
X-From: git-owner@vger.kernel.org Fri Mar 15 13:43:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UGTzD-0004Jc-ED
	for gcvg-git-2@plane.gmane.org; Fri, 15 Mar 2013 13:43:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754432Ab3COMnY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Mar 2013 08:43:24 -0400
Received: from mail-la0-f54.google.com ([209.85.215.54]:38099 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754384Ab3COMnY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Mar 2013 08:43:24 -0400
Received: by mail-la0-f54.google.com with SMTP id gw10so3617191lab.41
        for <git@vger.kernel.org>; Fri, 15 Mar 2013 05:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:sender:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FL4P0n53cHqXRWled0AET2MMU69XstuPqFxDM9mxzpw=;
        b=H86rF4oVtVhdftd0HWA7zG5O9Ugmls4AcVBMLK4EdCWAtOKV6VIqwzdw4haoqS8Vsw
         PtJug9hPQudWWmr8MEJN6db+HV5oUav07YfsVBsnmvXGqoKe/sL/e/SUEWNAUqGSjbCu
         eYku2QZtUefdyGyINPnMtjWgtKQIqVj27hDaT7Rnhja0QGFIHBnVkPUg8LdkvVJ8kcD3
         kcmQKZE4aiBEC3E6jQLBkXR50B4BF35wWj/3FgSWVbJFR5JV9RyucgvgA/DItJJR0o3N
         VbifqQVV4ptY2BbmphQ9ZIAVep3sockR/GaFohH3H+EEzAP+EkTQ9IRtEtYuLH1LzUDO
         LZDQ==
X-Received: by 10.112.99.100 with SMTP id ep4mr2593284lbb.13.1363351402465;
        Fri, 15 Mar 2013 05:43:22 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPS id l1sm2003371lbn.8.2013.03.15.05.43.21
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 15 Mar 2013 05:43:21 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1UGTzb-00064K-GH; Fri, 15 Mar 2013 13:44:15 +0100
Content-Disposition: inline
In-Reply-To: <868B103B-690E-477B-BF75-8F954F893E6F@infoservices.in>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218240>

On Fri, Mar 15, 2013 at 05:54:05PM +0530, Joydeep Bakshi wrote:
> [1] the server will have different git repo with branches
> [2] there will be a web-based GUI which must be flexible to show just=
 a specific branch of a repo based on user authentication
> [3] the web-based GUI should also have the flexibility to show a sing=
le repo based on the authentication
> [4] the web-based GUI should have an admin account to supervise and c=
onfigure all repos along with their branches
> [3] there must be a control mechanism in the repo/web based GUI which=
 have ACL on branches i.e.
> some specific users should see some specific/ or just a branch and ab=
le to commit there only.
>=20
> based on the above scenario could anyone suggest the best available s=
olution ?
> There are many like gitolike/github etc=E2=80=A6. but don't know whig=
 one has much finer granular
> control/ACL/web-based GUI=E2=80=A6

gitolite have a more fine ACL. Check it out. However it doesn't really
meet your needs with web-interface (and I'm not even sure about the ACL
thing is fine enough for you). You can read more about ACL in the git
book: http://git-scm.com/book/ch7-4.html

The webgui that's most populair is cgit and git-web. They don't do ACL
afaik.

Why would you need ACL? Why not don't share the branches that are going
to be secret? Or are you looking for some branches to be read only?

When we did this, we did a simple gitolite implementation ourself and
integrated cgit on our website wich already had ACL. It works well.
Howerver we do ACL on repo-level, not on branch level.

You can also look into git-submodules which will make it possible for
you to do repo-wide ACL.

However I'm not sure you will be using git in the way git is designed
too and even if it will work, maybe an other solution is better for you=
=2E

--=20
Med v=C3=A4nliga h=C3=A4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
