From: Scott Chacon <schacon@gmail.com>
Subject: [RFC PATCH 1/4] Document the HTTP transport protocol
Date: Tue, 6 Apr 2010 06:53:13 -0700
Message-ID: <v2wd411cc4a1004060653nd8d8e924t92183c55543e8294@mail.gmail.com>
References: <1255065768-10428-1-git-send-email-spearce@spearce.org>
	 <1255065768-10428-2-git-send-email-spearce@spearce.org>
	 <m2md411cc4a1004052157v200f902ek22420456e4a45512@mail.gmail.com>
	 <7v1vetkt8i.fsf@alter.siamese.dyndns.org>
	 <u2hd411cc4a1004060652k5a7f8ea4l67a9b079963f4dc4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 06 15:53:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nz9DY-0002TS-Gg
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 15:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755908Ab0DFNxT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Apr 2010 09:53:19 -0400
Received: from fg-out-1718.google.com ([72.14.220.152]:28826 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754567Ab0DFNxS convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Apr 2010 09:53:18 -0400
Received: by fg-out-1718.google.com with SMTP id d23so691563fga.1
        for <git@vger.kernel.org>; Tue, 06 Apr 2010 06:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:received:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Dmzt6gcO8eC4dQgW9j1N7XXh0pBTneF6I2Ktopgv0x8=;
        b=XhmlRKU1ovQEPzsfT++TPI6/tNemurWjssaqtGOH+CpQh9CBMwntf55Vah+v/vt1EU
         bXWIB0lZKgWCFb/E493H+nT4B/sz4Ce7Q3OFG6YTHoZ8Go7NaJcQa+CROBuXW0tkAxJW
         HLy846Ml1MhkT49452RSKBkAVEDaDxk+tsFNk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rFt+v0eCvQ3ss0QLe0+8C3t2soUEgA+tiqTRM2TNhFSR2N8Mj4PiroTPuZvYmlvbu9
         9UPWsG89Bpp5bo+V6ZQpRzixDB73a1YYvZcHUYWoMs2TNQL0xz6ghrnNpP7dxhgNt9G+
         nbgRqlluanGCAr4ZLVa4vG7oqYYa8CdAuqX6g=
Received: by 10.86.53.2 with HTTP; Tue, 6 Apr 2010 06:53:13 -0700 (PDT)
In-Reply-To: <u2hd411cc4a1004060652k5a7f8ea4l67a9b079963f4dc4@mail.gmail.com>
Received: by 10.87.58.37 with SMTP id l37mr11119828fgk.21.1270561994002; Tue, 
	06 Apr 2010 06:53:14 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144142>

Hey,

On Mon, Apr 5, 2010 at 11:09 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Scott Chacon <schacon@gmail.com> writes:
>
>> On Thu, Oct 8, 2009 at 10:22 PM, Shawn O. Pearce <spearce@spearce.or=
g> wrote:
>>> Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
>>> ---
>>> =C2=A0Documentation/technical/http-protocol.txt | =C2=A0542 +++++++=
++++++++++++++++++++++
>>> =C2=A01 files changed, 542 insertions(+), 0 deletions(-)
>>> =C2=A0create mode 100644 Documentation/technical/http-protocol.txt
>>
>> I just spent a while looking for this in my email archive - why was
>> this document not added to the technical/ dir? =C2=A0Can we put it t=
here?
>
> Perhaps because it was marked as RFC and not much discussion went on?
> Sorry, but I cannot keep mental bandwidth to remember the threads fro=
m 6
> months ago while doing this as a part-time non-job ;-)
>

I understand, it wasn't meant as a criticism, I was just curious why
this file was never included. =C2=A0That the series was marked as RFC m=
akes
sense. =C2=A0Could I request that this one patch be included? =C2=A0Or =
if Shawn
has a more recent one? =C2=A0I have found and extracted it and have it =
in a
topic branch locally, but if someone else wanted to reference it to
implement the HTTP stuff it would probably be really helpful to at
least have something in the main tree.

Thanks,
Scott
