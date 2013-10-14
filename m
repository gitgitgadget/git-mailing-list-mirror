From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH gitk 0/4] gitk support for git log -L
Date: Sun, 13 Oct 2013 22:25:48 -0700
Message-ID: <20131014052547.GB25344@google.com>
References: <cover.1370806329.git.trast@inf.ethz.ch>
 <874nblpamj.fsf@linux-k42r.v.cablecom.net>
 <874nbdnomj.fsf@hexa.v.cablecom.net>
 <51F6CB7D.1070806@web.de>
 <87siyu98cq.fsf@linux-k42r.v.cablecom.net>
 <20130818115456.GA6772@iris.ozlabs.ibm.com>
 <874namay5p.fsf@linux-k42r.v.cablecom.net>
 <xmqq61v18u5s.fsf@gitster.dls.corp.google.com>
 <87k3hhadhj.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Mon Oct 14 07:26:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VVafT-0000Sa-FC
	for gcvg-git-2@plane.gmane.org; Mon, 14 Oct 2013 07:26:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778Ab3JNFZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Oct 2013 01:25:52 -0400
Received: from mail-pb0-f52.google.com ([209.85.160.52]:45671 "EHLO
	mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750722Ab3JNFZv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Oct 2013 01:25:51 -0400
Received: by mail-pb0-f52.google.com with SMTP id wz12so6810753pbc.39
        for <git@vger.kernel.org>; Sun, 13 Oct 2013 22:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DO6pneVwP82G/AAjtqJJ2sThm0sx6Ukq0mhCXU98MFI=;
        b=tGbO5+gRnS6xnAtnX0AHtd3PqJ3YGSr6w5xZSBU6cB4LfkNfTsHhntK17/0wBrj6Cy
         uLuOLlEJxrwC8ji5gaR6XzCukicvWJ3G+nI3XF/sC/FVlArQUMlHP30pVyu2JGblDg/2
         lqP0cGg3HjE2GGmb9tD/LpYL5EYlPouG0iZF//wh9QrlQWUlwba1yTtHVlXU1x36I6ZD
         zLBFUx9ql3kUGiQyxdSpTVIgv2rhZf+YywHHuxCAsXurvgkJgbbUPdOizpfBFBopzhfK
         I8yJQTtAfbfyGDjO9PVFoseCSoOftlmhIEL6IsGJkqXgykQAdQt41MMehWcweJlvYiAQ
         iY6g==
X-Received: by 10.68.186.227 with SMTP id fn3mr74432pbc.170.1381728350808;
        Sun, 13 Oct 2013 22:25:50 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id dq3sm75516083pbc.35.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 13 Oct 2013 22:25:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <87k3hhadhj.fsf@linux-k42r.v.cablecom.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236092>

Thomas Rast wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Thomas Rast <trast@inf.ethz.ch> writes:

>>> Existing gitk chokes on 'gitk -S foo', but works with 'git -Sfoo'.
>>
>> I somehow thought that we encourage the "stuck/sticked" form, to
>> reduce things the users need to remember to cope better with options
>> with optional value.
>
> I just looked into this again, to get it rolling.
>
> Am I reading you correctly as saying that any support for the unstuck
> form is entirely coincidental, and it's okay to support only the stuck
> version in new gitk?

Sort of. :)

gitcli(7) says that the sticked form is to be preferred "when you are
scripting git".  But most git commands use parse-options, which of
course supports both forms and makes life easier for humans.

Support for just the sticked form is better than nothing, especially
if the gitk(1) manpage gains a note about it.  In the long run I guess
the ideal would be to add a parse-options-like library to the tcl
support.

My two cents,
Jonathan
