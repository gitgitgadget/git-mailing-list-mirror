From: Matt Di Pasquale <pasquale@fas.harvard.edu>
Subject: Re: git for pushing local subdir to website
Date: Mon, 3 Aug 2009 15:13:43 -0400
Message-ID: <13f0168a0908031213r59a9ea61m824ca7e5209962fc@mail.gmail.com>
References: <13f0168a0908031011odd98c03ye08a1b0774fca523@mail.gmail.com> 
	<200908031201.41039.wjl@icecavern.net> <13f0168a0908031109h10c02424l91938918639c6a57@mail.gmail.com> 
	<200908031258.13787.wjl@icecavern.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Wesley J. Landaker" <wjl@icecavern.net>
X-From: git-owner@vger.kernel.org Mon Aug 03 21:14:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MY2zd-0002zE-KV
	for gcvg-git-2@gmane.org; Mon, 03 Aug 2009 21:14:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754506AbZHCTOG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Aug 2009 15:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754350AbZHCTOF
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Aug 2009 15:14:05 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:37578 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754497AbZHCTOE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Aug 2009 15:14:04 -0400
Received: by bwz19 with SMTP id 19so2629752bwz.37
        for <git@vger.kernel.org>; Mon, 03 Aug 2009 12:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:from:date:x-google-sender-auth:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=1rPpDRm6/We8YWFFZAhnUWp6UZIhx0vPR6zcnNbKpG0=;
        b=OECKi5Bw44J75d9ehuFlSDy+o54Ry/gHMpoAi3KyQrOrJBajX+OUALtQLq87pImBiK
         0aIIlEHcutHq7+OQxia8EK2SpZEKgytJXV54QK6maR1kVOddQ/Z3va9px5DHwdLaxYUf
         eaAq6V+Zk+eomMDB1cjThiG+VOOuLHd9NWDOk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=KlhDGdonJqTU14k5KvHDF/NrGggOsMgpSBbizmRHhb9u9Tg4sVUsjw+ER8h/ZOoti8
         X73R3FN7UwkFwpt4eu86OWUfckOjzuM1YJ3kSaTnLfboG2Gu61vBhaSuhDGROreTl4B/
         +Y+W58N9X+ScJ08OarOauqPRmF/H0Z2I+uuRs=
Received: by 10.103.1.4 with SMTP id d4mr1902871mui.53.1249326843069; Mon, 03 
	Aug 2009 12:14:03 -0700 (PDT)
In-Reply-To: <200908031258.13787.wjl@icecavern.net>
X-Google-Sender-Auth: 43cfb6e87db5cda6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124719>

wow. thanks. that gave me some good ideas.
i think u were right about rsync. it was pretty easy to set up.
assuming the name of my app is myapp, i just put the following alias
in my ~/.bash_profile on my local machine.

alias mapush=3D'rsync -e ssh -av --exclude=3D".DS_Store"
~/Projects/myapp/myapp.com/
matt@mattdipasquale.com:projects/myapp.com/'

btw, is there a way to make aliases that are local to certain
directories? like typing mapush works from any directory. what if i
just wanted the alias to be push and only work from within
~/Projects/myapp? is that possible?

those aren't the actual paths i used. but u get the point.
then i just type mapush and it does it.

and i just use a local git repository in ~/Projects/myapp/.git to
track local changes since none are made on the server... so i don't
need a git repo there like u said...

it's pretty fast. but will rsync be okay if i decide to move files
around a bit? i know git is pretty good about that. and what if i
delete certain files? will rsync delete them... like git does? guess
i'll figure those questions out in time.

thanks!

-matt


On Mon, Aug 3, 2009 at 2:58 PM, Wesley J. Landaker<wjl@icecavern.net> w=
rote:
> On Monday 03 August 2009 12:09:26 Matt Di Pasquale wrote:
>> yes... i've thought of that. that's a good idea. i just love git and
>> i've never really used rsync. how do i do that?
>> i'll go google it..
>
> Rsync can do a lot of things, but the usual easy way to do it is to d=
o
> something like this to send files via rsync over an ssh connection:
>
> rsync -av /some_dir/ user@host:/some_dir/
>
> This is essentially the same as using scp, but rsync saves a lot of n=
etwork
> bandwidth by only sending the changes between the source and destinat=
ion.
>
>> i guess it would also be nice to use git though incase i decide i wa=
nt
>> a collaborator, right?
>
> Setting things up to have a collaboration is kind of orthogonal to
> installing a production version of your app, but you could use the sa=
me
> server (and possibly the same git repository) for both things if you =
wanted
> to.
>
> Here an example of one way to do it:
>
> On the server you could have a normal git repository in, say,
> /home/me/myapp, and it always has the "production" branch checked out=
=2E So
> now the following directories are interesting:
>
> /home/me/myapp =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-- rep=
ository branch w/ "production" checked out
> /home/me/myapp/.git =C2=A0 =C2=A0 =C2=A0 =C2=A0 -- the actual bare gi=
t repository
> /home/me/myapp/example.com/ -- the files that the web server should s=
ee
>
> Now, you can use symlinks (or web-server configuration) to point the
> webserver to the right locations, for example:
>
> http://example.com/myapp/ =C2=A0 =C2=A0 -- link to /home/me/myapp/exa=
mple.com/
> http://example.com/myapp.git/ -- link to /home/me/myapp/.git/
>
> Now, collaborators can pull from the http://example.com/myapp.git and=
 get
> the whole project, but access to http://example.com/myapp/ sees the
> example.com subdir as it's root, and everything works normally (assum=
ing
> webserver configuration & permissions are correct).
>
> Now you work on whatever branches you want, and push to the server wh=
enever
> you want for collaboration using whatever branches you want. As far a=
s the
> webserver is concerned, nothing changes when you do a push.
>
> Then, when you are ready to change the website, you put your producti=
on
> changes on the "production" branch, push them, and make sure they are
> checked out on the server (git push doesn't automatically check out t=
he
> files), e.g.:
>
> client$ # just made changes in production branch and want them "live"
> client$ git push
>
> server$ cd /home/me/myapp
> server$ git reset --hard
>
>> how would u set it up?
>
> Personally, I might set something like this if I had a good reason, b=
ut
> otherwise, I'd host my git repository for collaboration separately, a=
nd just
> use rsync to install production files on the server. For one thing, t=
hat
> needs less prerequisites and setup on the server, so it's good if you=
 don't
> fully control the server.
>
> Either way, a "production" branch is a good idea so you know logicall=
y
> exactly what and when you released things live.
>
