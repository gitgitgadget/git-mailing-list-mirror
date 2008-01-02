From: Gregory Jefferis <jefferis@gmail.com>
Subject: Stitching together private svn repo and public git repo
Date: Wed, 02 Jan 2008 19:25:41 +0000
Message-ID: <C3A195B5.10839%jefferis@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 02 20:26:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JA9EI-000854-Nd
	for gcvg-git-2@gmane.org; Wed, 02 Jan 2008 20:26:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756908AbYABTZt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jan 2008 14:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752889AbYABTZt
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jan 2008 14:25:49 -0500
Received: from mu-out-0910.google.com ([209.85.134.187]:26297 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756870AbYABTZs convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 2 Jan 2008 14:25:48 -0500
Received: by mu-out-0910.google.com with SMTP id i10so4335147mue.5
        for <git@vger.kernel.org>; Wed, 02 Jan 2008 11:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:user-agent:date:subject:from:to:message-id:thread-topic:thread-index:mime-version:content-type:content-transfer-encoding;
        bh=I8h2JJ9SFfDJ44RjtqKnvH68uDHgY7xWVJUM8AQN8i0=;
        b=qlDUu5/I19vnJIx0DPW7UKwqYQI53+y/TvYxdPIb3h/tCK6MeWoG6rBSikWTEZblXJXh/I/HAzfmRsgiMnurBdYInN9vtLJ/yYSpzPocWF9BzvWw+BW8RygqsUY3dNRtIj8gU9A+nNGnp5Y92Qc8TJlfp2Z9fcUVU3bkOtZiiyk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=user-agent:date:subject:from:to:message-id:thread-topic:thread-index:mime-version:content-type:content-transfer-encoding;
        b=OwM9wUqwsXStK66NUuPuwEXyhdbdXugoVNcmR4GI4HVqdG9Jcs4pZgFgIGCjNr7lTZSsmYJxQoc/pQSD+rEMYnPCt7cr11BDZLNJK+geMsjp4bFwxVeM+YSfLZV59BLh4GXMstTnvgdsfsW5TKz/dMc/2zSq8GZiCY5P6H2jGPw=
Received: by 10.78.172.20 with SMTP id u20mr17259939hue.13.1199301946626;
        Wed, 02 Jan 2008 11:25:46 -0800 (PST)
Received: from ?81.98.250.69? ( [81.98.250.69])
        by mx.google.com with ESMTPS id k7sm19288813nfh.0.2008.01.02.11.25.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 02 Jan 2008 11:25:45 -0800 (PST)
User-Agent: Microsoft-Entourage/11.2.3.060209
Thread-Topic: Stitching together private svn repo and public git repo 
Thread-Index: AchNdUL2gbRDNbloEdyDSgAUURoPUg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69486>

Short Version:=20

Repo B is a completely linear repo that has been tracking public repo A=
 for
some time.  A number of manual merges were done to bring new A releases
into=A0B but there are no connections between the two repos.  (How) can=
 I
stitch B to A to reflect this relationship?  I want to retain B's histo=
ry
and leave myself with an arrangement in which I can pull from A into B
periodically?  Many thanks for your suggestions, Greg.

--
Long Version:

I have been tracking my modifications of a public project released as t=
ar
balls with my own local svn repository.  My svn repo was completely lin=
ear
and I always merged in changes manually each time a new tar ball was
released.  This started to get painful.

Now I want to do better.  I have set up a public git repository ("A") t=
o
track the tar ball releases from the public project.  I have converted =
my
svn repo with git-svn to a git repo ("B").

My goal is to end up with a (new?) git repo tracking the public repo (A=
) so
that I can pull in any changes and merge easily. Fine, but I also want =
to
keep the history that I have imported from my svn repository (B).  So m=
y
question is, can anyone suggest some pointers for how to stitch togethe=
r A
and B?

Right now I have been trying to pull B into A to splice:

A $ git checkout v1.91
B $ git checkout v1.91-manualmerge
B $ git pull --no-commit -s ours ../A

This looks right when I run gitk, but if I repeat this for a second mer=
ge
point then the previous merge seems to disappear from history when I br=
ing
up gitk.

I haven't found any docs/wiki info that has enlightened me yet.  Any
suggestions, wisdom, links etc very much appreciated - I do want to try=
 to
get this right now, so I don't have to rejig everything in the future. =
 Best
wishes and many thanks,

Greg.

--=20
Gregory Jefferis, PhD                               and:
Research Fellow
Department of Zoology                               St John's College
Downing Street                                      Cambridge
Cambridge, CB2 3EJ                                  CB2 1TP
