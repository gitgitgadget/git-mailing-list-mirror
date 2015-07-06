From: Plamen Totev <plamen.totev@abv.bg>
Subject: Git grep does not support multi-byte characters (like UTF-8)
Date: Mon, 6 Jul 2015 14:28:16 +0300 (EEST)
Message-ID: <2008630603.1189842.1436182096558.JavaMail.apache@nm33.abv.bg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 13:28:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC4ZB-0005BG-PI
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 13:28:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754778AbbGFL17 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Jul 2015 07:27:59 -0400
Received: from smtp-out.abv.bg ([194.153.145.80]:45753 "EHLO smtp-out.abv.bg"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754194AbbGFL16 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 07:27:58 -0400
Received: from nm33.abv.bg (nm33.ni.bg [192.168.151.4])
	by smtp-out.abv.bg (Postfix) with ESMTP id B85BC56ED79
	for <git@vger.kernel.org>; Mon,  6 Jul 2015 14:27:37 +0300 (EEST)
DomainKey-Signature: a=rsa-sha1; s=smtp-out; d=abv.bg; c=simple; q=dns;
	b=di2Sr6Iu1bs4fQObd4bgbEO9mzzXf8rtXQbBgY+3oTj7qWg8vZ1rBCzTZ83eok6Zw
	e4JN/12YxkWTpoIFPGkRAerylUKbcdfx2rfYL70BNZd4opExN1IQlC1aDSmgSsb298a
	RJgIOybLBBJPQs8yIFWPkCCrlvtW4VU873P4Cg4=
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=abv.bg; s=smtp-out;
	t=1436182057; bh=azBrKzS6DN1EyGbhgBLIZKn/jJ5PpVMVOdeV3RFKK6w=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:DKIM;
	b=NHYJjJqx+b4BdAVGuzfDwsgZbeJGY5C6Gp5GUIhOQ91xS8R1ytRoqaChRSHK+mAU6
	 M+ub8sFSadxh044pjXxStsspczHzG0DFtyVvji4uBioSXfFgYILoW8tFObm5twiLZ5
	 ySnKsc943kCixA5dA/m145GCiA1ZpNadhr8VztO4=
Received: from nm33.abv.bg (localhost.localdomain [127.0.0.1])
	by nm33.abv.bg (Postfix) with ESMTP id 88B60BDF5C
	for <git@vger.kernel.org>; Mon,  6 Jul 2015 14:28:16 +0300 (EEST)
X-Mailer: AbvMail 3.0
X-Originating-IP: 95.111.52.16
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273381>

Hello,=C2=A0

It looks like the git grep command does not support multi-byte characte=
r sets like UTF-8. As a result some of the grep functionality is not wo=
rking. For example if you search for non Latin words the ignore case fl=
ag does not have effect(the search is case sensitive). I suspect there =
are some regular expressions that will not work as expected too.=C2=A0

When I'm using the git from the shell I could use the GNU grep utility =
instead. But some tools like gitweb use git grep so they are not workin=
g properly with UTF-8 files with non Latin characters.=C2=A0

Much of the grep code seems to be copied from the GNU grep utility but =
the multi-byte support is left out. I just wondered what could be the r=
eason.=C2=A0

Regards,=C2=A0
Plamen Totev
