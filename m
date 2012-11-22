From: Yichao Yu <yyc1992@gmail.com>
Subject: Re: Remote hung up during `git fetch`
Date: Thu, 22 Nov 2012 14:44:19 -0500
Message-ID: <CAMvDr+Rv6Krmjto6nQL18GnEj-+qCFPYgp7jDQnLs-ybamM0FA@mail.gmail.com>
References: <CAMvDr+R__wWRwm2xNC3-v0T1RVu_rKdjKUJhb8cHwEXvuX9OMQ@mail.gmail.com>
 <CAMvDr+QuMpfdTdkOMOiYyEnHvQjia2cDCt3sx2rQwwLcJiCVmw@mail.gmail.com> <CAJo=hJveYb09uhZWsKWKYor5Jcuz+wZ40F3wnsR3Hy8bcxeb6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Nov 22 20:44:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tbchm-0004pA-LR
	for gcvg-git-2@plane.gmane.org; Thu, 22 Nov 2012 20:44:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757081Ab2KVTon (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Nov 2012 14:44:43 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49570 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756183Ab2KVTol (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Nov 2012 14:44:41 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so2440634iea.19
        for <git@vger.kernel.org>; Thu, 22 Nov 2012 11:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=y9Aundtu+5Lrf1GRjvr9m+YNMJUFjk8/08UQFrAmsHs=;
        b=WhEmyscE0FTpHmsIhxQwx261UW2SP9gIgVp4ONQXgJNshjmLDiYirHf8CMChBc5yXc
         myY1VOWfNqswjqx+FkewXcCF7AGoH32ASZNEacC0mAhEGyRlm64wzTQmUBuhMPBlpcWr
         YOIRDFLUPj7seOR5cqdBXKhfFlBkTJsHS1R65aVhMWE9hwY3giGV0UQdi0sQugQra4Rc
         3Jg3ktw+dAM7rnjp1KybtY+bYGHOs4U4g5VVMPkpo1rP0/IkeFzEU/7NVWjuSskQrdkM
         HUY6MFOmVdYEa6JP3e8A7tWqOYVa5iJShsG4OY5ZKTkwULM7N/JT7skfWWvfMjI2VBdU
         99bA==
Received: by 10.50.152.236 with SMTP id vb12mr1568091igb.15.1353613480905;
 Thu, 22 Nov 2012 11:44:40 -0800 (PST)
Received: by 10.64.15.165 with HTTP; Thu, 22 Nov 2012 11:44:19 -0800 (PST)
In-Reply-To: <CAJo=hJveYb09uhZWsKWKYor5Jcuz+wZ40F3wnsR3Hy8bcxeb6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210201>

On Thu, Nov 22, 2012 at 2:01 PM, Shawn Pearce <spearce@spearce.org> wrote:
> On Thu, Nov 22, 2012 at 10:39 AM, Yichao Yu <yyc1992@gmail.com> wrote:
>> I sent this email yesterday to the git mailing list but I cannot find
>> it in any archive so I decide to send it again.
>
> If it was HTML formatted it would have been silently dropped by the list.
Well, I simply forward the original email and both of them are plain
text I believe....


>
>> Does anyone know what has happened to the mailing list? I haven't
>> receive any email from several kernel related busy mailing lists for
>> several hours....
>
> US holiday today? The list traffic tends to be down during holidays.
This silent?.... 0 email from the kernel mailing list for 10+ hours?..
anyway.... nvm...

>
>> I want to build packages for snap shoot of different branches from
>> different remote git repositories in the same local directory (so that
>> I don't need to recompile everything everytime.) and I am using a
>> combination of `git clone/checkout/reset/fetch` to do that. However,
>> during git-fetch, the remote sometimes stop responding or simply reset
>> the connection. This happens occasionally at least for both ssh and
>> git protocol (not sure about http/https) on github, bitbucket and also
>> kernel.org so I think it is probably not due to a weird behavior of a
>> certain host. Does anyone know the reason or is there anything I have
>> done wrong? And is there a better way to set the local tree to a
>> certain branch at a certain url? THX
>
> If the remote server is really busy it might be OOM'ing the server
Well, clone succeeded but fetch didn't?...

> process which would disconnect the client. Or maybe its your ISP
> sending a rogue RST packet to kill the connection because they don't
> like traffic that leaves their network and costs them money on a
> peering agreement. Or... ?
Well, yes I have only tested here but I don't really think MIT is
doing that... No?

>
>> #!/bin/bash
>>
>> repo_name=git
>> # remote1='git://github.com/torvalds/linux.git'
>> remote1='git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git'
>> branch1='master'
>> # remote2='git://github.com/git/git.git'
>> remote2='git://git.kernel.org/pub/scm/git/git.git'
>> branch2='next'
>>
>> git clone --depth 1 --single-branch --branch "$branch1" "$remote1" "$repo_name"
>> cd "$repo_name"
>> git fetch -vvv "$remote2" # "$branch2:$branch2"
>>
>> -----------------------------------------------
>>
>> Cloning into 'git'...
>> remote: Counting objects: 43215, done.
>> remote: Compressing objects: 100% (41422/41422), done.
>> remote: Total 43215 (delta 3079), reused 22032 (delta 1247)
>> Receiving objects: 100% (43215/43215), 119.06 MiB | 1.60 MiB/s, done.
>> Resolving deltas: 100% (3079/3079), done.
>> Checking out files: 100% (40905/40905), done.
>> fatal: destination path 'git' already exists and is not an empty directory.
>
> Why does this error come up? It looks like git already exists locally.
> Git should have aborted much earlier in clone when the directory
> exists.
Ahh, sorry. I killed the previous script to use LANG=C but forgot to
remove the directory which is normally deleted automatically by the
last few lines of my script that I didn't paste here (cd and rm...).
So here is the right output.

---------------------------------------

Cloning into 'git'...
remote: Counting objects: 43215, done.
remote: Compressing objects: 100% (41071/41071), done.
remote: Total 43215 (delta 3699), reused 13345 (delta 1598)
Receiving objects: 100% (43215/43215), 116.91 MiB | 4.51 MiB/s, done.
Resolving deltas: 100% (3699/3699), done.
Checking out files: 100% (40905/40905), done.
Server supports multi_ack_detailed
Server supports side-band-64k
Server supports ofs-delta
want 2d242fb3fc19fc9ba046accdd9210be8b9913f64 (HEAD)
have ef6c5be658f6a70c1256fbd18e18ee0dc24c3386
have db9d8c60266a5010e905829e10cd722519e14777
done
fatal: read error: Connection reset by peer

----------------------------------------------------

>
>> Server supports multi_ack_detailed
>> Server supports side-band-64k
>> Server supports ofs-delta
>> want 2d242fb3fc19fc9ba046accdd9210be8b9913f64 (HEAD)
>> have ef6c5be658f6a70c1256fbd18e18ee0dc24c3386
>> have db9d8c60266a5010e905829e10cd722519e14777
>> done
>> fatal: The remote end hung up unexpectedly
>
> This looks like its from the fetch command. Since the server doesn't
yes, plz simply ignore the previous one....

> report any errors to the client, its hard to say why the server just
> gave up right there. I wonder if this is related to the fact that you
> did a shallow clone initially. The shallow clone may have confused the
> server when fetch ran because it only sent 2 have lines and gave up.
Probably (related to shallow clone...) but hopefully this is not sth I
shouldn't do?
And a shallow clone is really what I want in my case. I really don't
need the full history to compile...

>
> Try exporting GIT_TRACE_PACKET=1 and seeing if you can get more
> detailed information from the protocol on the client side.

So here it is, I have removed lots of tags fetching (hopefully they
are irrelevant). Is there anything that looks strange (Looks like it's
actually .... done???)? Any more information needed?

----------------------------------------------

Cloning into 'git'...
remote: Counting objects: 43385, done.
remote: Compressing objects: 100% (41117/41117), done.
Receiving objects: 100% (43385/43385), 117.05 MiB | 4.73 MiB/s, done.
remote: Total 43385 (delta 3862), reused 13596 (delta 1722)
Resolving deltas: 100% (3862/3862), done.
Checking out files: 100% (40905/40905), done.
packet:        fetch> git-upload-pack
/pub/scm/git/git.git\0host=git.kernel.org\0
packet:        fetch< 2d242fb3fc19fc9ba046accdd9210be8b9913f64
HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow
no-progress include-tag multi_ack_detailed
packet:        fetch< 1c03999bef32edabd3db6479279b3ef90cc635ca refs/heads/maint
packet:        fetch< 2d242fb3fc19fc9ba046accdd9210be8b9913f64 refs/heads/master
packet:        fetch< ce6fbe5b9dc5e1e8ce1499bd8f7fb982e0c68289 refs/heads/next
packet:        fetch< 7b4a70c62f3a83fbd8b44bf712141754a5f64205 refs/heads/pu
packet:        fetch< 2c806864e99fc1252cea652ab0fc837067e726ba refs/heads/todo
packet:        fetch< d5aef6e4d58cfe1549adef5b436f3ace984e8c86
refs/tags/gitgui-0.10.0
packet:        fetch< 3d654be48f65545c4d3e35f5d3bbed5489820930
refs/tags/gitgui-0.10.0^{}
packet:        fetch< 33682a5e98adfd8ba4ce0e21363c443bd273eb77
refs/tags/gitgui-0.10.1
packet:        fetch< 729ffa50f75a025935623bfc58d0932c65f7de2f
refs/tags/gitgui-0.10.1^{}

... tags... and tags... and tags.....

packet:        fetch< c15295d7477ccec489953299bd03a8e62f86e611
refs/tags/v1.8.0-rc2
packet:        fetch< cd46259ebf2e624bcee2aaae05c36663d414e1a2
refs/tags/v1.8.0-rc2^{}
packet:        fetch< 22ed067acc84eac8a0a72d20478a18aee4e25571
refs/tags/v1.8.0-rc3
packet:        fetch< 87a5461fa7b30f7b7baf27204f10219d61500fbf
refs/tags/v1.8.0-rc3^{}
packet:        fetch< 0000
Server supports multi_ack_detailed
Server supports side-band-64k
Server supports ofs-delta
want 2d242fb3fc19fc9ba046accdd9210be8b9913f64 (HEAD)
packet:        fetch> want 2d242fb3fc19fc9ba046accdd9210be8b9913f64
multi_ack_detailed side-band-64k thin-pack ofs-delta
packet:        fetch> shallow 65546ab097b023886a60df4cbc931d4cc362b98e
packet:        fetch> shallow b80d60e1c3854460a1f01d4110da5ae98f30f9b2
packet:        fetch> 0000
packet:        fetch> have 5a903166dd31a42e39283b075cc6b9a9c079d1af
have 5a903166dd31a42e39283b075cc6b9a9c079d1af
packet:        fetch> have b80d60e1c3854460a1f01d4110da5ae98f30f9b2
have b80d60e1c3854460a1f01d4110da5ae98f30f9b2
packet:        fetch> have 65546ab097b023886a60df4cbc931d4cc362b98e
have 65546ab097b023886a60df4cbc931d4cc362b98e
packet:        fetch> done
done
fatal: read error: Connection reset by peer

----------------------------------------------------------

>
> FYI, https://kernel.googlesource.com/ mirrors git://git.kernel.org/ so
> you can also try pulling from that server (e.g.
> https://kernel.googlesource.com/pub/scm/git/git.git).
THX. I have no problem cloning/pulling either the git or the kernel
tree from anywhere. It only happens when I want to do this kind of
fetching. I think git.kernel.org should be the best place to
demonstrate this kind of error since you may know exactly what is
running on the server. (And you probably don't want to try reproducing
sth on my private ssh git server?.) =P
