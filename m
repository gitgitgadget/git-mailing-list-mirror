From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5/RFC 1/6] Documentation: Preparation for gitweb manpages
Date: Tue, 11 Oct 2011 17:39:49 +0200
Message-ID: <201110111739.49967.jnareb@gmail.com>
References: <1318098723-12813-1-git-send-email-jnareb@gmail.com> <201110102352.25456.jnareb@gmail.com> <7v62jwjvdk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Drew Northup <drew.northup@maine.edu>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 11 17:39:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDeQq-0000qb-0o
	for gcvg-git-2@lo.gmane.org; Tue, 11 Oct 2011 17:39:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754940Ab1JKPjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Oct 2011 11:39:48 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:40262 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754886Ab1JKPjs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Oct 2011 11:39:48 -0400
Received: by gyg10 with SMTP id 10so6644325gyg.19
        for <git@vger.kernel.org>; Tue, 11 Oct 2011 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=mTWlIbvCnCO+5/natavBXNH8pUJvt/Y4NFU0r8KgydQ=;
        b=GQ45vzm7zqtDQVnT5qYn/mKn+8xGqdwQJgsIvMrnVRWRW3j4iaMyOa7GsZpnWEa4Qh
         sid9aWsijEmKpm2WFaDyFXb22P9gjHXSTaqwxyX23F1JxK6C2pJH5TF+NsHFQD0Oyvxa
         FTuVXwzkkwNoeUV2mF9cgd3RJYBU+mLo+IrG4=
Received: by 10.223.1.131 with SMTP id 3mr41430062faf.30.1318347587216;
        Tue, 11 Oct 2011 08:39:47 -0700 (PDT)
Received: from [192.168.1.13] (abwh114.neoplus.adsl.tpnet.pl. [83.8.231.114])
        by mx.google.com with ESMTPS id n1sm38098060fad.20.2011.10.11.08.39.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 11 Oct 2011 08:39:45 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <7v62jwjvdk.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183299>

On Tue, 11 Oct 2011, Junio C Hamano wrote:

> I probably do not have time to look into this, but just FYI my trial merge
> to 'pu' of this topic is failing like this:
> 
> asciidoc: ERROR: gitweb.conf.txt: line 484: illegal style name: Default: ()
> asciidoc: ERROR: gitweb.conf.txt: line 494: illegal style name: Default: 300

Damn, I thought I have fixed that.  This probably depends on AsciiDoc
version ("make doc" on 'master' generates a few _warnings_ for me related
to similar situation), but the problem is with

  [Default: <value>]

that was copied from gitweb/README.  But [<sth>] is an attribute list
(style name in simplest form), used more often in newer AsciiDoc.

So either we have to escape '[' and ']', i.e. use {startsb} and {endsb},
which would reduce human-friendliness, or move to different way of marking
default values, e.g. _italic_.

What do you think?
-- 
Jakub Narebski
Poland
