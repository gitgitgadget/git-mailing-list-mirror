From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git-subtree: directory mismatch
Date: Wed, 25 Nov 2009 18:45:22 -0500
Message-ID: <32541b130911251545x212cc55el9f8d4bc44eadd45b@mail.gmail.com>
References: <20091124195353.GA16627@lonquimay.wrk.lsn.camptocamp.com> 
	<32541b130911241348s21e21fb8n12edf374e6a3c309@mail.gmail.com> 
	<20091125080812.6117@nanako3.lavabit.com> <32541b130911251028h6db240d5yd171fa4941ef14ba@mail.gmail.com> 
	<7v7htexuxc.fsf@alter.siamese.dyndns.org> <32541b130911251148v70a5dc77k9936881d0b382ec2@mail.gmail.com> 
	<7vpr76uzju.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0911260013550.4985@pacific.mpi-cbg.de> 
	<32541b130911251520l7a84554bxab9cf59ff9d8fc1@mail.gmail.com> 
	<20091125234122.GA31422@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Nanako Shiraishi <nanako3@lavabit.com>,
	Marc Fournier <marc.fournier@camptocamp.com>,
	git@vger.kernel.org
To: =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 26 00:45:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDRYT-0005Pz-W3
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 00:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759953AbZKYXpi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 18:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759579AbZKYXpi
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 18:45:38 -0500
Received: from mail-yx0-f188.google.com ([209.85.210.188]:55187 "EHLO
	mail-yx0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759454AbZKYXph convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 18:45:37 -0500
Received: by yxe26 with SMTP id 26so229664yxe.4
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 15:45:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=nm8mDKbfswLC1MckcZapnkMLA1Hn9YeYzels1gU8Y14=;
        b=FcKTJ7vNu9ULh9Ci/fVglbBOPIUcxvHjsqbCFfI9hV4uDCateh8v4o4pmDCwQRaJqE
         6FFTJdVg1XSwOXLeEZ9IBwe+daTVJIeGKnVRHusxA2b0jyXWedg+2kRg05RN9gmdx0ea
         gdqKe3XXjkCYKikv839T1QHrcRqw9MDQbYpMM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=E32nU5qyq1wYt3vitMRQicclRMIcP0auyw0O3/cQMwSIa2qGKjjrj30ndRIzTQZ5F8
         TkHeD+Hkdkirx6nHDpX/KTBAx9DRO+bCiBaS/G253aYszTCS6VMUZh9puIaHxc6ZgiTm
         cRGMT1pj3yMkATRa9LyYImjSHPR3xYKPSoMRM=
Received: by 10.150.115.21 with SMTP id n21mr14772722ybc.30.1259192743485; 
	Wed, 25 Nov 2009 15:45:43 -0800 (PST)
In-Reply-To: <20091125234122.GA31422@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133707>

2009/11/25 Bj=F6rn Steinbrink <B.Steinbrink@gmx.de>:
> On 2009.11.25 18:20:45 -0500, Avery Pennarun wrote:
>> I read the earlier thread and I still don't quite understand this
>> point. =A0What makes it difficult?
>
> I guess it's -Xfoo vs. -X foo (note the space). Same deal with log
> -S<string>. "git log -S foo" would look for an empty string (I guess)
> being added/removed in some commit in foo's history, while "git log
> -Sfoo" looks for "foo" being added/remove in HEAD's history.

Oh.  Ouch.  Isn't it standard for options-that-take-string-parameters
to always *require* that parameter?  This seems to be how getopt
works.  Basically "-X foo" is the same as "-Xfoo" in that system.

If parse_options doesn't already do this, should I try to add it someho=
w?

Avery
