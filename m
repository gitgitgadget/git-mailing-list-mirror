From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Consecutive git gc fails on Windows network share
Date: Mon, 20 Jan 2014 22:52:27 +0100
Message-ID: <52DD9A9B.5070400@googlemail.com>
References: <d10603d6-7740-44f8-909f-7ba1ea77d3a2@googlegroups.com> <52D9701F.5070009@web.de> <11936e14-7442-4601-8e97-b2062894975b@googlegroups.com> <52DD59E0.4090301@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>, 
 Jochen <zwanzig12@googlemail.com>,
 msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>
X-From: msysgit+bncBCN6TVX6TQDRBHVV62LAKGQEHXL6JXQ@googlegroups.com Mon Jan 20 22:52:31 2014
Return-path: <msysgit+bncBCN6TVX6TQDRBHVV62LAKGQEHXL6JXQ@googlegroups.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-fa0-f57.google.com ([209.85.161.57])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <msysgit+bncBCN6TVX6TQDRBHVV62LAKGQEHXL6JXQ@googlegroups.com>)
	id 1W5Mlj-00043k-1u
	for gcvm-msysgit@m.gmane.org; Mon, 20 Jan 2014 22:52:31 +0100
Received: by mail-fa0-f57.google.com with SMTP id m1sf446953fam.12
        for <gcvm-msysgit@m.gmane.org>; Mon, 20 Jan 2014 13:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlegroups.com; s=20120806;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=/X3LxqxxUicrVo9LfS7d5j4Ljtbw4cy222Qn/XwXRE4=;
        b=eDGMyYQRNp8GvvLSmylMOgtXm5a1G101LwBooRTKmWRO7eIpJcJlPcgdTzme3NQUB2
         1qTE89kGUXcW5mTSLgS90UBavO8inaj+wi+sJ09pkCvGdpqmZUnzrgdjYZ/bc2M2NtmH
         dJsZsy/3JAdKZCSP3JggUwRuqPWHpXPiCjGl/7pn7znQ+J1mUHuj9PW2XJ/WU8d1zUPa
         oL+g7BfIN2kqKwJPU0s9MtYQ8asSDoE3ZlPShVb7R/UXtYpcEDajOJ6vt2EOErSsDTW6
         q8A7bzS0L4MhLc9W/UKK24s1e1oourWssv7pD3Ffuc5AmmR17wjjB8kXkhie3zGYzjbi
         dvcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject:references
         :in-reply-to:x-original-sender:x-original-authentication-results
         :precedence:mailing-list:list-id:list-post:list-help:list-archive
         :sender:list-subscribe:list-unsubscribe:content-type
         :content-transfer-encoding;
        bh=/X3LxqxxUicrVo9LfS7d5j4Ljtbw4cy222Qn/XwXRE4=;
        b=zI6g/cbgJYVdKFSxXdJ3ZEgqpb5v55tqfjExsJ0fvUNodfqXkhmejaOUvzSRwpUgSH
         CzAxp22Abeelsn+eX7+M2glIQozgsbF9D/YZF3U3L27kiDDnz2pbvQx6/ZM5Lzrrq2Vh
         nxNJ3vUhjD82HTTQSgRnGQCA9D4N83gjAbpipRDozyHvh8NiXLtYpZvihIhRnxIGX/Fq
         kqb07602EBs9OXZlHUI2u2YYTmedXkmwAZh3ZqLP33WeKwlR1UWNb3cwrEb9vzGU2adr
         J7Twq+SLBHxGB0T52eN63To+sRxEqkRL7vwMb7/YZPY/AMJKSa7ggNDXODzGFBg9kVHU
         gcqQ==
X-Received: by 10.153.0.8 with SMTP id au8mr28971lad.14.1390254750588;
        Mon, 20 Jan 2014 13:52:30 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.152.43.132 with SMTP id w4ls391774lal.64.gmail; Mon, 20 Jan
 2014 13:52:29 -0800 (PST)
X-Received: by 10.152.216.35 with SMTP id on3mr9396503lac.6.1390254749343;
        Mon, 20 Jan 2014 13:52:29 -0800 (PST)
Received: from mail-ea0-x22e.google.com (mail-ea0-x22e.google.com [2a00:1450:4013:c01::22e])
        by gmr-mx.google.com with ESMTPS id jb4si869021wic.0.2014.01.20.13.52.29
        for <msysgit@googlegroups.com>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Jan 2014 13:52:29 -0800 (PST)
Received-SPF: pass (google.com: domain of stefanbeller@googlemail.com designates 2a00:1450:4013:c01::22e as permitted sender) client-ip=2a00:1450:4013:c01::22e;
Received: by mail-ea0-f174.google.com with SMTP id b10so3376455eae.33
        for <msysgit@googlegroups.com>; Mon, 20 Jan 2014 13:52:29 -0800 (PST)
X-Received: by 10.14.209.129 with SMTP id s1mr20037035eeo.21.1390254749152;
        Mon, 20 Jan 2014 13:52:29 -0800 (PST)
Received: from [192.168.1.7] (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id d43sm7502586eeo.12.2014.01.20.13.52.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Jan 2014 13:52:28 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <52DD59E0.4090301@web.de>
X-Enigmail-Version: 1.5.2
X-Original-Sender: stefanbeller@googlemail.com
X-Original-Authentication-Results: gmr-mx.google.com;       spf=pass
 (google.com: domain of stefanbeller@googlemail.com designates
 2a00:1450:4013:c01::22e as permitted sender) smtp.mail=stefanbeller@googlemail.com;
       dkim=pass header.i=@googlemail.com
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
X-Google-Group-Id: 152234828034
List-Post: <http://groups.google.com/group/msysgit/post>, <mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit>
Sender: msysgit@googlegroups.com
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:msysgit+subscribe@googlegroups.com>
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe>, <mailto:googlegroups-manage+152234828034+unsubscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240730>

On 20.01.2014 18:16, Torsten B=C3=B6gershausen wrote:
> (No top-posting, please see my comments below)
> On 2014-01-20 15.02, Jochen wrote:
>> On 01/16/2014 10:55 AM, Jochen Haag wrote:
>> Hello,
>>
>> we want to report the following issue, because it seems to be not an
>> intended behaviour. Maybe someone can have a look at it at some point.
>> It is not urgent for us.
>>
>> After upgrading from Git version 1.8.1.msysgit.1 to 1.8.5.2.msysgit.0 we
>> observed that a consecutive git gc fails, in case the Git repo is
>> located on a Windows network share. Operating system used is Windows 7
>> 64 bit SP1.
>>
>> In case git gc fails temporary packs and index remain in .git/objects/pa=
ck/.
>>
>> "Consecutive" means, that git gc is called on an already packed
>> repository (e.g. git gc is called more than once).
>>
>> This is the output given in case of error:
>>
>> U:\GitEnv>git gc
>> Counting objects: 139, done.
>> Delta compression using up to 8 threads.
>> Compressing objects: 100% (71/71), done.
>> Writing objects: 100% (139/139), done.
>> Total 139 (delta 65), reused 139 (delta 65)
>> fatal: renaming
>> '.git/objects/pack/.tmp-7920-pack-ad9d069e7c27ce19cc5b6cde82b4a38bedbf58=
84.pack'
>> failed: Permission denied
>> error: failed to run repack
>>
>> And here the output with GIT_TRACE =3D 1:
>>
>> U:\GitEnv>git gc
>> trace: built-in: git 'gc'
>> trace: run_command: 'pack-refs' '--all' '--prune'
>> trace: built-in: git 'pack-refs' '--all' '--prune'
>> trace: run_command: 'reflog' 'expire' '--all'
>> trace: built-in: git 'reflog' 'expire' '--all'
>> trace: run_command: 'repack' '-d' '-l' '-A'
>> '--unpack-unreachable=3D2.weeks.ago'
>> trace: built-in: git 'repack' '-d' '-l' '-A'
>> '--unpack-unreachable=3D2.weeks.ago'
>> trace: run_command: 'pack-objects' '--keep-true-parents'
>> '--honor-pack-keep' '--non-empty' '--all' '--reflog'
>> '--unpack-unreachable=3D2.weeks.ago' '--local' '--delta-base-offset'
>> '.git/objects/pack/.tmp-7612-pack'
>> trace: built-in: git 'pack-objects' '--keep-true-parents'
>> '--honor-pack-keep' '--non-empty' '--all' '--reflog'
>> '--unpack-unreachable=3D2.weeks.ago' '--local' '--delta-base-offset'
>> '.git/objects/pack/.tmp-7612-pack'
>> Counting objects: 139, done.
>> Delta compression using up to 8 threads.
>> Compressing objects: 100% (71/71), done.
>> Writing objects: 100% (139/139), done.
>> Total 139 (delta 65), reused 139 (delta 65)
>> fatal: renaming
>> '.git/objects/pack/.tmp-7612-pack-ad9d069e7c27ce19cc5b6cde82b4a38bedbf58=
84.pack'
>> failed: Permission denied
>> error: failed to run repack
>>
>> After running git gc twice, this is what is left in .git/objects/pack/:
>>
>> U:\GitEnv\.git\objects\pack>ls -al
>> total 53676
>> drwxr-xr-x    1 hgj2fe   Administ        0 Jan 16 10:43 .
>> drwxr-xr-x    1 hgj2fe   Administ        0 Jan 14 12:52 ..
>> -r--r--r--    1 hgj2fe   Administ     4964 Jan 16 10:43
>> .tmp-7612-pack-ad9d069e7c27ce19cc5b6cde82b4a38bedbf5884.idx
>> -r--r--r--    1 hgj2fe   Administ 18315618 Jan 16 10:43
>> .tmp-7612-pack-ad9d069e7c27ce19cc5b6cde82b4a38bedbf5884.pack
>> -r--r--r--    1 hgj2fe   Administ     4964 Jan 16 10:40
>> .tmp-7920-pack-ad9d069e7c27ce19cc5b6cde82b4a38bedbf5884.idx
>> -r--r--r--    1 hgj2fe   Administ 18315618 Jan 16 10:40
>> .tmp-7920-pack-ad9d069e7c27ce19cc5b6cde82b4a38bedbf5884.pack
>> -r--r--r--    1 hgj2fe   Administ     4964 Jan 14 12:52
>> pack-ad9d069e7c27ce19cc5b6cde82b4a38bedbf5884.idx
>> -r--r--r--    1 hgj2fe   Administ 18315618 Jan 14 12:52
>> pack-ad9d069e7c27ce19cc5b6cde82b4a38bedbf5884.pack
>>
>> In case we remove the read-only flag of the pack and index manually
>> before running git gc again, no problem occurs:
>>
>> U:\GitEnv\.git\objects\pack>git gc
>> trace: built-in: git 'gc'
>> trace: run_command: 'pack-refs' '--all' '--prune'
>> trace: built-in: git 'pack-refs' '--all' '--prune'
>> trace: run_command: 'reflog' 'expire' '--all'
>> trace: built-in: git 'reflog' 'expire' '--all'
>> trace: run_command: 'repack' '-d' '-l' '-A'
>> '--unpack-unreachable=3D2.weeks.ago'
>> trace: built-in: git 'repack' '-d' '-l' '-A'
>> '--unpack-unreachable=3D2.weeks.ago'
>> trace: run_command: 'pack-objects' '--keep-true-parents'
>> '--honor-pack-keep' '--non-empty' '--all' '--reflog'
>> '--unpack-unreachable=3D2.weeks.ago' '--local' '--delta-base-offset'
>> 'U:/GitEnv/.git/objects/pack/.tmp-3736-pack'
>> trace: built-in: git 'pack-objects' '--keep-true-parents'
>> '--honor-pack-keep' '--non-empty' '--all' '--reflog'
>> '--unpack-unreachable=3D2.weeks.ago' '--local' '--delta-base-offset'
>> 'U:/GitEnv/.git/objects/pack/.tmp-3736-pack'
>> Counting objects: 139, done.
>> Delta compression using up to 8 threads.
>> Compressing objects: 100% (71/71), done.
>> Writing objects: 100% (139/139), done.
>> Total 139 (delta 65), reused 139 (delta 65)
>> trace: run_command: 'prune-packed'
>> trace: built-in: git 'prune-packed'
>> trace: run_command: 'update-server-info'
>> trace: built-in: git 'update-server-info'
>> trace: run_command: 'prune' '--expire' '2.weeks.ago'
>> trace: built-in: git 'prune' '--expire' '2.weeks.ago'
>> trace: run_command: 'rerere' 'gc'
>> trace: built-in: git 'rerere' 'gc'
>>
>> The problem might be related to this commit:
>> https://github.com/msysgit/git/commit/a1bbc6c0176f1fa2d4aa571cc0183a1f0f=
f9b285
>>
>>
>> Best regards,
>>
>> Jochen
> ------
>>
>>
>> Am Freitag, 17. Januar 2014 19:02:07 UTC+1 schrieb Torsten B=C3=B6gersha=
usen:
>>
>>
>>     So, please, what happens if you revert that commit?
>>     It could be good if you can test it and share the results with the l=
ist
>>     /Torsten
>>
>>
>> Instead of reverting we did some more analysis.
>>
>> In repack.c we found the following code:
>>
>>         /* Now the ones with the same name are out of the way... */
>>         for_each_string_list_item(item, &names) {
>>                 for (ext =3D 0; ext < 2; ext++) {
>>                         char *fname, *fname_old;
>>                         struct stat statbuffer;
>>                         fname =3D mkpathdup("%s/pack-%s%s",
>>                                         packdir, item->string, exts[ext]=
);
>>                         fname_old =3D mkpathdup("%s-%s%s",
>>                                         packtmp, item->string, exts[ext]=
);
>>                         if (!stat(fname_old, &statbuffer)) {
>>                                 statbuffer.st_mode &=3D ~(S_IWUSR | S_IW=
GRP | S_IWOTH);
>>                                 chmod(fname_old, statbuffer.st_mode);
>>                         }
>>                         if (rename(fname_old, fname))
>>                                 die_errno(_("renaming '%s' failed"), fna=
me_old);
>>                         free(fname);
>>                         free(fname_old);
>>                 }
>>         }
>>
>> The rename command replaces a mv -f command of the original shell script=
. Obviously the -f option can also override a read-only file but rename can=
 not on a network share.
>>
>> We changed the code as followed:
>>
>>         /* Now the ones with the same name are out of the way... */
>>         for_each_string_list_item(item, &names) {
>>                 for (ext =3D 0; ext < 2; ext++) {
>>                         char *fname, *fname_old;
>>                         struct stat statbuffer;
>>                         fname =3D mkpathdup("%s/pack-%s%s",
>>                                         packdir, item->string, exts[ext]=
);
>>                         fname_old =3D mkpathdup("%s-%s%s",
>>                                         packtmp, item->string, exts[ext]=
);
>>                         if (!stat(fname_old, &statbuffer)) {
>>                                 statbuffer.st_mode &=3D ~(S_IWUSR | S_IW=
GRP | S_IWOTH);
>>                                 chmod(fname_old, statbuffer.st_mode);
>>                         }
>> +++                         if (!stat(fname, &statbuffer)) {
>> +++                                 statbuffer.st_mode |=3D (S_IWUSR | S=
_IWGRP | S_IWOTH);
>> +++                                 chmod(fname, statbuffer.st_mode);
>> +++                         }
>>                         if (rename(fname_old, fname))
>>                                 die_errno(_("renaming '%s' failed"), fna=
me_old);
>>                         free(fname);
>>                         free(fname_old);
>>                 }
>>         }
>>
>> Before rename is called the destination file is made writeable. This wor=
ked for us. We are not sure if this is a good implementation.
>=20
> Jochen,
> thanks for sharing the code changes with us.
>=20
> I allowed me to=20
> a) reconstruct the original mail,
> b) add "+++" at the places where you added the stat() and chmod(),
> c) and to send the question "is this a good implementation ?" to upstream=
 git.
>=20
> I think your implementation makes sense.
> /Torsten
> =20
>=20

I'm sorry for breaking repack there. The implementation sounds
reasonably to me.

Thanks for reporting.
Do you want to prepare an upstream patch?

Thanks,
Stefan

--=20
--=20
*** Please reply-to-all at all times ***
*** (do not pretend to know who is subscribed and who is not) ***
*** Please avoid top-posting. ***
The msysGit Wiki is here: https://github.com/msysgit/msysgit/wiki - Github =
accounts are free.

You received this message because you are subscribed to the Google
Groups "msysGit" group.
To post to this group, send email to msysgit@googlegroups.com
To unsubscribe from this group, send email to
msysgit+unsubscribe@googlegroups.com
For more options, and view previous threads, visit this group at
http://groups.google.com/group/msysgit?hl=3Den_US?hl=3Den

---=20
You received this message because you are subscribed to the Google Groups "=
msysGit" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to msysgit+unsubscribe@googlegroups.com.
For more options, visit https://groups.google.com/groups/opt_out.
