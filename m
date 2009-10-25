From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] Use 'fast-forward' all over the place
Date: Sun, 25 Oct 2009 12:02:27 +0300
Message-ID: <94a0d4530910250202h7a890575md080a554f9e0b3e6@mail.gmail.com>
References: <1256373092-15126-1-git-send-email-felipe.contreras@gmail.com>
	 <1256373092-15126-2-git-send-email-felipe.contreras@gmail.com>
	 <7v1vks2l8q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael J Gruber <git@drmicha.warpmail.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 25 10:02:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1yzj-0001RB-Ub
	for gcvg-git-2@lo.gmane.org; Sun, 25 Oct 2009 10:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752790AbZJYJCZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Oct 2009 05:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752489AbZJYJCZ
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Oct 2009 05:02:25 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:14935 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752099AbZJYJCY convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Oct 2009 05:02:24 -0400
Received: by fg-out-1718.google.com with SMTP id d23so745596fga.1
        for <git@vger.kernel.org>; Sun, 25 Oct 2009 02:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Pc7EYzROMp5LJv4RZxUsqhPk6sjslfjU8S7P0FWaT+0=;
        b=ROVoafEGg7lEo/wysb45tKoM8C5RpAtABXe7yZ5nbaZH+O1cqsDlrFKpS1gjUJ4ax5
         7S8vRrRlZZl9JfbNh8PDqyG9etLYRtFyg/WuQMYaSBgJcES0eawY5lGCWCgcKcTqBrOt
         zWWZ5jNHsCKAU4rl3+oh5Mqs8aGFSqm2n0rE4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DXDqRyzYl0IeChu6Blf4A96gOjqTJXjcROZbdrZ5yWySmaTPcs5T1ReQg1/h15DGCq
         WQtFFYLFOASghATfiEVfJI3BK/QOvuQbUfI8NCwntOqaydaU9BGUczghWI2ah+U8DGbd
         RxtlJ+NvtWmr0dd4Cad5wv9qQZSXigljvMPNA=
Received: by 10.87.66.32 with SMTP id t32mr2421110fgk.75.1256461347097; Sun, 
	25 Oct 2009 02:02:27 -0700 (PDT)
In-Reply-To: <7v1vks2l8q.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131195>

On Sun, Oct 25, 2009 at 6:41 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> This is the latter half of my review; please see
>
> =C2=A0 =C2=A0From: =C2=A0 =C2=A0 =C2=A0 Junio C Hamano <gitster@pobox=
=2Ecom>
> =C2=A0 =C2=A0Subject: Re: [PATCH] Use 'fast-forward' all over the pla=
ce
> =C2=A0 =C2=A0Date: =C2=A0 =C2=A0 =C2=A0 Sat, 24 Oct 2009 10:50:05 -07=
00
> =C2=A0 =C2=A0Message-ID: <7v3a587kc2.fsf@alter.siamese.dyndns.org>
>
> for the other half.
>
> Felipe Contreras <felipe.contreras@gmail.com> writes:

>> diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-r=
eceive-email
>> @@ -315,8 +315,8 @@ generate_update_branch_email()
>> =C2=A0 =C2=A0 =C2=A0 # "remotes/" will be ignored as well.
>>
>> =C2=A0 =C2=A0 =C2=A0 # List all of the revisions that were removed b=
y this update, in a
>> - =C2=A0 =C2=A0 # fast forward update, this list will be empty, beca=
use rev-list O
>> - =C2=A0 =C2=A0 # ^N is empty. =C2=A0For a non fast forward, O ^N is=
 the list of removed
>> + =C2=A0 =C2=A0 # fast-forward update, this list will be empty, beca=
use rev-list O
>> + =C2=A0 =C2=A0 # ^N is empty. =C2=A0For a non fast-forward, O ^N is=
 the list of removed
>
> Wasn't non-fast-forward a single compound word of three?

Yes, but as I mentioned before; it's not something I'm tackling on
this patch: only "non-fast forward". I think a separate patch should
be done for "non fast.forward" -> non-fast-forward.

>> diff --git a/git-gui/lib/branch_create.tcl b/git-gui/lib/branch_crea=
te.tcl
>> index 3817771..f1235c7 100644
>> --- a/git-gui/lib/branch_create.tcl
>> +++ b/git-gui/lib/branch_create.tcl
>> @@ -77,7 +77,7 @@ constructor dialog {} {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -variable @opt_merg=
e
>> =C2=A0 =C2=A0 =C2=A0 pack $w.options.merge.no -side left
>> =C2=A0 =C2=A0 =C2=A0 radiobutton $w.options.merge.ff \
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -text [mc "Fast Forward =
Only"] \
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -text [mc "Fast-forward =
Only"] \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -value ff \
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -variable @opt_merg=
e
>> =C2=A0 =C2=A0 =C2=A0 pack $w.options.merge.ff -side left
>
> Please leave git-gui out; (1) it is not managed by me and the patch s=
hould
> be fed to Shawn separately, and (2) updating [mc] keystrings must nee=
d
> matching updates to the translation file and the templates.
>
> I also think this is a label string and the capitalization must be ke=
pt,
> i.e. "Fast-Forward Only".

Ok.

>> diff --git a/t/t1001-read-tree-m-2way.sh b/t/t1001-read-tree-m-2way.=
sh
>> @@ -51,7 +51,7 @@ check_cache_at () {
>> =C2=A0}
>>
>> =C2=A0cat >bozbar-old <<\EOF
>> -This is a sample file used in two-way fast forward merge
>> +This is a sample file used in two-way fast-forward merge
>> =C2=A0tests. =C2=A0Its second line ends with a magic word bozbar
>> =C2=A0which will be modified by the merged head to gnusto.
>> =C2=A0It has some extra lines so that external tools can
>
> Doesn't changing this change the actual test blob used? =C2=A0Do you =
know if
> the test still passes when git is not broken?

I didn't check. I will.

Cheers.

--=20
=46elipe Contreras
