From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: A Basic Git Question About File Tracking
Date: Sat, 08 Oct 2011 18:17:41 -0700 (PDT)
Message-ID: <m3ipnz0xri.fsf@localhost.localdomain>
References: <j6dlhf$dp3$1@dough.gmane.org> <20111004011035.GA13836@elie>
	<4E8A5DF0.6040003@gmail.com> <20111004012244.GB13836@elie>
	<4E90E60C.7060105@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-4
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 03:17:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCi1W-0006Vg-4X
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 03:17:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751399Ab1JIBRp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 8 Oct 2011 21:17:45 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40331 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751068Ab1JIBRo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Oct 2011 21:17:44 -0400
Received: by bkbzt4 with SMTP id zt4so6649925bkb.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 18:17:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=PqNZr4XRb3+D/wFdJaTNuXjfgP2/tO9bI8QQAxk8iAg=;
        b=Rbc/DgcTyJnQVZ2iFO/IUnx90a3Ej9oWCSBC0r8CHi3mTjm3KQh7Amu0gbjFFtfplM
         WZF+L5FtxZTBFpdzvXov56xEMJe5zcPVWXHeozhkf98S/58cYeQc38byLdcDm4qRo8ys
         xRbI6n7AXQiwe/oFjSeW5QrmTMEI1jB7EJHek=
Received: by 10.204.133.77 with SMTP id e13mr2260887bkt.94.1318123062547;
        Sat, 08 Oct 2011 18:17:42 -0700 (PDT)
Received: from localhost.localdomain (abws83.neoplus.adsl.tpnet.pl. [83.8.242.83])
        by mx.google.com with ESMTPS id x4sm5899002fad.1.2011.10.08.18.17.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 18:17:41 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id p991HHY3018163;
	Sun, 9 Oct 2011 03:17:28 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id p991H6iH018159;
	Sun, 9 Oct 2011 03:17:06 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4E90E60C.7060105@gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183180>

Jon Forrest <nobozo@gmail.com> writes:

> On 10/3/2011 6:22 PM, Jonathan Nieder wrote:
>=20
> [I'm just getting back to this question. I had accidentally
> sent this follow up directly to Jonathan but I want to
> continue this on the email list.]
>=20
> > Yes, "x" is tracked.  Moreover, "x" is in the index.  You can
> > list files in the index with the "git ls-files -s" command.
>=20
> This spoils my understanding of what the index
> is. I had been thinking that after you add files
> to the index, and then commit, the index is then
> empty. In other words, whatever's in the index
> gets committed, and then the index is cleaned.
>=20
> On the other hand, if the definition of a tracked
> file is a file that's in the index, then this definitely
> clears up my understanding of tracked files.
>=20
> If every file that's 'git add'ed stays in the
> index, how does git know which files to commit?
>=20
> I can't prove it but I suspect that many git beginners
> also are confused by this.

You seem to be under [false] impression that git commit is about
_changes_ / _changeset_.

It is not true.  What is stored in git commit object is (pointer to)
_snapshot_ of a state of a project at given time.  This means that
"git commit" creates a tree object out of state of the index, and
creates commit object that points to said newly created tree, and has
version you started work from as its parent.  It is commit remember
the previous version that allows to turn commit into changeset.

Hopefully that would clear up your confusion.
--=20
Jakub Nar=EAbski
