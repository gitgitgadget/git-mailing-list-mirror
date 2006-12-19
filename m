X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] gitweb: Show '...' links in "summary" view only if there are more items
Date: Tue, 19 Dec 2006 13:42:44 +0100
Message-ID: <200612191342.46220.jnareb@gmail.com>
References: <20061218224327.GG16029@localhost> <20061219120854.GA16429@localhost> <200612191328.08928.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Tue, 19 Dec 2006 12:41:09 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=VQINKvZGy3pmXpLb7fFeBUU451CRsbECSIuATshkMF4oaxcJNnFDqWPx3Iq9GPQh0+xN5tibk+egZD5UtsZvmIjRdUtRuXjIKu1J0K8ESzJ0ffDO2xpwu4ZofslI4MuL1opaTTOgV4CMLwo/QozkY0V/U9K8uLk6J8dNmamHpYU=
User-Agent: KMail/1.9.3
In-Reply-To: <200612191328.08928.jnareb@gmail.com>
Content-Disposition: inline
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34828>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GweH1-0004PW-TN for gcvg-git@gmane.org; Tue, 19 Dec
 2006 13:40:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932815AbWLSMko convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006 07:40:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932817AbWLSMkn
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 07:40:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.170]:33967 "EHLO
 ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S932815AbWLSMkn (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec
 2006 07:40:43 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1806762uga for
 <git@vger.kernel.org>; Tue, 19 Dec 2006 04:40:41 -0800 (PST)
Received: by 10.66.219.11 with SMTP id r11mr8455384ugg.1166532041419; Tue, 19
 Dec 2006 04:40:41 -0800 (PST)
Received: from host-81-190-25-107.torun.mm.pl ( [81.190.25.107]) by
 mx.google.com with ESMTP id x33sm9083654ugc.2006.12.19.04.40.29; Tue, 19 Dec
 2006 04:40:40 -0800 (PST)
To: Robert Fitzsimons <robfitz@273k.net>
Sender: git-owner@vger.kernel.org


>> @@ -2876,8 +2879,8 @@ sub git_summary {
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0}
>> =A0=A0=A0=A0=A0=A0=A0=A0}
>> =A0
>> -=A0=A0=A0=A0=A0=A0=A0open my $fd, "-|", git_cmd(), "rev-list", "--m=
ax-count=3D17",
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0git_get_head_hash($pro=
ject), "--"
>> +=A0=A0=A0=A0=A0=A0=A0open my $fd, "-|", git_cmd(), "rev-list", "--m=
ax-count=3D16",
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0$head, "--"
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0or die_error(undef, =
"Open git-rev-list failed");
>> =A0=A0=A0=A0=A0=A0=A0=A0my @revlist =3D map { chomp; $_ } <$fd>;
>> =A0=A0=A0=A0=A0=A0=A0=A0close $fd;
>=20
> and if we remove that chunk, then your earlier patch would not
> touch git_summary at all, so mine would cleanly apply (I think).

Sorry, I haven't noticed git_get_head_hash($project) -> $head
Sorry for the noise.
--=20
Jakub Narebski
