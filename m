From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCHv5 08/12] gitweb: auxiliary function to group data
Date: Mon, 27 Sep 2010 10:12:22 +0200
Message-ID: <201009271012.23175.jnareb@gmail.com>
References: <1285344167-8518-1-git-send-email-giuseppe.bilotta@gmail.com> <201009262347.15779.jnareb@gmail.com> <AANLkTimOJ7RXDWXy=tF+rZf1gnfB7_GHCZuU5bZ5Wc91@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 27 10:13:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P08ph-0003lY-25
	for gcvg-git-2@lo.gmane.org; Mon, 27 Sep 2010 10:13:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932798Ab0I0IMo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 27 Sep 2010 04:12:44 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:63001 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758901Ab0I0IMd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Sep 2010 04:12:33 -0400
Received: by fxm3 with SMTP id 3so1632203fxm.19
        for <git@vger.kernel.org>; Mon, 27 Sep 2010 01:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Zw+wM9tQSuxPKqN/fV8LRjpBY2lOZ0LuCn8KUBjW600=;
        b=cLDKSX7j19HOP8h1+lieXUuhujwNMabwvI5OXugp/fhhD+PaL1BhDzQao8B7+vF9ev
         ymx8FkauV0m3c6LVESbthNOTMSrjuVH2EBL0E4TzT6xR8McHz/CeYszq6+cYVHFk4TcK
         t02oi+qWgrmYFHO48zq2sM/TkL/T0ayLeEDhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=ul3Zk9NioSIIsbalBnSZIPhF7EU5AB5edwOlGSTInya6Fo43lSZJjuyHkJB1V/5DF+
         o8naamI1VSbv6UKwU2CXQ3LrVRleV/ZIOFqMAVZ1fmJEgkF5sX4kOsz8BaZN2y0W0mjV
         Xhoj+HU8hzYkmfb171Qgq6vcYtLnoH/pI/vBg=
Received: by 10.223.119.210 with SMTP id a18mr5825036far.38.1285575151778;
        Mon, 27 Sep 2010 01:12:31 -0700 (PDT)
Received: from [192.168.1.13] (abvz242.neoplus.adsl.tpnet.pl [83.8.223.242])
        by mx.google.com with ESMTPS id c20sm2247120fak.33.2010.09.27.01.12.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 27 Sep 2010 01:12:30 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <AANLkTimOJ7RXDWXy=tF+rZf1gnfB7_GHCZuU5bZ5Wc91@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157319>

Dnia poniedzia=B3ek 27. wrze=B6nia 2010 09:26, Giuseppe Bilotta napisa=B3=
:
> 2010/9/26 Jakub Narebski <jnareb@gmail.com>:
>> On Fri, 24 Sep 2010, Giuseppe Bilotta wrote:
>>
>>> Subject: gitweb: auxiliary function to group data
>>>
>>
>> Errr... what!? =A0git_group() is not "auxiliary function to group da=
ta",
>> but a template for output of group of data.
>=20
> I will rephrase

Though I don't know how such rephrasing should look like.

>> It would be probably good to describe how this output looks like
>> (using e.g. ASCII-art mockup) in a commit message.
>=20
> Well, that would depend on the CSS that is used ... should I squash
> the styling in this patch then?

No, I don't think it is needed, but it can be done.

>>> +sub git_group {
>>
>> Name?
>=20
> git_collection? git_collect_data? I'm a little short on ideas.
> git_section? git_subsection? the function (with different styling) ca=
n
> probably be used even for the main sections in each view (think
> summary view in particular).

git_group_html / git_subgroup_html / git_subsection_html
print_group / print_subgroup / print_section / print_subsection

It needs either *_html suffix (like git_header_html), or print_* prefix
to denote that it prints HTML fragment, I think.

>>> + =A0 =A0 $content_func->() if defined $content_func;
>>
>> More defensive programming would be to use
>>
>> =A0+ =A0 =A0 $content_func->() if ref($content_func) eq 'CODE';
>>
>> Or even:
>>
>> =A0+ =A0 =A0 if (ref($content) eq 'CODE') {
>> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 $content->();
>> =A0+ =A0 =A0 } elsif (ref($content) eq 'ARRAY') {
>> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 print @$content;

The 'ARRAY' part is probably unnecessary overengineering.

>> =A0+ =A0 =A0 } elsif (!ref($content) && defined($content)) {
>> =A0+ =A0 =A0 =A0 =A0 =A0 =A0 print $content;
>> =A0+ =A0 =A0 }

Or even (in the vein of further overengineering)

    +     } elsif (ref($content) eq 'SCALAR') {
    +             print esc_html($$content);
    +     } elsif (!ref($content) && defined($content)) {
    +             print $content;
    +     }

or vice versa ;-)

>>
>> Well, $content could be also open filehandle...

Though I don't know how to check that.  ref on filehandles return
'GLOB'... well, we can use 'openhandle' from Scalar::Util (core).
But that is probably unnecessary overengineering.
=20
> Ah, very interesting and very flexible, I'll steal your idea.
>=20
> --=20
> Giuseppe "Oblomov" Bilotta
>=20

--=20
Jakub Narebski
Poland
