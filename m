From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Does Git really need a commit message to go with a commit?
Date: Sat, 3 Apr 2010 21:58:23 -0400
Message-ID: <w2v32541b131004031858t692577a7p5009637f831bff46@mail.gmail.com>
References: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 04 03:58:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyF6w-0006bX-EM
	for gcvg-git-2@lo.gmane.org; Sun, 04 Apr 2010 03:58:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755517Ab0DDB6q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 3 Apr 2010 21:58:46 -0400
Received: from mail-yx0-f191.google.com ([209.85.210.191]:44087 "EHLO
	mail-yx0-f191.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755078Ab0DDB6o convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 3 Apr 2010 21:58:44 -0400
Received: by yxe29 with SMTP id 29so1580038yxe.4
        for <git@vger.kernel.org>; Sat, 03 Apr 2010 18:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:received:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=/Kf35SZ0IQ7nbc2EFDtZ812o991fEpRNM3pWmagYU1g=;
        b=iTe9kTPYDU9A0kebnSbvw1poansTXENqQ9ZKH0hl7xOV5gXsRaNbNWXzWQWpMfwNFi
         vKqV9X2dWRmIB4ebjPvg3/WVAUBFZ+V3Y7WZImf3eQWNzmtl9UjmJV0gerM+OUDHLjZH
         MjiEjYmrkYviM5+MiX1SQmi0z+5+bxhBucA5M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=RNQN9yQXoS5uu1JhHNG9XiCy1Y21DKmQYYp8mSSkj1FtA8VXoj7OE47qzuBk4VV26/
         0B+5SoXs8HuYwJxBmpjERM1SoGwAD6Sv4g8dHi42LMSYvILb7+8qGWIFpFEzkqrJGnU8
         FadfgUA9rqZfuo5Cyue9LVgJoyn02stl5Ujqc=
Received: by 10.150.199.19 with HTTP; Sat, 3 Apr 2010 18:58:23 -0700 (PDT)
In-Reply-To: <z2r51dd1af81004031506pc9ac1840ie9953ae6df91d01b@mail.gmail.com>
Received: by 10.150.56.14 with SMTP id e14mr5197138yba.339.1270346323110; Sat, 
	03 Apr 2010 18:58:43 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143911>

On Sat, Apr 3, 2010 at 6:06 PM, =C6var Arnfj=F6r=F0 Bjarmason
<avarab@gmail.com> wrote:
> git-commit(1) doesn't allow you to make a commit without a commit
> message. This is annoying and doesn't properly preserve history in
> applications like snerp-vortex which replay a SVN dump into Git. You
> have to add `$msg =3D "Git made me do it" unless length $msg' somewhe=
re.
>
> Is there really no way to add a commit with no message with the git
> tools? Will anything break if I manually construct a commit with no
> message? Are commit messages inherently part of the format or does
> git-commit(1) just think it knows better than me?

git-commit isn't really meant to be used by scripts.  Try using
git-commit-tree instead, which doesn't enforce a commit message.

(Or use git fast-import; a quick glance at Snerp suggests that it's
intended to be *fast*; using fast-import ought to make things vastly
quicker.)

Avery
