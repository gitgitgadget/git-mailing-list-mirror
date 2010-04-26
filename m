From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/3] pretty: format aliases
Date: Mon, 26 Apr 2010 12:57:08 -0500
Message-ID: <20100426175707.GB11022@progeny.tock>
References: <1272210175-20484-1-git-send-email-wmpalmer@gmail.com>
 <20100425194800.GB14736@coredump.intra.peff.net>
 <20100425220955.GA25620@progeny.tock>
 <20100426172235.GA626@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Will Palmer <wmpalmer@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, Cheng Renquan <crquan@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Apr 26 19:56:40 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6SXr-0004dH-SQ
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 19:56:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753625Ab0DZR41 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 13:56:27 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:38849 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753347Ab0DZR40 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 13:56:26 -0400
Received: by pwj9 with SMTP id 9so8593346pwj.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 10:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=u3ZOg+qgQ19iMyHPzedGcQ5Fj5NSbYtjFDSyULpnXJ8=;
        b=liGNRCZUjnBkBh4/w4da8K7xZV/1wcRMph86xG/v2qYUUV10/8tpHSOJIUpYR0bsw1
         HSiv8mT7ToCX++he1/gXofqmmT+JbBFJ4sv2Xo5Ic/lELVA3+wgdNKIFeHM95M5wqWg9
         lDQIDhTAKdMzPAXNrAzTGiYfwR2h8k3HkHRc4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=vhDHsTujd5XSslxDLa5cSCpp1Gw4dIPyPSMVGF8QZe7dVZPcbDh/Ym/cwD5ldSuUd7
         1eqhtTEUooDlNJeUhmpQ8cG0w8CaKd+MBz0aYfnNYTMoc5MquF46qt6LRle26LgddzJ8
         FQhhMe6Do4ZcBPPu93dS8GLtcbV6Trl+yMLlk=
Received: by 10.142.67.26 with SMTP id p26mr2104011wfa.67.1272304585432;
        Mon, 26 Apr 2010 10:56:25 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm3281095iwn.11.2010.04.26.10.56.11
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 10:56:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100426172235.GA626@coredump.intra.peff.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145833>

Jeff King wrote:

> To be clear, I don't have any problem with the _functionality_. I jus=
t
> think it probably should have been log.pretty, or pretty.default or
> something. Too late now, though.

Ah, sorry to be dense.  Maybe something like the following would work:

 [log "format"]
	changelog =3D "* [%h] %s"

This is rev-list=E2=80=99s code, and log is its most noticeable manifes=
tation.

By the way: I just noticed today that rev-list is not very friendly
when given a --pretty=3Dformat: specification:

  $ git rev-list -1 --oneline HEAD
  651b91e log --format=3Demail: fix confusing variable name
  $ git rev-list -1 --format=3D'%h %s' HEAD
  commit 651b91ef7a15a46145d65193c8709670b969161f
  651b91e log --format=3Demail: fix confusing variable name

Is this deliberate?  I mention it because I seem to remember from the
discussion of --decorate configuration that scripts should be using
rev-list in preference to log even when a --format option is involved.

Jonathan
