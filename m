From: Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [PATCH 1/2] fetch: better alignment in ref summary
Date: Thu, 26 May 2016 10:22:25 -0400
Message-ID: <574706A1.8040606@xiplink.com>
References: <20160522112019.26516-1-pclouds@gmail.com>
 <20160522112019.26516-2-pclouds@gmail.com>
 <xmqqfut9bnff.fsf@gitster.mtv.corp.google.com>
 <CACsJy8BS2n8T1smxEJMPNiXBvMYHWnQ9BQGk_OKqJd1GFcuk7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 16:31:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5wKB-0001X0-TG
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 16:31:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754084AbcEZObm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 10:31:42 -0400
Received: from smtp138.dfw.emailsrvr.com ([67.192.241.138]:52403 "EHLO
	smtp138.dfw.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754050AbcEZObm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 10:31:42 -0400
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 May 2016 10:31:42 EDT
Received: from smtp30.relay.dfw1a.emailsrvr.com (localhost.localdomain [127.0.0.1])
	by smtp30.relay.dfw1a.emailsrvr.com (SMTP Server) with ESMTP id 2F39F18019F;
	Thu, 26 May 2016 10:22:27 -0400 (EDT)
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp30.relay.dfw1a.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 496C01801FA;
	Thu, 26 May 2016 10:22:26 -0400 (EDT)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA)
	by 0.0.0.0:465 (trex/5.5.4);
	Thu, 26 May 2016 10:22:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
In-Reply-To: <CACsJy8BS2n8T1smxEJMPNiXBvMYHWnQ9BQGk_OKqJd1GFcuk7w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295656>

On 2016-05-22 09:59 PM, Duy Nguyen wrote:
> On Mon, May 23, 2016 at 7:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> That is, I wonder if the above can become something like:
>>
>>>  From github.com:pclouds/git
>>>   * [new branch]      { -> pclouds/}2nd-index
>>>   * [new branch]      { -> pclouds/}3nd-index
>>>   * [new branch]      { -> pclouds/}file-watcher
>>>   ...
>>
>> The above example borrows the idea used in diffstat label for
>> renaming patch and I think you can design a better notataion, but a
>> big point is that you can shorten the whole thing by not repeating
>> the common part twice.  The arrow aligns merely as a side effect of
>> the shortening, taking advantage of the fact that most people fetch
>> with "$their_prefix/*:$our_prefix/*" renaming refspec.
>
> I did think of that. My only concern is, with the new output I can't
> simply copy the ref name (e.g. pclouds/2nd-index) and use it to, say,
> examine with git-log. But I'm more of a "tab tab tab" person than
> "copy and paste", so I don't know how often people need to do that.

Why do we need any kind of "->" at all?  How about simply (with an 
update to "old-branch" for comparison to probably-more-common output):

 From github.com:pclouds/git
    cafed0c..badfeed  pclouds/old-branch
  * [new branch]      pclouds/2nd-index
  * [new branch]      pclouds/3nd-index
  * [new branch]      pclouds/file-watcher

		M.
