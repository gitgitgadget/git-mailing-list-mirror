From: demerphq <demerphq@gmail.com>
Subject: Re: Problems using perl's Git.pm module
Date: Thu, 2 Dec 2010 19:41:00 +0100
Message-ID: <AANLkTimKKssBbtuLKCqG9WGbOe+-CH4pc5PDaNxCH_PS@mail.gmail.com>
References: <20101202114003.GA26070@raven.wolf.lan>
	<AANLkTi=8=k9iNWzTnGz821k9A_CZNiEt_KkC8TXu6oS_@mail.gmail.com>
	<7vpqtkrrtc.fsf@alter.siamese.dyndns.org>
	<AANLkTikQdw3aafsfP+SCQ-z9_TZrPJx694QOSeNTrvp6@mail.gmail.com>
	<20101202181425.GG3962@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= <avarab@gmail.com>,
	Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 02 19:41:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1POE5e-0007Ax-8p
	for gcvg-git-2@lo.gmane.org; Thu, 02 Dec 2010 19:41:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757660Ab0LBSlE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Dec 2010 13:41:04 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60560 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755002Ab0LBSlC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Dec 2010 13:41:02 -0500
Received: by vws16 with SMTP id 16so1246574vws.19
        for <git@vger.kernel.org>; Thu, 02 Dec 2010 10:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TOthPquWQn75ZXgVyHg9hCm/Xn1hLmjZGCeLcZP5GsQ=;
        b=Se8c44JbZLQqCu3vU6GTnPPhRqIT6mWxGFg7HYSYGpKwP22kG3lprtZfEkCPNQjZp/
         lIUsn5e3hp/VAiNNDBk/bFbu3rpFfpjWfocKkdqjDkNB4/kMknGvXewKtnHoZIk0ikR6
         5KJQdpi66AtaXo4IMv2wAl5YS0sWrofQSVq+c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=cQA4ceD4uGaLsA1DGEQeWDqtBeLRM9Q9LfUPVOXQbFySwqGx5jUZFx9eRwkL2GMUMV
         UjvOuGwWjAF/wDwyhV1hEP9XMsq02cyyAaIhCgjMHxE0Cv56fG5UQsqXQxvkJGGAfZ5w
         4ZyWNOFz3HrA7SO7jd/nq7ueiZC+eoszDpHe4=
Received: by 10.229.246.79 with SMTP id lx15mr347010qcb.30.1291315260990; Thu,
 02 Dec 2010 10:41:00 -0800 (PST)
Received: by 10.229.192.193 with HTTP; Thu, 2 Dec 2010 10:41:00 -0800 (PST)
In-Reply-To: <20101202181425.GG3962@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162729>

On 2 December 2010 19:14, Jonathan Nieder <jrnieder@gmail.com> wrote:
> demerphq wrote:
>> On 2 December 2010 18:46, Junio C Hamano <gitster@pobox.com> wrote:
>> > =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmail.com> writes:
>
>>>> Why are you using it? It's for internal use only.
>>>
>>> That is not a valid question nor answer, I am afraid.
>>
>> So you are saying that it is for more than internal use?
>
> I assume so. =A0I had guessed the same thing (that it is meant to be
> generally useful), based on the following:
>
> =A0- it is installed to be usable with a simple "use Git"
> =A0 automatically

Well that is true. But im not sure that is a good reason.


> =A0- "perldoc Git" tells me that this module gives Perl scripts an ea=
sy
> =A0 way to interface the Git version control system, not that it is a=
n
> =A0 implementation artifact

Any perl module, or script, or podfile installed in a place that
perldoc knows about is available to perldoc.

> =A0- tools like "git svn" were not historically part of core git, and
> =A0 usage by them was not exactly internal use.

Well, the counter  arguments are:

No back-compat layer for older gits. Tight binding to a particular git
- no availability of upgrades independent of upgrading git. No
availability or review of the module on the standard venues for doing
so for Perl modules. CPAN, CPANTESTERS, smoke reports, etc.

And well the line:

# Totally unstable API.
$VERSION =3D '0.01';

STRONGLY suggests that the module should not be used by code outside
the Git package itself.

Cheers,
yves


--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
