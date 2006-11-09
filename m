X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: protect blob and diff output lines from controls.
Date: Thu, 9 Nov 2006 10:34:41 +0100
Message-ID: <200611091034.42190.jnareb@gmail.com>
References: <7vpsbxqzre.fsf@assigned-by-dhcp.cox.net> <200611090146.25306.jnareb@gmail.com> <7vwt65pgqs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Thu, 9 Nov 2006 09:34:01 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=n2T+iFRsgP7gTZjQ7XRMzUWUhNYaIkNX4gwG7mSda9KDv201la2T6H96a+u+v+olADDXhVDtYv3tYeXltN5Vtgmq0bC803aAMNNGEMmdae7UxggN9j/Jp+rUpx6BiLGBdE53Znfx7Gi9DqC3tyP/UUEGZouMN5YWd4JGLpSbK9k=
User-Agent: KMail/1.9.3
In-Reply-To: <7vwt65pgqs.fsf@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31185>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gi6II-0002uq-Ct for gcvg-git@gmane.org; Thu, 09 Nov
 2006 10:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754812AbWKIJdy convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Thu, 9 Nov 2006 04:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754813AbWKIJdy
 (ORCPT <rfc822;git-outgoing>); Thu, 9 Nov 2006 04:33:54 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:54873 "EHLO
 ug-out-1314.google.com") by vger.kernel.org with ESMTP id S1754812AbWKIJdx
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 9 Nov 2006 04:33:53 -0500
Received: by ug-out-1314.google.com with SMTP id m3so163362ugc for
 <git@vger.kernel.org>; Thu, 09 Nov 2006 01:33:52 -0800 (PST)
Received: by 10.67.100.17 with SMTP id c17mr1010667ugm.1163064830152; Thu, 09
 Nov 2006 01:33:50 -0800 (PST)
Received: from host-81-190-24-209.torun.mm.pl ( [81.190.24.209]) by
 mx.google.com with ESMTP id w40sm555899ugc.2006.11.09.01.33.49; Thu, 09 Nov
 2006 01:33:50 -0800 (PST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Dnia czwartek 9. listopada 2006 02:10, Junio C Hamano napisa=B3:
> Jakub Narebski <jnareb@gmail.com> writes:

>> Well, the pathname has the limit that it must be in single line
>> after quoting. The "blob" output is multipage.
>=20
> I honestly have _no_ idea what distincition you are seeing
> here.  Both blob and diff output are processed one line at a
> time and its result would be on a single line too.

I was thinking about _conceptual_ difference, not technical.
(Perhaps I should make it more clear.)=20

Pathname is item (or part of item in the case of page_path)
which is contained (and must be contained) in single line.
It is also expected (although if we follow this expectation
is up to us) that the pathname would quote special characters
similarly to how shell/operating system quotes pathnames
(e.g. in ls output).

"Blob" output on the other hand ("blob" view and patch part of
"blobdiff" and "commitdiff" views) is [a part of] larger, multiline
whole. One could also expect that special characters would be
quoted like editor quotes special characters. (Of course question
is: which editor?)

This of course is complicate by single line output like subject
or authorship, or signoff, which is not pathname.


All this discussion shows that gitweb quoting is more complicated
that I thought.
--=20
Jakub Narebski
