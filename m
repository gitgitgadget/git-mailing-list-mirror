From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: bug? - git-checkout treeish paths  ignores deleted files
Date: Mon, 08 Oct 2007 23:39:29 -0400
Message-ID: <470AF7F1.2010903@gmail.com>
References: <470AD21E.6070906@gmail.com> <3B0685AB-0725-4473-8AE6-359F93851C10@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Tue Oct 09 05:39:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If5we-0003VS-V1
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 05:39:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbXJIDjf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Oct 2007 23:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753151AbXJIDjf
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 23:39:35 -0400
Received: from wr-out-0506.google.com ([64.233.184.229]:34359 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753055AbXJIDje (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 23:39:34 -0400
Received: by wr-out-0506.google.com with SMTP id 36so766389wra
        for <git@vger.kernel.org>; Mon, 08 Oct 2007 20:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        bh=ae5CyyVqTRawQZuMsILbhuDmaSqcqfs7Tc+vbZGi2nY=;
        b=U2WKJaErfwoU//8LCtDoitE5MbJlljCEWYJ1egiiG8YDjlnj7d3VXkBPUe1JY3bdLdvM4Ft5+AABVQYEmIRhpwpvww0/FHU5aY9ettOM4QT6oE2LMTEnAKBjq76q6mGWVJPz7YBXmnT6Jbdr7TmV+LF5PFkS85BgfzA3n7kL91Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=JaDhupoPXpqUiLtquGh7TD8PYjHJV0HpbFOEr7Nn6AYmUR7JiapFCHrdQRmE1HhMbbTNcEciFZPfTNdrklRlLT3fKXN8AO+CqfPiqLGfefqDQEoAS8KZQNr4JZazP2W8pubt+3ZUO3Wh8Wf25NQ2oE7z1GaVKUuze3MCz5RjNos=
Received: by 10.90.52.18 with SMTP id z18mr4799148agz.1191901173427;
        Mon, 08 Oct 2007 20:39:33 -0700 (PDT)
Received: from ?192.168.1.117? ( [71.246.225.127])
        by mx.google.com with ESMTPS id 36sm10135830aga.2007.10.08.20.39.30
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 08 Oct 2007 20:39:30 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <3B0685AB-0725-4473-8AE6-359F93851C10@wincent.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60351>

Wincent Colaiuta wrote:
> El 9/10/2007, a las 2:58, Mark Levedahl escribi=F3:
>
>> Shouldn't   "git checkout topic path"  make the directory tree roote=
d=20
>> at path identical to what is on branch topic? It doesn't.
>>
>>
>
> No, the behaviour is correct.
>
> - first you removed the file on the topic branch; at the same time yo=
u=20
> removed it from your working tree
> - then you switched back to the master branch and so the file was=20
> added back to your working tree
> - then you switched back to the topic branch, and seeing as the file=20
> "a" is not being tracked in the topic branch Git doesn't touch it
>
> In general, Git only meddles with stuff that you've told it to track.=
=20
> This is actually a good thing in most cases because it makes some=20
> workflows involving dirty trees or trees with untracked content=20
> somewhat more convenient.
>
> Cheers,
> Wincent
>
>
I'm not convinced...

"git checkout branch dir" should make dir have the same value it would=20
get if I just did "git checkout branch".  The latter command will ignor=
e=20
files only if they are untracked in *both* HEAD and branch. I fail to=20
see why the path-limited version of git-checkout should give a differen=
t=20
result on the part it is asked to affect than the non-path limited=20
version. This is very inconsistent and I'm having a hard time=20
understanding what workflow it will help.

Mark
