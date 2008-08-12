From: Marcus Griep <neoeinstein@gmail.com>
Subject: Re: How to show an annotated tag's timestamp?
Date: Tue, 12 Aug 2008 16:36:50 -0400
Message-ID: <48A1F462.9000404@gmail.com>
References: <48A1E739.3010803@dirk.my1.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?RGlyayBTw7xzc2Vyb3R0?= <newsletter@dirk.my1.cc>
X-From: git-owner@vger.kernel.org Tue Aug 12 22:38:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT0cv-0001tG-H1
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 22:37:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbYHLUgz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Aug 2008 16:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751933AbYHLUgz
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 16:36:55 -0400
Received: from wx-out-0506.google.com ([66.249.82.230]:41255 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbYHLUgy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 16:36:54 -0400
Received: by wx-out-0506.google.com with SMTP id h29so1812409wxd.4
        for <git@vger.kernel.org>; Tue, 12 Aug 2008 13:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :x-enigmail-version:content-type:content-transfer-encoding;
        bh=vD8cluhHLluXiG1XlKLQYd6H1m649LBw714M38jQqOg=;
        b=P7E18agnVYCvIPaZFmz8Ju6oFet3DNqK51U9pJy4VKHRgjojfqP6qRjoG82tKqUJi+
         NHkf1R84O9/DHxY5E4pPiZRsj5ubaS6AuS09deLAPOQxmyRWv5GFE8o4yDtw30YSgW92
         hFpY1NK7y0hOQOHlrH4FNWgpTx5GfIO82lMaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:x-enigmail-version:content-type
         :content-transfer-encoding;
        b=pzytavSHaKv3DiAGL8FO6jTAAKmnuFMXhynZiHyF9R+iTHdVdSJDUg6UQ7g2b5yjuh
         SbUOqSDpfV6+Izjb9diq/arNlvKTI56B+ruKX3vhqiyKeAYwHu3jzXX5Xh5jDBao7MHt
         MpLdfNUT/rc7GsqPL/1FvsxiEd9PFEvSFxB6M=
Received: by 10.90.81.19 with SMTP id e19mr13485315agb.24.1218573413186;
        Tue, 12 Aug 2008 13:36:53 -0700 (PDT)
Received: from ?10.95.36.106? ( [4.79.245.132])
        by mx.google.com with ESMTPS id 38sm3430885wrl.1.2008.08.12.13.36.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 12 Aug 2008 13:36:52 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
In-Reply-To: <48A1E739.3010803@dirk.my1.cc>
X-Enigmail-Version: 0.95.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92137>

Try this:

git log --pretty=3Dformat:"Tagger: %an <%ae>%nDate: %ad%n%n%b" -1 v1.6.=
0-rc1

Dirk S=C3=BCsserott wrote:
> I'd like to display *when* a certain annotated tag was
> created, i.e. its timestamp. I know two ways but am looking
> for a third one:
>=20
> Gitk: When clicking the yellow tag item (called 'testtag'
> in my case) it says:
> -------------
> object 9a04a26d3e5ea09be32934f50020d0286ebe7325
> type commit
> tag testtag
> tagger <tagger's name> <tagger's email-address> 1218568300 +0200
> -------------
> Well, I can convert 1218568300 into some human readable string,
> but that's not convenient.
>=20
> So I tried 'git show testtag'. It says:
> -------------
> (*) tag testtag
> (*) Tagger: <tagger's name> <tagger's email-address>
> (*) Date:   Tue Aug 12 21:17:17 2008 +0200
> (*)
> (*) testtag
> commit 0a62b3380d21bf65270490619da4a2efd6d2ca7a
> Author: ...
> Date:   Thu Apr 24 18:49:38 2008 +0200
> [...]
> -------------
>=20
> ... followed by the whole commit message and diff of the
> commit that's pointed to by the tag. That's too much for
> my purpose.
>=20
> Is there a way to output only when and by whom the tag
> was created (incl. the tag's messsage), i.e. the lines
> above marked with (*)?
>=20
> AHA,
>   Dirk
>=20
> --=20
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Marcus Griep
GPG Key ID: 0x5E968152
=E2=80=94=E2=80=94
http://www.boohaunt.net
=D7=90=D7=AA.=CF=88=CE=BF=C2=B4
