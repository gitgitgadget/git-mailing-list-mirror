From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] merge-recursive: option to specify rename threshold
Date: Mon, 27 Sep 2010 15:01:25 -0700
Message-ID: <FFDB2371-6C96-472C-A650-412546636450@sb.org>
References: <A0604F16-CA84-4A84-B74B-CE8AB455DF77@sb.org> <1285202724-52474-1-git-send-email-kevin@sb.org> <7vk4m7n7uo.fsf@alter.siamese.dyndns.org> <D5046A0E-7A35-421D-856F-5278FBE02914@sb.org> <7vocbj3gjk.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 28 00:01:48 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P0LlZ-0000NW-0v
	for gcvg-git-2@lo.gmane.org; Tue, 28 Sep 2010 00:01:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759375Ab0I0WBa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 18:01:30 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:53527 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759323Ab0I0WBa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 18:01:30 -0400
Received: by pxi10 with SMTP id 10so1552898pxi.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 15:01:29 -0700 (PDT)
Received: by 10.142.204.8 with SMTP id b8mr7071741wfg.158.1285624889853;
        Mon, 27 Sep 2010 15:01:29 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id i20sm7944714wff.5.2010.09.27.15.01.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 15:01:27 -0700 (PDT)
In-Reply-To: <7vocbj3gjk.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157367>

On Sep 26, 2010, at 10:24 PM, Junio C Hamano wrote:

> Kevin Ballard <kevin@sb.org> writes:
> 
>>> At the end-user level, this new option to merge-recursive has exactly the
>>> same meaning as existing -M given to "diff" family; people would probably
>>> want to see it made available as a synonym to "diff" family as well, no?
>> 
>> You mean so you can type `git diff --rename-score=50% foo`? A reasonable
>> suggestion, but then what do we do with -B and -C? It doesn't make much
>> sense to give a longer name to only one of the three options. This patch
>> was concerned with simply exposing the functionality to the merge
>> strategy and doesn't attempt to address the problem of providing long
>> names for this trio of options.
> 
> I would call them --break-threshold and --copy-threshold respectively.
> 
> I have been happy without long option names when we originally had only
> short names, but some people seem to be able to be more explicit, so...

After taking a look at this, it raises another question. -B, -M, and -C all have optional arguments, but the long-form names don't seem to support that. `git diff --rename-threshold= foo` would work, but looks mighty odd, and if I make it support `git diff --rename-threshold foo` that would also work, but the name doesn't seem appropriate without the argument. Should I go ahead and support `git diff --rename-threshold foo` and just live with it looking weird, or do you have a better suggestion?

-Kevin Ballard