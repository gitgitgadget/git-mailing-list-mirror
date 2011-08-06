From: Jon Seymour <jon.seymour@gmail.com>
Subject: Re: [PATCH 03/40] whitespace: remediate t1006-cat-file.sh
Date: Sat, 6 Aug 2011 19:47:36 +1000
Message-ID: <CAH3AnrpjzV_QkuaKgbW2xfwqvpcTnqmeRxAX4xrCTMNW38hhYA@mail.gmail.com>
References: <1312620119-18369-1-git-send-email-jon.seymour@gmail.com>
	<1312620294-18616-1-git-send-email-jon.seymour@gmail.com>
	<1312620294-18616-3-git-send-email-jon.seymour@gmail.com>
	<20110806092856.GB7645@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Aug 06 11:47:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QpdU3-0004XR-QZ
	for gcvg-git-2@lo.gmane.org; Sat, 06 Aug 2011 11:47:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754092Ab1HFJrh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Aug 2011 05:47:37 -0400
Received: from mail-vx0-f174.google.com ([209.85.220.174]:53194 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753973Ab1HFJrh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Aug 2011 05:47:37 -0400
Received: by vxi9 with SMTP id 9so1497068vxi.19
        for <git@vger.kernel.org>; Sat, 06 Aug 2011 02:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9489ryiQG1pYKKhrl3KIuEvgz4DQzPgkV8grAAagQoU=;
        b=bxS/0CwcoIB1iOEksgQ1on0MFzNXa/RrVkvfBBqYtXRGT9PO+FcyeIyKtUaf/XfAA1
         fS2dMu1Ij7pKLRurxwX3SGeboywQxJ1S6yNIlgYrilEyZUymVu8nIQSx1GiJhAr3xiu4
         iVJT8l9RqThxpMAhewiWisq+bFgwolyqiNiKo=
Received: by 10.52.27.171 with SMTP id u11mr3444850vdg.131.1312624056586; Sat,
 06 Aug 2011 02:47:36 -0700 (PDT)
Received: by 10.52.183.134 with HTTP; Sat, 6 Aug 2011 02:47:36 -0700 (PDT)
In-Reply-To: <20110806092856.GB7645@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178879>

On Sat, Aug 6, 2011 at 7:28 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Aug 06, 2011 at 06:44:17PM +1000, Jon Seymour wrote:
>
>> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
>> index d8b7f2f..c78bf87 100755
>> --- a/t/t1006-cat-file.sh
>> +++ b/t/t1006-cat-file.sh
>> @@ -14,7 +14,7 @@ strlen () {
>>
>> =C2=A0maybe_remove_timestamp () {
>> =C2=A0 =C2=A0 =C2=A0if test -z "$2"; then
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0echo_without_newline "$1"
>> + =C2=A0 =C2=A0 echo_without_newline "$1"
>
> Yes, this indent with spaces violates our coding style policy. Howeve=
r,
> the 4-space indentation does, too (and the space between function nam=
e
> and parentheses). The "right" way is according to our policy is:
>

Sure, but I not claiming the fix up is complete.

> =C2=A0maybe_remove_timestamp() {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if test -z "$2"; then
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0echo_wi=
thout_newline "$1"
>
> So I have to wonder if this automated indentation is really worthwhil=
e.
> The result still doesn't meet our whitespace criteria (and I am sligh=
tly
> dubious that it is possible to write an accurate general-purpose
> indenter for shell code).

Or that complete automation is possible...

>
> I suppose you could argue that even taking it partway towards right i=
s
> better than nothing. But I get the feeling that nobody is really look=
ing
> at this code; if they were, they would fix the style while they were
> there. And if not, then who cares if it's 10% right or 30% right?
>
> I dunno. I'm not against a one-time cleanup, but I think making the
> cleanup script a part of the repo is kind of silly. Between git's
> whitespace warnings (which I suspect post-date most of these changes)
> and code review (which we need to catch non-automated style violation=
s,
> in addition to regular bugs, of course), it seems like we already hav=
e
> a better solution in place. It's just that nobody has bothered to cle=
an
> up the old code.

Well, the battle against white space errors in an ongoing one. This is
just one more tool that might help.

As mentioned elsewhere, It would be more useful, I think to generalise
test-cleaner so that it could be used with files other than just tests
and, indeed, for edits other than just whitespace cleanup.

I think there is value is ensuring that the slavish application of an
automated cleanup doesn't introduce test breaks.

jon.
