From: =?ISO-8859-1?Q?Santi_B=E9jar?= <santi@agolina.net>
Subject: Re: [RFC/PATCH 1/2] remote tracking: return the tracking branch for 
	the given branches
Date: Thu, 18 Jun 2009 23:31:51 +0200
Message-ID: <adf1fd3d0906181431o9b50191n29f349a14f9d1be1@mail.gmail.com>
References: <1245311834-5290-1-git-send-email-santi@agolina.net>
	 <m3iqithd24.fsf@localhost.localdomain>
	 <adf1fd3d0906180655q5c142889r3375169b6cf1f8b0@mail.gmail.com>
	 <200906181617.07802.jnareb@gmail.com>
	 <adf1fd3d0906180740t637da9braea02deb3cba2680@mail.gmail.com>
	 <adf1fd3d0906181201r5f3b2f55t8427e7be5ba07e9a@mail.gmail.com>
	 <7v63etnydr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 18 23:32:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHPDE-0006VZ-Cg
	for gcvg-git-2@gmane.org; Thu, 18 Jun 2009 23:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753781AbZFRVbv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 18 Jun 2009 17:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753458AbZFRVbu
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jun 2009 17:31:50 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:52763 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751428AbZFRVbu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Jun 2009 17:31:50 -0400
Received: by bwz9 with SMTP id 9so1401003bwz.37
        for <git@vger.kernel.org>; Thu, 18 Jun 2009 14:31:51 -0700 (PDT)
Received: by 10.204.61.209 with SMTP id u17mr1787673bkh.86.1245360711641; Thu, 
	18 Jun 2009 14:31:51 -0700 (PDT)
In-Reply-To: <7v63etnydr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121871>

2009/6/18 Junio C Hamano <gitster@pobox.com>:
> Santi B=E9jar <santi@agolina.net> writes:
>
>> One thing it just occurred to me is to return the explicit refspec
>> instead of the tracking branch. So with the default config (after a
>> clone):
>>
>> $ git remote tracking origin refs/heads/master
>> refs/heads/master:refs/remotes/origin/master
>
> I think the output is sensible, instead of saying something like
> 'origin/master'.

OK.

>
> We can and should allow the end users to use abbreviated form as inpu=
t to
> us (either command line or configuration value) when it is unambiguou=
s,

OK. Moreover I think it also applies to the %(upstream) case I
reported some days ago.

> but when returning values for use by Porcelains, we should be strict =
and
> precise to avoid ambiguities.
>
>> this makes a difference in case we want to allow returning all the
>> matching tracking branch and not the first one with more than one
>> branch, as:
>>
>> $ git config remote.origin.fetch --add +refs/heads/*:refs/remote/ano=
ther/*
>>
>> $ git remote tracking origin refs/heads/master
>> refs/heads/master:refs/remotes/origin/master
>> refs/heads/next:refs/remotes/origin/next
>
> I am not sure what this example is doing. =A0You asked about refs/hea=
ds/master
> but you also talk about refs/heads/next? =A0 I guess you meant to say
>
> =A0 =A0$ git remote tracking origin refs/heads/master
> =A0 =A0refs/heads/master:refs/remotes/origin/master
> =A0 =A0refs/heads/master:refs/remotes/another/master
>
> instead, judging from the next example?

Yes.

Santi
