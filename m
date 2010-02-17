From: Robert Zeh <robert.allan.zeh@gmail.com>
Subject: Git svn fetches entire trunk on tags (change from 1.6.5.2 to 1.7.0)
Date: Tue, 16 Feb 2010 19:17:47 -0600
Message-ID: <94a51d821002161717q4dd116f9tebff3a2475446a8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 17 02:18:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhYYM-00064S-Fn
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 02:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933863Ab0BQBRu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Feb 2010 20:17:50 -0500
Received: from mail-iw0-f185.google.com ([209.85.223.185]:47057 "EHLO
	mail-iw0-f185.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933839Ab0BQBRt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Feb 2010 20:17:49 -0500
Received: by iwn15 with SMTP id 15so5907774iwn.19
        for <git@vger.kernel.org>; Tue, 16 Feb 2010 17:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=9djmDXR5W7IqWn/fxlRvZGbTWH84FX+BHLZfIEi9Qa0=;
        b=GHCp5EF3P5mxAKnuO2PebfWTZ1Ms7E6WbgWIwgX5WiUqyZMp1ospW4rWHuontgso0E
         iCokqSaL2tY/CK+SBeVYjXsG4Vr9jEwZe96XL/zjg8UGDAiTcbfY8Xe/VViT7FSiaS63
         QWwmeoeo5RuuHJOz1dEAATDVb+JPDA5B43GK4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=CagBUKMtByF5TA3NQuMPY8UadUPcTJUZKs9eoYy86ONq1xpk7IUjRGQMkRwfvhXxQB
         ALoihf0rf9aTQMiVCc/1liZ+sKZSYxITV/+Tn2/YGgLTf2viKVADhWWKfrKqcqZTcpvi
         PEZ/eJxuS0HnRh335gff8PmndTod1rGYpEbBk=
Received: by 10.231.190.146 with SMTP id di18mr4153788ibb.19.1266369467902; 
	Tue, 16 Feb 2010 17:17:47 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140196>

Since upgrading from 1.6.5.2 to 1.7.0 I've noticed a change in how
git=A0svn=A0fetches from the Subversion repository on tags.=A0=A0Of cou=
rse,
for the repo I'm working with there are many more tags then branches.
1.6.5.2 gives me=A0the following on a tag:


r333 =3D b15f3f20710a1e282fb6ff62c13fad64376ad2b4 (refs/remotes/trunk)
=46ound possible branch point:http://bt011us013s/prod_repos/trunk
=3D>http://bt011us013s/prod_repos/tags/3.09.1255, 333
=46ound branch parent: (refs/remotes/tags/3.09.1255)
b15f3f20710a1e282fb6ff62c13fad64376ad2b4
=46ollowing parent with=A0do_switch
Successfully followed parent

r334 =3D 77d132d69bc333e7c988a4f3af9d48a98dadf0d4 (refs/remotes/tags/3.=
09.1255)

With 1.7.0:
r333 =3D b15f3f20710a1e282fb6ff62c13fad64376ad2b4 (refs/remotes/trunk)

=A0=A0=A0=A0=A0=A0=A0=A0A=A0=A0=A0=A0=A0=A0=A0Enterprise/Header.txt
=A0=A0=A0=A0=A0=A0=A0=A0....

r334 =3D 2c0e6dd89e81e7d18288e135f40f193b2ff22018 (refs/remotes/tags/3.=
09.1255)

The SHA1s are also different.

It would be nice if the entire branch wasn't fetched.

Robert
