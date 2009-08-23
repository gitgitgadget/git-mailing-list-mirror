From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCH] gitweb: pull ref markes pull out of subject <a> tag
Date: Sun, 23 Aug 2009 22:43:30 +0200
Message-ID: <cb7bb73a0908231343k3546682ge05cc4f3c3d83638@mail.gmail.com>
References: <1251016089-10548-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<200908232213.48786.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 23 22:44:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfJuz-0007h1-A0
	for gcvg-git-2@lo.gmane.org; Sun, 23 Aug 2009 22:44:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934129AbZHWUnu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Aug 2009 16:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934105AbZHWUnu
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Aug 2009 16:43:50 -0400
Received: from mail-ew0-f207.google.com ([209.85.219.207]:52964 "EHLO
	mail-ew0-f207.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934100AbZHWUnt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 23 Aug 2009 16:43:49 -0400
Received: by ewy3 with SMTP id 3so1888809ewy.18
        for <git@vger.kernel.org>; Sun, 23 Aug 2009 13:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=bdddqAGW2IAZuCRgCpRFEywksrbAdojv4fmalk92sxY=;
        b=psQTHbvFkivbo5yGq8dfdPgR6Y91kEB2ahWzophxt194AHo/UiT6PehDWB0x4psNw6
         9ucZtjW1Xc7Ym6kTDNXOFEecckALYCEn2IqKRLixxjvs4SW+9ypyRl5On5iJY2HoMjpb
         FaWHA9BgHCRHaTuOGzGFY3qF6S5sszRw93dWM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=DrogrOqFPouAf/Dc3kIUY2sVy5tiGpV01mSjRDVDh5KO6liP8gO40NPhpfnJTXOXTC
         EvQfJeRv2rHug48Pgr68k/dBmlf0K5s2uFppRuzv5SLpcHWw+9SyEOPisKtSIuktTCrR
         kQZM+o5MnDhpnwHtadCEInJ4X77cNsqucWFVk=
Received: by 10.210.81.3 with SMTP id e3mr2368073ebb.12.1251060230117; Sun, 23 
	Aug 2009 13:43:50 -0700 (PDT)
In-Reply-To: <200908232213.48786.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126876>

2009/8/23 Jakub Narebski <jnareb@gmail.com>:
> For format_subject_html which you are fixing, and which is used by
> 'shortlog', 'history' and 'tags' views this didn't cause much changes
> in layout. =A0But the way gitweb uses git_print_header_div in views s=
uch
> as 'tree', 'blob' etc., where the outer (containing) link is made int=
o
> *block* element[1] by the way of CSS (display: block) makes layout
> (visualisation) very screwed up in older browser. =A0But I don't expe=
ct
> you to fix that.
>
> [1] Originally so the area to click is larger.

=46ixing that really needs some kind of ridiculously complex
workarounds, or a totally different layout. That is actually one of
the situations where nested links make perfect sense, and it's a real
pity the standard wouldn't allow them, and that some client actually
altered the DOM to 'fix' it. But anyway.

> Signoff?

Aaaargh. Is it enough if I put it here:

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>

or should I resend?

(One would expect I actually learned to add it, finally, but noooo ...
gah, stupid me.)

>> The next step would be to find a way to layout decently the case whe=
n
>> some shortlog entries have a _humongous_ amount of ref markers. See
>> for example http://git.oblomov.eu/acecad/shortlog
>>
>> I honestly doubt these cases happen in normal git repositories, but =
it
>> might still be worth taking them into consideration. Possibilities
>> include hard-limiting the title column maximum width (in browsers fo=
r
>> which the corresponding attributes and rules work), manual insertion=
 of
>> hard line breaks <br/> every n-th ref marker, or something more dyna=
mic
>> such as hiding most of the ref markers when they are more than, say,=
 5,
>> and showing them on hover.
>>
>> Suggestions? Comments?
>
> Perhaps limiting to heads and tags if there are too many refs?

That wouldn't help at all in the case I linked:
http://git.oblomov.eu/acecad/shortlog due to the number of tags that
were imported from CVS.

--=20
Giuseppe "Oblomov" Bilotta
