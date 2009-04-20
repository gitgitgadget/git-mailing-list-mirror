From: Jay Soffian <jaysoffian@gmail.com>
Subject: Oldest supported Perl version
Date: Mon, 20 Apr 2009 10:59:00 -0400
Message-ID: <76718490904200759l24e1bd9exe0e1b60f7b2847a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Michael Witten <mfwitten@gmail.com>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 20 17:00:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvuzP-0000SI-2z
	for gcvg-git-2@gmane.org; Mon, 20 Apr 2009 17:00:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756081AbZDTO7I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 20 Apr 2009 10:59:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756201AbZDTO7G
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Apr 2009 10:59:06 -0400
Received: from mail-gx0-f166.google.com ([209.85.217.166]:63898 "EHLO
	mail-gx0-f166.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755987AbZDTO7E convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Apr 2009 10:59:04 -0400
Received: by gxk10 with SMTP id 10so601259gxk.13
        for <git@vger.kernel.org>; Mon, 20 Apr 2009 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=qYvuEceE+blrujrFZwtZZJ4RpngxeB1M62bd4LI01Y0=;
        b=sAuo8g1ltjjoYkjOWcaf5sQMyFplSaCarYA5NoaiqqNE7tav44bRz6CPB5baPafs57
         kJCZ0EybWgTbelDjYdcpdSSRTHbAnqnw0QEX8/5H3mJ7O5BGxas/axoNxSLgTJTo00HM
         qi2zAaf8rmkOpyHn1u1JX0TW0UpIkCMIhb+Uk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=CEF/JbqAkUrR5WIRMeBb3d0IkHH5Q1R9jsUoAPEoSXQnIHpA+pibOjsMj1rDDA3Q5g
         VyQNYoeSPqbOe3W2c7MwbzpX0qZ/1RtKJLL2PyDbCM+m/+CE/WwVIz/Y2fQScvaiOTgT
         U+mbemfKp7O0dCbr5Cav0m2hT3U57XuSWIFEo=
Received: by 10.150.133.18 with SMTP id g18mr6516096ybd.57.1240239541197; Mon, 
	20 Apr 2009 07:59:01 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116998>

On Sun, Apr 19, 2009 at 9:58 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Sorry, I should have checked myself. =C2=A0defined-or "//" is 5.8.1 o=
r later.
>
> Now the real question was if we still support anything older, and if =
so
> what is the bottom version?
>
> I certainly can go with "5.8.1 or later", but I vaguely recall during=
 the
> gitweb discussion we said anything without the utf-8 support is unusa=
ble
> for gitweb, but I think we also said that the rest of the git codebas=
e
> should support running with something older (5.6.1, perhaps).

15 minutes of research:

* 2006-06-25 Junio C Hamano: "Tentatively let's say our cut-off point i=
s
  somewhere around 5.6." --
  http://article.gmane.org/gmane.comp.version-control.git/22607

* 2008-05-30 Lea Wiemann: "Gitweb relies on Unicode support (e.g. "use
  Encode") and will continue to be compatible with 5.8 and 5.10 only" -=
-
  http://article.gmane.org/gmane.comp.version-control.git/83339

* 2008-08-13 Lea Wiemann: "This makes Git.pm dependent on Perl 5.6.1. S=
ome
  tests (like t3701-add-interactive.sh) seem to work with pretty much a=
ny Perl
  version out there, and requiring File::Spec changes this" --
  http://article.gmane.org/gmane.comp.version-control.git/92260

* 2008-08-15 Marcus Griep: "Git.pm: Make File::Spec and File::Temp requ=
irement
  lazy" -- c14c8ce

* 2008-08-30 Junio C Hamano: "I agree we should say we rely on 5.6 or n=
ewer."
  -- http://article.gmane.org/gmane.comp.version-control.git/94399

* 2008-09-01 Junio C Hamano: "I personally think it is probably Ok to d=
eclare
  that we do depend on 5.8" --
  http://article.gmane.org/gmane.comp.version-control.git/94523


So here's my take-away. For the *.perl scripts and gitweb, it's 5.8.0. =
=46or the
test suite and Git.pm, all Perl versions are theoretically supported, b=
ut for
practical purposes, it may be 5.6.0.

Whatever is decided this time, perhaps it should be burned into the top=
s of
the *.perl scripts (i.e. "require 5.008;"). It should also be added to
CodingGuidelines. You know, so this conversation doesn't keep recurring=
=2E :-)

j.
