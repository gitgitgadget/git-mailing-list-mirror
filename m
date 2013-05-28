From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 4/5] test: improve rebase -q test
Date: Tue, 28 May 2013 10:19:07 -0700
Message-ID: <20130528171907.GA28153@google.com>
References: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
 <1369745671-22418-5-git-send-email-felipe.contreras@gmail.com>
 <7vvc6311dr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Neil Horman <nhorman@tuxdriver.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 28 19:19:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhNYQ-0003fV-En
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 19:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934937Ab3E1RTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 13:19:18 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36148 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934928Ab3E1RTR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 13:19:17 -0400
Received: by mail-pd0-f180.google.com with SMTP id 14so5469445pdc.39
        for <git@vger.kernel.org>; Tue, 28 May 2013 10:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=S3wO35fiTKpGEtYV+hrka4+p3T7Meg1vSOarwKD9X7c=;
        b=p8c0J3ZKg/Ka4kPGjzaolcscq0o/j4sURjl58mYxrKA+kPVPsXf75UiGvt2k7ZhbaT
         YEDA/pBEsp25DdLmypxR02PEizykosCadg538VNPqmB4YVB4RcoZjjOOqVoJY53UlN31
         wMmsCqFqA0lH69iuaL8T5yaXSU3sBWVfhew8Hty9Hw+zJq+dbRZP2lGFPtPrVqqnYMFm
         c/9TZ/bLv2CLPMjBbB6NFkYnhhCrjx02HuyKoXj9Fl1Y3+yDzdr+FshQe2KqWiTSrHA4
         jlyS57vsiVyI91GOo/VZL5aYAOUB3b1de2fHJjeTcfywtdorZxkPQvayDB2VeQFLJ1VE
         kUEQ==
X-Received: by 10.68.255.130 with SMTP id aq2mr34003600pbd.164.1369761555085;
        Tue, 28 May 2013 10:19:15 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id l16sm5251774pag.22.2013.05.28.10.19.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 10:19:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <7vvc6311dr.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225671>

Junio C Hamano wrote:

> A more preferrable alternative may be adding something like this to
> test-lib.sh and call it from here and elsewhere (there are about 50
> places that do "test ! -s <filename>"), perhaps?
>
>         test_must_be_an_empty_file () {
>                 if test -s "$1"
>                 then
>                         cat "$1"
>                         false
>                 fi
>         }

I generally just use the two-liner

	>empty &&
	test_cmp empty output

directly in cases like this.

Thanks,
Jonathan
