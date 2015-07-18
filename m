From: Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v2] gitk: Add a "Copy commit summary" command
Date: Sat, 18 Jul 2015 14:45:34 +0200
Message-ID: <55AA4A6E.9000301@drbeat.li>
References: <1437060565-4716-1-git-send-email-dev+git@drbeat.li> <20150717092251.GB5916@iris.ozlabs.ibm.com> <xmqqvbdi3ipb.fsf@gitster.dls.corp.google.com> <20150718122325.GA6817@yogo.paulus.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jul 18 14:47:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGRW7-0006Dn-7F
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 14:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752399AbbGRMqz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 18 Jul 2015 08:46:55 -0400
Received: from mx1.2b3w.ch ([92.42.186.250]:35164 "EHLO mx1.2b3w.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750809AbbGRMqy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 18 Jul 2015 08:46:54 -0400
Received: from mx1.2b3w.ch (localhost [127.0.0.1])
	by mx1.2b3w.ch (Postfix) with ESMTP id 8109EC3442;
	Sat, 18 Jul 2015 14:46:51 +0200 (CEST)
X-Spam-Checker-Version: SpamAssassin 3.3.2 (2011-06-06) on dilbert.2b3w.ch
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=ALL_TRUSTED,BAYES_00
	autolearn=ham version=3.3.2
Received: from mcmini.bolli (178-241-153-5.dyn.cable.fcom.ch [5.153.241.178])
	by mx1.2b3w.ch (Postfix) with ESMTPSA id 59891C33DD;
	Sat, 18 Jul 2015 14:46:51 +0200 (CEST)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <20150718122325.GA6817@yogo.paulus.ozlabs.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274163>

On 18.07.15 14:23, Paul Mackerras wrote:
> On Fri, Jul 17, 2015 at 08:30:24AM -0700, Junio C Hamano wrote:
>> Paul Mackerras <paulus@samba.org> writes:
>>
>>> We have an item in the preferences menu to control the SHA1 length
>>> that is automatically selected when going to a new commit.  It's
>>> stored in the variable $autosellen.  That seems like it would be a
>>> reasonable choice for the SHA1 length to use here.
>>
>> Reusing a configuration that is used to control something similar
>> sounds sensible to me.
>>
>>> The only possible
>>> problem is that it defaults to 40 and so might give an overly long
>>> result for some users.  Maybe you could use $autosellen but limit it
>>> to at most 12 or 16 or something like that.
>>
>> How is the thing that is "automatically selected when going to a new
>> commit" used by the end user?  What is the reason why people may
>> want to configure it?  I understand that this is the string that
>> goes into the selection buffer, so presumably people are using this
>> selection to paste elsewhere?  If so, that sounds like very similar
>> to Beat's use case---perhaps if 40 is too long for Beat's use case
>> as a sensible default, then it is also too long for its original use
>> case?
> 
> It's used for pasting into commit messages and emails, and it's used
> for pasting onto the command line when typing git commands.  For the
> second, the length doesn't matter; the limit was added for the first
> case.
> 
>> Or do you expect it to be common to want to use autosellen set to 40
>> and Beat's abbrev len set to much shorter, e.g. 16?  If so they may
>> deserve two different settings, with different defaults.
> 
> I would think that if $autosellen is 40 it's almost certainly because
> the user hasn't found that control in the preferences window. :)
> 
>> Artificially limiting it to 12 or 16 does not sound all that
>> sensible, though.
> 
> Adding --abbrev=$autosellen if $autosellen is not 40 sounds like it
> would do what we want.

That's exactly what I did in v4 of the patch:
http://article.gmane.org/gmane.comp.version-control.git/274161

Thanks,
Beat
