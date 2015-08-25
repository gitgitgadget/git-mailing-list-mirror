From: Luke Diamand <luke@diamand.org>
Subject: Re: [PATCH v5] git-p4: Obey core.ignorecase when using P4 client
 specs.
Date: Tue, 25 Aug 2015 19:24:32 +0100
Message-ID: <55DCB2E0.5090605@diamand.org>
References: <1440451805-85095-1-git-send-email-larsxschneider@gmail.com> <55DC111A.6090501@diamand.org> <55DC285D.9030500@web.de> <23CB37E8-9704-4A9D-8CAB-2812AD59394D@gmail.com> <CAE5ih7-o6eVF-z2GORxHa_TdDaXgexLpW3jctESTnL46Mfdo8w@mail.gmail.com> <B7632D9A-BB8B-41E5-9C3D-F7376A0C81D3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?windows-1252?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Git Users <git@vger.kernel.org>, Pete Wyckoff <pw@padd.com>,
	Tor Arvid Lund <torarvid@gmail.com>, ksaitoh560@gmail.com,
	Junio C Hamano <gitster@pobox.com>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 25 20:24:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUItm-000561-8K
	for gcvg-git-2@plane.gmane.org; Tue, 25 Aug 2015 20:24:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbbHYSYi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Aug 2015 14:24:38 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:32894 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755497AbbHYSYh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Aug 2015 14:24:37 -0400
Received: by wijn1 with SMTP id n1so1558869wij.0
        for <git@vger.kernel.org>; Tue, 25 Aug 2015 11:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=X4sx1nuOVGLc6QZ/YYBzkBw9fe8yEFSYnQ0bSURFt3c=;
        b=EQ9s4OelEAArYBWY2VfkEIKE7MEcLfkVWwp0kQvDoB4XFs7sS4huu/nTJGEi9cy5jC
         gNDrQC1LImWNCtGzomLWcbLkFK7nuESq06zdL66T6Jdw2YPe3QAHQUH0smjSuP+6UU+f
         M1Gml81K2nJb8lDqnVdClxotJbbIEurudSmu4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=X4sx1nuOVGLc6QZ/YYBzkBw9fe8yEFSYnQ0bSURFt3c=;
        b=mVlYAHspsT+KesdrDUarH5GGuMM1rw9Hv9WQVcsAtV8jJi1r3imR4H1nt4sL3Hft/E
         xuMFf6H6mcLnIrG6B88A8RiMHeKKKOdhJCJX2v1LHtAT3E1OH1uvT3/ogs5fUD+lkId7
         Q5C+t+CCXteSPWxD4X+ylo9TxsRjYHrDPOtEqUA47NaSe2I898HicfF3eGnbwLITXxQM
         ESbrMzuTxKhGH4Hvej3lq+/61XCmKimci/rGks8fneZ+Ufk11QXlCtPPToP0DAYnjsj/
         Lbtt9efK8hG+lUzDxT2NJbuL2NCdYxUJAMcUef2ZR2743fXBXP8h48h11vDDm04zBa+Q
         6T5Q==
X-Gm-Message-State: ALoCoQkuj+lhOW2YshsFMGGXNSQLJaD6rp6U88JFjGMuI8YzY8hFd5k1SQetXDEhH35Avo/+OYVS
X-Received: by 10.194.78.230 with SMTP id e6mr52958617wjx.43.1440527076490;
        Tue, 25 Aug 2015 11:24:36 -0700 (PDT)
Received: from [192.168.245.128] (cpc7-cmbg17-2-0-cust139.5-4.cable.virginm.net. [86.1.43.140])
        by smtp.gmail.com with ESMTPSA id d17sm71738wjs.32.2015.08.25.11.24.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 25 Aug 2015 11:24:35 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <B7632D9A-BB8B-41E5-9C3D-F7376A0C81D3@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276555>

On 25/08/15 14:14, Lars Schneider wrote:
>>
>> So the choices are:
>>
>> 1. A new command-line option which would silently set core.ignorecas=
e
>> 2. Users just have to know to set core.ignorecase manually before
>> using git-p4 (i.e. Lars' patch v5)
>> 3. Fix fast-import to take a --casefold option (but that's a much bi=
gger change)
>>
> I vote for 2 because that solves the problem consistently with the ex=
isting implementation for now. That means we don=92t surprise git-p4 us=
ers. In addition I would try to fix (3), the =97casefold option, in a s=
eparate patch. Although this (3) patch could take a bit as I have two m=
ore git-p4 patches in the queue that I want to propose to the mailing l=
ist first.

That works for me. Ack.

Thanks!
Luke
