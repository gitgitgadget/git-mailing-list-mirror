From: David Kastrup <dak@gnu.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Thu, 17 Jan 2008 00:58:47 +0100
Message-ID: <85ir1tpbk8.fsf@lola.goethe.zz>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201>
	<65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org>
	<200801162251.54219.jnareb@gmail.com>
	<1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org>
	<alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
	<7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org>
	<alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Kevin Ballard <kevin@sb.org>, Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:59:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFIAl-0002Oj-U9
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 00:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751513AbYAPX7L convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2008 18:59:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751721AbYAPX7J
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 18:59:09 -0500
Received: from mail-in-03.arcor-online.net ([151.189.21.43]:54443 "EHLO
	mail-in-03.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750921AbYAPX7G convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2008 18:59:06 -0500
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mail-in-03.arcor-online.net (Postfix) with ESMTP id C79D32CB21B;
	Thu, 17 Jan 2008 00:59:04 +0100 (CET)
Received: from mail-in-16.arcor-online.net (mail-in-16.arcor-online.net [151.189.21.56])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id AC61B100C6;
	Thu, 17 Jan 2008 00:59:04 +0100 (CET)
Received: from lola.goethe.zz (dslb-084-061-027-179.pools.arcor-ip.net [84.61.27.179])
	by mail-in-16.arcor-online.net (Postfix) with ESMTP id 730C7236E47;
	Thu, 17 Jan 2008 00:58:50 +0100 (CET)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 1A2CB1C00279; Thu, 17 Jan 2008 00:58:47 +0100 (CET)
In-Reply-To: <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 16 Jan 2008 15:38:35 -0800 (PST)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.92/5488/Wed Jan 16 21:44:30 2008 on mail-in-16.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70779>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 16 Jan 2008, Kevin Ballard wrote:
>>=20
>> There's a difference between "looks similar" as in "Polish" vs "poli=
sh", and
>> actually is the same string as in "Ma<UMLAUT MODIFIER>rchen" vs "M<A=
 WITH
>> UMLAUT>rchen". Capitalization has a valid semantic meaning, normaliz=
ation
>> doesn't.=20
>
> That simply isn't true.
>
> Normalization actually has real semantic meaning. If it didn't, there
> would never ever be a reason why you'd use the non-normalized form in
> the first place.

Actually, there is no good reason for non-normalized forms (deficient
software not able to deal with some of the normalized forms is not a
good reason: such software should be fixed).

It is just that the file system is a rather quirky place for enforcing
the normalization.  One should not be able to get unnormalized forms
created easily in the first place, be it command line or script.

> And there *are* cases where there are distinctions. Especially inside
> computers. For one thing, you may not be talking about "characters on
> screen", but you may be talking about "key sequences". And suddenly
> "a<UMLAUT MODIFIER>" is a two-key sequence, and "<a WITH UMLAUT>" is =
a
> single-key sequence, and THEY ARE DIFFERENT.
>
> See?

No.  Input methods are not the same as their resulting string.  I can
even produce some ASCII characters on my keyboard in more than one way
and would not expect them to lead to different codes.

>> How do you figure? When I type "M=E4rchen", I'm typing a string, not=
 a
>> byte sequence. I have no control over the normalization of the
>> characters.  Therefore, depending on what program I'm typing the nam=
e
>> in, I might use the same normalization as the filename, or I might
>> miss. It's completely out of my control. This is why the filesystem
>> has to step in and say "You composed that character differently, but
>> I know you were trying to specify this file".
>
> Pure and utter garbage.
>
> What you are describing is an *input method* issue, not a filesystem
> issue.
>
> The fact that you think this has anything what-so-ever to do with
> filesystems, I cannot understand.

How nice.  We are actually in agreement here.

> See? Putting the conversion in the filesystem IS INSANE. You wouldn't
> make the filesystem convert the characters in the data stream (becaus=
e
> it would cause strange data conversion issues) AND FOR EXACTLY THE
> SAME REASON it shouldn't do it for filenames either!

Yup.  But that does not mean that normalization is a bad idea.  It is
just that the filesystem is not the right place for it.

--=20
David Kastrup, Kriemhildstr. 15, 44793 Bochum
