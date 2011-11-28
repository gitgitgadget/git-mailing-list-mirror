From: =?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
Subject: Re: gitweb: in-page errors don't work with mod_perl
Date: Mon, 28 Nov 2011 22:42:16 +0100
Message-ID: <CAKD0UuzsV7A_j8YD4b0Lb95L2NcRcSu5PH8C9aZQmEx3tOuQjQ@mail.gmail.com>
References: <CAKD0UuweWoY5ObXgyN9vrOXWrKdNYWuG7CGB0V7HvcuiwRJD+A@mail.gmail.com>
 <201111280138.02511.jnareb@gmail.com> <CAKD0UuyDUPJFkpWbj2qFYsnii+6WoABnokhhhx4PysPW0FX2sA@mail.gmail.com>
 <201111281754.59205.jnareb@gmail.com> <CAKD0Uuws=zU+Pg8afn91mm0t4Rp_GNF++dTYnjA9okndyR=cXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 22:42:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RV8yK-0000uc-87
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 22:42:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713Ab1K1Vmj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Nov 2011 16:42:39 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:37915 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab1K1Vmi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2011 16:42:38 -0500
Received: by wwp14 with SMTP id 14so9799288wwp.1
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 13:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=WaayirrWFnKGp5UUbh2pDeo6KjgFhEHe0KgEYmi0AFA=;
        b=HHDPox6UfwFOLUV89fTluia7ykgZZBczWsJ+hvF6yMcKuZyJ6tAShG/186YdkUU5l3
         djQQXnyLsFcGWKCbep8cMKIsef7AFBKYjQ8XoSOzIc9Onlu7f6804TcSH3a8MwII2BIV
         1Igk9p0+gcuz0KUqF8V8gSQv1FTCAxoDZqlqo=
Received: by 10.227.207.10 with SMTP id fw10mr6062787wbb.2.1322516557051; Mon,
 28 Nov 2011 13:42:37 -0800 (PST)
Received: by 10.180.87.37 with HTTP; Mon, 28 Nov 2011 13:42:16 -0800 (PST)
In-Reply-To: <CAKD0Uuws=zU+Pg8afn91mm0t4Rp_GNF++dTYnjA9okndyR=cXQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186034>

On Mon, Nov 28, 2011 at 21:13, J=C3=BCrgen Kreileder <jk@blackdown.de> =
wrote:
> On Mon, Nov 28, 2011 at 17:54, Jakub Narebski <jnareb@gmail.com> wrot=
e:
> =C2=A0[...]
>>
>> The configuration is very similar. =C2=A0Perhaps that is the differe=
nce between
>> Apache 2.0.x (mine) and Apache 2.2.x (yours).
>>
>> Does adding `$r->err_headers_out();` before `$r->status(200);` helps=
?
>> I'm grasping at straws here. =C2=A0mod_perl documentation is not ver=
y helpful.
>
> Doesn't help unfortunately. =C2=A0It's hard to find any information a=
bout
> this on the net (except for your comment on stackoverflow :).
>
> The only way to get mod_perl to return a custom error message with
> correct status code I've found so far is $r->custom_response($status,
> $msg). =C2=A0Unfortunately mod_perl then ignores headers I set, e.g.
> content-type.

I guess this explains it:
http://foertsch.name/ModPerl-Tricks/custom-content_type-with-custom_res=
ponse.shtml
Requires quite some restructuring to gitweb.perl.


Juergen
