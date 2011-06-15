From: Sedat Dilek <sedat.dilek@googlemail.com>
Subject: Re: Patch-level-format conversion
Date: Wed, 15 Jun 2011 23:16:54 +0200
Message-ID: <BANLkTim8bdVGo8u_HzZpE_5+xmPe_O+_Dw@mail.gmail.com>
References: <BANLkTimRArtFBqA4BFASjkS9BC1sbSfUJQ@mail.gmail.com>
	<20110615205507.GB27172@elie>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=000e0cd60836fae81c04a5c6ab06
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 23:17:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWxSP-0004IE-EB
	for gcvg-git-2@lo.gmane.org; Wed, 15 Jun 2011 23:17:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886Ab1FOVQ4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 17:16:56 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58276 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752383Ab1FOVQz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 17:16:55 -0400
Received: by qyk7 with SMTP id 7so2210730qyk.19
        for <git@vger.kernel.org>; Wed, 15 Jun 2011 14:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:reply-to:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=FyY5uHjOA+TlfcxefR1+U70fUKThoVcD2WaHOIYdphs=;
        b=J8hjngo4+RcljxE90Dgfl5HTwmJEidZyrMfLKBpougX4YNpuGUmav6/7sUZJGTEGAP
         3Z5xNw+gkizggzt3oyfAUiWKgE9zUg2LhFe6KC3Z//wVXns4h0aD/VraVgs7Dx76+cyk
         5R5flLUX7bOQUlJA8SxmZwSILEQGxT3uzqkMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        b=jjX2PzVIDVLlvFF/Q0rTYQsIDJBonTVLATg1inIykf5Q4FZd2eGDBbGobT6ZPlToq/
         TRRtXJhqFE832Ng995MDi6VhAoTd1d8wKvfh3JINypk6/USgKo1s4uGOQ3Seqr9o+u4L
         YeBwgaX7lul4TCFzBG2L5NqJzEYwRSUjGNOe4=
Received: by 10.229.117.95 with SMTP id p31mr115714qcq.97.1308172614297; Wed,
 15 Jun 2011 14:16:54 -0700 (PDT)
Received: by 10.229.55.148 with HTTP; Wed, 15 Jun 2011 14:16:54 -0700 (PDT)
In-Reply-To: <20110615205507.GB27172@elie>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175853>

--000e0cd60836fae81c04a5c6ab06
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 15, 2011 at 10:55 PM, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> (+cc: the git list so others can correct me. =C2=A0I hope that's okay.)
>
> Hi,
>
> Sedat Dilek wrote:
>
>> I have here a patchset extracted from my own git-repo (via git format-pa=
tch).
>>
>> The project for which those patches are want "p0" format, means no
>> ---- a/... +++ b/... but --- ... +++ ...
>>
>> IIRC git does "p1" format as default.
>> Any help? Idea?
>
> If I understand correctly, you are in luck. =C2=A0The "git format-patch
> --no-prefix" command thanks to Dscho seems to do exactly that:
>
> =C2=A0$ git log -Sno-prefix -- Documentation/diff-options.txt
> =C2=A0commit eab9a40b6dd5c1c571b1deb264133db47bb4794d
> =C2=A0Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> =C2=A0Date: =C2=A0 Tue Dec 18 19:32:14 2007 +0000
>
> =C2=A0 =C2=A0 Teach diff machinery to display other prefixes than "a/" an=
d "b/"
>
> =C2=A0 =C2=A0 With the new options "--src-prefix=3D<prefix>", "--dst-pref=
ix=3D<prefix>"
> =C2=A0 =C2=A0 and "--no-prefix", you can now control the path prefixes of=
 the diff
> =C2=A0 =C2=A0 machinery. =C2=A0These used to by hardwired to "a/" for the=
 source prefix
> =C2=A0 =C2=A0 and "b/" for the destination prefix.
>
> =C2=A0 =C2=A0 Initial patch by Pascal Obry. =C2=A0Sane option names sugge=
sted by Linus.
>
> =C2=A0 =C2=A0 Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx=
.de>
> =C2=A0 =C2=A0 Acked-by: Linus Torvalds <torvalds@linux-foundation.org>
> =C2=A0 =C2=A0 Signed-off-by: Junio C Hamano <gitster@pobox.com>
>
> Hope that helps.
> Jonathan
>

Hi Jonathan,

I played a bit with git format-patch and git diff and got some helpful
hints from friends of #grml and #quassel.de.
Attached is the README.txt I produced some hours ago.

Regards,
- Sedat -

--000e0cd60836fae81c04a5c6ab06
Content-Type: text/plain; charset=US-ASCII; name="README.txt"
Content-Disposition: attachment; filename="README.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_goys6zew0

UTogSG93IHRvIGdlbmVyYXRlIGZyZWV0ei1jb25mb3JtIHBhdGNoZXMgb3V0IG9mIGEgR0lUIHJl
cG9zaXRvcnk/CgpBLiBGb2xsb3cgdGhlc2UgaW5zdHJ1Y3Rpb25zLgoKIyMjIENoZWNrb3V0IGZy
ZWV0eiBkZXZlbG9wbWVudCBicmFuY2gKc3ZuIGNvIGh0dHA6Ly9zdm4uZnJlZXR6Lm9yZy90cnVu
ay8gZnJlZXR6LXRydW5rCmNkIGZyZWV0ei10cnVuay8KCiMjIyBHZXQgbGF0ZXN0IHJldmlzaW9u
CnJldmlzaW9uPSQoTENfQUxMPUMgc3ZuIGluZm8gfCBncmVwICJMYXN0IENoYW5nZWQgUmV2IiB8
IGF3ayB7J3ByaW50ICQ0J30pCmVjaG8gJHJldmlzaW9uCgojIyMgVHVybiBmcmVldHotdHJ1bmsg
c291cmNlLWRpciBpbnRvIGEgR0lUIHJlcG9zaXRvcnkKZ2l0IGFkZCAtLWlnbm9yZS1lcnJvcnMg
Li8gOyBnaXQgY29tbWl0IC1tICJgYmFzZW5hbWUgJFBXRGAgU1ZOIHJldmlzaW9uICRyZXZpc2lv
biIKCiMjIyBFZGl0IHNvbWUgZmlsZXMgYW5kIHNhdmUgY2hhbmdlcwokRURJVE9SIGZpbGUxIGZp
bGUyCgojIyMgRXh0cmFjdCBwYXRjaHNldApnaXQgZm9ybWF0LXBhdGNoIC0tbm8tcHJlZml4IC0t
bm8tbnVtYmVyZWQgJEZJUlNULi4kTEFTVAoKIyMjIFNvbWUgZ2l0IGZvcm1hdC1wYXRjaCBvcHRp
b25zIGV4cGxhaW5lZDoKICAgICAgLS1uby1wcmVmaXg6IERvIG5vdCBzaG93IGFueSBzb3VyY2Ug
b3IgZGVzdGluYXRpb24gcHJlZml4LgogICAtbiwgLS1udW1iZXJlZDogTmFtZSBvdXRwdXQgaW4g
W1BBVENIIG4vbV0gZm9ybWF0LCBldmVuIHdpdGggYSBzaW5nbGUgcGF0Y2guCi1OLCAtLW5vLW51
bWJlcmVkOiBOYW1lIG91dHB1dCBpbiBbUEFUQ0hdIGZvcm1hdC4KCgotIFNlZGF0IERpbGVrIDxz
ZWRhdC5kaWxla0BnbWFpbC5jb20+ICgxNS1KdW4tMjAxMSkK
--000e0cd60836fae81c04a5c6ab06--
