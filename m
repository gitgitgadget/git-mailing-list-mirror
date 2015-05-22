From: Allen Hubbe <allenbh@gmail.com>
Subject: Re: [PATCH v4] send-email: Add simple email aliases format
Date: Fri, 22 May 2015 14:03:45 -0400
Message-ID: <CAJ80satx=A+SHYbvkTrUTpCSDq9UR0CKxGr=0BuLzgJJa4-x3A@mail.gmail.com>
References: <9f88da801466c83331d02262855e8bef4164e5eb.1432266004.git.allenbh@gmail.com>
	<CAPig+cRLxk26p7DFaS+gRkKZxkRwf8g=4=j2QHX6AC2Uk5J++w@mail.gmail.com>
	<CAJ80satbXXBYva9qrgR1oA_f7LAHUeAm21=R-mGsWx+sDoQ9sQ@mail.gmail.com>
	<xmqqlhggfz97.fsf@gitster.dls.corp.google.com>
	<CAJ80sateODWDUvkAf9YbMMSYv_-=nKnBopGjgDFFSkVHuQJJMQ@mail.gmail.com>
	<xmqqzj4wedlo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 22 20:04:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YvrIn-0003GX-CX
	for gcvg-git-2@plane.gmane.org; Fri, 22 May 2015 20:04:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946027AbbEVSED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 May 2015 14:04:03 -0400
Received: from mail-wg0-f46.google.com ([74.125.82.46]:35469 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161013AbbEVSDr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 May 2015 14:03:47 -0400
Received: by wgfl8 with SMTP id l8so24793594wgf.2
        for <git@vger.kernel.org>; Fri, 22 May 2015 11:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jtZdIK51zpxaFfi15vhyH8XigfyodDnXLO4CuyDksl4=;
        b=pc+2tjgzx72AY0j+3RW9TSCuh/NF2Bvzd/0LYwzt69yDFfj02VKXiwpp7dhG6VlQje
         tOTPP0BuEoSsmlNZh9SBw+Pacwk7/+AcHrUuLKIenz6QlBZmiPCtTD7bClodD5NMxf1F
         Q53J0Vi2HoWQKyZ2ii8geEhQilXVHLcCkYAWurnJO2tuJkat8va2JEZMTuuPu3TzEAci
         x11/uVNIBzJ9WEKiUFk+mWLRmRO3YrPb35Dynwb0M15uWc1I/l1wKebvDq9RnzSzl5c1
         CqQJ7b6ZP3CJdN1cPQ2ueHGjKpTC/ynkSA7BHROcqnAtDJS6IXPOypq2o9cEVev7HT2C
         HM6g==
X-Received: by 10.180.94.168 with SMTP id dd8mr9660597wib.76.1432317825934;
 Fri, 22 May 2015 11:03:45 -0700 (PDT)
Received: by 10.28.59.4 with HTTP; Fri, 22 May 2015 11:03:45 -0700 (PDT)
In-Reply-To: <xmqqzj4wedlo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269746>

On Fri, May 22, 2015 at 1:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Allen Hubbe <allenbh@gmail.com> writes:
>
>> On Fri, May 22, 2015 at 10:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>
>>> Let me step back a bit.  Earlier you said your aim is not to use an
>>> alias file you already have and use with the MUA/MTA, but to have a
>>> collection of aliases to use with git-send-email only.  Is there a
>>> reason to add support for a new format (whether it is compatible to
>>> or subset of postfix/sendmail format, or a totally new one) for that
>>> goal?  What makes the existing formats unsuitable?
>>
>> It's just a matter of personal preference what is suitable or not, for
>> me, in my environment, etc.  Is there a reason I should use the alias
>> format of some email client, if I don't use that email client?
>
> I do not think "should" is a good word in the context of that
> sentence, as nobody is forcing you to choose one of the existing
> formats.  But one reason you might want to do so would be because
> git-send-email already knows about it.
>
> It is a different matter if you already use an email client that
> supports your new format and you are trying to reuse an alias file
> with that email client.  But I got an impression that was not the
> case, so the choice seemed to me between
>
>  - learning and using one of existing 5; and

I imagine that's what most people would do, faced with the same issue.
I did initially go look at those formats.  Since I didn't really
prefer any of them, I approached solving the problem in a different
way.

>
>  - inventing, adding support for, and using a new one.
>
> That felt to me was a choice that is clearly not in favor of the
> latter, and I was wondering if there were other reasons to shift the
> balance.  For example, "all of the existing formats are klunky and
> difficult to write" might be why "learning and using one of existing
> 5" is not a win, compared to "inventing, ading support for, and
> using a new one".  I do not know if that is the case, so I wanted to
> hear the reason why.

That "for example" is it.  Why should I have to type "alias" before
each alias in the file?  It's not in any way hard to do - it just
serves no purpose other than to make the parser happy.  Perhaps the
keyword does serve a purpose in mutt, but for me it is pointless to
type that.

>
>> I'm not trying to force anything on anyone else by offering this, just
>> another option that might be suitable for someone else, in their
>> environment, as it is in mine.  People who don't like it can choose a
>> different option.  People who don't like any of the options can write
>> their own like I did, or is that not allowed for some reason?
>
> We prefer not to carry dead code---when we add things, we would want
> to make sure it will be widely useful so that other people benefit.

1 vote for useful.  I realize this is self serving, but I hoped
sharing it would benefit others.

>
>> I've already shown that I am willing to change the name, write the
>> documentation, write the tests, modify the syntax, and so on.  I've
>> done the work, from +6 lines to +57 lines, as requested.  I'm not
>> looking forward to v5, v6... v10 of what was a really really simple
>> patch.  If you don't like it, please don't string me along.  This is
>> not my job.
>
> Yeah, I know.
>
> A trade off from contributor's side is between (1) handing the
> maintenance to the upstream, so that a feature will stay available
> with minimum fuss in the future, or (2) having to carry one's own
> enhancement forward every time one updates from the upstream.

(3) good citizenship in open source to share one's changes to the code.

>
> On the other hand, a trade off from project's side is between (1)
> rejecting a half-way finished ware and hurting feelings of people
> and (2) accepting a half-way finished ware and having to spend
> engineering effort (e.g. making sure it fits to the rest of the
> system without adding dead weight) to polish it to the end.
>

I get that, in the general case, and especially for large features
that affect a lot of the user base.  How worried are you in this case,
about (2), for such a small amount of code that now has a more
extensive unit test case and documentation than any of the other
options?
