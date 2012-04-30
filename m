From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT] Preventing "git push" when guilt patches are applied
Date: Mon, 30 Apr 2012 12:34:46 +0200
Message-ID: <4F9E6AC6.9070606@opera.com>
References: <4F8FBD63.9050507@opera.com> <CAPc5daV4mK7aLRAm4Ow9TBPf5Tj3B=Qpf0=cRXjbeZoOuoYMKQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, ceder@lysator.liu.se
To: Junio C Hamano <gitster-vger@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 30 12:35:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOnwl-0000Od-Ql
	for gcvg-git-2@plane.gmane.org; Mon, 30 Apr 2012 12:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109Ab2D3KfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 06:35:05 -0400
Received: from smtp.opera.com ([213.236.208.81]:46935 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755070Ab2D3KfE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 06:35:04 -0400
Received: from [10.30.1.61] (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q3UAYrXP017133
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 30 Apr 2012 10:34:59 GMT
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120412 Thunderbird/11.0.1
In-Reply-To: <CAPc5daV4mK7aLRAm4Ow9TBPf5Tj3B=Qpf0=cRXjbeZoOuoYMKQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196550>

On 04/19/2012 05:19 PM, Junio C Hamano wrote:
> On Thu, Apr 19, 2012 at 12:23 AM, Per Cederqvist<cederp@opera.com>  wrote:
>> I have by accident done "git push" when I intended to write "guilt
>> push" a couple of times.  If there are guilt patches applied when I do
>> this the result is that (part of) my half-finished patch series is
>> pushed to the master branch.  That is of course not good.
>>
>> TopGit avoids this issue since I'm on a separate branch when patches
>> are applied.
>> ...
>> I'd like to add something similar to Guilt, to avoid making this
>> mistake ever again.  (It is quite embarrassing to clean up after you
>> push a couple of half-baked patches.)  But I don't know how the
>> feature should be designed.  Some ideas:
>> ...
>
> Isn't the most obvious one (somehow missing from your list) from your
> observation you
> described earlier to have guilt apply patches on a separate branch?

It wasn't obvious to me, but I think it is a good idea. I've posted
an implementation of this here:

http://thread.gmane.org/gmane.comp.version-control.git/196546

> Would it also work to set "[push] default = none"?  Then "git push"
> typed by mistake for
> "guilt push" (I am assuming that "$whichever push" does not take any
> other argument,
> and that is the root cause of your fat-finger-embarrassment issue)
> would not push anything
> out.

That would maybe help me, but I would still be reluctant to recommend
Guilt to my friends, as I don't want to be the reason they make stupid
mistakes. :-)

     /ceder
