From: Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH] bash-completion: Add non-command git help files to bash-completion
Date: Fri, 15 Aug 2008 15:03:10 -0400
Message-ID: <48A5D2EE.4080400@griep.us>
References: <1218816948-7864-1-git-send-email-marcus@griep.us> <7v8wuyb0m7.fsf@gitster.siamese.dyndns.org> <48A5CC07.2040500@griep.us> <7vvdy29kok.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 15 21:04:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU4b0-0008KY-Km
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 21:04:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758488AbYHOTDV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2008 15:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757094AbYHOTDV
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 15:03:21 -0400
Received: from wr-out-0506.google.com ([64.233.184.237]:44419 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758090AbYHOTDU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 15:03:20 -0400
Received: by wr-out-0506.google.com with SMTP id 69so1163965wri.5
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 12:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding:sender;
        bh=2vaeumFscoyzXro5rD0ghnB5YvXQ4VRuh56qGkQE8K4=;
        b=qHjfpSzA0YHK0Ep+kiDZRGJrQKXBS6b0FekFL1X7M00M+ajJKnt7wUfYLim/VOiQnu
         p5e0zibDtxqHDUdqTmeXUV6DScyePt5KlHbWhGRBSgQ3qWc4LiSxmvKCUFdZioLR15Jk
         rzBhQQPWooDiHsZkmswJP515zZQt1LrY9TOnc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding:sender;
        b=u1YLlqwcFmR7olmVqJBoUvJ41PVYDpzIjyGD5AGGgGDBCy2WJMxx9tR3j4eh8ifQbK
         2lDqs61S/JLYBgqjtrCWzYmVg+5uZ9/q6lAJODPDNzUTcLcA8zPmcYQFIqvDLNO06i+A
         NjKby1loKM38NAPh6j6kZG0vaZhjllcAEesRw=
Received: by 10.90.80.19 with SMTP id d19mr1977418agb.65.1218826999462;
        Fri, 15 Aug 2008 12:03:19 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id 10sm1143143wrl.11.2008.08.15.12.03.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 12:03:12 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <7vvdy29kok.fsf@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92510>

Junio C Hamano wrote:
> That is exactly what I mean.  I do not think bloating shell completio=
n to
> enumerate what help topics there are when the user hits "git help <TA=
B>"
> is a good idea to begin with.  It is a maintenance nightmere for one
> thing, and it does not help non-bash users.
>=20
> 	$ git help
> 	$ git help --all
>=20
> are existing ways for you to get list of "command topics" that you ca=
n ask
> the help system about, but I do not see a way to ask "git-help, pleas=
e
> tell me what topics that are not git-commands can I ask you about?", =
hence
> my suggestion to add "git help topics".
>=20
> And if you based "git help <TAB>" completion on the output from such =
help
> subcommand, you would not have to maintain the list of topics yoursel=
f in
> the completion script, and I would not mind such a patch too much.

Gotcha.  A static list buried in git-completion.bash would be a mainten=
ance
headache.  I can take a look at that some.

Would we also want to look at doing something similar with '--' option
completion, i.e. invoking the command with '-h' to get the usage and lo=
ng
options, then building the completion list on that rather than the stat=
ic
lists it uses now?  The one downside to that is that some completions
include trailing '=3D', which wouldn't be present in a usage list.

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
