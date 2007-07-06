From: "Marco Costalba" <mcostalba@gmail.com>
Subject: Re: [Qgit RFC] commit --amend
Date: Fri, 6 Jul 2007 10:12:50 +0200
Message-ID: <e5bfff550707060112p29b9565bw9ccba6601745b850@mail.gmail.com>
References: <20070610150839.GG4084@efreet.light.src>
	 <e5bfff550706101510x6d685944ja70c9d9dbb3668f6@mail.gmail.com>
	 <20070611044258.GJ4084@efreet.light.src>
	 <e5bfff550706102245p27aea579w65ee96161630a624@mail.gmail.com>
	 <20070705185426.GB3991@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Jul 06 10:13:05 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6ivz-0000OD-HL
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 10:12:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758527AbXGFIMy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 04:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761428AbXGFIMx
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 04:12:53 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:13978 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755783AbXGFIMw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 04:12:52 -0400
Received: by wr-out-0506.google.com with SMTP id i30so111550wra
        for <git@vger.kernel.org>; Fri, 06 Jul 2007 01:12:51 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AxMubY3QqiJG6JePNXwYtdLkWA7RJPmSaMU/LNL26l2RKPKwX4aGQxcDEdhYyTEYk4NIu17DQz4oiT9PsF95TLJn6TgsEbQzuPlZilsa8xGBXTjckDt9BVZdtw1QRV8erwHBidRXayw9K0Lwn6+5PHkzRjJYXY51cSnOARa6vto=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=exOYdfrSQ5dnPfdvgAl/5R5GFBHXKKRq+Maswxv+kE4/PXHterKkBcYNSORZco887OQwA+d4mnl9rZk1NNhE4DYS7+efIpTT5F20weHP3v/n23PzFu7f4BTBG5jsJIYiA0lqQO6pq8OJUz1vqryAk1tzevbukS5Rqhw5/WqTXKA=
Received: by 10.114.26.1 with SMTP id 1mr419236waz.1183709570103;
        Fri, 06 Jul 2007 01:12:50 -0700 (PDT)
Received: by 10.114.61.9 with HTTP; Fri, 6 Jul 2007 01:12:50 -0700 (PDT)
In-Reply-To: <20070705185426.GB3991@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51730>

On 7/5/07, Jan Hudec <bulb@ucw.cz> wrote:

>
> Therefore I'll either have to always ask git via run("git-rev-parse HEAD",
> head), add HEAD into the map, or store HEAD somewhere in the Git object.
> Which do you think makes most sense?
>

Asking git when you need it and keep HEAD value only for the minimum
time required to execute the commit command.

- HEAD is very 'volatile'

- commit is _not_ performance critical.

- commit, being a write operation, is instead bugs/misbehaviour
critical (a big point to use an high level "git-commit" BTW)

- asking git with getRefSha("HEAD", ANY_REF, true)  is very quick and
in any case much quicker then the whole commit dance.

- someone can always change the repo behind you, qgit is not the only
interface to git ;-) does exist also the command line.


Marco
