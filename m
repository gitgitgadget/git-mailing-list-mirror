From: Stephan Hugel <urschrei@gmail.com>
Subject: Error when verifying tags signed using 1.7.3.1
Date: Mon, 4 Oct 2010 23:13:21 +0100
Message-ID: <AANLkTikguMr4E+1m9QEX1x1beQPaHNBqSNPQUQWcFZgF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 05 00:13:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P2tHj-0005ZH-Uj
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 00:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754337Ab0JDWNX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Oct 2010 18:13:23 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:34703 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751546Ab0JDWNW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Oct 2010 18:13:22 -0400
Received: by wyb28 with SMTP id 28so5439435wyb.19
        for <git@vger.kernel.org>; Mon, 04 Oct 2010 15:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=HqQpIB1BNXnj9FeP5cAr6UyteWu6iWWNNbyqfFnRoQI=;
        b=boLT0BPGxDNG/K2shCKgE9U1hSzPp1VE1LjL12r0zz1eEJA12ykq3v1OtZgh0SMyGL
         Eb0Wqyx+X11xTCxr1LB1Wh75jnhDRChTyP/NnLp+L7pL69ZqwwBQLXQKvZGx1KgV02O6
         MYQ1R7RneZt8HHRKMcZcsn+WjM7sf1wvI4Pgc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=pBpb29x+WJf9p5wezLfLQKcUt4BO96yAwHIiB9wXxvbhnRJQieCYfe+ojIM05Ir0xO
         5UQR931ebnjXiX5zckQk/WrtQgPifWrNlo2qSwn5VTCGVELKGE3H2a5c2bPxjt3s8X4b
         jnQPTeN5snk5Bfdeh4+02yc9Gbynd4+bKAlLM=
Received: by 10.216.236.197 with SMTP id w47mr168278weq.114.1286230401281;
 Mon, 04 Oct 2010 15:13:21 -0700 (PDT)
Received: by 10.216.230.232 with HTTP; Mon, 4 Oct 2010 15:13:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158129>

Hello, git list.
I seem to be unable to verify tags I create and sign using the git -s
command in 1.7.3.1
Existing tags (i.e. created with 1.7.2.x, using the same key and GnuPG
version) can be verified, but attempts to verify created tags result
in the following:

object 791abd4848d86ea98071f35bbce4d4b274ef0788
type commit
tag v1.4
tagger name <name@host.com> 1286228562 +0100

Better header detection and regex
-----BEGIN PGP MESSAGE-----
Version: GnuPG v1.4.9 (Darwin)

iD8DBQBMqkph8Y2TgZsQ1pARAgxrAJ40ATxZw219CWI6FCaDAtbY8UHdoACePF6Q
PyNkf67w7AA8hkQqLAYGcyI=
=VLWl
-----END PGP MESSAGE-----
gpg: Signature made Mon  4 Oct 22:42:57 2010 IST using DSA key ID 9B10D690
gpg: BAD signature from "name <name@host.com>"
error: could not verify the tag 'v1.4'


I have confirmed that my key is valid (have
signed/encrypted/decrypted/verified using it after this error
occurred). I have also tried to create a tag using a newly-created
key, with the same result. I have attempted to created signed tags in
multiple repos. Is this a known bug?
