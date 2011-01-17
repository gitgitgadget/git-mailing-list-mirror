From: "Aaron S. Meurer" <asmeurer@gmail.com>
Subject: Re: git bisect problems/ideas
Date: Mon, 17 Jan 2011 11:23:19 -0700
Message-ID: <54DED602-0BA7-4462-AC00-1DDEEF83068C@gmail.com>
References: <855249CA-A006-475C-8F96-EFD614795064@gmail.com> <AANLkTikNzpCwEieV8sXXctMm+DR69fkLfCF+F3xB6b-k@mail.gmail.com>
Mime-Version: 1.0 (iPod Mail 7E18)
Content-Type: text/plain;
	charset=us-ascii;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 17 19:24:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PetkW-0002Yj-H2
	for gcvg-git-2@lo.gmane.org; Mon, 17 Jan 2011 19:24:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417Ab1AQSYL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Jan 2011 13:24:11 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:54422 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710Ab1AQSYJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Jan 2011 13:24:09 -0500
Received: by gyb11 with SMTP id 11so2025232gyb.19
        for <git@vger.kernel.org>; Mon, 17 Jan 2011 10:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:references:message-id:from:to:in-reply-to
         :content-type:content-transfer-encoding:x-mailer:mime-version
         :subject:date:cc;
        bh=6b6gz2aC2ff3A94/ygu1qXUpdZ9kTzVD5El3IFMJKWQ=;
        b=Q0tqSYNgG29bEnXnMyPRi/bx47R5GUUN48huuKqwS6lB/hErDYrZuI5pQ/Et0loBTC
         exR6qmIVO8YzzI+vqLsCExrzdRrRQkodgE80X7LuZkPl2Ql9v7wartU1Fw59ic+z5L2h
         U1huZp8MHvh5LgCrOFp4X2WcSUIi6HcG4xRlo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=references:message-id:from:to:in-reply-to:content-type
         :content-transfer-encoding:x-mailer:mime-version:subject:date:cc;
        b=scecRnOiquGbtKhtNYHS8BNRsSrie8xU3saz3H1tthAw2T/VxA32JfniWhzkVwC8Gk
         Z75EZahCSFtqByTblLVIct28RMqKI1nxJLm0rebzOPUfmaQ1l5oAJQuBqRMl1wLL6RA3
         jPLEkb1qHcrqxU6ZrYffLwDi+kEnQqNl05VAE=
Received: by 10.151.15.9 with SMTP id s9mr204039ybi.4.1295288648268;
        Mon, 17 Jan 2011 10:24:08 -0800 (PST)
Received: from [192.168.1.131] (c-68-42-39-41.hsd1.nm.comcast.net [68.42.39.41])
        by mx.google.com with ESMTPS id v4sm2312359ybe.17.2011.01.17.10.24.04
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 17 Jan 2011 10:24:06 -0800 (PST)
In-Reply-To: <AANLkTikNzpCwEieV8sXXctMm+DR69fkLfCF+F3xB6b-k@mail.gmail.com>
X-Mailer: iPod Mail (7E18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165175>

On Jan 17, 2011, at 2:38 AM, Christian Couder <christian.couder@gmail.com 
 > wrote:

> Hi,
>
> On Sat, Jan 15, 2011 at 8:33 AM, Aaron S. Meurer  
> <asmeurer@gmail.com> wrote:
>> First off, do you guys have an issue tracker?
>
> No, we don't. We use the mailing list.
>

Well that's amazing to me. How on Earth fo you manage stuff?

>>  I asked on IRC, and someone told me that he didn't think you did,  
>> and to just post here.  After searching your websites, as far as I  
>> can tell he was right, though this is amazing to me that you can  
>> handle a project like this without an issue tracker.  If you guys  
>> really do, then sorry.  I would rather post this there than here  
>> (though if you really do, please make it more findable!)
>>
>> I just noticed this error/bug:
>>
>> git checkout test
>> git bisect start
>> <do some bisecting>
>> git branch -D test
>> <finish bisecting>
>> git bisect reset
>>
>> And it gives an error, because test has been deleted.  This is in  
>> 1.7.3.5.  Now, I looked through the log of the current master of  
>> git to see if anything has been done about this, and all I noticed  
>> was the commit 3bb8cf88247db5, which essentially improves the error  
>> message.
>>
>> Now, this is good, because it seemed to me above that I was stuck  
>> bisecting until I recreated the test branch.  I did not realize the  
>> git bisect <commit> syntax until later.
>
> You mean "git bisect reset <commit>".
>

Yes, of course. :)


>> But this has brought me to bother you guys about something that has  
>> been bugging me for a while. I hate git bisect reset.  90% of the  
>> time I do not want to go back to where I started bisecting.  I  
>> would much prefer to just have a git bisect stop command, which  
>> just stops the bisecting process, but leaves me where I am (like a  
>> shortcut to git bisect reset HEAD).  This would be much more  
>> symmetric with git bisect start.
>
> If more people want it, yeah, we can create such a shortcut. But you
> can also use a git alias for that.
>

Can you alias "git bisect stop", or would you have to alias "git  
bisect-stop"?

>> While we are on the topic of bisecting, I have another issue.  Can  
>> we remove the restriction that a "bad" commit come after a "good"  
>> commit?  I'd say about 70% of the time I use bisect to find a  
>> commit that fixes a bug, not breaks it.  Whenever this happens, I  
>> have to bend my mind over backwards to remind myself that the good  
>> behavior is really "bad" and the bad behavior is really "good".  Is  
>> there a reason that git bisect can't just introspect from which  
>> comes earlier and which comes later to see which is "good" or  
>> "bad" (instead of just raising an error when they are in the  
>> "wrong" order)?
>
> Yeah, many people find it difficult to reverse the meaning of "bad"
> and "good" when looking for a fix. There were some suggestions at some
> points to do something about it. Some of the suggestions were to use
> some aliases for "good" and "bad", but there was no agreement. Other
> suggestions had a patch attached but the patch was not good enough or
> something.
>
> Anyway, the restriction is that the "bad" commit cannot be an ancestor
> of a "good" commit. But the "good" commits need not be all ancestors
> of the "bad" commit. For example if you have a "master" branch and a
> "dev" branch that was forked from the "master" branch at one point,
> like that:
>
> A-B-C-D-E <-- master
>      \F-G <-- dev
>

I don't understand how this can only be one way?  Isn't this  
symmetric?  In other words, how is it different from

A-B-C-D-E <-- dev
     \F-G <-- master

as far as bisect is concerned? Or maybe I am not entirely clear on  
what you are saying.

> you can use one of the branch as "bad" and the other one as "good".
> And that means that in this case we cannot automatically reverse the
> meaning of "good" and "bad".
>
> So if we ever implement a "--reverse" mode, I think that the best we
> could do if we detect that a "bad" commit is an ancestor of a "good"
> commit is to suggest the use of this "--reverse" mode. Or we could ask
> and use this mode if the answer is yes.
>
> Best regards,
> Christian.

This would be an acceptable solution to me (--reverse with asking).

Aaron Meurer
