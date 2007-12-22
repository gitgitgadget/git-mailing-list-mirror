From: Gustaf Hendeby <hendeby@isy.liu.se>
Subject: Re: [PATCH] Move git send-email cover letter temporary file to $GIT_DIR
Date: Sat, 22 Dec 2007 10:13:26 +0100
Message-ID: <476CD536.1060502@isy.liu.se>
References: <7vhcic9e17.fsf@gitster.siamese.dyndns.org>	<1198284202-20666-1-git-send-email-hendeby@isy.liu.se>	<7vmys3358v.fsf@gitster.siamese.dyndns.org>	<ee77f5c20712211718g230802b6jb70e5db1f6a43973@mail.gmail.com>	<7vhcib2phi.fsf@gitster.siamese.dyndns.org>	<ee77f5c20712212304s598d344dg41d03f58084d794e@mail.gmail.com> <7vd4szyuva.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Symonds <dsymonds@gmail.com>, luciano@eurotux.com,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 22 10:14:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J60Qx-0000m5-Bs
	for gcvg-git-2@gmane.org; Sat, 22 Dec 2007 10:14:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147AbXLVJNl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Dec 2007 04:13:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752805AbXLVJNg
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Dec 2007 04:13:36 -0500
Received: from bogotron.isy.liu.se ([130.236.48.26]:32909 "EHLO
	bogotron.isy.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301AbXLVJN3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Dec 2007 04:13:29 -0500
Received: from spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19])
	by bogotron.isy.liu.se (Postfix) with ESMTP id 09AEF25A9B;
	Sat, 22 Dec 2007 10:13:28 +0100 (MET)
Received: from bogotron.isy.liu.se ([130.236.48.26])
 by spamotron.isy.liu.se (spamotron.isy.liu.se [130.236.48.19]) (amavisd-new, port 10022)
 with ESMTP id 04310-07; Sat, 22 Dec 2007 10:13:27 +0100 (MET)
Received: from [192.168.13.34] (85.8.6.119.static.se.wasadata.net [85.8.6.119])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by bogotron.isy.liu.se (Postfix) with ESMTP id 4F1B525A99;
	Sat, 22 Dec 2007 10:13:27 +0100 (MET)
User-Agent: Thunderbird 2.0.0.9 (Windows/20071031)
In-Reply-To: <7vd4szyuva.fsf@gitster.siamese.dyndns.org>
X-Virus-Scanned: by amavisd-new at isy.liu.se
X-Spam-Checker-Version: SpamAssassin 2.63-isy (2004-01-11) on spamotron.isy.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69129>

Junio C Hamano wrote:
> "David Symonds" <dsymonds@gmail.com> writes:
> 
>> On Dec 22, 2007 5:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>> "David Symonds" <dsymonds@gmail.com> writes:
>>>
>>>> On Dec 22, 2007 12:09 PM, Junio C Hamano <gitster@pobox.com> wrote:
>>>>> Don't you have $repo (an instance of Git) at that point?  You
>>>>> should be able to ask repo_path() about it, shouldn't you?
>>>> Isn't git-send-email still useful outside a Git repo?
>>> Then why does it run "rev-parse --git-dir"?
>> I'm suggesting that it should still function just fine without being
>> inside a repo, so it should adequately handle "rev-parse --git-dir"
>> returning 128.
> 
> Ah, true.  Then the current behaviour to use the $(pwd) for
> temporary file area would be Ok for now.

Ok, just drop the patch I don't feel strongly about it.

However, the code today demands that git send-email is run from within a 
git repository - it seems that $repo = Git->repository() assumes that. 
I'd suggest changing this behavior so that git send-email becomes 
runnable from outside a git repository.  Unfortunately, I'm starting to 
get in above my head here, for one I really don't know the helper 
functions in Git.pm.  Is there any good place to read up on what is in 
Git.pm, except for the code itself?

/Gustaf
