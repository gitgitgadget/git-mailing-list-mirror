From: John Szakmeister <john@szakmeister.net>
Subject: Re: Credentials and the Secrets API...
Date: Tue, 1 Nov 2011 02:39:07 -0400
Message-ID: <CAEBDL5XOnsq1zBRq+f1zKJqQvxJjRPywCRbPKn77x9Yaa4QVkA@mail.gmail.com>
References: <CAEBDL5Udooim_3Za76Q1Rt_aGXtsSv76nxRegGWRBE=WJQzfZA@mail.gmail.com>
	<20111027174807.GD1967@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 01 07:39:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RL80A-0003nN-Qs
	for gcvg-git-2@lo.gmane.org; Tue, 01 Nov 2011 07:39:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565Ab1KAGjJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Nov 2011 02:39:09 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:64928 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750987Ab1KAGjI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Nov 2011 02:39:08 -0400
Received: by vws1 with SMTP id 1so5521949vws.19
        for <git@vger.kernel.org>; Mon, 31 Oct 2011 23:39:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=m7OJfy6WoOpJUQISVzdF+6RSK9YTZvoRuPkXPTexKKI=;
        b=CJ0MuXJJkMse8dmACjCbYKqzotS/SnXhhH4YNQZbsvyWZYfLrl4FhXjPJm2ISweVhT
         cmb96RCTmZv/9Ph4oj22aOiXLi7MPg64C39wyjqGa+t4fjmoESkBBNCQKPBDtAoi7nxY
         YCy9xneMlIZO0Ez8bwNfUw88I7rqo2Y+Vhmwg=
Received: by 10.52.38.4 with SMTP id c4mr7088473vdk.123.1320129547722; Mon, 31
 Oct 2011 23:39:07 -0700 (PDT)
Received: by 10.220.184.65 with HTTP; Mon, 31 Oct 2011 23:39:07 -0700 (PDT)
In-Reply-To: <20111027174807.GD1967@sigill.intra.peff.net>
X-Google-Sender-Auth: bl6ow65KE9QTLfFB5rwRaiFntaM
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184558>

On Thu, Oct 27, 2011 at 1:48 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Oct 27, 2011 at 12:05:03PM -0400, John Szakmeister wrote:
[snip]
>> With that information, I went ahead and created a
>> gnome-credential-keyring that uses Gnome's Keyring facility. =C2=A0I=
 still
>> need to do a few more things (mainly run it against Jeff's tests), b=
ut
>> it's generally working. =C2=A0Just wanted to keep folks in the loop.
>> Hopefully, I can get patches out this weekend.
>
> Great, I'm looking forward to reading it.

I've pushed up the work I've done to:
   <https://github.com/jszakmeister/git-credential-keyring>

There's not much to it.  It also doesn't handle certs and that sort of
thing.  I think we need to figure out which protocols need to be
handled differently so that we can use the appropriate api for the
keyring-like api. :-)

I also chose this way instead of a patch to git, because it appears
your work is no longer in pu (I must have missed the fact that it was
removed).  Once your work makes it way back in, I can look into
getting it into the contrib area, if that's desired.

>> Jeff: it would be really excellent to break out the various pieces. =
=C2=A0I
>> think it would also be better to split the asking for passwords from
>> the storing of passwords.
>
> That's my current plan. I just need to stop dragging my feet on
> re-rolling the series.

Sounds good!  I'll be happy to update when you do re-roll it.  The
test you sent out was very helpful, BTW.  I do think the test cases
with no context are a bit broken though.  It doesn't seem right to ask
the storage backend to retrieve a password without any context at all,
IMHO.  My implementation doesn't pass those two tests.  It does pass
the rest of them though.

-John
