From: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>
Subject: Re: git-new-workdir for filesystems without links (e.g. FAT32)?
Date: Mon, 7 Feb 2011 13:19:46 +0100
Message-ID: <AANLkTik-P6o954FTH8sUWbnDekT+rcnvk1z8iQ0SXU-i@mail.gmail.com>
References: <loom.20110206T151206-851@post.gmane.org>
	<20110206191459.GA17939@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 07 13:19:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmQ4P-0005y4-HE
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 13:19:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106Ab1BGMTr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Feb 2011 07:19:47 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:63216 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750785Ab1BGMTr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Feb 2011 07:19:47 -0500
Received: by vws16 with SMTP id 16so2849776vws.19
        for <git@vger.kernel.org>; Mon, 07 Feb 2011 04:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=aNdBSTfLgB2/jZYDdJ/OAXvBr6WW/BDoJWDH71IT3gI=;
        b=gI4cZZA37Eud98pUbHsvgjSQ9mr6VwjJ4yim106eimlmsv0D2nAjung726hOJPIiRB
         OdN7f1sK62qvEpUpROsnkGxRjLaXYhreXRdb58UqPGHdgZE2Jn45dlu/y+4NzX+M3aTe
         vRqRNK/hU7999l0ttKfA+HjuKBARFw7D01WKE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=sEe758Xz4+NKSm9p7lOWn+SH5eFsVEVFrJzwoGnZS7bm3oSt/jm5RzEbvKJU0W7ilF
         IqYmUsuhDDlQRlaWUqNaWfuqW+t3jp0+D9dzs1tmFmCVR30Bv2BkMxugx8dQVqmW7A91
         DfJD1XjzwyuJMmgOlInxiJeQyV1ComF0OrTG0=
Received: by 10.220.177.76 with SMTP id bh12mr4593890vcb.106.1297081186148;
 Mon, 07 Feb 2011 04:19:46 -0800 (PST)
Received: by 10.220.195.132 with HTTP; Mon, 7 Feb 2011 04:19:46 -0800 (PST)
In-Reply-To: <20110206191459.GA17939@elie>
X-Google-Sender-Auth: r7XGA7LP7KamvgZv-QHNwPxvfUc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166257>

On Sun, Feb 6, 2011 at 8:14 PM, Jonathan Nieder <jrnieder@gmail.com> wr=
ote:
> Hi Piotr,
>
> Piotr Krukowiecki wrote:
>
>> git-new-workdir requires soft links to work, so obviously it will fa=
il if file
>> system does not support them. Is there any other way for having mult=
iple working
>> dirs with one repository?
>
> I assume you mean a way to share refs between repositories without
> using symlinks? =A0Then alas, that is not implemented, though there
> is some interest. =A0See [1] for details.
[...]
> If on the other hand you just want to share objects (not refs) betwee=
n
> repositories, the GIT_OBJECT_DIRECTORY environment variable might
> help.

I need several working directories (for different branches). I wanted
to use git-new-workdir because, as I understand, I could do 'git svn
fetch' only once and then 'git rebase' for each working dir. So the
only reason was performance (network and disk).

I don't know if sharing objects is enough. If I understand correctly,
if a fetch introduces e.g. new branches, then only one working
directory will have information about them?


--=20
Piotrek
