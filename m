From: "Kevin P. Fleming" <kpfleming@digium.com>
Subject: Re: Tracking empty directories
Date: Wed, 02 Feb 2011 06:31:38 -0600
Organization: Digium, Inc.
Message-ID: <4D494EAA.2060803@digium.com>
References: <AANLkTi=gf9_618iojpYJgN_msAe-FBq-Jao=sj76VQak@mail.gmail.com> <AANLkTi=u6=mhOd9LFYRy48y41xRcXmYDtktOKoBjjMgO@mail.gmail.com> <20110201183508.GE3771@burratino> <201102012003.50941.jnareb@gmail.com> <AANLkTikkymYmnXh7XB1SM8br_oK-YmAJYfkwjTuLzr+f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>, git@vger.kernel.org,
	Shawn Pearce <spearce@spearce.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 02 14:02:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PkcMC-00043A-1X
	for gcvg-git-2@lo.gmane.org; Wed, 02 Feb 2011 14:02:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754022Ab1BBNCm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Feb 2011 08:02:42 -0500
Received: from mail.digium.com ([216.207.245.2]:40563 "EHLO mail.digium.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613Ab1BBNCl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Feb 2011 08:02:41 -0500
X-Greylist: delayed 1859 seconds by postgrey-1.27 at vger.kernel.org; Wed, 02 Feb 2011 08:02:41 EST
Received: from zimbra.digium.internal ([10.24.55.203] helo=zimbra.hsv.digium.com)
	by mail.digium.com with esmtp (Exim 4.69)
	(envelope-from <kpfleming@digium.com>)
	id 1Pkbs4-0000FF-Fz; Wed, 02 Feb 2011 06:31:40 -0600
Received: from localhost (localhost.localdomain [127.0.0.1])
	by zimbra.hsv.digium.com (Postfix) with ESMTP id 6F7DFD82A1;
	Wed,  2 Feb 2011 06:31:40 -0600 (CST)
Received: from zimbra.hsv.digium.com ([127.0.0.1])
	by localhost (zimbra.hsv.digium.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6E5X8qQsiDmY; Wed,  2 Feb 2011 06:31:39 -0600 (CST)
Received: from [192.168.1.6] (173-24-207-63.client.mchsi.com [173.24.207.63])
	by zimbra.hsv.digium.com (Postfix) with ESMTPSA id 60D42D82A0;
	Wed,  2 Feb 2011 06:31:39 -0600 (CST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101208 Thunderbird/3.1.7
In-Reply-To: <AANLkTikkymYmnXh7XB1SM8br_oK-YmAJYfkwjTuLzr+f@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165909>

On 02/01/2011 09:54 PM, Nguyen Thai Ngoc Duy wrote:
> On Wed, Feb 2, 2011 at 2:03 AM, Jakub Narebski<jnareb@gmail.com>  wrote:
>>> To add, one would use "git update-index --add".
>>
>> Porcelain version could be "git add -N<directory>", don't you agree?
>
> "git add" is recursive, with or without -N. What I worry is user
> accidentally "git add -N<dir>" where<dir>  is not empty, which adds
> everything in<dir>.
>
>>> The magic disappears when you register a file within that directory;
>>> to tell git you want to keep it, one would mkdir and
>>> "git update-index --add" again.  Once it's working, we can think about
>>> if there is a need for making that last step automatic after all
>>> (my guess: "no"). ;-)
>>
>> Hmmm... could we use mechanism similar to assume-unchanged to mark
>> directory as explicitely tracked, and that git should not remove it
>> when it becomes empty?
>
> I think git-attr suits better, more persistent. Although if you insist
> the directory must stay, why not just put a hidden file in there?

That's what I do now... in fact, since the empty directory needs to 
exist in checkouts *and* be empty, adding a .gitignore file with content 
'*' works quite well.

-- 
Kevin P. Fleming
Digium, Inc. | Director of Software Technologies
445 Jan Davis Drive NW - Huntsville, AL 35806 - USA
skype: kpfleming | jabber: kfleming@digium.com
Check us out at www.digium.com & www.asterisk.org
