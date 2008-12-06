From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFCv3 2/2] gitweb: links to patch action in commitdiff and shortlog view
Date: Sat, 6 Dec 2008 16:25:53 +0100
Message-ID: <200812061625.53527.jnareb@gmail.com>
References: <1228345188-15125-1-git-send-email-giuseppe.bilotta@gmail.com> <200812060153.52947.jnareb@gmail.com> <cb7bb73a0812060525k65a7f549l2cce5f0dae9fc76c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>,
	"Junio C Hamano" <gitster@pobox.com>
To: "Giuseppe Bilotta" <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 16:27:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L8z41-0001Bo-NU
	for gcvg-git-2@gmane.org; Sat, 06 Dec 2008 16:27:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756815AbYLFP0A convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 6 Dec 2008 10:26:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756723AbYLFP0A
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Dec 2008 10:26:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:22327 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756802AbYLFPZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2008 10:25:59 -0500
Received: by nf-out-0910.google.com with SMTP id d3so220833nfc.21
        for <git@vger.kernel.org>; Sat, 06 Dec 2008 07:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=+emDN9a5vE22c/CgQt4zyXuOtgWW2B5gvReFumn6wMo=;
        b=oE02KKDl2d+8osxcZprRhoDHi8KMREmu8cVbDwTvNyHi4oCizLHf5fxzlx1D63Q0fR
         dYsbHlS/a74DdcVLyix7q9jOZZnNzMiyzbZrZTExryxMxTvQ5b7xgLw5O1VTAvgaQBtV
         pWK9nCErmMCqjKR8LCe4qk1wR9+69cTNU9MnE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=PuNUJJh1RtkBCXDRn6pKT4U8QVWMBKjBB/j6pGIhaLiVbzL/BpMsduz6UntjjyeIE4
         idgi8sK2EfiJdMNx0F1NZldm30WMoP9TwW7jgV4qZmq/s6p7cNGEQWtj7iII1RTeOlmr
         WK84yhyv02Xnl0dZKXj8UgzqGViRRaB05YRy8=
Received: by 10.210.119.16 with SMTP id r16mr1325819ebc.191.1228577156143;
        Sat, 06 Dec 2008 07:25:56 -0800 (PST)
Received: from ?192.168.1.11? (abvc175.neoplus.adsl.tpnet.pl [83.8.200.175])
        by mx.google.com with ESMTPS id 3sm6822229eyi.45.2008.12.06.07.25.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 06 Dec 2008 07:25:55 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <cb7bb73a0812060525k65a7f549l2cce5f0dae9fc76c@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102463>

Dnia sobota 6. grudnia 2008 14:25, Giuseppe Bilotta napisa=B3:
> On Sat, Dec 6, 2008 at 1:53 AM, Jakub Narebski <jnareb@gmail.com> wro=
te:
>> On Wed, 3 Dec 2008, Giuseppe Bilotta wrote:
>>
>>> In shortlog view, a link to the patchset is only offered when the n=
umber
>>> of commits shown is less than the allowed maximum number of patches=
=2E
>>>
>>> Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
=20
>>> +     if (gitweb_check_feature('patches')) {
>>> +             $formats_nav .=3D " | " .
>>> +                     $cgi->a({-href =3D> href(action=3D>"patch", -=
replay=3D>1)},
>>> +                             "patch");
>>> +     }
>>>
>>>       if (!defined $parent) {
>>>               $parent =3D "--root";
>>> @@ -5415,6 +5420,11 @@ sub git_commitdiff {
>>>               $formats_nav =3D
>>>                       $cgi->a({-href =3D> href(action=3D>"commitdif=
f_plain", -replay=3D>1)},
>>>                               "raw");
>>> +             if ($patch_max) {
>>> +                     $formats_nav .=3D " | " .
>>> +                             $cgi->a({-href =3D> href(action=3D>"p=
atch", -replay=3D>1)},
>>> +                                     "patch");
>>> +             }
>>>
>>>               if (defined $hash_parent &&
>>>                   $hash_parent ne '-c' && $hash_parent ne '--cc') {
>>
>> In the above two hunks 'patch' view functions as "git show --pretty=3D=
email"
>> text/plain equivalent, but this duplicates a bit 'commitdiff_plain'
>> functionality.  Well, 'commitdiff_plain' has currently some errors,
>> but...
>=20
> All things considered, for single commit view there is (modulo bugs)
> no factual difference between plain diff and patch view.
>=20
> Although we could merge them, I'm thinking that the plain diff view
> has somewhat too much information in it. For backwards compatibility
> it's probably not wise to change it, but we should consider it for th=
e
> next major version, honestly.

I'm just wondering if we should add 'patch' link to 'commit' and
'commitdiff' views (as alternate view) at all...
=20
>>> @@ -5949,6 +5959,14 @@ sub git_shortlog {
>>>                       $cgi->a({-href =3D> href(-replay=3D>1, page=3D=
>$page+1),
>>>                                -accesskey =3D> "n", -title =3D> "Al=
t-n"}, "next");
>>>       }
>>> +     my $patch_max =3D gitweb_check_feature('patches');
>>> +     if ($patch_max) {
>>> +             if ($patch_max < 0 || @commitlist <=3D $patch_max) {
>>> +                     $paging_nav .=3D " &sdot; " .
>>> +                             $cgi->a({-href =3D> href(action=3D>"p=
atch", -replay=3D>1)},
>>> +                                     @commitlist> 1 ? "patchset" :=
 "patch");
>>> +             }
>>> +     }
>>
>> Here 'patch' view functions as "git format-patch", able to be downlo=
aded
>> and fed to git-am.  Perhaps the action should also be named 'patches=
'
>> here?; it could lead to the same function.
>=20
> I had half an idea to do so. 'patches' or 'patchset'?

Hmmm... I think 'patches'.

>> By the way, there is subtle bug in above link. If shortlog view is l=
ess
>> than $patch_max commits long, but it is because the history for a gi=
ven
>> branch (or starting from given commit) is so short, and not because
>> there is cutoff $hash_parent set, the 'patchset' view wouldn't displ=
ay
>> plain text equivalent view, but only patch for top commit.
>=20
> Ah, good point.
>=20
> Hm, not easy to solve. One way could be to add the hash_parent
> manually. Or we could make the 'patches' view different from the
> 'patch' view in the way it handles refspecs without ranges. I'm
> leaning towards the latter. What's your opinion?

I think simplest solution would be to add $hash_parent if it is not
set from the last commit, i.e. $commitlist[-1]{'id'}

>> I assume that the link is only for 'shortlog' view, and not also for
>> 'log' and 'history' views because 'shortlog' is the only log-like vi=
ew
>> which support $hash_parent?
>=20
> The actual reason is that I never use log nor history view, but since
> they don't support hash_parent because of this (I was the one who sen=
t
> the patch to support hash_parent in shortlog view) you could
> paralogistically say that's the reason ;-)
>=20
> I'm not sure about history view, but for log view I'm considering
> addiong also a 'patch' link next to each commit. I'll think about it.

Well, you can add it only for 'shortlog' view, and when the code for
all log-like views would get consolidated, you will get link to 'patche=
s'
view automatically :-)

--=20
Jakub Narebski
Poland
