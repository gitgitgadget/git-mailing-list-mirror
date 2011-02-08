From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] cache-tree: do not cache empty trees
Date: Tue, 8 Feb 2011 11:11:19 +0700
Message-ID: <AANLkTim_G9cPs=+1GQ2qBEgriOyKYgXk17iHE4oq9h2C@mail.gmail.com>
References: <1296899427-1394-1-git-send-email-pclouds@gmail.com>
 <1296914835-808-1-git-send-email-pclouds@gmail.com> <20110207091740.GA5391@elie>
 <20110207095713.GA19653@do> <7v1v3jvaef.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Jakub Narebski <jnareb@gmail.com>,
	"Dmitry S. Kravtsov" <idkravitz@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 08 05:11:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmevm-00031X-9b
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 05:11:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868Ab1BHELy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 23:11:54 -0500
Received: from mail-ww0-f44.google.com ([74.125.82.44]:36999 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753566Ab1BHELu convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 23:11:50 -0500
Received: by wwa36 with SMTP id 36so5607274wwa.1
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 20:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=rgI8fJ9UR7yWgIcoctohqaVQBwE/nCRJfsjRDfUbT20=;
        b=KnOQd09yPOxSTnaS2Uy2vwTeaL0wXz8Q+gBeCImetimnNXMAFEWV6hfg1r3E91GoOi
         t6B+LJtGpQm3C/RZ3kttnlGNRh/z7IMzUQlr3iWL9MZq5u+uo5QfqEMRH7UH9p28IILt
         pOH0773/icfIwvIuuX3TbS311CcEHRK3eQH4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=EtwKfyr4KX4lW6UeaUxKYJbbwdoYUeWwbTF7zmYkv3gtTZYEFFKHskK7nui57IfKfJ
         zMQE188bmMybIrWMpYK83ZBuHdOe8+xe/NIlPqrB4k6A2cAGUdnCDr/o5yyzg0l1vr0A
         uyA+ARm06HYkGey8uIvsv7gFBx5beJw8hdx2M=
Received: by 10.216.163.69 with SMTP id z47mr15195438wek.43.1297138309316;
 Mon, 07 Feb 2011 20:11:49 -0800 (PST)
Received: by 10.216.66.144 with HTTP; Mon, 7 Feb 2011 20:11:19 -0800 (PST)
In-Reply-To: <7v1v3jvaef.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166331>

On Tue, Feb 8, 2011 at 3:48 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>> Perhaps it's not a good approach after all. What I wanted was to mak=
e
>> pre-1.8.0 tolerate empty trees created by 1.8.0. Perhaps it's better
>> to just let pre-1.8.0 refuse to work with empty trees, forcing users
>> to upgrade to 1.8.0?
>
> I don't think we saw even something remotely resembles an agreement t=
hat
> empty tree is a good thing to have yet. =C2=A0Why are you rushing thi=
ngs?

But empty trees are allowed in repo since 79b1138 (fsck.c: fix bogus
"empty tree" check). Index can't handle empty trees, so it's a bug to
me that index still accepts them as input and silently discard them. A
bug regardless directory tracking support in 1.8.0. A corner case that
nobody would likely encounter (except Ilari and his "ghost directory"
problem).
--=20
Duy
