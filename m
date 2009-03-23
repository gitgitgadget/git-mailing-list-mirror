From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] difftool: add support for an extended revision syntax
Date: Mon, 23 Mar 2009 17:46:34 +0100
Message-ID: <49C7BCEA.1060309@drmicha.warpmail.net>
References: <1237803348-9329-1-git-send-email-davvid@gmail.com> <49C7A20E.7060503@drmicha.warpmail.net> <20090323163343.GB16258@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 17:48:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlnKP-0007YF-3K
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 17:48:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756620AbZCWQqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 12:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755680AbZCWQqw
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 12:46:52 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:33226 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755250AbZCWQqw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 12:46:52 -0400
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id 2B69A2F66FD;
	Mon, 23 Mar 2009 12:46:50 -0400 (EDT)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Mon, 23 Mar 2009 12:46:50 -0400
X-Sasl-enc: kin1siCRgFV6wqFyP3S6irK4O69kV+Ouj1H4E9Zb2whk 1237826809
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 688E146273;
	Mon, 23 Mar 2009 12:46:49 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090323 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <20090323163343.GB16258@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114336>

David Aguilar venit, vidit, dixit 23.03.2009 17:33:
> On  0, Michael J Gruber <git@drmicha.warpmail.net> wrote:
>> David Aguilar venit, vidit, dixit 23.03.2009 11:15:
>>>
>>> This makes answering that question considerably easier.
>>> Users can now simply say:
>>>
>>> 	$ git difftool <file>~
>>>
>>> to compare <file> in the worktree against its
>>> previous version, and:
>>>
>>> 	$ git difftool <file>~2 <file>~
>>>
>>> to compare <file> from 2 versions ago to <file>'s
>>> previous version, etc.
>>>
>>
>> I like the idea of having a shortcut like that a lot, but I'm sorry I'm
>> not supportive of a tool-specific rev syntax extension; for principal
>> reasons, but also because diff, checkout and maybe others could make
>> good use of it.
> 
> I completely agree.  I want a convenient shortcut to use everywhere.
> 
> 
>> Work is underway on clearing out the issue of forbidden characters in
>> revision specifiers. We already have commit:file. I think something like
>> ~2:file would be short enough as well as in line with the usual
>> semantics. Similarly,
>>
>> git diff ~3 ~2 file
>> git diff ~3 file
>>
>> would be short and simple as soon as ~3 is implemented to be a shortcut
>> for HEAD~3. (I'm not sure we can actually use ~, even though it would
>> fit in with the usual "if it's not specified it's HEAD".) This would
>> only need a shortcut for HEAD, such as not even specifying it (as above)
>> or c~ with c being our new fancy character for that.
> 
> 
> One of my ulterior motives for sending this patch was to
> start a discussion on this topic.  I missed the discussion
> about clearing out forbidden characters so I'll see if I can
> find it in the archives.  Do you happen to have a link?
> 
> Keep in mind that the syntax that this patch added does
> not have file~3 = HEAD~3.  file~3 means finding file as it
> existed 3 changes-to-file ago, which is != to HEAD~3 if file
> did not change in the last 3 commits.
> 
> It basically runs 'git log -- file' so that only the commits
> that touch file are considered.
> 
> Are you suggesting that ~3:file could be the shortcut for
> this, or would we need a different syntax since you just
> said that ~3 would be a shortcut for HEAD~3?

I think both would be useful. Depending on the way it's done, only
HEAD~3 maybe be realizable.

> If there's work on syntax-sugarfying diff/checkout/etc. with
> these kind of shortcuts then I would like to help out with
> patches, testing, etc.

http://article.gmane.org/gmane.comp.version-control.git/114257 is the
newest installment, although
http://article.gmane.org/gmane.comp.version-control.git/114076 and
especially
http://article.gmane.org/gmane.comp.version-control.git/113647 is very
worthwhile reading :)

[Isn't there a better way to link to posts? I think I used to take
message ids.]

> This is a feature that lots of users would enjoy--I know that
> for sure.
> 
