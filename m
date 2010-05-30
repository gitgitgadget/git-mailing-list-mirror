From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC v2 6/6] gettext: Add a skeleton po/is.po
Date: Sun, 30 May 2010 16:29:12 -0500
Message-ID: <20100530212912.GA422@progeny.tock>
References: <1275173125-21010-1-git-send-email-avarab@gmail.com>
 <1275252857-21593-7-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff Epler <jepler@unpythonic.net>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 30 23:28:44 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIq3h-00030f-Er
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 23:28:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754948Ab0E3V2c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 30 May 2010 17:28:32 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43564 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754741Ab0E3V2c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 May 2010 17:28:32 -0400
Received: by iwn6 with SMTP id 6so373223iwn.19
        for <git@vger.kernel.org>; Sun, 30 May 2010 14:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=mrnX489YRKU+n7ireBCICmtqxSRrzn59yaPw8uWazsY=;
        b=fzblgWMmg6w82ZMuM/ytJ4jJf+Hf7ko0qyGyGRkcBzsgz3dhzwU6WCWrbwGPHdy8Ip
         ndaDLA41u2vBDxTurciXGLedh8Z+NdKyQA21vjDp1MVOZE5XNZjAYXog1SHulxumCZDt
         ZFOtl7SxOsU3AOaRp2JBlYpjEF0bIxoDC7dus=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=mmwwFxuxqW3XHUcWqXW71JpoR0wX9NyTZVsIcHXSR7SLvDnX0iS1j7xMBtmrATiL1s
         V+eRh9EO2ZPPTxzH31jmLPSI65ju4oq7Ty1isgPxTEWb+YMUdOOatOt6zSHO+7iBkS7H
         qIObqR5MFGwTkNfau/lwkHf/0u5g+X/qi1yww=
Received: by 10.231.194.196 with SMTP id dz4mr4576133ibb.66.1275254911342;
        Sun, 30 May 2010 14:28:31 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id b3sm22888834ibf.1.2010.05.30.14.28.29
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 30 May 2010 14:28:30 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1275252857-21593-7-git-send-email-avarab@gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148024>

Hi =C6var,

=C6var Arnfj=F6r=F0 Bjarmason wrote:

> +#: wt-status.c:53
> +msgid "# Unmerged paths:"
> +msgstr ""

On projects that use gettext, merging these line number changes can
be a royal pain.  In effect, the .po files are mixing semantically
meaningful text and automatically generated cruft.

So my ignorant questions:

 . does gettext use the #: comments for anything important?
 . can they be suppressed when generating the .po file?
 . can they be easily re-added if some translation front-end needs
   them?

> +#: git-pull.sh:124
> +msgid "Fetching tags only, you probably meant:"
> +msgstr ""

I noticed there are no printf formats among the shell scripting
examples.  Would we have to roll our own, like this?

  gettext 'You asked me to pull without telling me which branch you
want to OP_TYPE OP_PREP, and 'branch.CURR_BRANCH.merge' in
your configuration file does not tell me, either. Please
try again (e.g., 'git pull <repository> <refspec>').
See git-pull(1) for details.
' |
  sed "
	s/OP_TYPE/$op_type/g
	s/OP_PREP/$op_prep/g
	s/CURR_BRANCH/$curr_branch/g
  "

Jonathan
