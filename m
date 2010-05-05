From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Bizarre behavior on git commit
Date: Wed, 5 May 2010 01:01:10 -0500
Message-ID: <20100505060110.GA21260@progeny.tock>
References: <s2t6f5a4e781005042246sb9ef3d48j134b22b5b41133ed@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Dan Loewenherz <dloewenherz@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 05 08:01:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O9Xfl-0008EC-7u
	for gcvg-git-2@lo.gmane.org; Wed, 05 May 2010 08:01:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755359Ab0EEGBX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 May 2010 02:01:23 -0400
Received: from mail-iw0-f203.google.com ([209.85.223.203]:52347 "EHLO
	mail-iw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753137Ab0EEGBW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 May 2010 02:01:22 -0400
Received: by iwn41 with SMTP id 41so5814902iwn.20
        for <git@vger.kernel.org>; Tue, 04 May 2010 23:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=fzuh6I6uQ5VNVjVPpNL9vVnBi3Gi1iJj1Pe8bmewZvg=;
        b=jr4QPlcP3ZKWJxEEWCEhgjdGfMOs3N9w4MWQHiTfBUY0iOPBQz2p8a7zJIM5liNpCg
         6+xN9dKnIq4aVROVAsdjdyVcgt2hQ/QBN34zkSukTfIRMoDB6DYplUcUav1J6L4MVO2D
         PRjnkgzph3Fc5Q61laUkj14N93QzN31u1Jvvw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=OgoIwpxKUhVAhilSwhAtKHf97ymCEk9QsYu9oR4zyduTwbN4p2l/gNYNGUyIAGENx/
         znnXW7+TgCnqjve33tc+x+RLOtfycpUhWqo/Ju6mujd2LRN04RJM3N0g1m0l41Yue1/9
         OKqBiL2NwmKa9nUxQjDenP4mUU2RZe/Fg5wCA=
Received: by 10.231.166.16 with SMTP id k16mr1082551iby.14.1273039246211;
        Tue, 04 May 2010 23:00:46 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 21sm5953526iwn.11.2010.05.04.23.00.44
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 04 May 2010 23:00:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s2t6f5a4e781005042246sb9ef3d48j134b22b5b41133ed@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146377>

Dan Loewenherz wrote:

> I'm running into a weird issue in a specific repo where "git show-ref=
"
> usage is being displayed after invocating "git commit".
>=20
> E.g.
> $ git commit -m "my commit message"
> usage: git show-ref [-q|--quiet] [--verify] [--head]
[...]
> =A0=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0show refs from =
stdin that aren't in local repository
>=20
> [master 28a735f] my commit message
> =A01 files changed, 2 insertions(+), 0 deletions(-)
> $

Strange.  Maybe a hook script?

  GIT_TRACE=3D1 git commit -m "my commit message"

should reveal the culprit, I hope.

Hope that helps,
Jonathan
