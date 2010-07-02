From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [WIP/PATCH] Teach fast-import to print the id of each imported
 commit
Date: Fri, 2 Jul 2010 10:40:28 -0500
Message-ID: <20100702154028.GB2287@burratino>
References: <20100701031819.GA12524@burratino>
 <20100701054849.GA14972@burratino>
 <20100702051201.GC7209@burratino>
 <AANLkTintWyhcx9pURSqxs3e9BBkPx9KSPPYh4UOU7kv6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	David Barr <david.barr@cordelta.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 02 17:41:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OUiMV-00013Q-14
	for gcvg-git-2@lo.gmane.org; Fri, 02 Jul 2010 17:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758929Ab0GBPk6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Jul 2010 11:40:58 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57531 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753722Ab0GBPk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jul 2010 11:40:58 -0400
Received: by iwn7 with SMTP id 7so3373091iwn.19
        for <git@vger.kernel.org>; Fri, 02 Jul 2010 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=nbIqo8XpishSX22b1yk5dzsTtNygEhjElv+gxUNbiZY=;
        b=V729O3qNEx5zumLQ4/gD63IRwl/fNXkYhnILzJvgvd9ULIP3z01fGxOYVx6PAPG1b/
         Tv2xIWcN9m1FJ6Vg0nvJkRqK5WR0bLp9TxSsVHIHm/VekNKpd84FR+honyOEazrcRBK2
         KZtxmb75yhdjQmHxfytEa/R3j38MD3E34fbeo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=sm84TgHZx1AFpsRiGizpZh7nLm81jSN4voXhYsmoSZqj2TwMmXot1v0kxe+YxHqJG/
         YXW4O6mMxCRO8Avf7ziBj6wEI4qN20D+3t3PlO7kv4M7Bvnm0KPqEr1w3vhKEm0NH/ZX
         cgvluu2YkwVcR8xSqYbQ2kcfZR3BbMjIXZIB0=
Received: by 10.42.9.69 with SMTP id l5mr288231icl.80.1278085256841;
        Fri, 02 Jul 2010 08:40:56 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id x6sm3527004ibb.17.2010.07.02.08.40.55
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 02 Jul 2010 08:40:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTintWyhcx9pURSqxs3e9BBkPx9KSPPYh4UOU7kv6@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150138>

Sverre Rabbelier wrote:
> On Fri, Jul 2, 2010 at 07:12, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:

>> A =E2=80=98cat=E2=80=99 command (suggested by David) would also be u=
seful, so the
>> caller can read trees and blobs before they are accessible through
>> the object db. =C2=A0The svn importer would use this when applying
>> (svndiff0-format) deltas to import changes to regular files.
>
> How would the output be delimited? The same way fast-import expects
> its blob input?

Right.  I was imagining something like

 <blob hash> blob <size>
 ... content ...
 <blank line>

=C3=A0 la cat-file --batch.  Hopefully by the end of this weekend, if n=
o
one else gets to it first.
