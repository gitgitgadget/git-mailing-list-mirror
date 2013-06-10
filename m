From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] completion: remove ancient "ensure colon in
 COMP_WORDBREAKS" workaround
Date: Sun, 9 Jun 2013 17:09:54 -0700
Message-ID: <20130610000954.GA6464@elie.Belkin>
References: <1370822361-15637-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
X-From: git-owner@vger.kernel.org Mon Jun 10 02:10:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlpgZ-0008Gq-3V
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 02:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752599Ab3FJAKE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Jun 2013 20:10:04 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:63828 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752452Ab3FJAKD convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jun 2013 20:10:03 -0400
Received: by mail-pa0-f44.google.com with SMTP id lj1so798750pab.31
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 17:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LXShhtJyyCvWu/t7ZBGs9m+u8AFobETpMTqfae2uud8=;
        b=tCl3tu9NxGL8YP49xsmmbp1FsaYA+ufPn0YaQMD4TZFV9UgFhBF9ho+24SutTsT2J9
         suN7jJjC7NodRcf17OXkUEOMP6+aXhH5xDBw+OVa9Tjy5hPMij2pC9nfnx08jSRIELp5
         k0kUttWlQ8yTj2MBbEfzRVmEX0pHm3Qo348my+05s57NDYQcSyjzwjuttDtsFczEYvdK
         JWLd+4wVXDd5p/fy5C0EqfFgmowb5a9dNXIOHPzoVdSHAcaXsZBfo3MumNoTy0o+yhwt
         ULxvuOoe/B3O96rksBbuJ37zKISUi+WRagRkAYJ6v1QTcB/PLOGytii+iqOTllAVfnoZ
         svGw==
X-Received: by 10.68.190.196 with SMTP id gs4mr7605504pbc.189.1370823002420;
        Sun, 09 Jun 2013 17:10:02 -0700 (PDT)
Received: from elie.Belkin (c-107-3-135-164.hsd1.ca.comcast.net. [107.3.135.164])
        by mx.google.com with ESMTPSA id ig4sm8117809pbc.18.2013.06.09.17.10.00
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 17:10:01 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1370822361-15637-1-git-send-email-szeder@ira.uka.de>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227219>

SZEDER G=C3=A1bor wrote:

> Fedore 9 shipped the gvfs package with a buggy Bash completion script=
:
> it removed the ':' character from COMP_WORDBREAKS, thereby breaking
> certain features of git's completion script.  We worked this around i=
n
> db8a9ff0 (bash completion: Resolve git show ref:path<tab> losing ref:
> portion, 2008-07-15).
>
> The bug was fixed in Fedora 10 and Fedora 9 reached its EOL on
> 2009-07-10, almost four years ago.  It's about time to remove our
> workaround.

Nice!  I had wondered what that workaround was about but never
ended up digging into it.

Searching for COMP_WORDBREAKS in /etc/bash_completion.d/* finds
similar breakage (removal of '=3D' and '@') in the npm completion
script, but nothing involving colon.  So this looks like a good
change.

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
