From: Kyle Moffett <kyle@moffetthome.net>
Subject: Re: General support for ! in git-config values
Date: Thu, 2 Feb 2012 21:08:46 -0800
Message-ID: <CAGZ=bq++R+X+2r2_zQ4UZ6JvDC9W9_4nF23MQ6+612_Qe2RS4Q@mail.gmail.com>
References: <20120201184020.GA29374@sigill.intra.peff.net> <CACBZZX5mX55Rh8b2GYv7wKbCCypCkrn5AiM9BpXydgcYxHWdQA@mail.gmail.com>
 <7v62fq2o03.fsf@alter.siamese.dyndns.org> <CANgJU+X+UZmycwE6xkJ-zHfT7ai6nV9zbeR4WYnAXczL5JtqjA@mail.gmail.com>
 <7vliom13lm.fsf@alter.siamese.dyndns.org> <CANgJU+XQWdFmfmBJ4KX4GBz1a=TrVbp9BphGmhEb5Gphmzogjw@mail.gmail.com>
 <7v7h06109t.fsf@alter.siamese.dyndns.org> <CANgJU+WCdsF+igCWoueYcChYBvNyj5je_kvWorCBOgh5D7Bb9g@mail.gmail.com>
 <20120202023857.GA11745@sigill.intra.peff.net> <CANgJU+X2dRP__PFAywGEisDS3xyF7fSszSQG6BO61j2TMKL3Qg@mail.gmail.com>
 <20120202095432.GA19356@sigill.intra.peff.net> <CANgJU+XoZd6x6jdSHszigZaPgi+6H3Nbf4OG7p0y1_=7m+qntA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: demerphq <demerphq@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 03 06:09:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RtBP3-0004ft-9J
	for gcvg-git-2@plane.gmane.org; Fri, 03 Feb 2012 06:09:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750733Ab2BCFJL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Feb 2012 00:09:11 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:64866 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750718Ab2BCFJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2012 00:09:09 -0500
Received: by qcqw6 with SMTP id w6so1875613qcq.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 21:09:08 -0800 (PST)
Received: by 10.229.78.87 with SMTP id j23mr2155845qck.87.1328245748283; Thu,
 02 Feb 2012 21:09:08 -0800 (PST)
Received: by 10.229.135.207 with HTTP; Thu, 2 Feb 2012 21:08:46 -0800 (PST)
In-Reply-To: <CANgJU+XoZd6x6jdSHszigZaPgi+6H3Nbf4OG7p0y1_=7m+qntA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189737>

On Thu, Feb 2, 2012 at 02:21, demerphq <demerphq@gmail.com> wrote:
>> So far I haven't seen an actual patch to comment on
>> (or even a proposed syntax beyond starting a string with "!", which I
>> think is a non-starter due to conflicting with existing uses),
>
> I understand. I think we will probably use backtick quoting in git-deploy. So
>
> deploy.prefix=`cat /etc/SERVER_ROLE`
>
> will execute cat /etc/SERVER_ROLE and use the results as the value of
> the config option.

Alternatively, you could extend the recent proposal for GIT config
"include" statements so that something like this works:

[include]
    exec = echo "deploy.prefix = `cat /etc/SERVER_ROLE`"
    exec = /usr/local/bin/git-config-for-ldap-user

Thoughts?

Cheers,
Kyle Moffett
