From: Michael Cox <mhcox@bluezoosoftware.com>
Subject: Re: Error building installing on Redhat Linux Server release 5.3 
	(Tikanga)
Date: Fri, 19 Mar 2010 16:51:45 -0600
Message-ID: <d557014b1003191551o68858c28lf52d1622d8453776@mail.gmail.com>
References: <d557014b1003191436r4d141825p6c5b8e1b3bee4fc8@mail.gmail.com> 
	<7veijgc6md.fsf@alter.siamese.dyndns.org> <d557014b1003191525m490d1bfam4e8ce40681ff2214@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 19 23:52:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nsl38-0005ML-U8
	for gcvg-git-2@lo.gmane.org; Fri, 19 Mar 2010 23:52:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751380Ab0CSWwJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Mar 2010 18:52:09 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:39408 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212Ab0CSWwI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Mar 2010 18:52:08 -0400
Received: by gwaa18 with SMTP id a18so41068gwa.19
        for <git@vger.kernel.org>; Fri, 19 Mar 2010 15:52:05 -0700 (PDT)
Received: by 10.90.12.17 with SMTP id 17mr1112634agl.44.1269039125213; Fri, 19 
	Mar 2010 15:52:05 -0700 (PDT)
X-Originating-IP: [199.64.0.252]
In-Reply-To: <d557014b1003191525m490d1bfam4e8ce40681ff2214@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142657>

I noticed the following messages in the config.log

/usr/lib/gcc/i386-redhat-linux/4.1.2/../../../libcurl.so: undefined ref=
erence to
 `tld_strerror'
/usr/lib/gcc/i386-redhat-linux/4.1.2/../../../libcurl.so: undefined ref=
erence to
 `idna_strerror'

Could that be the source of my problem?

Michael



On Fri, Mar 19, 2010 at 4:25 PM, Michael Cox <mhcox@bluezoosoftware.com=
> wrote:
> That fixed the build problem. =C2=A0Thank you!
>
> But when I tried to run git after the successful build:
>
> =C2=A0 =C2=A0git clone http://www.kernel.org/pub/scm/git/git.git
>
> I still get the error message "fatal: Unable to find remote helper fo=
r 'http'"
>
> Michael
>
> P.S. I have to use http since I'm behind a firewall.
>
>
> On Fri, Mar 19, 2010 at 4:02 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Michael Cox <mhcox@bluezoosoftware.com> writes:
>>
>>> I downloaded the latest tarball (git-1.7.0.2), configured it, and
>>> make'ed it. =C2=A0When I did a "make install", the build seemed to =
work and
>>> most of the install, but I got an error when the installation tried=
 to
>>> use gtar:
>>>
>>> make -C templates DESTDIR=3D'' install
>>> make[1]: Entering directory `/users/e477610/exptool/src/git-1.7.0.2=
/templates'
>>> install -d -m 755 '/home/e477610/exptool/share/git-core/templates'
>>> (cd blt && gtar cf - .) | \
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 (cd '/home/e477610/exptool/share/git-co=
re/templates' && umask
>>> 022 && gtar xof -)
>>> gtar: This does not look like a tar archive
>>
>> A shot in the dark:
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0$ unset CDPATH
>>
>> Also remove anything that sets CDPATH from your .bashrc if you are m=
aking
>> it available to your non-interactive shell processes.
>>
>
