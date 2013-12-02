From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: [PATCH v3] gitweb: Add an option for adding more branch refs
Date: Mon, 02 Dec 2013 18:34:04 +0100
Message-ID: <529CC48C.5080902@gmail.com>
References: <1385639092-13362-1-git-send-email-krzesimir@endocode.com>  <CANQwDwfbNfbFqX+hw09bPLVKAN3RZciJmwdixzHrj89KY8FsTQ@mail.gmail.com> <1385985997.2054.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	sunshine@sunshineco.com
To: Krzesimir Nowak <krzesimir@endocode.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 18:34:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnXNy-0002Nm-VX
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 18:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753063Ab3LBReM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Dec 2013 12:34:12 -0500
Received: from mail-ea0-f177.google.com ([209.85.215.177]:49620 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753045Ab3LBReK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 12:34:10 -0500
Received: by mail-ea0-f177.google.com with SMTP id n15so9256112ead.36
        for <git@vger.kernel.org>; Mon, 02 Dec 2013 09:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=tmGKkIdNwdT/hSCkrjwyijqaWbl0s5+GGgbYHt3Zrb8=;
        b=BpKF/VOt2hh8YfepQwgP9Dxrg2v6vmg2GfVJMp0x2KZBBxm+Kh0c8tIrr3BDf4Izss
         s687+hBlai881dpND6BL7GHgarU6haGzZJAfBKRv6Nmx9rXaerUzhiR4the+3xuJrcsB
         8xDvs8VHAVgZjH+Gzv1fFLG/kt0umtU+nJ12KEhje4IIvdkbV4I+DXxJB6NX8PsZ1MWD
         ZZXyhkgbDbDWoMAvfcTPZ4S8gzHmK6Ws2vpPnbfBwc+IMBgNKGSyGL/Wx7CnlIwX5LCa
         VRlpjBaYkvLWu2mjrMJSgEmUv1rdEnqaKS62V7t04tSXrtRwC5u2ITpMZcm1ssIoE0HB
         Goig==
X-Received: by 10.15.67.195 with SMTP id u43mr42748788eex.14.1386005649543;
        Mon, 02 Dec 2013 09:34:09 -0800 (PST)
Received: from [158.75.2.83] ([158.75.2.83])
        by mx.google.com with ESMTPSA id j46sm73232895eew.18.2013.12.02.09.34.08
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 02 Dec 2013 09:34:08 -0800 (PST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <1385985997.2054.27.camel@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238639>

W dniu 2013-12-02 13:06, Krzesimir Nowak pisze:
> On Mon, 2013-12-02 at 01:21 +0100, Jakub Nar=C4=99bski wrote:
>> On Thu, Nov 28, 2013 at 12:44 PM, Krzesimir Nowak
>> <krzesimir@endocode.com>  wrote:
>>
>>> Allow @additional_branch_refs configuration variable to tell gitweb=
 to
>>> show refs from additional hierarchies in addition to branches in th=
e
>>> list-of-branches view.
>>>
>>> Signed-off-by: Krzesimir Nowak<krzesimir@endocode.com>
>>
>> Why not use %feature hash instead of adding new configuration variab=
le?
>> I think that this option is similar enough to 'remote_heads' feature
>> (which BTW should be 'remote-heads'), and could conceivably enabled
>> on a per-repository basis, i.e. with repository configuration overri=
de,
>> isn't it?
>
> I'd like to see some consensus on it before I start changing the patc=
h
> again.

%feature hash is mainly (but not only) about options that can be
configured on per-repository basis.  Configuration variables are
about options that are per-instance (per gitweb).

>> Usually %feature hash is preferred over adding new configuration var=
iable
>> but this is not some hard rule. Note however that patches adding new=
 config
>> are met with more scrutiny, as it is harder to fix mistakes because =
of
>> requirement of backwards compatibility of configuration files.
>>
>
> I don't know what kind of backwards compatibility you mention. Whethe=
r
> you want gitweb to survive reading old config file or to honor
> deprecated/old config variables.

I meant here honoring deprecated/old variables, i.e. honoring existing
configuration files.  See for example backward compatibility for old
$stylesheet variable vs new @stylesheets in print_header_links().

Though in this case it shouldn't be much of a problem; it would be
easy to honor @additional_branch_refs by setting 'default' for
'extra-branch-refs' feature to it.

>> BTW. there really should be gitweb/CodingGuidelines...
>>
>
> Yes, would be useful. As in every other project. :)

Well, Git itself *has* Documentation/CodingGuidelines, but perhaps
gitweb subsystem should have it's own...

[...]
>>> @@ -3662,7 +3701,8 @@ sub git_get_heads_list {
>>>                  my ($committer, $epoch, $tz) =3D
>>>                          ($committerinfo =3D~ /^(.*) ([0-9]+) (.*)$=
/);
>>>                  $ref_item{'fullname'}  =3D $name;
>>> -               $name =3D~ s!^refs/(?:head|remote)s/!!;
>>> +               my $strip_refs =3D join '|', map { quotemeta } get_=
branch_refs();
>>> +               $name =3D~ s!^refs/(?:$strip_refs|remotes)/!!;
>>>
>>>                  $ref_item{'name'}  =3D $name;
>>>                  $ref_item{'id'}    =3D $hash;
>>> @@ -7179,7 +7219,8 @@ sub snapshot_name {
>>>                  $ver =3D $1;
>>>          } else {
>>>                  # branches and other need shortened SHA-1 hash
>>> -               if ($hash =3D~ m!^refs/(?:heads|remotes)/(.*)$!) {
>>> +               my $strip_refs =3D join '|', map { quotemeta } get_=
branch_refs();
>>> +               if ($hash =3D~ m!^refs/(?:$strip_refs|remotes)/(.*)=
$!) {
>>>                          $ver =3D $1;
>>>                  }
>>>                  $ver .=3D '-' . git_get_short_hash($project, $hash=
);
>>
>> One one hand, it is about threating extra branch refs the same way a=
s 'head'.
>> On the other hand we loose distinction between 'refs/heads/foo' and =
e.g.
>> 'refs/wip/foo'. But maybe that's all right...
>>
>
> In git_get_heads_list sub I could append a " ($ref_dir)" to refs whic=
h
> are in neither 'heads' nor 'remotes', so heads view would look like:
> master
> old-stable
> some-work-in-progress (wip)
> some-other-branch (other)
>
> where both master and old-stable are in refs/heads/,
> some-work-in-progress in refs/wip/ and some-other-branch in refs/othe=
r/.
>
> In case of branch snapshot names (snapshot_name sub) I could change i=
t,
> so names for branches mentioned above would be
> "Project-master-<short-hash>.tgz",
> "Project-old_stable-<short-hash>.tgz",
> "Project-wip-some-work-in-progress-<short-hash>.tgz"
> "Project-other-some-other-branch-<short-hash>.tgz"
>
> What do you think?

That is, I think, a very good idea.  Though perhaps it would be more=20
readable to add this extra feature as a separate patch, on top of main =
one.

--=20
Jakub Narebski
