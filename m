From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Git 2.7.0 gitignore behaviour regression
Date: Wed, 6 Jan 2016 17:03:10 +0700
Message-ID: <CACsJy8CvPqYGRXB845+4fHjkXH_kSAWG684CoxtWAnXE-gM6ag@mail.gmail.com>
References: <4B0F686D-3DF9-4E5D-971D-DB106C6573FD@mikemcquaid.com>
 <20160105150602.GA4130@sigill.intra.peff.net> <CACsJy8AQ9s4VkFn+TNJLD55xJc40+-54BTYbC4Os71uSkL1QSA@mail.gmail.com>
 <5E517AD0-CD4E-4F85-8FEB-89B7A0183967@mikemcquaid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>
To: Mike McQuaid <mike@mikemcquaid.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 11:03:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aGkwV-0004ZI-Ti
	for gcvg-git-2@plane.gmane.org; Wed, 06 Jan 2016 11:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752176AbcAFKDn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jan 2016 05:03:43 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:34920 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752088AbcAFKDl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2016 05:03:41 -0500
Received: by mail-lb0-f179.google.com with SMTP id bc4so187890196lbc.2
        for <git@vger.kernel.org>; Wed, 06 Jan 2016 02:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=6yfU+setbi4cZd/NX1zSZ/O+PBTI3COg3F94Brjup5o=;
        b=oU0Hvib/GP52ByIsWpMXHVf2BDOIw4Hlotu6PsIQLz5wxmysxrXTk1dGniuzF2eOj2
         pmEGK+elXiH/V/5YOZZag3n4DCbaDEw2LEWKOD4ARKC8Ta25EOPeLY+oacdQhxlJM3Be
         ViztoPTrVToDgy1u2lJVjb6iw9F2qPXO8vV/Z7wISxk63GNd5zGtmujrQxOppMLnwcaY
         Pn5NjTsHi5h+xypSYOOXs7Puc0PWb6R2S7k0qj4eopOMeU4V6AUWZdJeTqgzh8n3xBio
         FCGj/ZNw/sUenG7xKJ9C+T1NyNfIV2UW8aD3jr1lLeQHpmgdBIN0j+kKn1w+AxHigyM2
         g8sQ==
X-Received: by 10.112.172.233 with SMTP id bf9mr35416068lbc.137.1452074620191;
 Wed, 06 Jan 2016 02:03:40 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Wed, 6 Jan 2016 02:03:10 -0800 (PST)
In-Reply-To: <5E517AD0-CD4E-4F85-8FEB-89B7A0183967@mikemcquaid.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283431>

On Wed, Jan 6, 2016 at 4:50 PM, Mike McQuaid <mike@mikemcquaid.com> wro=
te:
> it=E2=80=99s also a big area where libgit2 was inconsistent with Git=E2=
=80=99s behaviour on either of those versions too.

Yeah.. it looks like libgit2's gitignore support was written new, not
imported from C Git, so behavior differences (especially in corner
cases) and even lack of some feature ("**" support comes to mind). For
isolated features like gitignore, perhaps we can have an option to
replace C Git code with libgit2 and therefore can test libgit2 against
C Git test suite. It could be a good start for libgit2 to invade C
Git. Not sure if anybody's interested in doing it though.
--=20
Duy
