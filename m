From: David Roundy <roundyd@physics.oregonstate.edu>
Subject: Re: confusion with git diff-tree output
Date: Wed, 21 Oct 2009 18:23:08 -0400
Message-ID: <117f2cc80910211523m5c1399aej594398fb6597e5de@mail.gmail.com>
References: <117f2cc80910211043q3a92a7b6o15464cc049ee33dc@mail.gmail.com>
	 <20091021195103.01cef9c4@perceptron>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 22 00:35:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N0jaO-0006ZF-Ow
	for gcvg-git-2@lo.gmane.org; Thu, 22 Oct 2009 00:23:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755556AbZJUWXF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 21 Oct 2009 18:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755345AbZJUWXF
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Oct 2009 18:23:05 -0400
Received: from mail-qy0-f194.google.com ([209.85.221.194]:63921 "EHLO
	mail-qy0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755038AbZJUWXE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Oct 2009 18:23:04 -0400
Received: by qyk32 with SMTP id 32so4946389qyk.4
        for <git@vger.kernel.org>; Wed, 21 Oct 2009 15:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=MVtxUfl5xhG1Dh80Ci2CaZcfsVhMgIpZsKBLFeSgGBY=;
        b=frDI3KEVeZ1j80mCCus95FxIUKJJ+cNMKIxDtuoOjoSzYiwtPU64dmbD2uZ0yj0ovz
         pJZ/hcv99gbR8x77w0HpJXa8bLC7w3g/XskVEa9z9KCIzSk0uU5+MiM4W5Vw0VrM9zG8
         TzV7J3SSjdH5Zxs9aWwN4KnRnTONPpXOujLfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=TCneEDAKXMfANxxuTVhKk23CilcyTj+fUKPiZ+RBYP+5fp7ZnbNX+eJARPhPqMCnhF
         lo6xpQG8SbszFWlfhB3P42QeGPSro3lQB65KdNs8dMEqUmfEx8f8cwireriPUzFi0zM4
         vplQ9ZxNT1pisghvRL4IUuCP3FLizGTRxbqns=
Received: by 10.224.73.78 with SMTP id p14mr4247145qaj.56.1256163788402; Wed, 
	21 Oct 2009 15:23:08 -0700 (PDT)
In-Reply-To: <20091021195103.01cef9c4@perceptron>
X-Google-Sender-Auth: 3240af6b890a8e3d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130977>

You're right.  I figured I must be overlooking something obvious, and
that was it.  What surprised me was that -p implies -r, which is not
documented.  Since the -p output was recursive, I incorrectly presumed
that this was the default.

David

On Wed, Oct 21, 2009 at 1:51 PM, Jan Kr=C3=BCger <jk@jk.gs> wrote:
> Tree objects are recursively nested, i.e.
>
>> 66b67ea1763799c0b2ac01f6803177ca870f6544 M =C2=A0 =C2=A0Iolaus
>
> is a reference to another tree object... and since a file in that
> subtree changed, a new tree object that contains a different file
> record is now referenced as "Iolaus".
>
> By default git diff-tree doesn't recurse, but you can use -r for that=
=2E
> Which is documented, I might add. ;)
