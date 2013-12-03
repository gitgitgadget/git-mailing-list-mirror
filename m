From: =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3] gitweb: Add an option for adding more branch refs
Date: Tue, 3 Dec 2013 14:02:26 +0100
Message-ID: <CANQwDwcBx-rbiLwVY6zAmixr=93vyvpVWcCZMLuSEBgjTJ4-tg@mail.gmail.com>
References: <1385639092-13362-1-git-send-email-krzesimir@endocode.com>
 <CANQwDwfbNfbFqX+hw09bPLVKAN3RZciJmwdixzHrj89KY8FsTQ@mail.gmail.com>
 <1385985997.2054.27.camel@localhost.localdomain> <529CC48C.5080902@gmail.com> <1386068026.2208.16.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Tue Dec 03 14:03:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnpdV-00010P-RK
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 14:03:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830Ab3LCNDU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Dec 2013 08:03:20 -0500
Received: from mail-wi0-f175.google.com ([209.85.212.175]:64410 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442Ab3LCNDJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Dec 2013 08:03:09 -0500
Received: by mail-wi0-f175.google.com with SMTP id hi5so6482077wib.2
        for <git@vger.kernel.org>; Tue, 03 Dec 2013 05:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=TdlEDZ1mWcQLdf4o20A3auKtpWYwNuSldbz4elCgHCw=;
        b=J/4zaWCVxaQL5qIv79EGL3/+zlPpwt/y5T5IASFET/cRETG/AL0IzKfXdSNxzkirCv
         lm58bwNMrTuhrNrw1h+PK3sDmDRFDdYkTzDgZuJeTP2EqpRZfF+mNXvsswCWWGDt9Ne5
         ipVxBPNW3/1BuNfd31oJfuo5BshYhXd/tDY1dEICZOpgANGJreXt27wMTGE8Y2cjnVoY
         bM1IIgJnCFytx4snw3zO8j3p0f6luWJKtGmrebzgtJPq0l5T0Esa2mWmSkQ4hm3LYOjO
         e06gaFpVdGQk7VFtEXmxh5hfiw1Co07z/UjJL2IpDZy4Ta6O+dkKx1zvTQnzGQc+PyiF
         V/5g==
X-Received: by 10.180.188.229 with SMTP id gd5mr2422965wic.38.1386075788117;
 Tue, 03 Dec 2013 05:03:08 -0800 (PST)
Received: by 10.227.108.131 with HTTP; Tue, 3 Dec 2013 05:02:26 -0800 (PST)
In-Reply-To: <1386068026.2208.16.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238689>

On Tue, Dec 3, 2013 at 11:53 AM, Krzesimir Nowak <krzesimir@endocode.co=
m> wrote:
> On Mon, 2013-12-02 at 18:34 +0100, Jakub Nar=C4=99bski wrote:
>> W dniu 2013-12-02 13:06, Krzesimir Nowak pisze:
>>> On Mon, 2013-12-02 at 01:21 +0100, Jakub Nar=C4=99bski wrote:
>>>> On Thu, Nov 28, 2013 at 12:44 PM, Krzesimir Nowak
>>>> <krzesimir@endocode.com>  wrote:
>>>>
>>>>> Allow @additional_branch_refs configuration variable to tell gitw=
eb to
>>>>> show refs from additional hierarchies in addition to branches in =
the
>>>>> list-of-branches view.
>>>>>
>>>>> Signed-off-by: Krzesimir Nowak<krzesimir@endocode.com>
>>>>
>>>> Why not use %feature hash instead of adding new configuration vari=
able?
>>>> I think that this option is similar enough to 'remote_heads' featu=
re
>>>> (which BTW should be 'remote-heads'), and could conceivably enable=
d
>>>> on a per-repository basis, i.e. with repository configuration over=
ride,
>>>> isn't it?
>>>
>>> I'd like to see some consensus on it before I start changing the pa=
tch
>>> again.
>>
>> %feature hash is mainly (but not only) about options that can be
>> configured on per-repository basis.  Configuration variables are
>> about options that are per-instance (per gitweb).
>
> Well, I am mostly interested in per-instance configuration in this ca=
se,
> but if that is also possible with %feature hash, then ok, I'll try to
> make it work.

Yes, it is possible to have per-instance configuration (you can even
forbid per-repository configuration).

> From what I've seen (correct me please if I got it wrong) feature
> settings is taken from per-repository config file from [gitweb] secti=
on.
> If there's nothing then some default value is taken. That default val=
ue
> can be overriden with per-instance perl config file.

%feature settings are taken from gitweb configuration (the 'default'
key), and if given feature is overrideable and per-repository configura=
tion
in the form of appropriate key in [gitweb] section of repository config
file exists, it is used instead.

> So it is easy to override it from per-instance perl config by typing:
> $feature{'additional-branch-refs'}{'default'} =3D ['wip', 'no|tf"un,n=
y'];
> $feature{'additional-branch-refs'}{'override'} =3D 1;

Yes.  The 'override' is about checking (which imposes a bit of
performance penalty) and respecting per-repository configuration.

> (Note the edge case of refs/no|tf"un,ny, which passes the git
> check-ref-format scrutiny.)
>
> But for now, most of features are quite simple - either booleans,
> integers or list of simple strings (in snapshot feature). What I need
> here is a list of strings, like CSV in following example:
> [gitweb]
>         additional_branch_refs =3D wip,"no|tf""un,ny"
>
> Is dependency on external module like Text::CSV or Text::CSV_XS ok? I=
f
> not, I can hack some CSV reading code.

Why not use space, which is forbidden in refnames, to separate
entries?  Similar to feature_snapshot(), which is about comma separated
list, without escaping.

--=20
Jakub Narebski
