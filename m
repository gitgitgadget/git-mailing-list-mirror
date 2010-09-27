From: Kevin Ballard <kevin@sb.org>
Subject: Re: [PATCH] merge-recursive: option to specify rename threshold
Date: Sun, 26 Sep 2010 22:04:38 -0700
Message-ID: <D5046A0E-7A35-421D-856F-5278FBE02914@sb.org>
References: <A0604F16-CA84-4A84-B74B-CE8AB455DF77@sb.org> <1285202724-52474-1-git-send-email-kevin@sb.org> <7vk4m7n7uo.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 07:04:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P05tN-0004ld-Kg
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 07:04:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106Ab0I0FEl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Sep 2010 01:04:41 -0400
Received: from mail-px0-f174.google.com ([209.85.212.174]:35313 "EHLO
	mail-px0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751234Ab0I0FEk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Sep 2010 01:04:40 -0400
Received: by pxi10 with SMTP id 10so1257418pxi.19
        for <git@vger.kernel.org>; Sun, 26 Sep 2010 22:04:40 -0700 (PDT)
Received: by 10.114.130.5 with SMTP id c5mr7749190wad.125.1285563880198;
        Sun, 26 Sep 2010 22:04:40 -0700 (PDT)
Received: from [10.0.1.14] ([24.130.32.253])
        by mx.google.com with ESMTPS id c10sm9736826wam.13.2010.09.26.22.04.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 26 Sep 2010 22:04:39 -0700 (PDT)
In-Reply-To: <7vk4m7n7uo.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157298>

On Sep 26, 2010, at 9:11 PM, Junio C Hamano wrote:

> Kevin Ballard <kevin@sb.org> writes:
> 
>> The recursive merge strategy turns on rename detection but leaves the
>> rename score at the default. Add a strategy option to allow the user
>> to specify a rename score to use.
> 
> Sounds straightforward, except that Documentation/diff-options.txt seems
> to call the number associated with -M "threshold", not "score".  The title
> of the patch incidentally says threshold as well ;-)

It says "threshold" because that's how the -M switch to git-diff is documented. The merge strategy option is called "rename-score" partially because that's what it's called internally, and partially because it's just an easier name to remember/type. I have no objections to calling it "rename-threshold" if you think that's better.

> At the end-user level, this new option to merge-recursive has exactly the
> same meaning as existing -M given to "diff" family; people would probably
> want to see it made available as a synonym to "diff" family as well, no?

You mean so you can type `git diff --rename-score=50% foo`? A reasonable suggestion, but then what do we do with -B and -C? It doesn't make much sense to give a longer name to only one of the three options. This patch was concerned with simply exposing the functionality to the merge strategy and doesn't attempt to address the problem of providing long names for this trio of options.

-Kevin Ballard