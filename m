From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v3 0/3] automatically skip away from broken commits
Date: Sat, 13 Jun 2009 12:35:47 -0700 (PDT)
Message-ID: <m3r5xo2ajc.fsf@localhost.localdomain>
References: <20090606043853.4031.78284.chriscool@tuxfamily.org>
	<c07716ae0906101237o5038fc4dle9f11b6f2216652a@mail.gmail.com>
	<7vtz2nlrfs.fsf@alter.siamese.dyndns.org>
	<200906110602.54861.chriscool@tuxfamily.org>
	<4A308B5D.2010704@zytor.com> <4A309083.9090907@zytor.com>
	<c07716ae0906120456j1a14af52n47c3a3542201aaf@mail.gmail.com>
	<4A33F7E4.4020201@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Sam Vilain <sam@vilain.net>, Ingo Molnar <mingo@elte.hu>
To: "H. Peter Anvin" <hpa@zytor.com>
X-From: git-owner@vger.kernel.org Sat Jun 13 21:35:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MFZ1C-0002WR-JT
	for gcvg-git-2@gmane.org; Sat, 13 Jun 2009 21:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477AbZFMTfu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2009 15:35:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753874AbZFMTft
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jun 2009 15:35:49 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:36935 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752703AbZFMTfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2009 15:35:48 -0400
Received: by bwz9 with SMTP id 9so2644148bwz.37
        for <git@vger.kernel.org>; Sat, 13 Jun 2009 12:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=nnoevlb7JelQwoC3im2rI06QRJ5J26mJk32APuYCRZU=;
        b=UFptHacjc2CL1Bu2g4lWB6VqqHjVpOr/zrUWA1fpktdFcVS8HZzzv8P3ODIjX34Ctj
         VAiI4ljBKY6SEIJoWooEbiFgAX6EdXeaNJYsyzCaFPJiP+HpRe3vYxdsnsvy8JGDWw6n
         +64GvY7IIO1Y/Bj1ZbUlnAFIAlmOBoatHI7v4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=TVaT1IBv/cGYnjn8giG5UpBm9Pu/VZA393V1C9PaHgTU9mV+6XeMX2KHtZCALhiqmj
         vN16PEklD/Y8GoPOPqnciZgY2GsSUgY8b5fQ215svokof2o/08g+iZ8CmxTaWk5xkXOV
         p00ZBxN71Qd4d3xz3kOD+Vins1WnnvaFTUI8c=
Received: by 10.103.224.17 with SMTP id b17mr2645541mur.61.1244921749819;
        Sat, 13 Jun 2009 12:35:49 -0700 (PDT)
Received: from localhost.localdomain (abvg165.neoplus.adsl.tpnet.pl [83.8.204.165])
        by mx.google.com with ESMTPS id e9sm3337112muf.32.2009.06.13.12.35.47
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 13 Jun 2009 12:35:47 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n5DJYdds014377;
	Sat, 13 Jun 2009 21:34:45 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n5DJY02e014367;
	Sat, 13 Jun 2009 21:34:00 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A33F7E4.4020201@zytor.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121518>

"H. Peter Anvin" <hpa@zytor.com> writes:
> Christian Couder wrote:
>> On Thu, Jun 11, 2009 at 7:05 AM, H. Peter Anvin<hpa@zytor.com> wrote:

>> To implement the PRNG, I guess that using something based on the
>> function given by "man 3 rand" should be ok:
>> 
>> int get_prn(int count) {
>>     count = count * 1103515245 + 12345;
>>     return((unsigned)(count/65536) % 32768);
>> }
>> 
>> where the "count" we pass is the count of elements in the list rather
>> than the static seed.
> 
> Yes, or perhaps better we could use some combination of the SHA-1s
> involved as seeds... they are rather nice for this as they are wide and
> much better PRNGs than most classical algorithms.
> 
> The main problem with the above algorithm is that it only produces 16
> bits of output, which when biased can turn into a fairly significant
> granularity.

Why not borrow one of algorithms, e.g. taus[1] from GSL (GNU
Scientific Library)?

If I understand "Random Number Generator Performance" chapter in GSL
Manual it is of comparable performance of the above BSD `rand`
generator, and is of simulation quality.

[1] maximally equidistributed combined Tausworthe generator by L'Ecuyer

-- 
Jakub Narebski
Poland
ShadeHawk on #git
