From: "Peter Harris" <git@peter.is-a-geek.org>
Subject: Re: Overwrite master
Date: Tue, 2 Dec 2008 15:28:43 -0500
Message-ID: <eaa105840812021228v6f6e1252l5099f5dad325f99@mail.gmail.com>
References: <D1AC0A41-E89A-4B53-A449-DA9C4422998E@zooppa.com>
	 <eaa105840812020832p395ecefdq57e62f95182a3557@mail.gmail.com>
	 <67A24C29-12A6-43B0-95D5-70910C5F8841@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Nicholas Wieland" <nicholas.wieland@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 02 21:30:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7bsh-0004mz-8f
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 21:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbYLBU2q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 15:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750905AbYLBU2q
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 15:28:46 -0500
Received: from yx-out-2324.google.com ([74.125.44.29]:57758 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750729AbYLBU2p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Dec 2008 15:28:45 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1293504yxm.1
        for <git@vger.kernel.org>; Tue, 02 Dec 2008 12:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender
         :to:subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references
         :x-google-sender-auth;
        bh=4KL8gisn8e/3S++Zy16Tv6GTDt+KNvzE7jir0+nYnwA=;
        b=Q4VTE+jxsAkupb9XsD/ONC+/KS2W9s4N3gOGF6AQ6xXqCMJHKxQoEVhwFeHC1rfvvq
         l3txqqnBDy0DoBooBHS3ASoyzzDzOyQYDq3CK2xEQRQgtjTNPv85nSvkVTYC+uN/Ycfh
         MD6Tt7lQTaBzLJnew8SZ/FI7WwpFuhHA3rDts=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references:x-google-sender-auth;
        b=SIE/w/CGUB58K+t39QoUjNE4HgLERG/yjoU585tW39P6OdPkvDz5vG5A0vy29Ox5oP
         AdiWMUe3x0Nlh9zb/p2blMDIQzgzGscx5yIGFwvs/7OS0+sy+cU0vG9B9UnyAp/WNLkb
         TLFlqWQrlcJBnwYd+Sov/mVRKKP+tCepnsTl0=
Received: by 10.65.137.5 with SMTP id p5mr13053836qbn.7.1228249723734;
        Tue, 02 Dec 2008 12:28:43 -0800 (PST)
Received: by 10.65.230.19 with HTTP; Tue, 2 Dec 2008 12:28:43 -0800 (PST)
In-Reply-To: <67A24C29-12A6-43B0-95D5-70910C5F8841@gmail.com>
Content-Disposition: inline
X-Google-Sender-Auth: 19d74f2c1bfe7fef
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102174>

On Tue, Dec 2, 2008 at 3:09 PM, Nicholas Wieland wrote:
> Il giorno 02/dic/08, alle ore 17:32, Peter Harris ha scritto:
>
>> On Tue, Dec 2, 2008 at 11:10 AM, Nicholas Wieland wrote:
>>>
>>> Hi *,
>>> I need to overwrite my master branch with another branch. I've already
>>> created a backup branch of my master.
>>
>> While on master,
>> "git reset --hard <newbranch>"
>
> That's what I tried.
> Unfortunately I don't know where to go after:
>
> ngw@slicingupeyeballs ~/zooppa$ git commit
> # On branch master
> # Your branch and 'origin/master' have diverged,
> # and have 444 and 25 different commit(s) each, respectively.
> #
> nothing to commit (working directory clean)

That means your tracking branch is different from your local branch, by a lot.

> Do I have to push ? If I pull it tries to merge ...

If you push, it will be denied (non-fast-forward).

If you force push, your state will be as you expect. Be aware that
you're creating trouble for everyone else who uses 'origin' if you
force push. Also be aware that you will be undoing any changes that
anyone else has pushed to origin in the mean time.

Basically, history is history. If you don't want to cause problems for
the other users of 'origin', you may have to live with history as it
is. You won't be able to overwrite master, although you will probably
try to be more careful in the future.

Peter Harris
