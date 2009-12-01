From: Karl Wiberg <kha@treskal.com>
Subject: Re: [PATCH 5/6] stg mail: add basic support for git send-email
Date: Tue, 1 Dec 2009 08:33:19 +0100
Message-ID: <b8197bcb0911302333v36d38ae3n86417911249fe9b0@mail.gmail.com>
References: <20091128194056.949.88791.stgit@bob.kio>
	 <20091128195037.949.63611.stgit@bob.kio>
	 <b8197bcb0911291354m674d3698m929a1d542a59ed9f@mail.gmail.com>
	 <20091201000048.GL12733@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: catalin.marinas@gmail.com, git@vger.kernel.org
To: Alex Chiang <achiang@hp.com>
X-From: git-owner@vger.kernel.org Tue Dec 01 08:33:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFNEk-0007DR-LT
	for gcvg-git-2@lo.gmane.org; Tue, 01 Dec 2009 08:33:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753426AbZLAHdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2009 02:33:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753402AbZLAHdO
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Dec 2009 02:33:14 -0500
Received: from mail1.space2u.com ([62.20.1.135]:56570 "EHLO mail1.space2u.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752936AbZLAHdO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2009 02:33:14 -0500
Received: from mail-bw0-f227.google.com (mail-bw0-f227.google.com [209.85.218.227])
	(authenticated bits=0)
	by mail1.space2u.com (8.14.3/8.14.3) with ESMTP id nB17XDMs014246
	(version=TLSv1/SSLv3 cipher=DES-CBC3-SHA bits=168 verify=NOT)
	for <git@vger.kernel.org>; Tue, 1 Dec 2009 08:33:13 +0100
Received: by bwz27 with SMTP id 27so3190913bwz.21
        for <git@vger.kernel.org>; Mon, 30 Nov 2009 23:33:19 -0800 (PST)
Received: by 10.204.3.220 with SMTP id 28mr175741bko.4.1259652799724; Mon, 30 
	Nov 2009 23:33:19 -0800 (PST)
In-Reply-To: <20091201000048.GL12733@ldl.fc.hp.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134169>

On Tue, Dec 1, 2009 at 1:00 AM, Alex Chiang <achiang@hp.com> wrote:

> * Karl Wiberg <kha@treskal.com>:
>
> > try:
> >     try:
> >         cmd.append(path)
> >         call(cmd)
> >     except Exception, e:
> >         raise CmdException(str(e))
> > finally:
> >     os.unlink(path)
> >
> > (The combined try...except...finally statement didn't appear until
> > python 2.5, but we'd like to stay compatible with 2.4.)
>
> This statement confuses me a bit. The way I read it, I shouldn't use
> your suggestion due to compat reasons?

Oh. No, the "combined" statement would look like this:

try:
    cmd.append(path)
    call(cmd)
except Exception, e:
    raise CmdException(str(e))
finally:
    os.unlink(path)

It works exactly like the nested try...finally and try...except
statement above, but results in less indentation---and would thus be
preferred, if not for the 2.4 compatibility issue.

-- 
Karl Wiberg, kha@treskal.com
   subrabbit.wordpress.com
   www.treskal.com/kalle
