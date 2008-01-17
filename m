From: Pedro Melo <melo@simplicidade.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 00:40:55 +0000
Message-ID: <B2E52451-5153-4EFD-ADBE-AACDCEF6169E@simplicidade.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org> <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org> <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org> <BA518A23-FBF8-49BB-BEFB-D9A6BA1E302C@simplicidade.org> <alpine.LFD.1.00.0801161615330.2806@woody.linux-foundation.org> <E8E76634-FFEC-426B-B04D-3C2CD3790D5E@simplicidade.org> <85zlv5nvge.fsf@lola.goethe.zz>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Kevin Ballard <kevin@sb.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 01:41:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFIoz-0007aM-2I
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 01:41:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751136AbYAQAk7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2008 19:40:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751001AbYAQAk7
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 19:40:59 -0500
Received: from mail.sl.pt ([212.55.140.13]:49836 "EHLO sl.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750917AbYAQAk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 19:40:58 -0500
Received: (qmail 4675 invoked from network); 17 Jan 2008 00:40:56 -0000
X-Virus-Status: Clean (0.01734 seconds) ; Version: 0.3-0.88.6
X-Spam-Flag: NO
X-Spam-Status: NO (0.0/5.0) (0.00008 seconds / 0.07702 sA)
	Checked: by PTMail-AS v0.1 on mail.sl.pt
Received: from unknown (HELO [192.168.1.209]) (melo@[85.240.106.162])
          (envelope-sender <melo@simplicidade.org>)
          by mail-sl (qmail-ldap-1.03) with SMTP
          for <torvalds@linux-foundation.org>; 17 Jan 2008 00:40:56 -0000
Received-SPF: neutral (mail-sl: domain of (null) is neutral about designating 85.240.106.162 as permitted sender)
In-Reply-To: <85zlv5nvge.fsf@lola.goethe.zz>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70789>

Hello,

On Jan 17, 2008, at 12:32 AM, David Kastrup wrote:
> Pedro Melo <melo@simplicidade.org> writes:
>> On Jan 17, 2008, at 12:16 AM, Linus Torvalds wrote:
>>> On Wed, 16 Jan 2008, Pedro Melo wrote:
>>>>
>>>> The difference I see between us is that if I tell my filesystem  
>>>> that
>>>> I want to name my file with a particular string encoded in X, users
>>>> using encoding Y will be able to read it correctly. I like my
>>>> filesystem to make that work for me.
>>>
>>> The difference I see between us is that when I tell you that this is
>>> exactly the same thing as your file *contents*, you don't seem to  
>>> get
>>> it.
>>
>> I get that you think its the same thing.
>>
>> What I don't get is why a user should be forced to know what type of
>> encoding he and the other users are using on all the layers going  
>> down
>> to the filesystem. If two users on different systems or in different
>> configurations, choose the same unicode string as the name, why do we
>> need to make it harder for things to just work out?
>
> If you do the normalization in the right place, things will just work
> out.  The file system is not the right place.

No problem, but don't you think that git should to it?

Don't you think its important in a distributed tool that no matter  
what system they use, be it linux or solaris, they are able to talk  
about a file with non-ascii chars and be the same file to both of them?

That's the point I'm making. The fact that I need to set LANG across  
all users of a project is insane...

>> I'm willing to accept a file system or other layer that normalizes
>> encoding of filenames if that makes the end-user life easier,
>> specially in a tool distributed by nature.
>
> Well, as the issue shows it does not make life for the end-user  
> easier.

I'm assuming you are talking about HFS+ and the strange normalization  
it does.

I'm sorry but that was not the problem I sent. I sent a scenario, in  
which two users, using the same linux system but with different LANG  
settings cannot use git reliably.

Although this thread started because of HFS+ "choices", the problem  
is not really related to HFS+ given that you can have the same issues  
even on the same physical <insert flavor here> POSIX system.

Best regards,
-- 
Pedro Melo
Blog: http://www.simplicidade.org/notes/
XMPP ID: melo@simplicidade.org
Use XMPP!
