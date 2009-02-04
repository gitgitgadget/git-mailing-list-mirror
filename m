From: Aristotle Pagaltzis <pagaltzis@gmx.de>
Subject: Re: Support various HTTP authentication methods
Date: Wed, 4 Feb 2009 19:51:09 +0100
Message-ID: <20090204185109.GA31250@klangraum.plasmasturm.org>
References: <1233556274-1354-1-git-send-email-gitster@pobox.com> <1233556274-1354-2-git-send-email-gitster@pobox.com> <1233556274-1354-3-git-send-email-gitster@pobox.com> <1233556274-1354-4-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 04 19:53:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUmrw-0002I8-Kx
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 19:53:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761886AbZBDSvf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 4 Feb 2009 13:51:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761883AbZBDSvd
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 13:51:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:41163 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761865AbZBDSvc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 13:51:32 -0500
Received: (qmail invoked by alias); 04 Feb 2009 18:51:25 -0000
Received: from static-87-79-236-202.netcologne.de (EHLO klangraum) [87.79.236.202]
  by mail.gmx.net (mp001) with SMTP; 04 Feb 2009 19:51:25 +0100
X-Authenticated: #163624
X-Provags-ID: V01U2FsdGVkX18uaCd+MC0ulEE/MFF9ZlYibu0W6PC8JPDhlAKR6T
	w71NIu7CcKzKaH
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1233556274-1354-4-git-send-email-gitster@pobox.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108410>

* Junio C Hamano <gitster@pobox.com> [2009-02-02 07:35]:
> This patch allows users to specify the authentication method if
> supported by CURL, adding a couple of new settings and
> environment variables listed below (the names within the
> parentheses indicate the environment variables.)

I tried this patch against my Apache WebDAV server for which I
use Digest auth, but it didn=E2=80=99t get very far:

    Initialized empty Git repository in /tmp/xxxxxxx/.git/
    error: Couldn't get http://xxx:xxx@example.org:8086/xxxxxxx.git/HEA=
D for HEAD
    The requested URL returned error: 400
    Getting alternates list for http://xxx:xxx@example.org:8086/xxxxxxx=
=2Egit
    Getting pack list for http://xxx:xxx@example.org:8086/xxxxxxx.git
    Getting index for pack a9bed5817173acdf0a2dc86ddaf36c4f0c7f9ea3
    error: Unable to get pack index http://xxx:xxx@example.org:8086/xxx=
xxxx.git/objects/pack/pack-a9bed5817173acdf0a2dc86ddaf36c4f0c7f9ea3.idx
    The requested URL returned error: 400
    error: Unable to find 7ec6910c4d1733d575f955063fd52b2b0ae7ca5b unde=
r http://xxx:xxx@example.org:8086/xxxxxxx.git
    Cannot obtain needed object 7ec6910c4d1733d575f955063fd52b2b0ae7ca5=
b
    fatal: Fetch failed.

The server error log contained the following lines:

    [Wed Feb 04 19:49:14 2009] [error] [client 192.168.1.1] Digest: uri=
 mismatch - </xxxxxxx.git/info/refs> does not match request-uri </xxxxx=
xx.git/HEAD>
    [Wed Feb 04 19:49:15 2009] [error] [client 192.168.1.1] Digest: uri=
 mismatch - </xxxxxxx.git/objects/info/packs> does not match request-ur=
i </xxxxxxx.git/objects/pack/pack-a9bed5817173acdf0a2dc86ddaf36c4f0c7f9=
ea3.idx>

Does that have to do with something being missing in the Digest
support or is that operator error? If the latter, what might be
the culprit =E2=80=93 how do I diagnose it?

Regards,
--=20
Aristotle Pagaltzis // <http://plasmasturm.org/>
