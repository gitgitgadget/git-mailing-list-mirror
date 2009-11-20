From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: [ANNOUNCE] tig-0.15
Date: Fri, 20 Nov 2009 10:55:43 -0500
Message-ID: <2c6b72b30911200755l16b306cey16efb42fe9ba27da@mail.gmail.com>
References: <20091120133117.GA26917@diku.dk> <20091120135004.GA3919@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 16:56:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBVqD-0005ka-HN
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 16:56:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753258AbZKTPz6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Nov 2009 10:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753172AbZKTPz5
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 10:55:57 -0500
Received: from mail-iw0-f178.google.com ([209.85.223.178]:42329 "EHLO
	mail-iw0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752999AbZKTPz5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Nov 2009 10:55:57 -0500
Received: by iwn8 with SMTP id 8so2623223iwn.33
        for <git@vger.kernel.org>; Fri, 20 Nov 2009 07:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=jY96ryWzROLrlkWImdLDw75ZwFGhsyaFbBW5kCdxyjU=;
        b=KGyvk/f5enp/cVImvGwOpip4SsvzfVf4qOiIk7MjXhyLjwQyZpniwFigImdyM7UuRC
         ETEFT0LdTtCAX74/8Xs8PWyrgIlQHtvKJsraQ+xttLYFxdVS4rlKrS3y4PwnhIUNQ5II
         uIuZn4dYkxRNcFLQXAX6YyioXYxRFjWhIWzYQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=A6/2ZTIctlP45tahu+Yhvxj/HRBosi5E/4+JIucjb3ag0I63A0MpUmVGN00MWdgK+t
         ac86silHX9ZTDf4xR0siGPSeTuwnn1Xbw8SNxNdEFInusw4S6GEq2YkcA5OJln+e4nlq
         vPfD+h2r6l0lzAOT2HHv9MuOsFIfh9xzoZ5ps=
Received: by 10.231.125.13 with SMTP id w13mr720880ibr.32.1258732563099; Fri, 
	20 Nov 2009 07:56:03 -0800 (PST)
In-Reply-To: <20091120135004.GA3919@debian.b2j>
X-Google-Sender-Auth: d657c7ca45d781ba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133352>

On Fri, Nov 20, 2009 at 08:50, bill lam <cbill.lam@gmail.com> wrote:
> On Fri, 20 Nov 2009, Jonas Fonseca wrote:
>> =C2=A0 =C2=A0 =C2=A0 Build with asciidoc-8.4.5
> ..
>> =C2=A0 =C2=A0 =C2=A0 Update asciidoc table syntax to the one support=
ed by version 8.4.4
>
> sciidoc -aversion=3D0.15-dirty -asysconfdir=3D/usr/etc -b docbook -d =
manpage tigmanual.7.txt
> FAILED: /home/bill/src/tig/manual.txt: line 314: illegal [paradef-def=
ault] options: header: header
> make: *** [tigmanual.7.xml] Error 1
>
> May be the asciidoc 8.2.7 in debian lenny is not new enough. make ins=
tall-doc
> failed with the above message. =C2=A0Any workaround other than upgrad=
ing asciidoc ?

No, not if you want to build the man pages yourself.

How about adding a script or a make rule to optionally install man
pages from the release branch. For example:

install-release-doc-man:
       for doc in $(MANDOC); do \
               git checkout origin/release $$doc; \
       done
       $(MAKE) install-doc-man

--=20
Jonas Fonseca
