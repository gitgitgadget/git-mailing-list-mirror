From: Al Haraka <alharaka@gmail.com>
Subject: Re: Gitweb 1.7.5 and Textconv Configuration
Date: Sat, 2 Jul 2011 14:14:30 +0300
Message-ID: <CALWDD1woB0ytL6T-DwD92f824dnpz0mek=SYgz5jwqR0efnkpw@mail.gmail.com>
References: <CALWDD1x-_rEx+c9bpAgVk-hvnGz1bt0mbJoDkSjZkbe=gLscUg@mail.gmail.com>
	<20110702104313.GA10245@sigill.intra.peff.net>
	<20110702104437.GA10538@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jul 02 13:14:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qcy9k-0004Ts-Gc
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 13:14:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753956Ab1GBLOc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jul 2011 07:14:32 -0400
Received: from mail-fx0-f52.google.com ([209.85.161.52]:48409 "EHLO
	mail-fx0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753201Ab1GBLOb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 2 Jul 2011 07:14:31 -0400
Received: by fxd18 with SMTP id 18so3919565fxd.11
        for <git@vger.kernel.org>; Sat, 02 Jul 2011 04:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=oHB0F8Pu1LOwtUeYQ7g+Lz3AhzjTndwIbhQ0q7P8lmg=;
        b=s7ox2xvtmsi+UYOK/6r2P38klJdXXAFS5pq0iBJ4Q9gc7jzYelpQD0EABqmuEN8K0e
         of9xf4iuXQmF5Hq5qW0lVSCmn72GE3EFSkeGLGuHh8G7d2JwsbX8IkarG3HnwjpYdoRm
         esav05H5m7wEtSGUkbWKxPpHUZDdAjUco7Q2o=
Received: by 10.223.7.150 with SMTP id d22mr6264514fad.17.1309605270105; Sat,
 02 Jul 2011 04:14:30 -0700 (PDT)
Received: by 10.223.101.207 with HTTP; Sat, 2 Jul 2011 04:14:30 -0700 (PDT)
In-Reply-To: <20110702104437.GA10538@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176555>

On Sat, Jul 2, 2011 at 1:44 PM, Jeff King <peff@peff.net> wrote:
> On Sat, Jul 02, 2011 at 06:43:13AM -0400, Jeff King wrote:
>
>> The default gitweb configuration doesn't allow textconv (or external
>> diff) for security reasons; it would mean repo owners could execute
>> arbitrary commands as the gitweb user.
>>
>> If that's OK for your site, you can probably enable it with:
>>
>> =C2=A0 push @diff_opts, '--allow-textconv';

Just tried it.

$ more ~/repos/gitweb_config.perl
# where is the git binary?
$GIT =3D "/home/dreamhost_account/opt/bin/git";
# where are our git project repositories?
$projectroot =3D $ENV{'GIT_PROJECT_ROOT'};
# what do we call our projects in the gitweb UI?
$home_link_str =3D "~";
#  where are the files we need for gitweb to display?
@stylesheets =3D ("gitweb.css");
$logo =3D "git-logo.png";
$favicon =3D "/favicon.png";
# what do we call this site?
$site_name =3D "my personal git repos";
# Enable textconv
push @diff_opts, '--textconv';

Reloaded the webpage; still does *not* show text diffs.  Any way to
debug what is going wrong?

> Oops, this option is just called "--textconv". I got it confused with
> the flag in the code, which is ALLOW_TEXTCONV.

No worries.  You are steering my in the right direction, typos or not.

> -Peff
>



--=20
Alexander J. Stein
Cell:=C2=A0 +974 70013750
Email: alharaka@gmail.com
Skype: alexander.j.stein
