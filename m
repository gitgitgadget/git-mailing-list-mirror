From: Bryan Donlan <bdonlan@gmail.com>
Subject: Re: What's going on here? Bad repo, no error locally?
Date: Wed, 22 Apr 2009 00:52:29 -0400
Message-ID: <3e8340490904212152w4e308cf1wa0d20d05df3cbb48@mail.gmail.com>
References: <450196A1AAAE4B42A00A8B27A59278E70ACE053E@EXCHANGE.trad.tradestation.com>
	 <3e8340490904212121q4bf2e25dsf5673bff764895c9@mail.gmail.com>
	 <gsm6tr$or7$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "John M. Dlugosz" <ngnr63q02@sneakemail.com>
X-From: git-owner@vger.kernel.org Wed Apr 22 06:54:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwUTF-0003uv-JR
	for gcvg-git-2@gmane.org; Wed, 22 Apr 2009 06:54:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbZDVEwb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2009 00:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750890AbZDVEwb
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Apr 2009 00:52:31 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:39533 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750780AbZDVEwa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2009 00:52:30 -0400
Received: by qyk16 with SMTP id 16so1822942qyk.33
        for <git@vger.kernel.org>; Tue, 21 Apr 2009 21:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=YTp2LStoRbqzfC4ySzbxi1wUYVdMwZRiikQjaoHoYdk=;
        b=fkTdxDHFiGMS/A1ytiPq/d0PNd+JqNMHcKoy7STPH/tEYJxieiDusY+DTMYyJkYA/Z
         ZVqQQ0KrJYJSoAx6FALHX2UG6Ei+ias0xAHjeKMCZ8BTAsTikZdzqsHg1qQU/mLR2ssb
         SKUX+dm3iZ1O0cIy5Z0eq9KZeZWpbFn/qAZug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CgtWU00R9KyPhnLKTidzGUDViMdvjFgwSKWxZidZV3rlXysDcSisv+830XrCVBFq3R
         69wUS8NX8j20iQw5TJIzeIytScXAblmB92xixi4yN7VjpjLzBn/fvpZSRpmy1bXoy/zC
         Zy3y0/6j9EzRxykf7edcf7BfNHEERvzE74Xbs=
Received: by 10.220.72.11 with SMTP id k11mr10103905vcj.81.1240375949175; Tue, 
	21 Apr 2009 21:52:29 -0700 (PDT)
In-Reply-To: <gsm6tr$or7$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117170>

On Wed, Apr 22, 2009 at 12:37 AM, John M. Dlugosz
<ngnr63q02@sneakemail.com> wrote:
> Bryan Donlan wrote:
>>
>> Extract the object on developer B's workstation:
>> git cat-file blob <object ID> =A0> blob.dat
>>
>> Copy it to upstream, then do:
>> git hash-object -w blob.dat
>>
>> If all goes well, hash-object will give you back the blob's ID, and
>> the repository will fsck cleanly again.
>
> Thanks, I was looking through the manual for that but wasn't sure how=
 to put
> it together.
>
> But, what could be wrong with B's repo that makes this happen repetet=
ly? =A0I
> assumed it was network SNAFU, but after restoring the upstream repo, =
his
> push did it again.

Theoretically, this should never happen :)
Are you accessing the repo directly through a file share, or through a
git-daemon connection?
If the former, could something like a virus scanner be deleting loose
objects, perhaps?
