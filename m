From: B Smith-Mannschott <bsmith.occs@gmail.com>
Subject: Re: OS X and umlauts in file names
Date: Wed, 25 Nov 2009 10:51:48 +0100
Message-ID: <28c656e20911250151v7b89e5f8pa15aa2bd7d5f96d@mail.gmail.com>
References: <4B0ABA42.1060103@syntevo.com>
	 <alpine.LNX.2.00.0911231403100.14365@iabervon.org>
	 <4B0CEFCA.5020605@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Thomas Singer <thomas.singer@syntevo.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 10:52:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDEXa-0007CM-OW
	for gcvg-git-2@lo.gmane.org; Wed, 25 Nov 2009 10:52:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758354AbZKYJvs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Nov 2009 04:51:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758261AbZKYJvr
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Nov 2009 04:51:47 -0500
Received: from mail-ew0-f219.google.com ([209.85.219.219]:63695 "EHLO
	mail-ew0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758514AbZKYJvo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Nov 2009 04:51:44 -0500
Received: by ewy19 with SMTP id 19so194160ewy.21
        for <git@vger.kernel.org>; Wed, 25 Nov 2009 01:51:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=dcLPcfdXsovIZSZR0+FCBv8oQM2xOMdWCmtvQQezNMo=;
        b=AlzJgnhhUDez2y8NuKdA207t11aOV+P6CzTAceEtDWH98Nkcq7691QJNkQcuvuwOYU
         t6Xle67wVqLUz+dQVm+lcqnFrJCq0O8Wgjk/Rn8tkBFog9/Ul4fi7gdHue0+yaAK2xk/
         iKqAr6aiTfmRfJQ5EZrbG3YKEkWArLKHxoTpo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=mtkq6csBm7zKxpP0OnT7/sJLdQkjjQEXk3KJYBz/Dkg34zh6yuMJWbAHgASC8kDCOD
         e5+NRhH3c1YXBTbdmaVKXWDV/jiCGCjmMReCTdWfz3Gsk9+xLIJoscM6iQvQE02t+KPZ
         T0GYf7IpCRDsBl4Bj08fXV+wy2poB5quueMkw=
Received: by 10.213.1.5 with SMTP id 5mr493123ebd.22.1259142708278; Wed, 25 
	Nov 2009 01:51:48 -0800 (PST)
In-Reply-To: <4B0CEFCA.5020605@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133620>

On Wed, Nov 25, 2009 at 09:50, Thomas Singer <thomas.singer@syntevo.com=
> wrote:
> I've did following:
>
> =C2=A0toms-mac-mini:git-umlauts tom$ ls
> =C2=A0=C3=9Cberl=C3=A4nge.txt
> =C2=A0toms-mac-mini:git-umlauts tom$ git status
> =C2=A0# On branch master
> =C2=A0#
> =C2=A0# Initial commit
> =C2=A0#
> =C2=A0# Changes to be committed:
> =C2=A0# =C2=A0 (use "git rm --cached <file>..." to unstage)
> =C2=A0#
> =C2=A0# =C2=A0 =C2=A0 new file: =C2=A0 "U\314\210berla\314\210nge.txt=
"
> =C2=A0#
> =C2=A0toms-mac-mini:git-umlauts tom$ git stage "U\314\210berla\314\21=
0nge.txt"
> =C2=A0fatal: pathspec 'U\314\210berla\314\210nge.txt' did not match a=
ny files
>
> Note, that I copy-pasted the file name which 'git status' showed to t=
he
> stage command. IMHO, this should work, especially, because different =
people
> said Git would treat the file name as byte-array without interpreting=
 it in
> some kind.
>
> From the user with the German OS X (for which the staging is said to =
work),
> I've got the output of 'env' and hence also tried
>
> =C2=A0export LANG=3Dde_DE.UTF-8
>
> before doing the above steps, but with the same results. :(

The problem you are having is not because of the *encoding*, it's the
Normalization form that's messing things up. The fact is that in
Unicode there are two ways to represent many -- but not all --
accented characters.

- "composed": one code point for the accented character)
- "decomposed": two code points: one for the base letter, one or more
combining characters for the accents.

The composed code points are really just backward compatibility to
legacy encodings (like LATIN-1). If you want to actually support
(rather than just tolerate) unicode you have to know how to deal with
the decomposed form, and once you can do that there's little point
beyond backward compatibility in continuing to use composed form
internally.

The Subversion people have run into this same problem because they
made the same error of assuming that any given sequence of glyphs has
only one possible representation as unicode code points and thus only
one representation as UTF-8 bytes. Dionisos has done written up the
issues involved here:

http://svn.apache.org/repos/asf/subversion/trunk/notes/unicode-composit=
ion-for-filenames

// Ben
