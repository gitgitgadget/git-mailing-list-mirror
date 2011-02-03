From: Hilco Wijbenga <hilco.wijbenga@gmail.com>
Subject: Re: [1.8.0] reorganize the mess that the source tree has become
Date: Thu, 3 Feb 2011 13:42:27 -0800
Message-ID: <AANLkTikhPRGZ9DxCWbWvBiac_DYiXYsnEdHVOnbHUdU4@mail.gmail.com>
References: <20110202022909.30644.qmail@science.horizon.com>
	<alpine.LFD.2.00.1102030036420.12104@xanadu.home>
	<AANLkTimnMDuAX-Ctc5K3mt=b2bz2FTsb_P7Fs8RzVwpd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@fluxnic.net>,
	George Spelvin <linux@horizon.com>,
	Eugene Sajine <euguess@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 03 22:42:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pl6wk-00062g-AO
	for gcvg-git-2@lo.gmane.org; Thu, 03 Feb 2011 22:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753213Ab1BCVm3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Feb 2011 16:42:29 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:43480 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165Ab1BCVm2 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Feb 2011 16:42:28 -0500
Received: by qwa26 with SMTP id 26so1327489qwa.19
        for <git@vger.kernel.org>; Thu, 03 Feb 2011 13:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BOni0aKryc95RyBh0MNxLFtsUYAFETD4AItvoS+Zkfo=;
        b=JSEPxVEj2LyBlN1k43/KIhipi0iXNDX4Y36DPEXSJa0CxIMJFGJJbsy5jyOJOUsfCk
         WwiPuR+nk3rr9Bp5sU6xjjgl4krLejlbU4/DYURHKoCqYzKrJyAtEkUzyU0w8o4eTj/Y
         F1rmqE+KZkytyDxEqLEYWEThYzn1J59tg0C0w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rvHnk99V1cydu092wjmegkFFiTjbpxXLLMvDCjzgE3aWiXTya7LFy5ryV+XEWqVGV8
         6T0OADiKBDaMNOtgajIMfZrDHQIbDZxmlsIYlXbLsU7huC8pj5yhpGkF+tx4oay2zXVI
         wHgl8jEXlEgiTtG9GKNFW9WoELLTj6HC/GZa8=
Received: by 10.229.98.193 with SMTP id r1mr9861146qcn.22.1296769347260; Thu,
 03 Feb 2011 13:42:27 -0800 (PST)
Received: by 10.229.94.7 with HTTP; Thu, 3 Feb 2011 13:42:27 -0800 (PST)
In-Reply-To: <AANLkTimnMDuAX-Ctc5K3mt=b2bz2FTsb_P7Fs8RzVwpd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166003>

On 3 February 2011 10:46, Eugene Sajine <euguess@gmail.com> wrote:
> On Thu, Feb 3, 2011 at 1:16 AM, Nicolas Pitre <nico@fluxnic.net> wrot=
e:
>> On Tue, 1 Feb 2011, George Spelvin wrote:
>>
>>> For what it's worth, I don't see the "cleanup".
>>>
>>> If it significantly reduced the size of the largest directory,
>>> that would be a win. =C2=A0But moving everything into src/ doesn't
>>> do that.
>>>
>>> If there's a way to divide the source into cohesive subunits, that
>>> would be great. =C2=A0A programmer could ignore whole subdirectorie=
s
>>> when working on something.
>>>
>>> But just moving the whole existing pile into a subdirectory "becaus=
e
>>> everyone else does it" is not a reason; that's superstition.
>>
>> There is no superstition here, simply basic elegance.
>>
>> When you pick up a book from a shelf, do you see the actual content =
of
>> the book printed right from the inside of the cover page, and the ta=
ble
>> of content tossed in the margin? =C2=A0Would you construct a book yo=
urself
>> that way?
>>
>> A nice source tree should be organized with a minimum of hierarchica=
l
>> structure. =C2=A0To a newbie wanting to contribute to Git, it is rat=
her
>> frightening to cd into the git directory and see that ls generates m=
ore
>> than 280 entries. =C2=A0That simply looks sloppy. =C2=A0And this get=
s much worse
>> after a make.
>>
>> The top directory should make different things stand out much more
>> clearly, like a preface and a table of content. =C2=A0You have the
>> documentation here, the source there, the tests there, a clearly vis=
ible
>> README file, etc. =C2=A0If the src directory has about the same rela=
tive
>> number of files after a move that's fine. =C2=A0At least you should =
expect
>> _only_ source files in there (and possibly their by-products), and n=
ot
>> other types of data buried into the mix.
>>
>>> Having to type "src/" a lot more often is definitely a downside.
>>
>> Come on. =C2=A0This is a rather egocentric argument without much sub=
stance.
>>
>>> Heck, that's one thing I actively dislike about GNU autoconf conven=
tions.
>>
>> This has _nothing_ about any autoconf convention. =C2=A0GNU autoconf=
 requires
>> stupid things like having a bunch of files such as CREDITS, INSTALL,
>> CHANGELOG, and other whatnots even if you have nothing to put in the=
m,
>> in which case they still have to be there but empty. =C2=A0It also d=
ictates
>> the exact name your directories must have, etc.
>>
>> I'm not proposing a tree reorganization because GNU autoconf command=
s
>> it, but rather because this is a sensible thing to do.
>>
>>> If there's a compelling reason to change, could someone please desc=
ribe it?
>>
>> It's about the third time I'm putting forward arguments for this.
>> Please see the list archive.
>>
>> P.S. the netiquette on busy mailing lists recommends that you preser=
ve
>> all the email addresses that were listed as recipients on the messag=
e
>> you reply to. =C2=A0That would be highly appreciated.
>>
>>
>> Nicolas
>> --
>> To unsubscribe from this list: send the line "unsubscribe git" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.h=
tml
>>
>
> I'm not a hacker, but a user who had sometimes peeked into the git
> sources. Unbelievable mess... Impossible to see the structure in
> command line interface.
> I totally agree with Nicolas here.
> Folders were invented for a reason.
>
> IMHO
> src for source code
> build for build by-products
> tests for tests
>
> Come on, give us some love, please!;)

Another one from the peanut gallery. :-) I wholeheartedly agree with
both Nicolas and Eugene.

Quite frankly, I'm surprised there are (presumably experienced)
developers who do not immediately see the value of a little
organization. Surely, given the use of code conventions, formatting
rules, etcetera, the obvious one step further is to also organize
where the files go?

(Given that I'm just a lurker I promise to leave it at this. I just
wanted to show Nicolas a little support.)
