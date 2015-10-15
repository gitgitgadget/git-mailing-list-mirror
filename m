From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Thu, 15 Oct 2015 12:35:46 +0200
Message-ID: <F501FD44-F14B-4902-9E24-149451804C1C@gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com> <1444586102-82557-2-git-send-email-larsxschneider@gmail.com> <561CDDBA.609@gmail.com> <14146E1E-857D-416B-9287-F20826DCB806@gmail.com> <vpqwpuo35zo.fsf@grenoble-inp.fr>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: =?iso-8859-1?Q?Jean-No=EBl_Avila?= <avila.jn@gmail.com>,
	git@vger.kernel.org, johannes.schindelin@gmx.de, tboegi@web.de,
	pw@padd.com
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Oct 15 12:36:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmftD-0000fK-EP
	for gcvg-git-2@plane.gmane.org; Thu, 15 Oct 2015 12:36:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752597AbbJOKfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Oct 2015 06:35:55 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:37141 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751563AbbJOKfv convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Oct 2015 06:35:51 -0400
Received: by wijq8 with SMTP id q8so122831156wij.0
        for <git@vger.kernel.org>; Thu, 15 Oct 2015 03:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=content-type:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=sZAJjtAf1GQZy+O7iSS4N4IQXZEriV1Mz7p2/2d6GIQ=;
        b=QaWhkpQiGEP8yUqO93PPyq1zf3joUBKNA+39AHotef5+CPiJrwggxzRteAn/rGPMFO
         nKWvCv4UTE4eCBnclfBl1r++76Trd7kr2jAaxSnx/a1CqllN5E+tE+zavrubRfD4SFp2
         ebJqzdff2jybJi5gYd3cjZxJilqa4RY8AFS/OfA5IsE0Rt4dtIG8hJhelEbMmsEXjYpP
         HrhTUyQGycGOUC8reDzA8p2hVKobbazQoTIduFG1dANGvS9yoaHoRulHYpjs5ReKef3M
         jtdt+05D8Sp0bwjZS9E0p2HIKG2ImFyELGY+VYmn+dWEg3mk33iE1rkaNx2guhsTuQG7
         87wg==
X-Received: by 10.194.63.81 with SMTP id e17mr10790057wjs.147.1444905350558;
        Thu, 15 Oct 2015 03:35:50 -0700 (PDT)
Received: from [10.32.248.190] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id l1sm15633326wjx.13.2015.10.15.03.35.48
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Oct 2015 03:35:49 -0700 (PDT)
In-Reply-To: <vpqwpuo35zo.fsf@grenoble-inp.fr>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279659>


On 15 Oct 2015, at 10:12, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:

> Lars Schneider <larsxschneider@gmail.com> writes:
> 
>> I was reluctant to this because I feared problems. Especially while
>> running tests in parallel.
> 
> Isn't the point of using a CI tool to notice problems? ;-)
> 
> More seriously, running tests in parallel shouldn't be a problem since
> each test runs in its own directory with HOME set to this private
> directory, so two diffent tests should not interfer. If there's an issue
> with parallel tests, we probably prefer discovering them than avoiding
> them.
OK. Great!


>> make -j2 9min 11sec:
>> https://travis-ci.org/larsxschneider/git/jobs/85478022
>> 
>> make 17min 20sec:
>> https://travis-ci.org/larsxschneider/git/jobs/85432398
> 
> Since the tests are essentially IO-bound and not CPU-bound, it may even
> make sense to use -j3 here.
Hehe you're right.

make -j3 6min 2sec
https://travis-ci.org/larsxschneider/git/jobs/85497307

just for fun I tried a few more values and -j5 seems to be the best with 4min 27sec
https://travis-ci.org/larsxschneider/git/jobs/85501015

-j6 is slower again. Do you see a reason not to use "-j5"?

Thanks,
Lars
