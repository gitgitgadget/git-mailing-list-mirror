From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v4 31/45] rebase: trivial cleanup
Date: Sun, 9 Jun 2013 21:15:18 +0200
Message-ID: <20130609191518.GB12122@paksenarrion.iveqy.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
 <1370796057-25312-32-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	iveqy@iveqy.com
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 09 21:12:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ull2h-0003f7-PO
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:12:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765Ab3FITMj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 15:12:39 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:37645 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751090Ab3FITMi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:12:38 -0400
Received: by mail-la0-f41.google.com with SMTP id fn20so5141495lab.28
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=w6LbooNrWkBJjTOK//kBbDd5RAQl7WQcotlQe58KQUA=;
        b=0ey9te2DmMDn894ELFvTraDyKdETFUP9lsJ9rp7eRuSNPGg90zVC2TECQoH7/2DucZ
         6wS3QT2UQjN2K9c3P+FEbsOLRHeMaDlH007ztCeVvtEPhbIN/Ef9Fs/1OGw6DIYGLzdY
         cdJvQLKBo3ZWLuz33H6QlgeCqdPH5XcD8cNZuVLHWGhmlCRyTrlpIOipEGpTnN5U8aH4
         4N3p711I3TupFdzPd+r18kz/gDrdUFTstQhJ8VLgEWmNJZ7Q1y6jJy9GJ8EubWBu0/NG
         jF+v01jSx67SUig/3K2/4zC/fpmXNZAHsmG83LitLUHdUOBSBZaz77OiVDS8oi357fku
         WWTQ==
X-Received: by 10.152.19.65 with SMTP id c1mr3561275lae.24.1370805157499;
        Sun, 09 Jun 2013 12:12:37 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id zo6sm4451937lbb.9.2013.06.09.12.12.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:12:36 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1Ull5C-0003EF-Vs; Sun, 09 Jun 2013 21:15:19 +0200
Content-Disposition: inline
In-Reply-To: <1370796057-25312-32-git-send-email-felipe.contreras@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227103>

On Sun, Jun 09, 2013 at 11:40:43AM -0500, Felipe Contreras wrote:
> -		git_am_opt=3D"$git_am_opt -q"

This one makes me wonder a bit. I'm not sure about how this works in
git, so I would appriciate if someone can explain. I might also have
misunderstood something.

Here we have two sh-scripts (git rebase
and git am) interacting witch eachother. Both uses GIT_QUIET, so if
GIT_QUIET already is set by the caller (git rebase) the callee doesn't
have to set it to.

However GIT_QUIET is undocumented for git-am (in Git Manual). If we
translate git am to C/ruby/python/perl/etc. will we catch this?

This raises a few more generall questions:
do we already pass information between processes(!) with enviroment
variables? And is this documented the way it should be?

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
