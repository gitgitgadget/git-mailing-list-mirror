From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: jn/apply-filename-with-sp (Re: What's cooking in git.git (Aug
 2010, #02; Wed, 11))
Date: Sat, 14 Aug 2010 19:05:00 -0500
Message-ID: <20100815000500.GA12612@burratino>
References: <7vlj8cvi2e.fsf@alter.siamese.dyndns.org>
 <4C65BCD2.6000701@kdbg.org>
 <20100814022625.GA4199@burratino>
 <201008142037.50833.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Greg Brockman <gdb@mit.edu>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Elijah Newren <newren@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Sun Aug 15 02:06:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkQkM-0004uW-LF
	for gcvg-git-2@lo.gmane.org; Sun, 15 Aug 2010 02:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757565Ab0HOAGf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Aug 2010 20:06:35 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:56713 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757542Ab0HOAGf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Aug 2010 20:06:35 -0400
Received: by iwn7 with SMTP id 7so276692iwn.19
        for <git@vger.kernel.org>; Sat, 14 Aug 2010 17:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=k1IT9n6AqhTMMGNlVoEhXW3FFLyzN2XCBlkxSO8OJzI=;
        b=WMemHYoZsHqygtnUNUlzwJmeNua5hS76D4pSkO2MwTIR4zsT5GGnf8fWZb6wBywLQI
         t+rXgt8Ffk5F8hNx0DJ5kCBIvlOIZ0xOILTOoIzDsX1WpNcWJUmdU7XbNozdF4+Ov9kr
         ZEWWXQOHLJvwgltqBhUp4Xqa9d/f9CHncqJeI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=UA46UZVQYzCknpZxcyzZLJL00DyJPl67r7MBPwCUIa+KJW82GSenpEr0+Iwuf6sXA+
         N6OfxQNRRecPqG39f5fYujPupWqVp2oc79Gr9t5c46pHHCkomvLdioSz7bNTY+XwgeJm
         IWBVC/IsaHc8trVm3PdJISUovai5HmDZz51Ic=
Received: by 10.231.149.3 with SMTP id r3mr3635504ibv.109.1281830794342;
        Sat, 14 Aug 2010 17:06:34 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id e8sm2788180ibb.14.2010.08.14.17.06.33
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 14 Aug 2010 17:06:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201008142037.50833.j6t@kdbg.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153586>

Johannes Sixt wrote:
> On Samstag, 14. August 2010, Jonathan Nieder wrote:

>> @@ -20,6 +20,44 @@ test_expect_success 'setup: clean-up functions' '
>>  	reset_subdirs() {
>>  		rm -fr a b &&
>>  		mkdir a b
>> +	} &&
>> +
>> +	cat <<-\EOF >expand.sed &&
> ...
>=20
> Why not just write an explicit test vector? The result of expand will=
 be=20
> constant, no?

Yes, you=E2=80=99re right.  That=E2=80=99s the best way to go (especial=
ly since future
versions of GNU diff might handle special characters differently).
