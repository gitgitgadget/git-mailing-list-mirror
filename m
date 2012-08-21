From: Tim Chase <git@tim.thechases.com>
Subject: Re: misleading diff-hunk header
Date: Tue, 21 Aug 2012 10:42:13 -0500
Message-ID: <5033AC55.8080405@tim.thechases.com>
References: <503385D0.5070605@tim.thechases.com> <87a9xoi82i.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Tue Aug 21 17:41:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3qZo-0002pv-6Y
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 17:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755200Ab2HUPlA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 11:41:00 -0400
Received: from boston.accountservergroup.com ([50.22.11.22]:47091 "EHLO
	boston.accountservergroup.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752336Ab2HUPk7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2012 11:40:59 -0400
Received: from ppp-70-251-69-251.dsl.rcsntx.swbell.net ([70.251.69.251] helo=[192.168.1.12])
	by boston.accountservergroup.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <git@tim.thechases.com>)
	id 1T3qZe-0004gK-9W; Tue, 21 Aug 2012 10:40:58 -0500
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111120 Icedove/3.1.16
In-Reply-To: <87a9xoi82i.fsf@thomas.inf.ethz.ch>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - boston.accountservergroup.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - tim.thechases.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203968>

On 08/21/12 10:22, Thomas Rast wrote:
> Tim Chase <git@tim.thechases.com> writes:
> 
>> diff.{type}.xfuncname seems to start searching backwards in
>> from the beginning of the hunk, not the first differing line.
> [...]
>>   @@ -4,4 +4,5 @@ int call_me(int maybe)
>>
>>    int main()
>>    {
>>   +  return 0;
>>    }
>>
>> misleadingly suggesting that the change occurred in the call_me()
>> function, rather than in main()
> 
> I think that's intentional, and matches what 'diff -p' does.  It gives
> you the context before the hunk.  After all, if a new function starts in
> the leading context lines, you can see that in the usual diff data.

Okay...I tested "diff -p" and can't argue (much) with historical
adherence.  It just makes it hard for me to gather some stats on the
functions that changed, and requires that I look in more than one
place (both in the header, and in the leading context) rather than
having a single authoritative place to grep.

Then again, "diff -p" only seems to support C functions, while git
supports bibtex, cpp, html, java, objc, pascal, php, python, ruby,
and tex out-of-the-box, with the option to build your own
function-finder, so pure adherence to history gets a little muddied.

Thanks for your thoughts,

-tkc
