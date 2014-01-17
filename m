From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: Re: [PATCH] send-email: If the ca path is not specified, use the defaults
Date: Fri, 17 Jan 2014 15:34:08 -0800
Message-ID: <04260036-28A7-45CC-BD25-BED90A7C6DB4@gmail.com>
References: <1389807071-26746-1-git-send-email-i.gnatenko.brain@gmail.com> <xmqqa9ex2gi6.fsf@gitster.dls.corp.google.com> <7AD1C6ED-6177-415D-B342-D1FEA9F810B4@rubenkerkhof.com> <xmqqob3d0w7g.fsf@gitster.dls.corp.google.com> <20140115215024.GM18964@google.com> <xmqqppnry0p9.fsf@gitster.dls.corp.google.com> <E036CD5E-69B1-4ABD-957B-8E31D410A897@gmail.com> <xmqqlhyexyp4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Apple Message framework v936)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Ruben Kerkhof <ruben@rubenkerkhof.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Igor Gnatenko <i.gnatenko.brain@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 00:34:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4IvZ-0008Ac-Je
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 00:34:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752022AbaAQXeN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 18:34:13 -0500
Received: from mail-pd0-f179.google.com ([209.85.192.179]:60911 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751897AbaAQXeL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 18:34:11 -0500
Received: by mail-pd0-f179.google.com with SMTP id q10so2533397pdj.24
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 15:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:in-reply-to:subject:references:message-id:content-type
         :content-transfer-encoding:mime-version:date:cc;
        bh=gYGxI59RlPfBG/+hdus6IjAqDBoYAcG2MWkxXJpcxIs=;
        b=KxbBQuvsB3Yn68v3OgkrNE8/wCCZs4H4P9HOPaqfLI4qZRVc3lOBfzmgAZJSDz43ZQ
         cWLTJYwnNkZagS7LDlhTB7o910I8SGVIVYQkImlBG5Ed1wJil3Fa5ygTc7GJgmUsAnNb
         BoJz1d7Ok59HkpwO0KL9De6od6jVECfy49g7gbo1CyjBa35wgZUvwBBQ9xc6wAL28O8v
         N14/QSe4cTJCeocoGUVte/CwpLhpbN9M2HMUkKweMQKZjUs8qHQXBqj8tnhBBttFa4hK
         F1odwGbZw7uDpj6WCSqkrtaT6wIT/mRb5EkeJXYXFF47pgiZuGvISxVxMCkO0efiiWmV
         l94w==
X-Received: by 10.66.222.234 with SMTP id qp10mr5114400pac.156.1390001651028;
        Fri, 17 Jan 2014 15:34:11 -0800 (PST)
Received: from [172.16.16.105] (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id qp15sm25631134pbb.2.2014.01.17.15.34.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 15:34:10 -0800 (PST)
In-Reply-To: <xmqqlhyexyp4.fsf@gitster.dls.corp.google.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240635>

On Jan 17, 2014, at 10:14, Junio C Hamano wrote:
> If I am reading the code correctly, if /etc/ssl/certs does not exist
> on the filesystem at all, it wouldn't even attempt verification, so
> I take your "the verification will fail" to mean that you forgot to
> also mention "And on OS X, /etc/ssl/certs directory still exists,
> even though OpenSSL does not use it."  If that is the case, then our
> current code indeed is broken in exactly the same way for OS X as
> for Fedora.

My bad.  That directory does not normally exist, but, if some errant  
installer were to create an empty one...

> In short, I agree with you on both counts (the current code is wrong
> for OS X, and the proposed change will fix it).  I just want to make
> sure that my understanding of the current breakage is in line with
> the reality ;-)

Yes, you're right.  :)
