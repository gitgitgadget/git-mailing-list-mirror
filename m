From: David Michael <fedora.dm0@gmail.com>
Subject: Re: [PATCH] Add getenv.so for catching invalid getenv() use via LD_PRELOAD
Date: Mon, 7 Jan 2013 10:45:46 -0500
Message-ID: <CAEvUa7nLKv3R5DcqCe6zJsxgENS2YkNRSzeYk3WT_TjCJsFdnQ@mail.gmail.com>
References: <CAEvUa7niTJVfp8_kuWs50kvhfZ59F-yAuAmeOXEduHXOq-tRFA@mail.gmail.com>
	<1357376146-7155-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 16:46:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsEtw-0002Iq-MD
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 16:46:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753489Ab3AGPps convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 Jan 2013 10:45:48 -0500
Received: from mail-vb0-f42.google.com ([209.85.212.42]:50040 "EHLO
	mail-vb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753338Ab3AGPpr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Jan 2013 10:45:47 -0500
Received: by mail-vb0-f42.google.com with SMTP id fa15so19582560vbb.1
        for <git@vger.kernel.org>; Mon, 07 Jan 2013 07:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=SEAp6TMbKmAteNvcKRni0bnSLy3Mxb474DCGSz5rRQA=;
        b=R0bNHARQqVAqDNgSXeopOt6S3LUVRFSdkfW7kva4FKe5/7dFQgFQpAOtMlhA4vO6nA
         liHToRbPsii8Mfe58FODhVUfe3t64ztT+6DF7EZ2FwApDuJH0X+WYQynxJFBLw/CirTD
         72KLROS/JJeJNyClVes8IR3ZfueEq4ihwItaKUIBfFgQQF8RGCLtpLa+BEkEcGXxjD8m
         Ubals4VZUFjDpcKJlqRovPoX6+4TxHqUwUW7hAnEVKryRr0iul565lPzWqopjNkunW2T
         q6WMSEarJKXpTBIW9ckrQU3Eolif49dytVdBTPt1N04ycFcGYtMJn11EAlpc8goGr1SC
         VyyA==
Received: by 10.52.19.20 with SMTP id a20mr74554432vde.26.1357573546345; Mon,
 07 Jan 2013 07:45:46 -0800 (PST)
Received: by 10.58.85.138 with HTTP; Mon, 7 Jan 2013 07:45:46 -0800 (PST)
In-Reply-To: <1357376146-7155-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212899>

Hi,

On Sat, Jan 5, 2013 at 3:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
>  Perhaps this will help the getenv bug hunting (I assume we do the
>  hunting on Linux platform only). So far it catches this and is stuck
>  at getenv in git_pager().

=46or the record: I have been testing a macro pointing getenv at an
alternate implementation for the purpose of my port.  This alternate
function will return a unique pointer for each variable, as opposed to
using the same static buffer.  IBM considers this function a
proprietary z/OS extension (whereas the other is labelled as
conforming to half a dozen standards), but it seems to be more in-line
with the behavior git expects.

So I agree this patch is useful for reaching strict conformance to the
published specs, but I think we can go back to assuming no known
platforms are broken and unusable because of this.

Thanks.

David
