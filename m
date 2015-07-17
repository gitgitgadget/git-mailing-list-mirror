From: Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v3] gitk: Add a "Copy commit summary" command
Date: Fri, 17 Jul 2015 22:59:17 +0200
Message-ID: <55A96CA5.3050504@drbeat.li>
References: <205a18f7f8a7892a1fa63a91a84bfd9b@drbeat.li>	<CAPig+cR=u_ak_=J=gSAWfiNB01R7FBG+bCrx+k1HNAE0xHtwFQ@mail.gmail.com> <xmqqwpxy1yoo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Git List <git@vger.kernel.org>, Paul Mackerras <paulus@samba.org>
To: Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 23:00:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGCkH-0007dw-33
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jul 2015 23:00:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752913AbbGQVAd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 17:00:33 -0400
Received: from mx1.2b3w.ch ([92.42.186.250]:34381 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751702AbbGQVAc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 17:00:32 -0400
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id 84FC0C3442;
	Fri, 17 Jul 2015 23:00:29 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from mcmini.bolli (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id 5B2BCC33DD;
	Fri, 17 Jul 2015 23:00:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <xmqqwpxy1yoo.fsf@gitster.dls.corp.google.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274101>

On 17.07.15 19:28, Junio C Hamano wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
>>> Signed-off-by: Beat Bolli <dev+git@drbeat.li>
>>> Reviewed-by: Eric Sunshine <sunshine@sunshineco.com>
>>> Reviewed-by: Johannes Sixt <j6t@kdbg.org>
>>
>> You should drop these Reviewed-by: footers, as they imply that the
>> code was thoroughly digested and the implementation deemed correct.
> 
> ... and the most importantly, the named people said that themselves.
> 
> I do not think that happened here (yet).
> 
>>> +proc copysummary {} {
>>> +    global rowmenuid
>>> +
>>> +    set format "%h (\"%s\", %ad)"
>>> +    set summary [exec git show -s --pretty=format:$format --date=short \
>>> +                 $rowmenuid]
>>> +
>>> +    clipboard clear
>>> +    clipboard append $summary
>>> +}
>>> +
> 
> I think this is a reasonable implementation.  The usual "spawning a
> process for each commit is too expensive" would not apply, because
> it is done on demand only for the single commit that the end-user
> specified.

Thanks, Junio! That was my thought as well.

So, the question remains now if adding something like
--abbrev=$autosellen (maybe only if it's not set to its default value),
as Paul suggested, would make sense.

Beat
