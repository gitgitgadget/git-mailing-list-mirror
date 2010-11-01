From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: git-svn clone --stdlayout causes "fatal: refs/remotes/trunk: not
 a valid SHA1"
Date: Mon, 1 Nov 2010 12:11:41 -0500
Message-ID: <20101101171141.GA8853@burratino>
References: <225342.86075.qm@web24105.mail.ird.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Wong <normalperson@yhbt.net>
To: Klaus <klaus3b-gu@yahoo.de>
X-From: git-owner@vger.kernel.org Mon Nov 01 18:12:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PCxvP-0002uK-Py
	for gcvg-git-2@lo.gmane.org; Mon, 01 Nov 2010 18:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751158Ab0KARL7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Nov 2010 13:11:59 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:43480 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750746Ab0KARL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Nov 2010 13:11:57 -0400
Received: by eye27 with SMTP id 27so3284653eye.19
        for <git@vger.kernel.org>; Mon, 01 Nov 2010 10:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=IXITlbsd7qbiUwH6IPnneiCEb7r2PA8EQbK0dHqfHBM=;
        b=vWwYmcIskqad9UaPZ3cEVxg91nAXUoHdn9neX+FhdVvsxL6OBmnkNwQGkywjW4JHTZ
         pTZ8FCV8zUR/yoNfdVatjwy87+zkyaPwRSkb+cf44CPXBslhs6rfy56nWZh/l0emnwAU
         wW8Mf/24mK/XFJz6fUzUBrQX40oCPbQlfjMyo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=fGazW1JDJdhhHi0is6vNRUN+HSv/h44TvNtEmhSPplroMlansmhq8TX3FziuRRAwXt
         WNXQ7mwN3pYnMcYB85mxBxgqo9NxDuGZbmSLcOl3PYNteWPbydEYb5TneRUZG+G8CgkX
         g7quu1p9F0x8J6wET6RBjkQruLLlzm1veORvY=
Received: by 10.216.12.82 with SMTP id 60mr3000684wey.42.1288631516342;
        Mon, 01 Nov 2010 10:11:56 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.sbcglobal.net [68.255.106.176])
        by mx.google.com with ESMTPS id x65sm4013563weq.1.2010.11.01.10.11.54
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 01 Nov 2010 10:11:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <225342.86075.qm@web24105.mail.ird.yahoo.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160486>

Hi Klaus,

Klaus wrote:

> this works ok.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git svn clone svn://localhost/My=
Prj MyPrj=C2=A0 --username=3DMyUserName
> =C2=A0=C2=A0=C2=A0=20
> this causes the error (I added "--stdlayout")
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 git svn clone svn://localhost/My=
Prj MyPrj=C2=A0 --stdlayout=C2=A0--username=3DMyUserName
> =C2=A0=C2=A0=C2=A0=20
> last line of error output
> =E2=80=A6
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 M=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 Wiki/MyPrj_wiki/MyPrjHistory.wiki
> W: -empty_dir: MyPrjAll/trunc/MyPrjGui/DotNet11MainMenu.cs
> r141 =3D ad4166b68d89c4b795fb74a4fc09168160b2f60e=20
> (refs/remotes/tags/LastGuiMonolit_071207@142)
> W: +empty_dir: MyPrjAll/trunc/MyPrj.Gui
> r142 =3D 0decd283bb36f9296172970eeab377b6f93777ba=20
> (refs/remotes/tags/LastGuiMonolit_071207@142)
> Found branch parent: (refs/remotes/tags/LastGuiMonolit_071207) 0decd2=
83bb36f9296172970eeab377b6f93777ba
> Following parent with do_switch
> Successfully followed parent
> r143 =3D a4861b50a5f1c067210b30951dc06012a7d2da25=20
> (refs/remotes/tags/LastGuiMonolit_071207)
> fatal: refs/remotes/trunk: not a valid SHA1
> update-ref refs/heads/master refs/remotes/trunk: command returned err=
or: 128

Is your repository public?  If not, could you give a sketch of the proj=
ect
history, for example by running

 $ git log --oneline --name-status

from a successful (non-stdlayout) clone?

> note: although i am using ms-windows7 i mailed this report to the deb=
ian=20
> mailing-list because i think that=C2=A0=20

Redirecting discussion to the git mailing list; maybe someone there wil=
l
have other ideas for debugging.

Thanks for reporting,
Jonathan
