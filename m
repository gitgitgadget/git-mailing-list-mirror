From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH 1/2] Make generated MSVC solution file open from Windows 
	Explorer
Date: Sat, 26 Sep 2009 00:45:51 +0200
Message-ID: <bdca99240909251545h48fd62bdsafacb42aeb9a7b2@mail.gmail.com>
References: <4ABB84F4.7080403@gmail.com> <20090925220510.GY14660@spearce.org>
	 <81b0412b0909251511m24e5c6bcg3f8c4e3576ad3bd3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	mstormo@gmail.com
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 00:46:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrJYP-0007rX-3r
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 00:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752257AbZIYWpt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 25 Sep 2009 18:45:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752161AbZIYWps
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 18:45:48 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:51878 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854AbZIYWps convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 25 Sep 2009 18:45:48 -0400
Received: by fxm18 with SMTP id 18so2559330fxm.17
        for <git@vger.kernel.org>; Fri, 25 Sep 2009 15:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=O4k88iR7enApPjisnolb1PUKSLZK/b/dCswNIB94BM0=;
        b=w28Yy3+PnSsjpiXB74NWAasZyJONGjQ5fnGonaxTbU3b/dg5dJ+L4jNLfDx+qJp4XR
         2tc8lMLIXqoTzPlLQ1PgJyxXbaEix7Oar6oGGy8OcawUhcDW7yVa774yz4PUnO3qDyrJ
         5OaFY1W6mPT3YG+y1Qetc8LtUrHPpRWAVgFnU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FCowPxT5kkrvn7n91HVKKl+TtPZCAPYC9CiNdzplrqQB0Lku+CIeL/G2vmcED/24yc
         1Okp0hKTkw+xsygzewGm8uQQomZqkWMgTs7MQX8oB5LpA9ZNpDWxTyuNnCp+IkH8CT2v
         6CEvjq6kd+zIsvtgSCeiGDbr51MDJJnfI/9xU=
Received: by 10.86.227.26 with SMTP id z26mr1361103fgg.76.1253918751247; Fri, 
	25 Sep 2009 15:45:51 -0700 (PDT)
In-Reply-To: <81b0412b0909251511m24e5c6bcg3f8c4e3576ad3bd3@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129130>

On Sat, Sep 26, 2009 at 00:11, Alex Riesen <raa.lkml@gmail.com> wrote:

> On Sat, Sep 26, 2009 at 00:05, Shawn O. Pearce <spearce@spearce.org> =
wrote:
>> Sebastian Schuberth <sschuberth@gmail.com> wrote:
>>> In order to be able to open the generated solution file by double-c=
licking it
>>> in Windows Explorer, all project files need to use DOS line-endings=
 and a
>>> comment about the Visual Studio version needs to be added to the he=
ader of the
>>> solution file. This also fixes the icon that is displayed for the s=
olution file
>>> in Windows Explorer.
>>> Note that opening the solution file from a running instance of Visu=
al Studio
>>> already worked before.
>>
>> Something is wrong with both patches; neither applies. =C2=A0It look=
s
>> to be an issue with whitespace, like context lines are gaining an
>> extra space at the start of the line.
>
> Besides, there is PERLIO environment variable. Try setting it to
> PERLIO=3D':perlio'

But I don't feel like using it here would be the right thing to do.
Visual Studio project files should never ever be written out with Unix
line-endings, not even if someone created them under Unix. So instead
of relying on the environment variable to be set correctly, I believe
it's better to always enforce the correct line-endings here.

--=20
Sebastian Schuberth
