From: Vincent van Ravesteijn <vfr@lyx.org>
Subject: Re: [PATCH] Documentation update for 'git branch --list'
Date: Wed, 30 Nov 2011 06:54:38 +0100
Message-ID: <4ED5C51E.5070404@lyx.org>
References: <1321886000-4163-1-git-send-email-vfr@lyx.org> <7v7h2tgyw6.fsf@alter.siamese.dyndns.org> <4ECB43E4.7030607@lyx.org> <7vobw4doey.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, git@drmicha.warpmail.net
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 30 06:54:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVd88-0008Eh-E3
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 06:54:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709Ab1K3Fyr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 00:54:47 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:49028 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab1K3Fyq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 00:54:46 -0500
Received: by eeuu47 with SMTP id u47so80400eeu.19
        for <git@vger.kernel.org>; Tue, 29 Nov 2011 21:54:45 -0800 (PST)
Received: by 10.180.90.195 with SMTP id by3mr640935wib.30.1322632485321;
        Tue, 29 Nov 2011 21:54:45 -0800 (PST)
Received: from [192.168.40.217] (221-44.206-83.static-ip.oleane.fr. [83.206.44.221])
        by mx.google.com with ESMTPS id es5sm989443wbb.11.2011.11.29.21.54.41
        (version=SSLv3 cipher=OTHER);
        Tue, 29 Nov 2011 21:54:42 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:8.0) Gecko/20111105 Thunderbird/8.0
In-Reply-To: <7vobw4doey.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186102>

Op 22-11-2011 19:04, Junio C Hamano schreef:
> Vincent van Ravesteijn<vfr@lyx.org>  writes:
>
>> Op 21-11-2011 18:37, Junio C Hamano schreef:
>> ...
>>> It is natural to expect "git branch --merged pu vr/\*" to list branches
>>> that are contained in 'pu' whose names match the given pattern, but it
>>> seems to try creating a branch called "vr/*" and fails, for example.
>> If this is what you naturally would expect, I would expect the
>> following "git branch vr/*" to work as well.
>> What would you say if we try to interpret the argument as a pattern
>> when the argument is not a valid ref name?
> We don't, as that is inviting mistakes. "git branch vr/*" if you have a
> vr/ directory in your working tree may create vr/a branch from where the
> tip of vr/b points at by mistake.
>
> The "--merged" option is an explicit clue that the user is not interested
> in creating new branch, and the string being a pattern is additional clue.
> The "--list" option was recently added for the explicit purpose of giving
> such a clue as safety measure.

Well, that was the answer that I foresaw.

I will compose a patch implementing an at least consistent behaviour.

Vincent
