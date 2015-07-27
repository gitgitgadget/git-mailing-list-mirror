From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: fix repo name when cloning a server's root
Date: Mon, 27 Jul 2015 07:29:44 -0700
Message-ID: <xmqqzj2hish3.fsf@gitster.dls.corp.google.com>
References: <1437997708-10732-1-git-send-email-ps@pks.im>
	<CACsJy8C0xzTvxMo7=pLFJyu8Yaqm_nz1qVXMFFo9ubQE-dYYSw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patrick Steinhardt <ps@pks.im>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 27 16:30:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZJjPb-00014X-3H
	for gcvg-git-2@plane.gmane.org; Mon, 27 Jul 2015 16:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752420AbbG0O3r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Jul 2015 10:29:47 -0400
Received: from mail-pd0-f180.google.com ([209.85.192.180]:35529 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753208AbbG0O3q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Jul 2015 10:29:46 -0400
Received: by pdrg1 with SMTP id g1so53041005pdr.2
        for <git@vger.kernel.org>; Mon, 27 Jul 2015 07:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=AZDCy62kjH+PNEK/r9Kd/zDouJkMfO2EggKJqtd9GT8=;
        b=MuMwlNw9TG5PJoMpcYOjH03tW5j7nwl0ffB/8ywBtfcS/sesIbgjfyFHK32ctclaD6
         H0OsBEhIyWvE/aafZMaCUxSHYF1U6LLJrwdaHXirbkh4c7pw9jXy5Wt31IeEkS8fQ/2F
         19MOfol919A+jyqma4wgBzd8f2RnvjEZQEKo4rNhqrb8NXMQzNdsvHv2xbPb0TmR05DJ
         8+KXo71a/26qi0okRHvEUOBjgejvU90hh7GjpBU+raVTyTKzRd+dq65Ym0bHfuzsnwF1
         cpk3ZiZeMU0Nz7kVttraltGHtVF7pZIgbmytThD5diRITnmjjJUjbbsMyst6aSOWvTqK
         5U3Q==
X-Received: by 10.70.42.166 with SMTP id p6mr69478964pdl.118.1438007385751;
        Mon, 27 Jul 2015 07:29:45 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:2496:725d:b368:d039])
        by smtp.gmail.com with ESMTPSA id j5sm29893856pdi.7.2015.07.27.07.29.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 Jul 2015 07:29:44 -0700 (PDT)
In-Reply-To: <CACsJy8C0xzTvxMo7=pLFJyu8Yaqm_nz1qVXMFFo9ubQE-dYYSw@mail.gmail.com>
	(Duy Nguyen's message of "Mon, 27 Jul 2015 19:51:30 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274681>

Duy Nguyen <pclouds@gmail.com> writes:

>> I was not able to come by with a useful test as that would
>> require being able to clone a root directory. I couldn't find
>> anything in the current tests that looks like what I want to do.
>> Does anybody have an idea on how to achieve this?
>
> There's t/t1509/prepare-chroot.sh that will prepare a chroot for this
> purpose. You'll need linux, busybox and chroot permission.

If you do not use ssh:// or file://, it should be trivial to
arrange, no?  http://site/repo will typically not be serving
/repo from the root of the filesystem.
