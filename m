From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH/RFC] rebase: new convenient option to edit a single commit
Date: Fri, 28 Feb 2014 14:34:16 +0700
Message-ID: <CACsJy8BC089h3j4H-DV5+BdhK74=k4v+=vO6a26xRJ==BLJ3-Q@mail.gmail.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com> <20140228065802.GB31731@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 28 08:34:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJHy8-0007rL-Ut
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 08:34:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbaB1Het convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 28 Feb 2014 02:34:49 -0500
Received: from mail-qc0-f170.google.com ([209.85.216.170]:63870 "EHLO
	mail-qc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751955AbaB1Hes convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 28 Feb 2014 02:34:48 -0500
Received: by mail-qc0-f170.google.com with SMTP id c9so340805qcz.1
        for <git@vger.kernel.org>; Thu, 27 Feb 2014 23:34:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=E+L0QDcN3u0dkD7o4e+zDXJw6WzKmZyWKLZp37rtjKs=;
        b=wKx673fl8AS2/CoRdS89yfKrq8nBXS5bZR4YLM1cy4BwJU986410jnXhvwz3MxsGiq
         LWevdpd8AERInbVX/9IEe0pKcqttSR3dqSnYMljivpaLN65kuC4bVFtT0JsP7lw+XHNL
         OkEnxGuw2146sOdKAPRegejmgbtC/LK6+1crv+ipAaIEWHuRa5tyWlSSMWJ44z7nVqjY
         5IiK9NPRibzQeukcV6z7mncTdqqMqZ/1+D1M2OtzIV+5kctG+gUAqW9sdZ1fijx0xJMi
         HsSYlQl+nXOLjjNhTijuUUvn7e+3BC7KSpDWFV2A4TPnEBk3xtcsZKyBxLv1mczTcv14
         RKTQ==
X-Received: by 10.140.107.138 with SMTP id h10mr1557281qgf.30.1393572887659;
 Thu, 27 Feb 2014 23:34:47 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Thu, 27 Feb 2014 23:34:16 -0800 (PST)
In-Reply-To: <20140228065802.GB31731@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242900>

On Fri, Feb 28, 2014 at 1:58 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 27, 2014 at 08:01:18PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=
=E1=BB=8Dc Duy wrote:
>
>> I find myself often do "git rebase -i xxx" and replace one "pick" li=
ne
>> with "edit" to amend just one commit when I see something I don't li=
ke
>> in that commit. This happens often while cleaning up a series. This
>> automates the "replace" step so it sends me straight to that commit.
>
> Yeah, I do this a lot, too.  The interface you propose makes sense to
> me, though I'm not sure how much I would use it, as I often do not kn=
ow
> the specifier of the commit I want to change (was it "HEAD~3 or
> HEAD~4?"). I guess using ":/" could make that easier.

In my case, I just copy/paste the commit ID from "git log -lp". I
think :/ already works with rebase..

>
> One comment on the option name:
>
>> +1,edit-one!        generate todo list to edit this commit
>
> I'd expect "-$n" to mean "rebase the last $n commits" (as opposed to
> everything not in the upstream). That does not work currently, of
> course, but:
>
>   1. It has the potential to confuse people who read it, since it's
>      unlike what "-1" means in most of the rest of git.
>
>   2. It closes the door if we want to support "-$n" in the future.

I really like to do "git rebase -5" =3D=3D "git rebase HEAD~5" but neve=
r
gotten around do make it so. "-1/--edit-one" was chosen without much
thought. Will change it to something else.
--=20
Duy
