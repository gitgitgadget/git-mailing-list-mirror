From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: [PATCH] Add ERR support to smart HTTP
Date: Mon, 6 Sep 2010 19:54:31 +0530
Message-ID: <AANLkTi=jqpspQvz6--CGfVEpP8raD7RpNGgMs6KabXfS@mail.gmail.com>
References: <1283707815-32038-1-git-send-email-ilari.liusvaara@elisanet.fi>
	<AANLkTikGiekZGNffaraHK-waBt7wH84jujM_uh3cw46y@mail.gmail.com>
	<AANLkTinTFWHWU1vCnDa-c3p5g+y7wnH9A8fieowQHU5z@mail.gmail.com>
	<201009061049.38546.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Tarmigan Casebolt <tarmigan+git@gmail.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 06 16:24:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Osccs-00076t-35
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 16:24:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417Ab0IFOYe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 6 Sep 2010 10:24:34 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:57003 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751146Ab0IFOYd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Sep 2010 10:24:33 -0400
Received: by yxp4 with SMTP id 4so1531331yxp.19
        for <git@vger.kernel.org>; Mon, 06 Sep 2010 07:24:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ixqbiGuXaCh+SafBFH0tTtRAC9csHDYx/GHe8XERhq0=;
        b=dU+OEiX1zoqouaLrw4zB/a8+WoRKVrU1N/ZHHnSrY4xJRrQLsqlbu7tTJJ680GUfSg
         OsotdSmaXifmAlZpFNHxAzFYjHLTImYeDPcIW9n24N3jR6HIYk841U+wELd6m/p4QAlT
         5XTe8MWwJEU+7rwpGm/XnMzH41BzLub5Bs160=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=BeUx5FIoYj+G3Y1gLonw+WiXreXrOmwFut2urQb5zq7KNvYPHo4w4IjagDrIiZvzT/
         swd6dXhjXvfhslXIQdMUZA5N2Ebqgqsd0TrC4E9DVt2OLNlBsfUCJhCfg/bdRuANHp9M
         7w3bWfdlCfsmOSMYsHzDPvEvheAGJCSJajUUc=
Received: by 10.90.36.8 with SMTP id j8mr42222agj.187.1283783072082; Mon, 06
 Sep 2010 07:24:32 -0700 (PDT)
Received: by 10.90.209.12 with HTTP; Mon, 6 Sep 2010 07:24:31 -0700 (PDT)
In-Reply-To: <201009061049.38546.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155572>

On Mon, Sep 6, 2010 at 2:19 PM, Jakub Narebski <jnareb@gmail.com> wrote=
:
> On Mon, Sep 6, 2010, Sitaram Chamarty wrote:
>> On Mon, Sep 6, 2010 at 6:34 AM, Sitaram Chamarty <sitaramc@gmail.com=
> wrote:
>>> On Mon, Sep 6, 2010 at 2:52 AM, Jakub Narebski <jnareb@gmail.com> w=
rote:
>>>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>>>
>>>>> On Sun, Sep 5, 2010 at 18:49, Ilari Liusvaara
>>>>> <ilari.liusvaara@elisanet.fi> wrote:
>>>>>
>>>>>> AFAIK, HTTP errors don't have descriptions printed.
>>>>>
>>>>> I don't know if this applies here but HTTP error codes can come w=
ith
>>>>> any free-form \n-delimited string:
>>>>>
>>>>> =C2=A0 =C2=A0 HTTP/1.1 402 You Must Build Additional Pylons
>>>>
>>>> And you can also send more detailed description in the *body* (and=
 not
>>>> only HTTP headers) of HTTP response, though I don't know if git do=
es
>>>> that.
>>
>> turns out all this was moot. =C2=A0It was *because* I was using some=
thing
>> other than "200 OK" that the user was not seeing the message. =C2=A0=
Ilari's
>> patch just makes the message *look* better/cleaner, but I still have
>> to send it out with a "200 OK" status.
>>
>> That was... a surprise :-)
>
> From what I remember from smart HTTP discussion (during fleshing-out
> the protocol/exchange details), the fact that errors from git are sen=
d
> with "200 OK" HTTP status are very much conscious decision. =C2=A0But=
 I don't
> remember *why* it was chosen this way. =C2=A0If I remember correctly =
it was
> something about transparent proxies and caches... =C2=A0Is it documen=
ted
> anywhere? =C2=A0Can anyone explain it?
>
> Nevertheless I think it would be a good idea to make *client* more
> accepting, which means:
> 1. Printing full HTTP status, and not only HTTP return / error code;
> =C2=A0 perhaps only if it is non-standard, and perhaps only in --verb=
ose
> =C2=A0 mode.
> 2. If message body contains ERR line, print error message even if the
> =C2=A0 HTTP status was other than "200 OK". =C2=A0To be "generous in =
what you
> =C2=A0 receive" (well, kind of).
> 3. In verbose mode, if body of HTTP error message (not "HTTP OK")
> =C2=A0 exists and does not contain ERR line (e.g. an error from web s=
erver),
> =C2=A0 print it in full (perhaps indented).
>
> I think that neither of the above would lead to leaking sensitive
> information.

I didn't understand this bit about leaking info.  If the bits are
coming into my machine I know what they are anyway (or am able to find
out easily enough, even if git itself isn't showing them to me).
Where's the leak?

And I do see the point that Joshua made that the 200 reflects HTTP
status, not git status.  Makes sense, and answers my original
question...

regards

sitaram
