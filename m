From: Timur Tabi <timur@freescale.com>
Subject: Re: How can I tell if a file has been updated upstream?
Date: Fri, 5 Feb 2010 10:56:56 -0600
Message-ID: <ed82fe3e1002050856v68d4d02bnbe18394bebac2f4d@mail.gmail.com>
References: <ed82fe3e1002050823gec57827j184c9c4cff4f4a45@mail.gmail.com> 
	<20100205164407.GA27498@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 17:57:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdRUj-000217-Gn
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 17:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755112Ab0BEQ5U convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2010 11:57:20 -0500
Received: from mail-fx0-f211.google.com ([209.85.220.211]:41748 "EHLO
	mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754624Ab0BEQ5T convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Feb 2010 11:57:19 -0500
Received: by fxm3 with SMTP id 3so4223764fxm.39
        for <git@vger.kernel.org>; Fri, 05 Feb 2010 08:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=PHY+HdxaCmmLwq7VwN+rdZ3VFG6vYNSgpyMK2xWO+A0=;
        b=OpajJBubY6tQtUx5o8ccwyHg3q5SY9oTHyFite52v2X9hfRns1bEs821QXPgdrVNvh
         V8qXg/7Xy6by6ZaGMUIVN5LNR+Uwx+7VYwmHN4wKEiBvbOemD8CAin9hbzEtP08sNYas
         hTWQ5e6LD/SfADCxsMIySvzWvf+LEdseumg40=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=P+OiMeoixbyWKoZFf2W+cc4dqaB6zSV1WU2J2X1svH/yDtaoDzNygFSxVmvXm6MsNY
         0phhRqTuIq1QSoeVBF4HCsVfuoH/qt8Vi/lx2PueQef7NadRlIIGrXxMws/vh94ES+Pz
         x2q4WsM6/YdwCkvLST7Bt0hGP59MOzREdxs48=
Received: by 10.239.161.130 with SMTP id h2mr301208hbd.114.1265389036500; Fri, 
	05 Feb 2010 08:57:16 -0800 (PST)
In-Reply-To: <20100205164407.GA27498@spearce.org>
X-Google-Sender-Auth: b9cae8a119c19314
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139058>

On Fri, Feb 5, 2010 at 10:44 AM, Shawn O. Pearce <spearce@spearce.org> =
wrote:

> You can't tell a particular file, but you could use something like
> `git ls-remote refs/heads/master` to see what the branch is at,

$ git ls-remote refs/heads/master
fatal: 'refs/heads/master' does not appear to be a git repository
fatal: The remote end hung up unexpectedly

So maybe you meant this:

$ git ls-remote ssh://git.am.freescale.net/git/timur/bin refs/heads/mas=
ter
20fbe12069038057cbd0d66c5a673956f7792c7d	refs/heads/master

I can use this to compare with the local HEAD.  However, this only
tells me that the repository as a whole has changed.  I was hoping
there would be a way to see if just the one file has change.  I.e. how
can I get the HEAD of a *file* in a remote repository.

> I do this in repo, only I run `git fetch` once per day for the
> end-user. =A0That way the objects are local, and I can use a local
> check to see if there are updates that need to be pulled into the
> executable working directory.

Yeah, I'm not keen on performing an actual download, even if it's just =
a fetch.

--=20
Timur Tabi
Linux kernel developer at Freescale
