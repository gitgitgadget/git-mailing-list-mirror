From: Andrew Wong <andrew.w-lists@sohovfx.com>
Subject: Re: [PATCH] rebase -i: remove CHERRY_PICK_HEAD when cherry-pick failed
Date: Mon, 02 Apr 2012 18:38:49 -0400
Message-ID: <4F7A2A79.1040900@sohovfx.com>
References: <CAMP44s1EAwHjQ7S2ArLvhNg5qkR05DRJ70tQmP8sXYdOP=i_zQ@mail.gmail.com> <1332106632-31882-1-git-send-email-andrew.kw.w@gmail.com> <7vk42gbkl1.fsf@alter.siamese.dyndns.org> <4F679E67.4080708@sohovfx.com> <4F6E289B.4020104@sohovfx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Andrew Wong <andrew.kw.w@gmail.com>, git@vger.kernel.org
To: Andrew Wong <andrew.w@sohovfx.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 00:39:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEptq-0007G9-RJ
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 00:38:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752100Ab2DBWiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 18:38:54 -0400
Received: from smtp03.beanfield.com ([76.9.193.172]:50185 "EHLO
	smtp03.beanfield.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab2DBWix (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 18:38:53 -0400
X-Spam-Status: No
X-beanfield-mta03-MailScanner-From: andrew.w-lists@sohovfx.com
X-beanfield-mta03-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-2.9, required 6, autolearn=not spam, ALL_TRUSTED -1.00,
	BAYES_00 -1.90)
X-beanfield-mta03-MailScanner: Found to be clean
X-beanfield-mta03-MailScanner-ID: 1SEpth-0006DO-Ox
Received: from [66.207.196.114] (helo=[192.168.1.112])
	by mta03.beanfield.com with esmtpsa (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.76)
	(envelope-from <andrew.w-lists@sohovfx.com>)
	id 1SEpth-0006DO-Ox; Mon, 02 Apr 2012 18:38:49 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101026 SUSE/3.0.10 Thunderbird/3.0.10
In-Reply-To: <4F6E289B.4020104@sohovfx.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194573>

On 03/24/2012 04:03 PM, Andrew Wong wrote:
> On 12-03-19 5:00 PM, Andrew Wong wrote:
>> On 03/19/2012 12:51 PM, Junio C Hamano wrote:
>>> Isn't the real solution *not* to create the CHERRY_PICK_HEAD in the
>>> sequencer when it is not know if it is needed, instead of the
>>> current code
>>> which seems to create first and then selectively try to unlink() it?
>>>
>> Though if the additional flag in "cherry-pick" and additional option in
>> sequencer could be useful elsewhere, I could do it that way too.
> I looked into adding a "no-state" flag in 'cherry-pick' to not create
> the CHERRY_PICK_HEAD, but 'commit' actually has several dependencies
> on CHERRY_PICK_HEAD, such as recording reflog message,
> 'prepare-commit-msg' hook, and formatting a user message. So if we
> want to continue to pursue this path, we'd have to preserve those
> behaviors in 'commit' as well. It's probably not a good idea to make
> all these changes in  'cherry-pick' and 'commit' just to avoid a
> simple cleanup in 'rebase -i'. So I still prefer the patch I submitted
> earlier.
Can we look into queuing this patch? Or does anyone have any thoughts on
this?
