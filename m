From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 00/42] repo setup test cases and fixes
Date: Fri, 29 Oct 2010 12:09:06 -0500
Message-ID: <20101029170906.GA29249@burratino>
References: <1288334934-17216-1-git-send-email-pclouds@gmail.com>
 <AANLkTikJJnTXfWXKe5bm_Qyjmgna9g3vChdkPzoiAb4i@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 29 19:09:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBsSC-0002kv-CG
	for gcvg-git-2@lo.gmane.org; Fri, 29 Oct 2010 19:09:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934083Ab0J2RJU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Oct 2010 13:09:20 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44551 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932458Ab0J2RJS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Oct 2010 13:09:18 -0400
Received: by ewy7 with SMTP id 7so2403309ewy.19
        for <git@vger.kernel.org>; Fri, 29 Oct 2010 10:09:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=NYQp0pcBiFrjkYiraSM6dQWdwrbxBsf6Kqh5Fx/ZsHE=;
        b=b+Mo8R3JFGJGtbOcxv2TnyDbif5kpTmLgM3kug/L0DZJ2RI2ywMDNvUrABkGo+caGK
         Y9uWysrQXnOnSswWQyYCX7i0H5+C4BTQS/TqGqkIAq2JaJpVTMo3bbG/wJzm7yrHbZnp
         N1EHb+5ejU8UrlbKidxPHQM5VqD/6MeKeE0fM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=fVcJOS1LUhWsFYEaylH+z/VE5DM+5ymIzT3bRqoCyO12ImmbaBrU9xc4KmGMWN1iPO
         NtMb5bDjLDjohc74PMRPLg/OgUc3ea9yq0dt85uwk41iiO3JRV5Ikb1fArhYLtVERq0f
         OopM6K0iB+cXT+01w6gsPDsGjKDaIexDhuME8=
Received: by 10.216.49.145 with SMTP id x17mr1163665web.55.1288372157295;
        Fri, 29 Oct 2010 10:09:17 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id x12sm1737999weq.18.2010.10.29.10.09.14
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 29 Oct 2010 10:09:15 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikJJnTXfWXKe5bm_Qyjmgna9g3vChdkPzoiAb4i@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160343>

Sverre Rabbelier wrote:
> 2010/10/28 Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>:

>> This series includes setup coverage tests (180/376 fail). Then the f=
ixes,
>> which bring down to zero failed test in the end. 02/42 describes the
>> rules. New rules are:
>
> Shouldn't the fixes come first (for bisectability?).

Good point.  Ideally the tests would come first if the fixes are
contraversial, or be squashed with the fixes if neither is
contraversial, or after if the tests are contraversial but the fixes
are not.

=46or bisectability and clarity, the tests should use test_expect_failu=
re
when they fail (like this patch series does) and change that to
test_expect_success in the patch that fixes them.
