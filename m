From: David Aguilar <davvid@gmail.com>
Subject: Re: Re*: mergetool: support --tool-help option like difftool does
Date: Thu, 23 Aug 2012 00:39:06 -0700
Message-ID: <CAJDDKr42YtfcpARQx6Vx8-Uy7KF3yEoGOQ0VzPKsWQA_hG=MgA@mail.gmail.com>
References: <500CF8CE.90906@gmail.com>
	<500CF9D2.30102@gmail.com>
	<500CFAE1.3070304@gmail.com>
	<7vr4s2mnir.fsf@alter.siamese.dyndns.org>
	<7vipdemm0a.fsf_-_@alter.siamese.dyndns.org>
	<7vzk5m41gk.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Sebastian Schuberth <sschuberth@gmail.com>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 09:39:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4S0e-0005R2-LY
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 09:39:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933616Ab2HWHjM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 03:39:12 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:64715 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933614Ab2HWHjH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 03:39:07 -0400
Received: by vcbfk26 with SMTP id fk26so492958vcb.19
        for <git@vger.kernel.org>; Thu, 23 Aug 2012 00:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=BHhv4lDWW2ndWrzRU9Tf/gGM6RbaooTTm2yQNrCMPDY=;
        b=dHDDzy9UjdtFDenjSQ00wA+mnJFQ3jJhbjtkA6U8Mf9a4FTQjihTJeiFxKHxuOrG/n
         9EkcaWDVj27lh/+ZCvoQQ9F4E+IJ4p/SA04zLRg9/VzJi1Xn+yQB/4JrF2kBtmBJ4ngq
         ZVwX+lbmyOjJdL930mXcjD3bpnrhwlIVxAvtbJRwwER0ZlG5OPWZUUhwHkhDtincbR2W
         NwymmOZpfBbOxy+aC5DQlI0siRT1rctNpwxmqRWwGDj1gfDngVR02B7n2hbAyFqm0HmA
         /9+wa6o7wX2dwCNX/GPb0661oFyfS3NPa4/8thX89GnxmxY0wuN3tkCT4uQ7P6px48lH
         jz3w==
Received: by 10.220.241.143 with SMTP id le15mr529002vcb.3.1345707546616; Thu,
 23 Aug 2012 00:39:06 -0700 (PDT)
Received: by 10.58.173.104 with HTTP; Thu, 23 Aug 2012 00:39:06 -0700 (PDT)
In-Reply-To: <7vzk5m41gk.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204115>

On Wed, Aug 22, 2012 at 10:33 PM, Junio C Hamano <junio@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> This way we do not have to risk the list of tools go out of sync
>> between the implementation and the documentation.
>>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>>> +--tool-help::
>>>> +   List the supported and available diff tools.
>>>
>>> This part is a good addition (but it already is mentioned in the
>>> description of --tool above, so it is more or less a "Meh").
>>
>> I noticed that the main while loop has style violations in its
>> case/esac, but I left it as-is.  Reindenting it would be a low
>> hanging fruit janitor patch that would be a separate topic.
>
> After hinting a low-hanging-fruit that would be an easy way for new
> people to dip their toes, I saw no takers for one month, so I ended
> up doing it myself.

My bad, I didn't catch this and should have, especially so because
I had started on style fixing mergetool last week but ditched it;
I assumed it would be unwanted.  I will read more carefully.

Just please don't tell Charles about it ;-)

(I wanted to do this a long ago but at the time we didn't have
 the style guide for shell, and the time was perhaps not right...)

I am of course in favor of this patch.

While on the mergetool topic...

Would the ability to resolve the various merge situations using
the command-line be a wanted addition?

This would let a submodule or deleted/modified encountering
user do something like:

$ git mergetool --theirs -- submodule

...and not have to remember the various git commands that it runs.

This could touch just the parts of mergetool that require stdin,
but probably should work for everything.

It seems like exposing the guts of some of these mergetool functions
via command-line flags could be helpful, but I'm not sure if that's
overloading mergetool with too many features. What do you think?
-- 
David
