From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: problematic git log submodule-dir/
Date: Thu, 23 Jan 2014 06:56:47 +0700
Message-ID: <CACsJy8AQxwxq3x5eg0-NssDB2PQz7uaLw9oK0Otg+jW7HtG+2g@mail.gmail.com>
References: <2550653.GHkhBQDSTk@localhost.localdomain> <52E02B8C.6040309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: pawel.sikora@agmk.net, Git Mailing List <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Thu Jan 23 00:57:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W67ff-0006BL-ST
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jan 2014 00:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755865AbaAVX5T convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Jan 2014 18:57:19 -0500
Received: from mail-qc0-f174.google.com ([209.85.216.174]:37774 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753826AbaAVX5S convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jan 2014 18:57:18 -0500
Received: by mail-qc0-f174.google.com with SMTP id x13so1557728qcv.33
        for <git@vger.kernel.org>; Wed, 22 Jan 2014 15:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=wNcFL1AUjxbfR5vRLEe3tOAoAeOnxoZE9/TlKk6gnZg=;
        b=rEvHtQuiax+C5wBFl+HI3kCqYPWmwTo0BJ/PR6aYOfxrMuc2EAXVMEY0qFD0caghQr
         5xRX2vdc/WlzsQncu+L3ge3y4syo/XcPEHAi0VdilJPIxXypVjabIh9owkaxeO5OPLfT
         NBH35iigMncADiiwESaSmI7VjrC9+KE0D0K/V3DTAMgB8pSJU/dAVxEIPaIJzrrkHT7Q
         LVQvtR7kFqdwxxDaIkbDcjaln1bZLIW1oDXatRl8AhFvk1WaoTtSBTnAeh7xmqMVsbIO
         iIiGjysCtQVNTogCS8hSEXdcumMwnO4yCXld3v218ybDNlTgmhg4cZJNDSXvuUYOBKIF
         ppcA==
X-Received: by 10.229.56.200 with SMTP id z8mr7079273qcg.1.1390435038045; Wed,
 22 Jan 2014 15:57:18 -0800 (PST)
Received: by 10.96.136.98 with HTTP; Wed, 22 Jan 2014 15:56:47 -0800 (PST)
In-Reply-To: <52E02B8C.6040309@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240885>

On Thu, Jan 23, 2014 at 3:35 AM, Jens Lehmann <Jens.Lehmann@web.de> wro=
te:
> Am 20.01.2014 19:25, schrieb Pawe=C5=82 Sikora:
>> i've noticed that 'git log submodule-dir' and 'git log submodule-dir=
/'
>> return different results (module's head changes vs. nothing). is it =
a bug?
>> looks like a trailing slash is a problem for git-log.
>
> I think this is a bug, and for example "git diff" has similar problem=
s.
> This is especially nasty as shell auto-completion adds the '/' at the
> end.
>
> Duy, without having looked into the code myself yet: is this somethin=
g
> that might be easily fixed by using PATHSPEC_STRIP_SUBMODULE_SLASH*?

I think so. But I dislike those preprocessing because it looks
inefficient and the same change may be needed for other diff commands
as well. Maybe we can handle this at diff or log-tree.c level. Will
look further into it tonight.
--=20
Duy
