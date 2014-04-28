From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 1/2] trailer: fix to ignore any line starting with '#'
Date: Mon, 28 Apr 2014 10:16:14 +0200
Message-ID: <CAP8UFD0R6g13k8GM6wQXw2qgnjeOb=z_SC6jG6EfXvo8ALdg6g@mail.gmail.com>
References: <20140427200327.16880.53255.chriscool@tuxfamily.org>
	<20140427201238.16880.13774.chriscool@tuxfamily.org>
	<535DEE08.9090402@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Junio C Hamano <gitster@pobox.com>,
	git <git@vger.kernel.org>, Johan Herland <johan@herland.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Thomas Rast <tr@thomasrast.ch>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg Kroah-Hartman <greg@kroah.com>, Jeff King <peff@peff.net>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Mon Apr 28 10:16:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wegjg-0001HE-0s
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 10:16:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752239AbaD1IQT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 04:16:19 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:37809 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752137AbaD1IQP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 04:16:15 -0400
Received: by mail-vc0-f174.google.com with SMTP id ib6so1270170vcb.19
        for <git@vger.kernel.org>; Mon, 28 Apr 2014 01:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DHnC8BXA72Pa3SIEm1ZFxgHQymje8CImqN/mZNKRZdU=;
        b=nZlTuKhvdwmx0ysM0wwntmcr9AgduyLVRTCPfaijJ2e+e5q/kh0f4yhSvKqDAeKK1k
         3VhIQUky4KAKBcMasl8EBgFX4624KlILBlsz5ZUS3exmbzgYLQps8U3/Hxgks37nlBPz
         MqwIc12lPfa4mlarKZHYX9I4lU2yA2ksNaIHVDNxnjWSptZP5nclUUoOeLq2qeehrCyS
         GtsXbMlIpLNscen+49l94ONA5ixX7SN/kQRC5n8S9TfedMe4EPQHZBwFv2vHcONXD4DF
         lDlLDEekRoTmysLdMnohTBU7zlNKs7Tqo+lqzLmwVj/+eD6r0FwrWC5kjuR8TcfzdbKu
         CsyQ==
X-Received: by 10.52.229.97 with SMTP id sp1mr19274950vdc.23.1398672974375;
 Mon, 28 Apr 2014 01:16:14 -0700 (PDT)
Received: by 10.58.143.72 with HTTP; Mon, 28 Apr 2014 01:16:14 -0700 (PDT)
In-Reply-To: <535DEE08.9090402@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247242>

On Mon, Apr 28, 2014 at 7:58 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> On 04/27/2014 10:12 PM, Christian Couder wrote:
>> It looks like the commit-msg hook is passed a commit
>> message that can contain lines starting with a '#'.
>> Those comment lines will be removed from the commit
>> message after the hook is run.
>>
>> If we want "git interpret-trailers" to be able to
>> process commit messages correctly in the commit-msg
>> hook we need to ignore those lines.
>
> Shouldn't this take into account the config setting core.commentchar?

Yes, I will have a look at that.

Thanks,
Christian.
