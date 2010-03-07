From: Mark Lodato <lodatom@gmail.com>
Subject: Re: [PATCH] Fix indentation problem in git-ls-files(1)
Date: Sun, 7 Mar 2010 12:27:48 -0500
Message-ID: <ca433831003070927h4c3e24e1m75c7be88355f9663@mail.gmail.com>
References: <m2tyswb1jp.fsf@igel.home> <7v3a0fr740.fsf@alter.siamese.dyndns.org> 
	<m3r5nzw05p.fsf@hase.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Sun Mar 07 18:36:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoKP0-0004Cf-OR
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 18:36:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754571Ab0CGRgX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 7 Mar 2010 12:36:23 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:64383 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754559Ab0CGRgW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 7 Mar 2010 12:36:22 -0500
Received: by gyh3 with SMTP id 3so495517gyh.19
        for <git@vger.kernel.org>; Sun, 07 Mar 2010 09:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=WMzGeYwRvScG9hObI8+tQeeVdxdNhRh3VloT9MNF0sU=;
        b=YX5v/QQLA/0Kw2Pn3PVDshOOUYS5Em+ZRHYRME8uqs47BvU/7DS0fhB68ZgJvjMG2V
         eDU2UhAEUW/B5g/3Bt92dV3xdxCGfQlNaMK2IWu6wHxFZT49Q/YkbjMI/K9sWpLgGKwf
         MSvul9DsZXdw58W27/RFYSP15DADpeCjPZ1YE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=WNUrjrSAnmbKb3g77viAqkBoVRw/wZKN68g8ExG82It4ErOzgIbduHoXMZ4Jkci6MP
         HmsW9lX7oxKbU5/FGY0ORNRrf0Db1ZRfkPzx3CvW8kpPCqmbycvBc0UUMxhWT8XHQ4EG
         CFIux0VRUCtZ1gX/vaYu9Gu5eGgsdbEIGLL5o=
Received: by 10.91.153.1 with SMTP id f1mr4292595ago.21.1267982888100; Sun, 07 
	Mar 2010 09:28:08 -0800 (PST)
In-Reply-To: <m3r5nzw05p.fsf@hase.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141721>

On Fri, Mar 5, 2010 at 5:08 AM, Andreas Schwab <schwab@linux-m68k.org> =
wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Both [horizontal] and three colons are something we never have used =
in the
>> existing documentation set. =C2=A0How confident are you that various=
 versions
>> of deployed AsciiDoc people would use all support this?
>
> I'm sorry, but I have no idea. =C2=A0I just looked at the user guide =
on the
> asciidoc home page, which contais no version information.

Yes, the documentation is lacking here.  I believe we official support
AsciiDoc 8.2.7 - this is what the builds on kernel.org use.  Here's a
cheatsheet for that version:

	http://powerman.name/doc/asciidoc-827

Hopefully the following will clarify things for the future:

Use ';;' instead of ':::' for a nested list.  The former was added in
AsciiDoc 5.0.9; the latter in 8.3.5.

=46or horizontal lists, put the term and definition on the same line
*and* prefix it with [horizontal].  Before 8.3.0, horizontal lists
were specified by placing the definition on the same line as the term
(which mimics the output).  After 8.3.0, this formatting does not
matter, and the choice of vertical vs horizontal is determined by the
presence of [horizontal].  If you do both, I think it looks fine on
both.

Here's an example showing a normal, vertical list, with a nested,
horizontal list in the second item.

---- 8< ----
a::
	The first letter.
b::
	The second letter.
+
[horizontal]
	B;; The capital letter.
	beta;; The greek equivalent.
c::
	The third letter.
---- >8 ----

Perhaps it would be a good idea to add an Asciidoc section to
Documentation/CodingGuidelines?  This could clear up these sorts of
questions, and also cover conventions used in the manual: what name to
give metavariables, when to use backticks, when to use single quotes,
etc.
