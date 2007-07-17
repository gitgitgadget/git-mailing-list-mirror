From: Amit Walambe <awalambe@arcom.com>
Subject: Re: git bisect not accepting -git kernels
Date: Tue, 17 Jul 2007 17:58:21 +0100
Message-ID: <469CF52D.10407@arcom.com>
References: <469CE836.6010508@arcom.com> <469CF2E6.1020104@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Amit Walambe (awalambe@arcom.com)" <awalambe@arcom.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 17 18:58:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAqNd-0002U1-5X
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 18:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755137AbXGQQ60 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 17 Jul 2007 12:58:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754783AbXGQQ60
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jul 2007 12:58:26 -0400
Received: from mail28.messagelabs.com ([216.82.249.131]:58761 "HELO
	mail28.messagelabs.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754130AbXGQQ6Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jul 2007 12:58:25 -0400
X-VirusChecked: Checked
X-Env-Sender: awalambe@arcom.com
X-Msg-Ref: server-7.tower-28.messagelabs.com!1184691503!36168612!1
X-StarScan-Version: 5.5.12.11; banners=arcom.com,-,-
X-Originating-IP: [194.200.159.164]
Received: (qmail 23934 invoked from network); 17 Jul 2007 16:58:24 -0000
Received: from mail2.arcom.com (HELO mail2.arcom.com) (194.200.159.164)
  by server-7.tower-28.messagelabs.com with SMTP; 17 Jul 2007 16:58:24 -0000
Received: from amit.arcom.cc [10.2.2.55] by mail2.arcom.com with ESMTP
  (SMTPD32-8.00) id A66B7D000DA; Tue, 17 Jul 2007 18:03:39 +0100
User-Agent: Mozilla-Thunderbird 2.0.0.4 (X11/20070622)
In-Reply-To: <469CF2E6.1020104@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52776>

Thanks a ton everyone for all the replies.
Here is the current status :

Ren=E9 Scharfe wrote:
> Amit Walambe schrieb:
>> Hi!
>> I was trying to do a git bisect on 2.6.22-git6 and 2.6.22-git8. For
>> which I get following error :
>> root@amit:/usr/src/linux-git # git bisect good v2.6.22-git6
>> Bad rev input: v2.6.22-git6
>=20
> The -git snapshots are made automatically by kernel.org, and their na=
me
> is not included in the git repository.  You could create tags for the=
m
> like this:
>=20
>  git tag v2.6.22-git6 8f41958bdd577731f7411c9605cfaa9db6766809
>  git tag v2.6.22-git8 a5fcaa210626a79465321e344c91a6a7dc3881fa
>=20
> ... and afterwards you can use those revision names with bisect (or
> other git commands).  I've got the commit IDs (i.e. those mysterious =
40
> hex digits above) from the first line of the changelogs; their URLs a=
re:
>=20
>  http://kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.22-git6.=
log
>  http://kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.22-git8.=
log
I found the commit ids in following file as well :
http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.22-git6=
=2Eid
http://www.kernel.org/pub/linux/kernel/v2.6/snapshots/patch-2.6.22-git8=
=2Eid

But telling good/bad points to git bisect still fails, whether I pass=20
the commit-id or the tags I created with commands given by Ren=E9 :

root@amit:/usr/src/linux-git # git bisect good=20
8f41958bdd577731f7411c9605cfaa9db6766809
cat: .git/BISECT_NAMES: No such file or directory
root@amit:/usr/src/linux-git #
root@amit:/usr/src/linux-git #
root@amit:/usr/src/linux-git # git tag v2.6.22-git6=20
8f41958bdd577731f7411c9605cfaa9db6766809
root@amit:/usr/src/linux-git # git tag v2.6.22-git8=20
a5fcaa210626a79465321e344c91a6a7dc3881fa
root@amit:/usr/src/linux-git #
root@amit:/usr/src/linux-git #
root@amit:/usr/src/linux-git # git bisect good v2.6.22-git6
cat: .git/BISECT_NAMES: No such file or directory
root@amit:/usr/src/linux-git #
root@amit:/usr/src/linux-git #
root@amit:/usr/src/linux-git #
root@amit:/usr/src/linux-git # git bisect bad v2.6.22-git8
cat: .git/BISECT_NAMES: No such file or directory

Thanks and Regards,
--=20
Amit Walambe
Design Engineer, Arcom Control Systems Ltd.
http://www.arcom.com
Tel: +44-(0)1223 411200 ext. 3204
Direct: +44-(0)1223 403465

_____________________________________________________________________
The message in this transmission is sent in confidence for the attentio=
n of the addressee only and should not be disclosed to any other party.=
 Unauthorised recipients are requested to preserve this confidentiality=
=2E Please advise the sender if the addressee is not resident at the re=
ceiving end.  Email to and from Arcom is automatically monitored for op=
erational and lawful business reasons.

This message has been virus scanned by MessageLabs.
