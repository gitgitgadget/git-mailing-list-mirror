From: Phillip Susi <psusi@ubuntu.com>
Subject: Re: stash refuses to pop
Date: Tue, 10 Apr 2012 14:56:59 -0400
Message-ID: <4F84827B.80104@ubuntu.com>
References: <4F847350.3000409@ubuntu.com> <7vpqbfpim2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 20:57:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHgFX-0000pZ-IM
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 20:57:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758604Ab2DJS5B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 14:57:01 -0400
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.120]:6275 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753678Ab2DJS5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 14:57:00 -0400
X-Authority-Analysis: v=2.0 cv=bLSU0YCZ c=1 sm=0 a=/DbS/tiKggfTkRRHPZEB4g==:17 a=Qsx_du5GiBkA:10 a=vnNYxAp2wzwA:10 a=S1A5HrydsesA:10 a=8nJEP1OIZ-IA:10 a=fxJcL_dCAAAA:8 a=r73Kp_5zozj0vRj3mnUA:9 a=wPNLvfGTeEIA:10 a=2eKvNQJKnqYA:10 a=/DbS/tiKggfTkRRHPZEB4g==:117
X-Cloudmark-Score: 0
X-Originating-IP: 67.78.168.186
Received: from [67.78.168.186] ([67.78.168.186:55779] helo=[10.1.1.230])
	by cdptpa-oedge03.mail.rr.com (envelope-from <psusi@ubuntu.com>)
	(ecelerity 2.2.3.46 r()) with ESMTP
	id 79/8C-29249-B72848F4; Tue, 10 Apr 2012 18:56:59 +0000
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <7vpqbfpim2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195120>

On 4/10/2012 2:05 PM, Junio C Hamano wrote:
> Phillip Susi<psusi@ubuntu.com>  writes:
>
>> git stash refuses to apply a stash if it touches files that are
>> modified.  Using stash -p to selectively stash some hunks of a file
>> and then immediately trying to pop that stash causes this failure
>> every time.
>
> I think that is by design.

Being able to push something that you can not pop seems to be broken 
design...

> I do not use "stash -p" and personally, but I think its broken from the UI
> point of view.  The point of "stash" is to clear your workspace to a
> pristine state, do random things, and after you are done and cleared your
> workspace again, apply it to come back to the original state or a state as
> if you started your WIP from the updated clean-slate.

Or temporarily undo some changes and come back to those changes later?

> So probably the right way to use "stash -p" (if there were such a thing)
> would be to stash away the remainder in a separate stash with another
> "stash" without "-p" (which will clear your workspace to a pristine state)
> and then pop the one you created with "stash -p", I think.

That would not get you back to the state you were in when you first 
stashed, but instead to a state where you have the first set of changes, 
but not the second ( which you then also can not pop due to the first 
changes being there ).
