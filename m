From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] attr: support quoting pathname patterns in C style
Date: Tue, 9 Nov 2010 00:08:17 -0800
Message-ID: <E3AD4043-4453-494C-A8B8-DD8A8842D2AC@sb.org>
References: <AANLkTinNctmWpshBeSTzZRm6+EJ=Cjdpoaj4Aon+52_b@mail.gmail.com> <1288878944-14066-1-git-send-email-pclouds@gmail.com> <7vvd4bu2pl.fsf@alter.siamese.dyndns.org> <15C4C111-824D-4657-B034-A1BE1DAD50D4@sb.org> <7v8w13r756.fsf@alter.siamese.dyndns.org> <626BD1B6-4DDF-457F-B430-F15C891710E2@sb.org> <4CD8FCC0.2030500@viscovery.net>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>, git@vger.kernel.org,
	Marc Strapetz <marc.strapetz@syntevo.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Nov 09 09:08:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PFjFi-0006yV-RD
	for gcvg-git-2@lo.gmane.org; Tue, 09 Nov 2010 09:08:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753350Ab0KIIIW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Nov 2010 03:08:22 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:52460 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753099Ab0KIIIV convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Nov 2010 03:08:21 -0500
Received: by iwn10 with SMTP id 10so923671iwn.19
        for <git@vger.kernel.org>; Tue, 09 Nov 2010 00:08:21 -0800 (PST)
Received: by 10.42.215.7 with SMTP id hc7mr4097106icb.289.1289290100423;
        Tue, 09 Nov 2010 00:08:20 -0800 (PST)
Received: from [10.0.1.14] (c-24-130-32-253.hsd1.ca.comcast.net [24.130.32.253])
        by mx.google.com with ESMTPS id gy41sm959568ibb.17.2010.11.09.00.08.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 09 Nov 2010 00:08:19 -0800 (PST)
In-Reply-To: <4CD8FCC0.2030500@viscovery.net>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161023>

On Nov 8, 2010, at 11:48 PM, Johannes Sixt wrote:

> Am 11/8/2010 22:56, schrieb Kevin Ballard:
>> Basically what I'm trying to say is, we already break one particular
>> "rather rare" setup. I would love to come up with a solution that supports
>> both setups, but I don't know if one exists outside of using a config
>> variable to control whether git attribute patterns support quoting (a solution
>> I am not particularly fond of for this case).
> 
> Can we perhaps have a pseudo-attribute 'quoted-names' that is to be used
> like this:
> 
> * quoted-names
> "file 1" binary
> file.1 -diff
> 
> Its meaning would be that the remainder of the current .gitattributes file
> is to be parsed with C style path quoting enabled. The glob given with
> this attribute is irrelevant and ignored.
> 
> I didn't check whether old gits would ignore this unknown attribute.

This would certainly solve the regression issue, but from the perspective of
a brand new user of git this would make absolutely no sense and would be
a huge wart upon consistency.

-Kevin Ballard