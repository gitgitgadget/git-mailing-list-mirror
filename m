From: =?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
Subject: Re: gitweb: in-page errors don't work with mod_perl
Date: Mon, 28 Nov 2011 21:13:28 +0100
Message-ID: <CAKD0Uuws=zU+Pg8afn91mm0t4Rp_GNF++dTYnjA9okndyR=cXQ@mail.gmail.com>
References: <CAKD0UuweWoY5ObXgyN9vrOXWrKdNYWuG7CGB0V7HvcuiwRJD+A@mail.gmail.com>
 <201111280138.02511.jnareb@gmail.com> <CAKD0UuyDUPJFkpWbj2qFYsnii+6WoABnokhhhx4PysPW0FX2sA@mail.gmail.com>
 <201111281754.59205.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 21:13:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV7aN-0004un-Sv
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 21:13:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786Ab1K1UNv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Nov 2011 15:13:51 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:56650 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754112Ab1K1UNu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2011 15:13:50 -0500
Received: by eaak14 with SMTP id k14so2205783eaa.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 12:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mccHZ4giVtr/96TWlP4yw96PgF0SyF0pLPaOaucaVto=;
        b=OI5mfVtDsWoHvB/Nlm4X5BZ9YUrSox8yui4FGGq8vyNwNDHjucxEEPuPZN0jq0zlol
         o1MVxQHU6gn+jkQ8axjJ0Nya0zXQFz+FohPkzE6Jpn0JpDACPpoQt8YSXXuvTZL3fxhA
         tlaMndFNpv1ndOjiLUyIrgMSRlJ1AYeLKZuWQ=
Received: by 10.180.24.65 with SMTP id s1mr46158929wif.59.1322511229079; Mon,
 28 Nov 2011 12:13:49 -0800 (PST)
Received: by 10.180.87.37 with HTTP; Mon, 28 Nov 2011 12:13:28 -0800 (PST)
In-Reply-To: <201111281754.59205.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186033>

On Mon, Nov 28, 2011 at 17:54, Jakub Narebski <jnareb@gmail.com> wrote:
 [...]
>
> The configuration is very similar. =C2=A0Perhaps that is the differen=
ce between
> Apache 2.0.x (mine) and Apache 2.2.x (yours).
>
> Does adding `$r->err_headers_out();` before `$r->status(200);` helps?
> I'm grasping at straws here. =C2=A0mod_perl documentation is not very=
 helpful.

Doesn't help unfortunately.  It's hard to find any information about
this on the net (except for your comment on stackoverflow :).

The only way to get mod_perl to return a custom error message with
correct status code I've found so far is $r->custom_response($status,
$msg).  Unfortunately mod_perl then ignores header I set, e.g.
content-type.


Juergen
