From: Vasyl' Vavrychuk <vvavrychuk@gmail.com>
Subject: Re: [EGIT PATCH] Fixed trivial warnings. Mainly parametrized raw
 types, added serialVersionUID, removed unnecessery throws.
Date: Mon, 05 Jan 2009 03:13:13 +0200
Message-ID: <49615EA9.9070706@gmail.com>
References: <gjrcni$9q$1@ger.gmane.org> <200901050004.41531.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 02:15:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LJe3b-0003Zv-M0
	for gcvg-git-2@gmane.org; Mon, 05 Jan 2009 02:15:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbZAEBNp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Jan 2009 20:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbZAEBNo
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jan 2009 20:13:44 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:41340 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772AbZAEBNm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Jan 2009 20:13:42 -0500
Received: by bwz14 with SMTP id 14so22024698bwz.13
        for <git@vger.kernel.org>; Sun, 04 Jan 2009 17:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:newsgroups:to:cc:subject:references
         :in-reply-to:content-type:content-transfer-encoding;
        bh=AJZ5W9OfpCJseF0w0PH07nlRyviXinf40nqiWo6eQDk=;
        b=k8cTWB1C1pKy/1TWeFg5YlOX0dgP+ydvkpwbcdy61E1VwADC4Gx26Ea/WBDKJDFj5V
         VajTN4lzFRcrk/PX5agl4ZRdW1uaKO7E4DhKe8SHwjGV1Q4l04WL/hYypPUx7kqxtAdf
         lYocQ6Wh2+SZ/j6msIhvaaLD1M2hSYUXFLnYI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=vaA33QMZKV2qHnRZzjorlqzc1dbq1xwTsALK5KVtPw+bAWatSLCSAUnDVHCXlBgQlW
         SJRqCkebifHWSDydx0x5a8PLa6jlWHEyz/kOLFetasF6iXXaNOQa+JMv/b2hLIm2BiQY
         OerHqxj4YYorxmgEsD6fy4aBEUjlUPldkYjSQ=
Received: by 10.181.154.16 with SMTP id g16mr7873540bko.179.1231118019363;
        Sun, 04 Jan 2009 17:13:39 -0800 (PST)
Received: from ?192.167.1.125? ([91.200.115.178])
        by mx.google.com with ESMTPS id h2sm37707472fkh.29.2009.01.04.17.13.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 04 Jan 2009 17:13:38 -0800 (PST)
User-Agent: Thunderbird 2.0.0.19 (Windows/20081209)
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <200901050004.41531.robin.rosenberg.lists@dewire.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104555>

Robin Rosenberg wrote:
> s=F6ndag 04 januari 2009 23:20:19 skrev Vasyl' Vavrychuk:
>> Also fixed:
>> 1. "The 'Eclipse-LazyStart' header is deprecated, use 'Bundle-Activa=
tionPolicy'" warning.
>> 2. Possible NullPointerException warning.
>> 3. Unnecessery function parameter warning.
>=20
> Thanks for your interest in the projects.=20
> Most changes from a 30 seconds review look reasonable.
> However we don't apply changes this way. From your comments it seems =
we'd require about
> five patches since the changes are of very different types.

I thought that commit is trivial. But maybe series of patches will be b=
etter because of an ability to revert what we want.

>=20
> -- robin
>=20
>> diff --git a/org.spearce.egit.core.test/META-INF/MANIFEST.MF b/org.s=
pearce.egit.core.test/META-INF/MANIFEST.MF
>> index ee5f277..e8bcc79 100644
>> --- a/org.spearce.egit.core.test/META-INF/MANIFEST.MF
>> +++ b/org.spearce.egit.core.test/META-INF/MANIFEST.MF
>> @@ -11,7 +11,7 @@ Require-Bundle: org.eclipse.core.runtime,
>>   org.spearce.egit.ui,
>>   org.spearce.jgit,
>>   org.eclipse.core.filesystem
>> -Eclipse-LazyStart: true
>> +Bundle-ActivationPolicy: lazy
>=20
> Any pointers on this? (so I can learn)
http://help.eclipse.org/ganymede/index.jsp?topic=3D/org.eclipse.platfor=
m.doc.isv/reference/misc/bundle_manifest.html
The Eclipse-AutoStart and Eclipse-LazyStart headers have been deprecate=
d in Eclipse 3.4

>=20
>> diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/interna=
l/storage/GitFileHistory.java b/org.spearce.egit.core/src/org/spearce/e=
git/core/internal/storage/GitFileHistory.java
>> index c01c1c3..61c32ce 100644
>> --- a/org.spearce.egit.core/src/org/spearce/egit/core/internal/stora=
ge/GitFileHistory.java
>> +++ b/org.spearce.egit.core/src/org/spearce/egit/core/internal/stora=
ge/GitFileHistory.java
>> @@ -50,11 +50,11 @@
>>  	GitFileHistory(final IResource rsrc, final int flags,
>>  			final IProgressMonitor monitor) {
>>  		resource =3D rsrc;
>> -		walk =3D buildWalk(flags);
>> +		walk =3D buildWalk(/*flags*/);
>>  		revisions =3D buildRevisions(monitor, flags);
>>  	}
>> -	private KidWalk buildWalk(final int flags) {
>> +	private KidWalk buildWalk(/*final int flags*/) {
> Can't we just drop the parameter completely and wipe every trace of i=
t?
OK

>>  		final RepositoryMapping rm =3D RepositoryMapping.getMapping(resou=
rce);
>>  		if (rm =3D=3D null) {
>>  			Activator.logError("Git not attached to project "
>> diff --git a/org.spearce.egit.core/src/org/spearce/egit/core/project=
/GitProjectData.java b/org.spearce.egit.core/src/org/spearce/egit/core/=
project/GitProjectData.java
>> index 04130db..db5f20b 100644
>> --- a/org.spearce.egit.core/src/org/spearce/egit/core/project/GitPro=
jectData.java
>> +++ b/org.spearce.egit.core/src/org/spearce/egit/core/project/GitPro=
jectData.java
>> @@ -48,9 +48,9 @@
>>   * a Git repository.
>>   */
>>  public class GitProjectData {
>> -	private static final Map projectDataCache =3D new HashMap();
>> +	private static final Map<IProject, GitProjectData> projectDataCach=
e =3D new HashMap<IProject, GitProjectData>();
>> =20
>> -	private static final Map repositoryCache =3D new HashMap();
>> +	private static final Map<File, WeakReference> repositoryCache =3D =
new HashMap<File, WeakReference>();
> Been thinking about doing this myself but always found something more=
 interesting to do. Good.

Hope that we will have a generic version of SWT/JFace sometime. Because=
 now I do not know how to handle an inter operation between generic col=
lections and SWT, use SuppressWarning there maybe?

>> diff --git a/org.spearce.jgit/src/org/spearce/jgit/treewalk/Canonica=
lTreeParser.java b/org.spearce.jgit/src/org/spearce/jgit/treewalk/Canon=
icalTreeParser.java
>> index dcc53cd..4700510 100644
>> --- a/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreePa=
rser.java
>> +++ b/org.spearce.jgit/src/org/spearce/jgit/treewalk/CanonicalTreePa=
rser.java
>> @@ -175,8 +175,9 @@ public void back(int delta) {
>>  			// space so this prunes our search more quickly.
>>  			//
>>  			ptr -=3D Constants.OBJECT_ID_LENGTH;
>> -			while (raw[--ptr] !=3D ' ')
>> -				/* nothing */;
>> +			while (raw[--ptr] !=3D ' ') {
>> +				/* nothing */
>> +			}
> Not sure if this buys us anything. I wouldn't react if original code =
was either way, but
> changing it seems unnecessary.

With an old version I get "Empty control-flow statement" warning, I've =
checked org.eclipse.jdt.core.prefs file, there is:
org.eclipse.jdt.core.compiler.problem.emptyStatement=3Dwarning
