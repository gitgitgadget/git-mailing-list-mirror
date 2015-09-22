From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] filter-branch: add passed/remaining seconds on progress
Date: Tue, 22 Sep 2015 09:08:01 -0700
Message-ID: <xmqqzj0e4eu6.fsf@gitster.mtv.corp.google.com>
References: <1441379798-15453-1-git-send-email-bernat@primeranks.net>
	<1441633928-18035-1-git-send-email-bernat@primeranks.net>
	<CAPig+cRRMUhWwxAgVHKpMMne7XiOuYGTi_zgQMB=A+XNGUzLqQ@mail.gmail.com>
	<xmqqsi6o95r7.fsf@gitster.mtv.corp.google.com>
	<CAPig+cS7ObsWjqbLytCKp1PGF+224TYhC734dNa_HXYQ7p+GgQ@mail.gmail.com>
	<xmqq6133a6tf.fsf@gitster.mtv.corp.google.com>
	<CAPig+cRnVzRoyKOzPSJZd4JK_hB+_CBn0kjg4yYv=wWb-5vf7w@mail.gmail.com>
	<CALYJoz3xoiB2pVT+r0Nz+EYdE91WX6ypdmieMs1uubg=Vs4bog@mail.gmail.com>
	<CANy2qHcy=UD8xBeGVqGuEHVAgEvCSejt4LXk=vtpfQGSRkTg7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?R8OhYm9yIEJlcm7DoXQ=?= <gabor.bernat@gravityrd.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Mikael Magnusson <mikachu@gmail.com>, cbailey32@bloomberg.net,
	Lee.Carver@servicenow.com, Michael Witten <mfwitten@gmail.com>
To: Gabor Bernat <bernat@primeranks.net>
X-From: git-owner@vger.kernel.org Tue Sep 22 18:08:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeQ71-0006VL-6j
	for gcvg-git-2@plane.gmane.org; Tue, 22 Sep 2015 18:08:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758279AbbIVQIG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Sep 2015 12:08:06 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36654 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752171AbbIVQIF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 12:08:05 -0400
Received: by pacgz1 with SMTP id gz1so10346539pac.3
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 09:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=Z/P09vgymccDGYBkERsY64xojMxla/AYNqPE3KnFXvw=;
        b=TTUttGlk8S4vIJqz16axBOAjT4MUswTjs5C3bOEOFNc45Hf74N5x2w8fnmb+2p5IuC
         dqFMn8IH1lQCm4MJrt2+A8MW/ReHJqcIxTrdOuJFbtP0FZdb1VgxLIPqesRhJy2IgU2M
         sWU0I00EIim6dmO99yKD0YUxVpW5Aok8UgAXVzqjs3ASkov8aufnlYvNGtLsTg32X8iC
         3cVhzE4Jn8Qex49NU32E+o+xnNb/0CqisDk9HxVsUA2cn5rGZJJhamDnIsqxNJmcJ1kK
         pQ0Z8AsBdHDN27g6Z0w9gXd4YzfYMCLIDI2I0uw2dse0ra+HJb+03ZY4jyLRSGJ/kn/2
         AsMw==
X-Received: by 10.68.95.225 with SMTP id dn1mr19935365pbb.103.1442938083877;
        Tue, 22 Sep 2015 09:08:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:fd7e:7071:2eda:9c63])
        by smtp.gmail.com with ESMTPSA id ku8sm3171141pab.0.2015.09.22.09.08.02
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Tue, 22 Sep 2015 09:08:03 -0700 (PDT)
In-Reply-To: <CANy2qHcy=UD8xBeGVqGuEHVAgEvCSejt4LXk=vtpfQGSRkTg7g@mail.gmail.com>
	(Gabor Bernat's message of "Tue, 22 Sep 2015 17:53:05 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278401>

Gabor Bernat <bernat@primeranks.net> writes:

> On Mon, Sep 21, 2015 at 11:24 PM, G=C3=A1bor Bern=C3=A1t
> ...
>> Agreed, :) did not abandoned this, just got caught up with many stuf=
f.
>> Thanks for the help,
>
> So do I need to do anything else with this? :)

If you can fetch from me to see if the output from

    git log -p origin/master..71400d97b12a

looks sensible, that would be good.  There are two commits.

Thanks.
