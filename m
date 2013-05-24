From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/7] sha1_name: implement finding @{push}
Date: Fri, 24 May 2013 23:21:34 +0700
Message-ID: <CACsJy8AHX0181uON5Aa7oJzX8j3qAA26Ymh5G3YEGidD4O5zvA@mail.gmail.com>
References: <1369321970-7759-1-git-send-email-artagnon@gmail.com>
 <1369321970-7759-8-git-send-email-artagnon@gmail.com> <CACsJy8CV192WVW8u6YRnbf6Ue6tFbzyiCARwicwzapSZucaaMw@mail.gmail.com>
 <CALkWK0=XufbcwObBq7_MWX3jL63Nv3YeSvTUpOfXD+XoKkvMag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 24 18:22:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ufuks-00083s-L2
	for gcvg-git-2@plane.gmane.org; Fri, 24 May 2013 18:22:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755703Ab3EXQWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 May 2013 12:22:06 -0400
Received: from mail-oa0-f53.google.com ([209.85.219.53]:60944 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755017Ab3EXQWF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 May 2013 12:22:05 -0400
Received: by mail-oa0-f53.google.com with SMTP id g12so6439984oah.12
        for <git@vger.kernel.org>; Fri, 24 May 2013 09:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=nQY+/pFfvY1HtD9Gh5pDcGSOcko2OI2Pq8uSUEY0wcw=;
        b=p7b9kqT64gG7iTYD+tvk1teS0CW2UY3lBBrzrp1EHdnoBZ1jj/poQhBjg8v7vfpyFp
         ziyF1W7D5UljTB6OjM6ye7mslwgy4GH3dPXHRNRCM8NyMHuuXXSISpoGgWBBtt3BCKcq
         f4bxS6lqsjC/TnviupbHqxRJanO3UjOuBBoThNELUuYE0UMaq6HO+V0dN92uisN8dq+s
         /dR7F+9wqOm6wffo/f74o/W/vfJuqvR/naSyOb2PR4zk2WNwFMnllW0S7GsnblPLAwBh
         kVHjti8Q6pIYXRSBsc9RxzXjqzyOpjvjh7e5igihQ5/Rj73WxXMjiP5EogZp/BBHzTU2
         MklA==
X-Received: by 10.60.62.162 with SMTP id z2mr12225239oer.140.1369412524587;
 Fri, 24 May 2013 09:22:04 -0700 (PDT)
Received: by 10.76.141.232 with HTTP; Fri, 24 May 2013 09:21:34 -0700 (PDT)
In-Reply-To: <CALkWK0=XufbcwObBq7_MWX3jL63Nv3YeSvTUpOfXD+XoKkvMag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225374>

On Fri, May 24, 2013 at 11:15 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Duy Nguyen wrote:
>> On Thu, May 23, 2013 at 10:12 PM, Ramkumar Ramachandra
>> <artagnon@gmail.com> wrote:
>>> Try this now: configure your current branch's pushremote to push to
>>> "refs/heads/*:refs/heads/rr/*".  Now, type 'git show @{p}'.  Voila!
>>
>> Voila what? Why not avoid guessing game and describe what the patch is for?
>
> If you're on branch master, it'll output refs/heads/rr/master.  The
> topic is about having a @{push} corresponding to @{upstream}

Then "show @{p}" should show the tip commit of rr/master, not the ref
name. rev-parse (with an option, maybe) may be a better place for
this.

>>> +       dst_name = get_ref_match(remote->push, remote->push_refspec_nr,
>>> +                               this_ref, MATCH_REFS_ALL, 0, &pat);
>>> +       printf("dst_name = %s\n", dst_name);
>>> +}
>>> +
>>
>> Isn't this an abuse of extended sha-1 syntax? How can I combine this
>> with other @{}, ^, ~...?
>
> I'm unsure what you mean.  How can I be on branch master^1?  Did you
> read the cover-letter?

I did not expect @{p} to printf(). If it's part of get_sha1(), how can
it return an sha-1? And the cover letter said "7/7 is the meat". Not
very informative.
--
Duy
