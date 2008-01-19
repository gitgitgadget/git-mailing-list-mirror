From: Harvey Harrison <harvey.harrison@gmail.com>
Subject: Re: [PATCH] Let "git svn" run "git gc --auto" occasionally
Date: Sat, 19 Jan 2008 14:50:50 -0800
Message-ID: <1200783050.5724.196.camel@brick>
References: <20080119123557.GA30778@diana.vm.bytemark.co.uk>
	 <20080119223249.8227.31460.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org,
	Kevin Ballard <kevin@sb.org>,
	Junio C Hamano <gitster@pobox.com>
To: Karl =?ISO-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Sat Jan 19 23:51:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGMX4-00085X-M0
	for gcvg-git-2@gmane.org; Sat, 19 Jan 2008 23:51:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751809AbYASWuy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Jan 2008 17:50:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751785AbYASWux
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 17:50:53 -0500
Received: from rv-out-0910.google.com ([209.85.198.184]:3699 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbYASWux (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 17:50:53 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1302483rvb.1
        for <git@vger.kernel.org>; Sat, 19 Jan 2008 14:50:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        bh=xidGWTTqLyWxkvd3uuFVoHHzNiWJc6edzzmzQloWRDU=;
        b=Z9TOQYNYX8QObNvRdwYyHFSPkcIvb19htu4mVShOLn1kvwPSxHxIW5/ox24zOmXHbwP8tvZoU03h9Oh8a6gWYKwCjSnyrqN0bUMiYf/GwxhixHA6KguXXGVneb5yGo4NeLgMp5Y7vSId1GietsnYYxaAguOj3F8wVMfj5osGduw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:cc:in-reply-to:references:content-type:date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=udHPlXDJ0m8dsSHTK5RrJ/MgETRjGyhqzUt5mASM8aIB//B7cFLG3gAeiyrEviLmBOMK9DxHtU2D+ypejf4T44G5hYWKbeA+T0E7aTXGFFJUemDoPOBreUjrZ0KQNZ6gwjvXKvlu8FaJh3G7iNZrlUpYzd3zlwRNNM1i0dr/Nh0=
Received: by 10.140.133.10 with SMTP id g10mr3446071rvd.170.1200783050018;
        Sat, 19 Jan 2008 14:50:50 -0800 (PST)
Received: from ?192.168.1.100? ( [216.19.190.48])
        by mx.google.com with ESMTPS id g6sm4022136rvb.25.2008.01.19.14.50.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 19 Jan 2008 14:50:49 -0800 (PST)
In-Reply-To: <20080119223249.8227.31460.stgit@yoghurt>
X-Mailer: Evolution 2.12.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71135>

On Sat, 2008-01-19 at 23:36 +0100, Karl Hasselstr=C3=B6m wrote:
> Let "git svn" run "git gc --auto" every 100 imported commits, to
> reduce the number of loose objects.

I found 100 was a bit too low when doing some large repos, I've
been using 1000.  I'd argue that --repack=3D1000 should be done by
default.

> I'm not quite sure how this should interact with the --repack flag.
> Right now they just coexist, except for never running right after one
> another, but conceivably we should do something cleverer. Eric?
>=20

How about git gc always gets run at the very end of a git svn fetch?

Just a thought.

Harvey
