From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Issue 323 in msysgit: Can't clone over http
Date: Fri, 04 Sep 2009 03:25:38 -0700
Message-ID: <7viqfzvwf1.fsf@alter.siamese.dyndns.org>
References: <0016e6470f36315b8a0472bc75a8@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: msysgit@googlegroups.com
To: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>
X-From: grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com Fri Sep 04 12:26:05 2009
Return-path: <grbounce-SUPTvwUAAABqUyiVh9Fi-Slj5a_0adWQ=gcvm-msysgit=m.gmane.org@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yx0-f138.google.com ([209.85.210.138])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MjVzY-0003XF-GZ
	for gcvm-msysgit@m.gmane.org; Fri, 04 Sep 2009 12:26:04 +0200
Received: by yxe2 with SMTP id 2so3299343yxe.3
        for <gcvm-msysgit@m.gmane.org>; Fri, 04 Sep 2009 03:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=beta;
        h=domainkey-signature:received:received:x-sender:x-apparently-to
         :received:received:received:received-spf:received:dkim-signature
         :domainkey-signature:received:received:to:cc:subject:references:from
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :x-pobox-relay-id:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        bh=Gz6VSuCKTXOF2K9E1aGW0T+tLcQAwS6F8KBJ+RwbBUo=;
        b=WHl+81ISrgmcA/+YM6jCFT/7Ia2aOc/cLRyEHqfKCcCU1PgMBdpQQw54ltZQMf93G5
         905r/XYRAFRA874mcQkRILF0XoF+WjUedT+60fxyzCGTjcRsYtqCRx216S4Pb4XHW//J
         CM1K4usV8X7+c1zTBpRGVIoe+hou9nRnOcWlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlegroups.com; s=beta;
        h=x-sender:x-apparently-to:received-spf:authentication-results
         :dkim-signature:domainkey-signature:to:cc:subject:references:from
         :date:in-reply-to:message-id:user-agent:mime-version:content-type
         :x-pobox-relay-id:sender:precedence:x-google-loop:mailing-list
         :list-id:list-post:list-help:list-unsubscribe:x-beenthere-env
         :x-beenthere;
        b=zd5zu7v6G7gEV4nLAqr3PfDkP9roo6FNWyuNKKHsBtsnpYRhVSnNyNsU3sQ/nHxfVa
         fXV4HqxZK3Ktpg+xMPJWwxzYOiEvb8ecTsbGfwVUCF9CExCf16K5MIYc5fhLKL839avv
         I4JcMZXE/Or/CK2pHygb9aNkd/M4YyjA+o3FA=
Received: by 10.101.147.8 with SMTP id z8mr152078ann.19.1252059957844;
        Fri, 04 Sep 2009 03:25:57 -0700 (PDT)
Received: by 10.177.125.36 with SMTP id c36gr6841yqn.0;
	Fri, 04 Sep 2009 03:25:53 -0700 (PDT)
X-Sender: gitster@pobox.com
X-Apparently-To: msysgit@googlegroups.com
Received: by 10.229.29.146 with SMTP id q18mr1597101qcc.23.1252059951567; Fri, 04 Sep 2009 03:25:51 -0700 (PDT)
Received: by 10.229.29.146 with SMTP id q18mr1597100qcc.23.1252059951540; Fri, 04 Sep 2009 03:25:51 -0700 (PDT)
Received: from sasl.smtp.pobox.com (a-pb-sasl-sd.pobox.com [64.74.157.62]) by gmr-mx.google.com with ESMTP id 18si112352qyk.5.2009.09.04.03.25.48; Fri, 04 Sep 2009 03:25:48 -0700 (PDT)
Received-SPF: error (google.com: error in processing during lookup of gitster@pobox.com: DNS timeout) client-ip=64.74.157.62;
Authentication-Results: gmr-mx.google.com; spf=temperror (google.com: error in processing during lookup of gitster@pobox.com: DNS timeout) smtp.mail=gitster@pobox.com; dkim=pass header.i=@pobox.com
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1]) by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0D2D143BBF; Fri,  4 Sep 2009 06:25:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject :references:from:date:in-reply-to:message-id:mime-version :content-type; s=sasl; bh=pN0ZtYUOKZ9vqkTJvoG1tfJk5Vc=; b=JUqUGl cjCHWtCvBTPeRYKRfogqkIDKceLrcbbryEHXuDUdZ992TOYTqM09TJ00VOrHgPee mCWikIXFOndR94GlCqoxkcfPXvmV7KKdf2G6VHB/MAt3ZgLp1dbx4i0UrXnmuQd6 pB9hyDWH937WUGCv57lhHsuMWbw0oJiv+eZGU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject :references:from:date:in-reply-to:message-id:mime-version :content-type; q=dns; s=sasl; b=YwyHFD2jflMxu8nt4DAWc/VWgeFoChZl jOLJPNKdUs2Sr3dhRIT0Nv1YFS84jEI/p4Q2vPwhoHBgWa8lHuHZhiMH4W+wtF2C ZwlR+mkbIbLgFxyTDjPWnzTrxXBbcF99bn9+zAznCbYlMui9AVo5bCQRhacCHlMq IuMjo/y+l+M=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1]) by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D4E9A43BBE; Fri,  4 Sep 2009 06:25:44 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 5E26543BBB; Fri,  4 Sep 2009 06:25:40 -0400 (EDT)
In-Reply-To: <0016e6470f36315b8a0472bc75a8@google.com> (codesite-noreply@google.com's message of "Fri\, 04 Sep 2009 08\:40\:52 +0000")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4DFC0612-993D-11DE-8BFF-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: msysgit@googlegroups.com
Precedence: bulk
X-Google-Loop: groups
Mailing-List: list msysgit@googlegroups.com;
	contact msysgit+owner@googlegroups.com
List-Id: <msysgit.googlegroups.com>
List-Post: <mailto:msysgit@googlegroups.com>
List-Help: <mailto:msysgit+help@googlegroups.com>
List-Unsubscribe: <http://googlegroups.com/group/msysgit/subscribe>,
	<mailto:msysgit+unsubscribe@googlegroups.com>
X-BeenThere-Env: msysgit@googlegroups.com
X-BeenThere: msysgit@googlegroups.com
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127704>


codesite-noreply@google.com writes:

> Status: New
> Owner: ----
>
> New issue 323 by bjelli: Can't clone over http
> http://code.google.com/p/msysgit/issues/detail?id=323
>
> What steps will reproduce the problem?
> 1.Install Git-1.6.4-preview20090730.exe
> 2.Clone exsiting repository http://github.com/tekkub/addontemplate.git

This does not seem to be an msysgit issue.  Even on a Linux host, v1.6.2.5
seems to work Ok but 'maint', 'master', nor 'next' does not clone this one
correctly.

> Output:
> got 2c8851d269d51676b8c626e63991ee68a6f5d578
> walk 2c8851d269d51676b8c626e63991ee68a6f5d578
> got 758419d18ad255c3417ca341c6e12c6ca1aa203e
> got fa8a1ec5a791c245789f70e90a844f2b9a275991
> walk fa8a1ec5a791c245789f70e90a844f2b9a275991
> got e884a228df0e08e0f862edab6012d8407907ab48
> got f7ea166470af2538a6a19642f8c45213bac7bd40
> got 6100842656e95bf50f2c6f3ff6e997bcbe2474cc
> got 445c0ea7c7193f6fcb42b32db50104926d328322
> got a44d6309e48622590b2780f96bed371122db6b71
> got 3ecefa3f04f394f64f8fe7be14ac20e69f2f2c18
> Getting alternates list for http://github.com/tekkub/addontemplate.git
> Getting pack list for http://github.com/tekkub/addontemplate.git
> error: Unable to verify pack 382c25c935b744e909c749532578112d72a4aff9 is
> available
> error: Unable to find 0a41ac04d56ccc96491989dc71d9875cd804fc6b under
> http://github.com/tekkub/addontemplate.git
> Cannot obtain needed blob 0a41ac04d56ccc96491989dc71d9875cd804fc6b
> while processing commit fa8a1ec5a791c245789f70e90a844f2b9a275991.
> fatal: Fetch failed.
>
> What version of the product are you using? On what operating system?
> Git-1.6.4-preview20090730.exe
> Windows XP
>
> Please provide any additional information below.
> Defect was discussed on the github support board here:
> http://support.github.com/discussions/repos/957-cant-clone-over-http-or-git
