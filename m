From: Peter Harris <git@peter.is-a-geek.org>
Subject: Re: Disallow amending published commits?
Date: Sat, 21 Mar 2009 22:57:45 -0400
Message-ID: <eaa105840903211957g634f119bkf3e5adbc5d475793@mail.gmail.com>
References: <885649360903211056u38ff6cabxbe1a17d57faaa0c4@mail.gmail.com>
	 <eaa105840903211146s4ff398e3qa8b570a8d29a83f4@mail.gmail.com>
	 <885649360903211549h751c19e6sbaa0e07a14413d19@mail.gmail.com>
	 <eaa105840903211853p65327ffdvebbe28da5f256871@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git ML <git@vger.kernel.org>
To: James Pickens <jepicken@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 04:02:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlDxV-0006zN-Du
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 04:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752669AbZCVC5t convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 Mar 2009 22:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752088AbZCVC5s
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 22:57:48 -0400
Received: from yx-out-2324.google.com ([74.125.44.30]:11069 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751785AbZCVC5s convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Mar 2009 22:57:48 -0400
Received: by yx-out-2324.google.com with SMTP id 31so1630666yxl.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2009 19:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=MaxK6JUWF00rquv+Ck2/gR861w7pFMCtDoq0ZaMeqFk=;
        b=aHaKJI3kcoJW1X9bGw+TBB/JwWzeIbrKo5BG5giFKfj8MepXw1OgbUeiPkjAdfeQ8r
         OZ8NeA2XVlxn0l3ZNTkf3+BaxJGmzIJWuabGLiYJz/Xzas7LMW4tHOEyBoWjsbOOi8UN
         u3bHNa52LB2ybrfphebGbVvJp77BYTZ7NVzYk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=wi4dYj7dcG422BghQcYArrzZ7vfnX4rrWm+CKOlp1hd+lKjc31kQCKcs1+YB369SuT
         pUZ7qzlyA6zidV3qJJHYa3+51qGIxfoaK5talPhudtipQcyt04We2vO0KdT6pvizhRir
         lYRcPTO62HIbGVjR0MP6A6FH4L1oiBkIKuAy0=
Received: by 10.90.113.11 with SMTP id l11mr3226482agc.4.1237690665820; Sat, 
	21 Mar 2009 19:57:45 -0700 (PDT)
In-Reply-To: <eaa105840903211853p65327ffdvebbe28da5f256871@mail.gmail.com>
X-Google-Sender-Auth: 669e0a6d2dc1943e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114110>

On Sat, Mar 21, 2009 at 9:53 PM, Peter Harris wrote:
> On Sat, Mar 21, 2009 at 6:49 PM, James Pickens wrote:
>> On Sat, Mar 21, 2009, Peter Harris <git@peter.is-a-geek.org> wrote:
>>> Set receive.denyNonFastForwards if you don't want people to be able=
 to
>>> amend (or otherwise rewind) published history.
>>
>> Thanks, but unfortunately that won't work in our workflow. =A0Users =
never
>> push their changes; instead, they do a turnin to a continuous integr=
ation
>> server. =A0The server clones the central repo, pulls their changes i=
nto the
>> clone, builds and tests it, then pushes to the central repo if it pa=
sses
>> the tests. =A0So integration happens via 'pull' instead of 'push'.
>>
>> We can't force the pulls to be fast forward only, because we need to=
 allow
>> turnins from multiple users to be built and tested in parallel, with=
out
>> requiring users to pull from each other or otherwise coordinate thei=
r
>> turnins.
>
> Okay. So in that workflow, you won't ever lose the original history.

(Replying to myself, since I thought of one other thing)

You could, if you wanted, 'pull' into a clean branch. Ensure that it
was a fast-forward, and only then merge the result into the
integration branch. Developers would have to sync-up with the central
repo, but at least they wouldn't have to sync with each other.

Peter Harris
