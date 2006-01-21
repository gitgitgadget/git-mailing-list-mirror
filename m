From: sean <seanlkml@sympatico.ca>
Subject: Re: problem installing latest cogito
Date: Sat, 21 Jan 2006 14:49:01 -0500
Message-ID: <BAYC1-PASMTP061F43C7F760A9FB73B616AE1E0@CEZ.ICE>
References: <fof4t15q95qkakgk6b7fbfuqh3r6q7ei17@4ax.com>
	<20060121194826.GK28365@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: morgad@eclipse.co.uk, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 21 20:54:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0OoO-0008JS-2m
	for gcvg-git@gmane.org; Sat, 21 Jan 2006 20:54:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751204AbWAUTxz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jan 2006 14:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbWAUTxz
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jan 2006 14:53:55 -0500
Received: from bayc1-pasmtp06.bayc1.hotmail.com ([65.54.191.166]:39836 "EHLO
	BAYC1-PASMTP06.CEZ.ICE") by vger.kernel.org with ESMTP
	id S1751205AbWAUTxy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jan 2006 14:53:54 -0500
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Received: from linux1.attic.local ([69.156.6.171]) by BAYC1-PASMTP06.CEZ.ICE over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Sat, 21 Jan 2006 11:54:38 -0800
Received: from guru.attic.local (guru.attic.local [10.10.10.28])
	by linux1.attic.local (Postfix) with ESMTP id 07CE8644C23;
	Sat, 21 Jan 2006 14:53:53 -0500 (EST)
To: Petr Baudis <pasky@suse.cz>
Message-Id: <20060121144901.33b03395.seanlkml@sympatico.ca>
In-Reply-To: <20060121194826.GK28365@pasky.or.cz>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; i386-redhat-linux-gnu)
X-OriginalArrivalTime: 21 Jan 2006 19:54:38.0281 (UTC) FILETIME=[82C1F390:01C61EC4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 21 Jan 2006 20:48:26 +0100
Petr Baudis <pasky@suse.cz> wrote:

> >                 sed -e
> > 's/\${COGITO_LIB}/\${COGITO_LIB:-\/home\/david\/lib\/cogito\/}/g; \
> > 
> > s/\${COGITO_SHARE}/\${COGITO_SHARE:-\/home\/david\/share\/cogito\/}/g'
> > \
> >                        $file > $file.new; \
> >                 cat $file.new > $file; rm $file.new; \
> >         done
> > sed: -e expression #1, char 145: unterminated address regex

The problem seems to go away if you remove the quoted end-of-line:

sed -e 's/\${COGITO_LIB}/\${COGITO_LIB:-\/home\/david\/lib\/cogito\/}/g;
        s/\${COGITO_SHARE}/\${COGITO_SHARE:-\/home\/david\/share\/cogito\/}/g'


where the following, doesn't:

sed -e 's/\${COGITO_LIB}/\${COGITO_LIB:-\/home\/david\/lib\/cogito\/}/g; \
        s/\${COGITO_SHARE}/\${COGITO_SHARE:-\/home\/david\/share\/cogito\/}/g'

Sean
