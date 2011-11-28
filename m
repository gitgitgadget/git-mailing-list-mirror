From: =?UTF-8?Q?J=C3=BCrgen_Kreileder?= <jk@blackdown.de>
Subject: Re: gitweb: in-page errors don't work with mod_perl
Date: Tue, 29 Nov 2011 00:40:27 +0100
Message-ID: <CAKD0Uuw35Kdno=OxqP5SYtaVjqUFZCLL9fSSscN7sq=KmycyxA@mail.gmail.com>
References: <CAKD0UuweWoY5ObXgyN9vrOXWrKdNYWuG7CGB0V7HvcuiwRJD+A@mail.gmail.com>
 <CAKD0Uuws=zU+Pg8afn91mm0t4Rp_GNF++dTYnjA9okndyR=cXQ@mail.gmail.com>
 <CAKD0UuzsV7A_j8YD4b0Lb95L2NcRcSu5PH8C9aZQmEx3tOuQjQ@mail.gmail.com> <201111282332.07276.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 29 00:41:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVAop-0005de-1R
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 00:41:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754985Ab1K1Xkv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Nov 2011 18:40:51 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62685 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754947Ab1K1Xkt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2011 18:40:49 -0500
Received: by eaak14 with SMTP id k14so2371038eaa.19
        for <git@vger.kernel.org>; Mon, 28 Nov 2011 15:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackdown.de; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=cFOiergGYNoePbHJoxg26sTpfY3+WlkJDS+BY05yYU8=;
        b=ANRzEbdn6Tem6okbRYP1e3Sh42pBaRkhu+RkEKoqVdABMz6PCLz32tEZvpFy0nQpVg
         Iz1rFVVMRV9sHsfjrB0Nc+KWo1NDjZYSgj4fciPICUE6cU8o1EOWaih6PPSuh4LEjJvO
         NENRERiKVzLlPypOfuF12xxfTYQSrrfBc7XZg=
Received: by 10.227.204.208 with SMTP id fn16mr7348530wbb.6.1322523648082;
 Mon, 28 Nov 2011 15:40:48 -0800 (PST)
Received: by 10.180.87.37 with HTTP; Mon, 28 Nov 2011 15:40:27 -0800 (PST)
In-Reply-To: <201111282332.07276.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186039>

On Mon, Nov 28, 2011 at 23:32, Jakub Narebski <jnareb@gmail.com> wrote:
> J=C3=BCrgen Kreileder wrote:
>> On Mon, Nov 28, 2011 at 21:13, J=C3=BCrgen Kreileder <jk@blackdown.d=
e> wrote:
>> > On Mon, Nov 28, 2011 at 17:54, Jakub Narebski <jnareb@gmail.com> w=
rote:
>> > =C2=A0[...]
>> > >
>> > > The configuration is very similar. =C2=A0Perhaps that is the dif=
ference between
>> > > Apache 2.0.x (mine) and Apache 2.2.x (yours).
>> > >
>> > > Does adding `$r->err_headers_out();` before `$r->status(200);` h=
elps?
>> > > I'm grasping at straws here. =C2=A0mod_perl documentation is not=
 very helpful.
>> >
>> > Doesn't help unfortunately. =C2=A0It's hard to find any informatio=
n about
>> > this on the net (except for your comment on stackoverflow :).
>> >
>> > The only way to get mod_perl to return a custom error message with
>> > correct status code I've found so far is $r->custom_response($stat=
us,
>> > $msg). =C2=A0Unfortunately mod_perl then ignores headers I set, e.=
g.
>> > content-type.
>>
>> I guess this explains it:
>> http://foertsch.name/ModPerl-Tricks/custom-content_type-with-custom_=
response.shtml
>> Requires quite some restructuring to gitweb.perl.
>
> I'm coming close to declaring that ModPerl::Registry is horribly brok=
en
> with respect to error pages created by CGI, and say that we don't sup=
port
> it, removing mod_perl configuration examples from gitweb documentatio=
n.

Makes sense.  The benefits of mod_perl are properly small for gitweb an=
yway.


Juergen

--=20
http://blog.blackdown.de/
http://www.flickr.com/photos/jkreileder/
