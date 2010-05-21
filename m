From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH] perl shebangs: Use /usr/bin/env, not /usr/bin/perl
Date: Fri, 21 May 2010 15:22:14 +0000
Message-ID: <AANLkTinKPntmpqYXTADzivGic3HfeMEDm2f35N8Z7dMc@mail.gmail.com>
References: <1274453455-1941-1-git-send-email-avarab@gmail.com>
	 <1274454086-2312-1-git-send-email-avarab@gmail.com>
	 <A612847CFE53224C91B23E3A5B48BAC74483234EEB@xmail3.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
X-From: git-owner@vger.kernel.org Fri May 21 17:22:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFU3S-000694-7v
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 17:22:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933578Ab0EUPWR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 11:22:17 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57266 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933117Ab0EUPWP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 11:22:15 -0400
Received: by iwn6 with SMTP id 6so1277839iwn.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 08:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=rlDh2QulpTAoqiv5m9JBzuxFyaBrPRn+RKAt9s0ZBt4=;
        b=isMZOUkHugrSqKibjiRNEXK6L1sO4Fen5MqD2vwZcSpZRbuhjLmIzLTrc2rIk/C945
         eW1kR2ttCu03ZhxQITLe453CTf+INDmsRD3eihP2ibzlMiEN251OMZJTkdZDfG9tbpKP
         tYeALshUQT5+CTMxOjh2dyYOeYfLp8ngIN/UU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=JCZMPON2BBlwixqF8Ru4gwEQJPKaKKjW5yQzrEiXUZUOggyV9kO+547AaOjz/LW+qC
         g+3fCQxw4Y3hjnhJnwMS5cAIojErxvJrgC2CHn4347o9BW6Umn0sVdXJErE2jUBEIkpu
         OfJaPrcODb1mzJXdP9wWJIAqnBWbuRJUxTodM=
Received: by 10.231.147.18 with SMTP id j18mr1283937ibv.12.1274455334458; Fri, 
	21 May 2010 08:22:14 -0700 (PDT)
Received: by 10.231.171.145 with HTTP; Fri, 21 May 2010 08:22:14 -0700 (PDT)
In-Reply-To: <A612847CFE53224C91B23E3A5B48BAC74483234EEB@xmail3.se.axis.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147466>

On Fri, May 21, 2010 at 15:15, Peter Kjellerstedt
<peter.kjellerstedt@axis.com> wrote:
> This does not work. You cannot give arguments to an application
> started via /usr/bin/env; it will interprete everything after
> /usr/bin/env as the application name and fail with:

Doh'oh. You're right of course. I just tested it on the command-line
and by executing the scripts (Perl interprets the shebang itself):

    $ /usr/bin/env perl -w -le 'print $^W'
    1

However. Isn't Perl 5.6 the lowest version Git aspires to be
compatible with anyway? If that's the case they can just be changed to
'use warnings' across the board.
