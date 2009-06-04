From: Stephen Boyd <bebarino@gmail.com>
Subject: Re: [PATCHv1+eps] git-repack.txt: Clarify implications of -a for dumb 
	protocols
Date: Thu, 4 Jun 2009 12:46:23 -0700
Message-ID: <780e0a6b0906041246k43d42af1xe623168c52ff7e4f@mail.gmail.com>
References: <200906031950.56974.lists@informa.tiker.net> <1244115295-28688-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, lists@informa.tiker.net,
	Junio C Hamano <gitster@pobox.com>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Jun 04 21:47:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MCItv-0002a4-AL
	for gcvg-git-2@gmane.org; Thu, 04 Jun 2009 21:46:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752517AbZFDTqm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Jun 2009 15:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbZFDTqm
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jun 2009 15:46:42 -0400
Received: from yw-out-2324.google.com ([74.125.46.31]:38864 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462AbZFDTql convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Jun 2009 15:46:41 -0400
Received: by yw-out-2324.google.com with SMTP id 5so582428ywb.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2009 12:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=dDPLy1a+bznXVzxpoTgeB0ke0rrXnc0cfGTJZ3xeTyg=;
        b=jsmWGcqCcmG3NnRouY0GbJxPKjOxiYBFMaylyzhxorPmlquw5PSL8/4N4EcvKC/Y7V
         5nANc7TRo8yIBlRREiKatwhq6k06SRp2eDwgp2KzZcULnvqjJPmpyJ2vOIkexwopgBsH
         QrjBFNloNkGrQM3clwKP9HoD98b5+yxYGKIGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=H/xT7wBhOrEhLc/Gb63tTUZHXXiiS0zcsf718xROUDx5U4skGcxF54SADMqxp5QJmJ
         bqo9SRjvy9z+394PO7uZDN7IfdXEQDd0OiCJfsfl7cNLShhhgVttHMJkFhzO7u5/sHCg
         8hY4yWr+W3ALPfA1L+6RR6y5gdDjTQr+19DNM=
Received: by 10.100.41.9 with SMTP id o9mr3079466ano.155.1244144803256; Thu, 
	04 Jun 2009 12:46:43 -0700 (PDT)
In-Reply-To: <1244115295-28688-1-git-send-email-git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120706>

On Thu, Jun 4, 2009 at 4:34 AM, Michael J
Gruber<git@drmicha.warpmail.net> wrote:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0pack everything referenced into a single p=
ack.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Especially useful when packing a repositor=
y that is used
> =C2=A0 =C2=A0 =C2=A0 =C2=A0for private development and there is no ne=
ed to worry
> - =C2=A0 =C2=A0 =C2=A0 about people fetching via dumb protocols from =
it. =C2=A0Use
> + =C2=A0 =C2=A0 =C2=A0 about people fetching via dumb protocols from =
it.
> + =C2=A0 =C2=A0 =C2=A0 (Over dumb protocols, one would have to fetch =
the whole new
> + =C2=A0 =C2=A0 =C2=A0 pack in order to get any contained object, no =
matter how
> + =C2=A0 =C2=A0 =C2=A0 many other objects in that pack exist locally =
already.) Use
> =C2=A0 =C2=A0 =C2=A0 =C2=A0with '-d'. =C2=A0This will clean up the ob=
jects that `git prune`
> =C2=A0 =C2=A0 =C2=A0 =C2=A0leaves behind, but `git fsck --full` shows=
 as
> =C2=A0 =C2=A0 =C2=A0 =C2=A0dangling.

Instead of adding this, why don't we just remove the part about dumb
protocols? So just say that it's especially useful for private
development. Then, if we really want to keep this performance note
just add it after the paragraph in one of those "+" things (What are
those called?)
