From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: GSoC draft proposal: Line-level history browser
Date: Tue, 23 Mar 2010 13:57:45 -0500
Message-ID: <20100323185745.GA1382@progeny.tock>
References: <41f08ee11003202316w2fddc5f4jebda47f325451577@mail.gmail.com>
 <4BA61CF9.7040104@gmail.com>
 <41f08ee11003212048q1950eb3s95f1caf7ba640874@mail.gmail.com>
 <7vfx3tvv9y.fsf@alter.siamese.dyndns.org>
 <41f08ee11003212134s586aa71cs23255d02f38d53d1@mail.gmail.com>
 <7vhbo8syyf.fsf@alter.siamese.dyndns.org>
 <41f08ee11003220031p6fda651eycff2641df10864da@mail.gmail.com>
 <7v7hp4n6qn.fsf@alter.siamese.dyndns.org>
 <20100322081003.GA26535@progeny.tock>
 <41f08ee11003222301y569a5972q3c67d10c77abe27a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, gitzilla@gmail.com,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Bo Yang <struggleyb.nku@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 19:58:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nu9Ic-0003uM-Ti
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 19:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753719Ab0CWS5y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 14:57:54 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:37702 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566Ab0CWS5x (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 14:57:53 -0400
Received: by pwi5 with SMTP id 5so3584447pwi.19
        for <git@vger.kernel.org>; Tue, 23 Mar 2010 11:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=H5xox5yQhDc3d5nT8NQzvybnvNak5Ym6yXGjVtBO3ro=;
        b=NwfNHLL1Z3VGir2GtjARykBLmar5peiFrGcvP9UPs2alVSgMcw7Qza/MQ3hEDt5Cdc
         fmWTs9FpDQP94LHcMEUwa5zeYrjQwM71k7a+HN/CHlxsy1F5eY2mxl+1iPYYEGW9iMpt
         qh+JzxW71Ry/hS/31GArKg8a1W1/TnkFNUphc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Pc90kqvJf5iEVQLL+jWJb6BmzbC9OSu2bt026pAHw/OvpwlV5KcjLOWYdgpOgAtUIj
         ZChpbZCcos2m8sM9HxUg6IoLcEqz9EXSdqfVq1jAB1vMfc+ATBdUYwbAmcTLKA8q5b9z
         tW2nBmKtz7zcINQ/9vwOl9wL8CvxhdKguHzog=
Received: by 10.115.135.13 with SMTP id m13mr2829416wan.206.1269370671749;
        Tue, 23 Mar 2010 11:57:51 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm5238784iwn.7.2010.03.23.11.57.49
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 23 Mar 2010 11:57:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <41f08ee11003222301y569a5972q3c67d10c77abe27a@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143042>

Hi,

[reordering quoted text for convenience]

Bo Yang wrote:

> I can't understand fully about your above strategy. I think we can
> category the code change into two cases:

Thanks!  What you said is much more coherent than the vague things I
wrote.

> 2. The diff looks like:
[...]
> This means, the code here is added from scratch. Here, I think we hav=
e
> three options.
> 1. Find if the new code is moved here from other place.
> 2. Find if the new code is copied from other place.
> 3. We find the end of the history, so stop here.

If the code is copied verbatim from elsewhere, this is something =E2=80=
=98git
blame=E2=80=99 is already very good at.  See [1].

=46uzzy matching is a big pain.  =E2=80=98git blame=E2=80=99 knows how =
to ignore
whitespace.  Dscho suggested counting common words.  Maybe there are
some other ways.  I think there is a real danger of getting lost in thi=
s
problem and wasting a lot of time, so although it is very interesting, =
I
would consider any progress in this area a bonus rather than a goal.

> 1. The diff looks like:
>=20
> @@ -1008,29 +1000,29 @@ int cmd_format_patch(int argc, const char
> **argv, const char *prefix)
>                 add_signoff =3D xmemdupz(committer, endpos - committe=
r + 1);
>         }
>=20
> -       for (i =3D 0; i < extra_hdr_nr; i++) {
> -               strbuf_addstr(&buf, extra_hdr[i]);
> +       for (i =3D 0; i < extra_hdr.nr; i++) {
> +               strbuf_addstr(&buf, extra_hdr.items[i].string);
>                 strbuf_addch(&buf, '\n');
>         }
>=20
>=20
> ie: there is both deletion and addition in a change. And this means w=
e
> modify some lines of the code. So, what we do will be tracing the two
> 'minus' lines and then find another diff. Start trace from that diff
> recursively.

If you can make a heuristic along these lines this work well, I think i=
t
would be great.  I imagine it might work very well for commits that mad=
e
nice, small changes (like many of those in git.git).  Jakub pointed out
some of the difficulties, and I like to hope your idea of =E2=80=9Cwhen=
 in doubt,
include more lines=E2=80=9D may work well in many cases in git.git stil=
l.

Good luck, and thank you for taking my crazy ideas seriously. :)

Regards,
Jonathan

[1] See v1.4.4-rc1~2 (Merge branch 'jc/pickaxe', 2006-11-07) and the
commits preceding it.  About that series, Junio wrote:

	Actually the plan is to make it do _true_ pickaxe,
	although it will most likely end up either in dustbin or
	replace blame.

It replaced blame.

I am not actually sure, but I assume =E2=80=9Ctrue pickaxe=E2=80=9D ref=
ers to the
goals described in <http://gitster.livejournal.com/35628.html>
and the linked-to message.
