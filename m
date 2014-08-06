From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Subtree with submodule inside?
Date: Wed, 6 Aug 2014 16:51:52 -0700
Message-ID: <20140806235152.GB12427@google.com>
References: <CAHd499CaCeHYGZSQeY8MRVnnjXBTgDy=OUqBYqNd1e5GiKre_A@mail.gmail.com>
 <xmqqk36lmrpl.fsf@gitster.dls.corp.google.com>
 <CAHd499AmY+EYXAK8h_oYiOn-amnNrE1+a7qsQ4x7bCOVsJDxcw@mail.gmail.com>
 <53E28CAB.4040800@web.de>
 <20140806220832.GA12427@google.com>
 <xmqqr40tkxcp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Robert Dailey <rcdailey.lists@gmail.com>,
	Git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 07 01:52:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFB0C-0008UZ-CU
	for gcvg-git-2@plane.gmane.org; Thu, 07 Aug 2014 01:52:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754089AbaHFXv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Aug 2014 19:51:56 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:35558 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753556AbaHFXvz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Aug 2014 19:51:55 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so4309351pab.0
        for <git@vger.kernel.org>; Wed, 06 Aug 2014 16:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=H2pnqGSHZ1b/En2uHBJWlC506Ww+IAEnj41FHsUOwj8=;
        b=gc9mmWFWAoeOSp9fIxV8OxlHtX0DeUb8RPJ/U3HjE9JhLBuEL0HtK2WHmxD9aJYrSr
         //1eOoRcEuQDk4Jcvzvi9ZiSlRcsf0agl910tuq2wGmFNQADNDvDgwwBwvsbTXjMF/+Q
         e7i3pQGpyBr4/XGjEAW7K5Yahf6xdEliZhLdPlZLiPUj2tYMNkuo3nawfP7XX6oF6xcY
         Bitm5j3Nv0NSN8DxgztWNzmglD5j3xcLdSvzQmTSMIpxUFQhjN7TUguekhWMh1On6/Kl
         96hAbjPX3zusrkCpd2FrthDgNVMpH4CMt14L/zVQeEdHnnuDO8ggtdA92/sJhW+t0vaS
         mIEg==
X-Received: by 10.70.133.33 with SMTP id oz1mr14253833pdb.72.1407369114956;
        Wed, 06 Aug 2014 16:51:54 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:6468:14d6:3fee:7b4e])
        by mx.google.com with ESMTPSA id sm4sm8237257pab.7.2014.08.06.16.51.54
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 06 Aug 2014 16:51:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqr40tkxcp.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254916>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>>  2. Submodules aware of their superproject and of the parent's branches.
>>     In other words, submodules would act as though under refs/ they
>>     had a symlink
>>
>> 	parent -> ../../../refs
>>
>>     So you could do
>>
>> 	git checkout --recurse-submodules master
>>
>> 	cd path/to/submodule
>> 	git checkout parent/heads/next
>>
>>     This would avoid danger from "git gc" in submodules and would
>>     get rid of most of the motivation for named branches in the
>>     submodule, I'd think.
>
> Are you assuming that they share their object stores?

No.  The 'symlink' thing is a think-o.  (When trying to explain the
idea I ended up oversimplifying and speaking nonsense.)

What I wanted to say is that parent/heads/next would be a way to
refer from the submodule to the same commit as

	refs/heads/next:path/to/submodule

refers to in the parent.

Thanks for clarifying,
Jonathan
