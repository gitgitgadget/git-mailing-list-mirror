From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 2/3] pretty: make %H/%h dependent on
 --abbrev[-commit]
Date: Mon, 26 Apr 2010 04:53:29 -0500
Message-ID: <20100426095206.GA31483@progeny.tock>
References: <1272232579-18895-1-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-2-git-send-email-wmpalmer@gmail.com>
 <1272232579-18895-3-git-send-email-wmpalmer@gmail.com>
 <20100426031012.GA29953@progeny.tock>
 <u2i5b9751661004260047n168ad87bx6083fc201bfb21d9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, gitster@pobox.com, peff@peff.net,
	Thomas Rast <trast@student.ethz.ch>,
	=?iso-8859-1?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Will Palmer <wmpalmer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 26 11:52:51 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O6Kze-0002uD-II
	for gcvg-git-2@lo.gmane.org; Mon, 26 Apr 2010 11:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752902Ab0DZJwk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Apr 2010 05:52:40 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:49010 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab0DZJwj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Apr 2010 05:52:39 -0400
Received: by pxi17 with SMTP id 17so1508680pxi.19
        for <git@vger.kernel.org>; Mon, 26 Apr 2010 02:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TjrugKe97719Hqn8YQp5imeuOhsE9eMt7i9xumKqmFs=;
        b=iGIp8vh/0a/jX8bQqR9ncdghNibUilbuMBvrdvM9W9oVwVsibXiFQSezJsT8pwpn+J
         SZenwHDmR3Z961eDnZF9jhPTMQRJTGbUCk4HV4uDi24nTUpA4bxZziNY2qSP0fwURemG
         TCmMbd+Uq4k62KhPJExaNs/00KCu0Dff2rphc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=kV9AihjxujPKkKY/lDaPoZVGSjLkQy26N1QvOByNQooTy65vWnD6J0g+sgFk7VRGQj
         yMWowPR4aDhZTLubSnSvcivxPLVSyUFA1erArWF3j7iwqHnIa9QOvOaGF09BiA8qLGIv
         cz8Gi3HEP81axomnkUsFJEl5ATg+rnIbY4TqY=
Received: by 10.114.87.17 with SMTP id k17mr3730187wab.215.1272275558540;
        Mon, 26 Apr 2010 02:52:38 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 23sm3013561iwn.2.2010.04.26.02.52.37
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 26 Apr 2010 02:52:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <u2i5b9751661004260047n168ad87bx6083fc201bfb21d9@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/145801>

Will Palmer wrote:
> Jonathan Nieder wrote:

>> Shortlog doesn=E2=80=99t print commit hashes, does it?
>
> Shortlog accepts --format, though this doesn't seem to be documented
> (if I type "man" and search
> for "format"), so perhaps it should be.

Oh, neat!  Maybe this would save you the trouble.

Jonathan Nieder (3):
  t4201 (shortlog): guard setup with test_expect_success
  t4201 (shortlog): Test output format with multiple authors
  shortlog: Document and test --format option

Will Palmer (1):
  pretty: Respect --abbrev option

 Documentation/git-shortlog.txt |    8 +++
 builtin/shortlog.c             |    3 +-
 pretty.c                       |    7 ++-
 shortlog.h                     |    1 +
 t/t4201-shortlog.sh            |  116 +++++++++++++++++++++++++++++++-=
-------
 t/t6006-rev-list-format.sh     |   19 +++++++
 6 files changed, 126 insertions(+), 28 deletions(-)
