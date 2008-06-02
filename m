From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: [StGIT BUG] StGIT errors out on rebasing patch deleting file with Unicode filename
Date: Mon, 2 Jun 2008 14:26:08 +0100
Message-ID: <b0943d9e0806020626s3a1009d6q2a4cdb2526be9c8d@mail.gmail.com>
References: <200806011046.51872.jnareb@gmail.com>
	 <200806020939.05902.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Jakub Narebski" <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 02 15:27:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3A4T-000754-4b
	for gcvg-git-2@gmane.org; Mon, 02 Jun 2008 15:27:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbYFBN0M convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 2 Jun 2008 09:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754336AbYFBN0L
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Jun 2008 09:26:11 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:47459 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753473AbYFBN0K convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 2 Jun 2008 09:26:10 -0400
Received: by py-out-1112.google.com with SMTP id p76so420854pyb.10
        for <git@vger.kernel.org>; Mon, 02 Jun 2008 06:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=zlRWqZwRDmrnfGCS7+1coWtYi4rGwWv9BGo5DSUiAZg=;
        b=Aa3IRLfLVN2QHdtcXriL0uXg7JS+U7rUuUAg5GoO537MTDTuvTKHI6ivbwe56ArG0euHv5cY46SdlHn9IbN8wnyBmEXIjY4xhsXmT5Di1NwMgX0jC+HNF0wehR14/c9Bv+yNhKHNudhuN3mgSc++xoKRNyLCR33pdlglGTxyATQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=kPi90Zmbkm1Pxr3qUcwQnCrd0lACrl2IWa4G435Eh6kSX/kdbDcoEx6FgMlvou/gRNb27+f85QBeF2vjeDi0EBwtZqGkwQdSj27GOHKsDgOfJrBPESr88UHGIIoxzGUTNGv9BwUyXOX7N8UAWfjCAiO0WWqp29wynUxaOrhoD4Y=
Received: by 10.114.149.2 with SMTP id w2mr9549969wad.92.1212413168851;
        Mon, 02 Jun 2008 06:26:08 -0700 (PDT)
Received: by 10.114.171.16 with HTTP; Mon, 2 Jun 2008 06:26:08 -0700 (PDT)
In-Reply-To: <200806020939.05902.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83519>

2008/6/2 Jakub Narebski <jnareb@gmail.com>:
> On Sun, 1 June 2008, Jakub Narebski wrote:
>
>> StGIT errors out on rebasing patch which deletes file with Unicode
>> characters in filename (with characters outside US-ASCII in filename=
).
>> The patch in question is patch deleting gitweb/test/* in git directo=
ry,
>> and is present already on the 'origin' branch (the branch we rebase
>> onto), so stg-rebase should result in an empty patch (as first patch=
).
>>
>>  "gitweb/test/M\303\244rchen" |    2 --
>>  gitweb/test/file with spaces |    4 ----
>>  gitweb/test/file+plus+sign   |    6 ------
>>  3 files changed, 0 insertions(+), 12 deletions(-)
>>  delete mode 100644 gitweb/test/M=E4rchen
>>  delete mode 100644 gitweb/test/file with spaces
>>  delete mode 100644 gitweb/test/file+plus+sign
>>
>> I guess the error is caused by using unescaped (quoted) filename.
>
> You can WORKAROUND this bug by setting core.quotepath to false.  This
> allowed me to make stg-rebase.

I can add a workaround in StGIT to actually ignore the exception
raised by os.remove() but I don't know how to convert the quoted file
name back to its unicode value in Python.

--=20
Catalin
