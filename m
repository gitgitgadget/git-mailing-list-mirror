From: Stefan Beller <sbeller@google.com>
Subject: Re: git fails updating submodule only if --quiet is specified
Date: Tue, 22 Mar 2016 11:22:24 -0700
Message-ID: <CAGZ79kZaV3w5TM+FPORcFOdeCY8idCYV_yB4Vt5eSNVrNomp2w@mail.gmail.com>
References: <3E1D841C-7665-43DB-A0F8-99999C59C28D@googlemail.com>
	<219B1DC5-8379-4FD5-8739-D99890362769@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Marcus T <maddimax@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Mar 22 19:23:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiQxY-0007kB-Qg
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 19:23:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751093AbcCVSWn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Mar 2016 14:22:43 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:32970 "EHLO
	mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750776AbcCVSWZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Mar 2016 14:22:25 -0400
Received: by mail-yw0-f174.google.com with SMTP id h65so122470357ywe.0
        for <git@vger.kernel.org>; Tue, 22 Mar 2016 11:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-transfer-encoding;
        bh=IHIKqq1ooLyxJDOG85Ufq2AheBe3ZwbRCWsc3Vl4hWM=;
        b=aBJ0ptgTYqViWd9DCaqiBEdg9Iih04PPPADbfV1LQU3RBLVZnAr5xOqWtXdZLjJpru
         +xJxT4aTRBTLtaTRzYX4tJcmIjMNsv3FjMf8jG4coWbdXdFnQOs9ol3T4gePj+zGGYz/
         c1K+v4JqS0Bq19hvf2Ia2dOGsky4Kd6tdIcMPoV2tt5PR2+2b33Cw3u8pO1br42s6Sxl
         996e3+osV+DyYE1Fq6WHDz9sxEjEE9AjpkJyFc1o10cg92xF8/rb3FxLAFuZDRr7ERRz
         RsrUiRV3ahtukaRA2BMT0DSupr0wszw22h/s++3/1riSvCdYnxLjY5B+A5X101XjimTz
         fGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=IHIKqq1ooLyxJDOG85Ufq2AheBe3ZwbRCWsc3Vl4hWM=;
        b=hhLbyYhtTLuYjXhMnXS/zv8GM6LZ/gBxAr6Dyk+ITEcAFaSHR49Gv670DDtT4alv3B
         RvF+KGWK2Zn6wvc16Gb+LgSYM3QeZDGsmmSdTk5ePtzWjbKVVDXZVKeoPH2MCVofmPhO
         PS6lnn2JOo5Z6oSP0MOicBsFYdB0gV1eOQ7KuGpia/Fh7GL4k+QOzXScLUj2qdbPseT7
         IbjHe02ckly4RGLfgGi3SYyZjoDDmcIJSIPxqPBBO1Tje62FX3CXv5cl8aMOEch1hf1h
         1wSVr6Yri9blf/dFiAvcjsR+dfaBPwviz2/Uv8SaN50h3/NTDDYQrj6lfZFpylM9aX4d
         FBgg==
X-Gm-Message-State: AD7BkJKojmntfPPG4LrwcMUtlb51ncKb8vv0S8l3/HgG4yBWSVAfOCO9PKvIue1fHwH1Wz0//2/X/aiKZtVhVXr+
X-Received: by 10.37.105.135 with SMTP id e129mr6357952ybc.185.1458670944217;
 Tue, 22 Mar 2016 11:22:24 -0700 (PDT)
Received: by 10.37.51.137 with HTTP; Tue, 22 Mar 2016 11:22:24 -0700 (PDT)
In-Reply-To: <219B1DC5-8379-4FD5-8739-D99890362769@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289540>

On Tue, Mar 22, 2016 at 8:51 AM, Marcus T <maddimax@googlemail.com> wro=
te:

git submodule was partially rewritten in v2.7 so I would assume that
is some fallout from
there. (passing the wrong arguments at the wrong time/place)

However lookingat your logs, I would suspect it is an error in git
clone instead, as that is the
last command which has the --quiet flag passed through the stack.


> I did a bunch more investigation:
>
> My original problem was that it would work on a terminal, but not whe=
n running under jenkins.
>
> Turns out the =E2=80=9C-v=E2=80=9D in the "index-pack=E2=80=9D step i=
s whats leading to the error.
>
> I can reproduce the issue with the command "git submodule update --in=
it --recursive > out.txt 2>&1"
>
> It seems that the =E2=80=9C-v=E2=80=9D is dropped automatically by gi=
t if its not connected to a terminal.
> This is only an issue for =E2=80=9Cgit://=E2=80=9C urls. ssh and http=
s seem to not be affected.

That is what the transport protocol determines at
https://github.com/git/git/blob/master/transport.c#L743

I would expect that index-pack just works without -v instead of crashin=
g.

>
>
>
>> On 22 Mar 2016, at 16:02, Marcus T <maddimax@googlemail.com> wrote:
>>
>> Hello,
>>
>> I=E2=80=99m running into a nasty issue where =E2=80=9Cgit submodule =
update =E2=80=94init=E2=80=9D fails if I add =E2=80=9C=E2=80=94quiet=E2=
=80=9D
>>
>> Following you can find the output with GIT_TRACE=3D1:
>>
>> WITHOUT --quiet:
>>
>> GIT_TRACE=3D1 git submodule update --init --recursive
>> 15:51:48.248945 git.c:561               trace: exec: 'git-submodule'=
 'update' '--init' '--recursive'
>> 15:51:48.249023 run-command.c:334       trace: run_command: 'git-sub=
module' 'update' '--init' '--recursive'
>> 15:51:48.256626 git.c:344               trace: built-in: git 'rev-pa=
rse' '--git-dir'
>> 15:51:48.258494 git.c:344               trace: built-in: git 'rev-pa=
rse' '--git-path' 'objects'
>> 15:51:48.260406 git.c:344               trace: built-in: git 'rev-pa=
rse' '-q' '--git-dir'
>> 15:51:48.262940 git.c:344               trace: built-in: git 'rev-pa=
rse' '--show-prefix'
>> 15:51:48.264156 git.c:344               trace: built-in: git 'rev-pa=
rse' '--show-toplevel'
>> 15:51:48.266637 git.c:344               trace: built-in: git 'submod=
ule--helper' 'list' '--prefix' ''
>> 15:51:48.268074 git.c:344               trace: built-in: git 'submod=
ule--helper' 'name' 'buildroot'
>> 15:51:48.269913 git.c:344               trace: built-in: git 'config=
' 'submodule.buildroot.url'
>> 15:51:48.271168 git.c:344               trace: built-in: git 'config=
' '-f' '.gitmodules' 'submodule.buildroot.update'
>> 15:51:48.272422 git.c:344               trace: built-in: git 'submod=
ule--helper' 'name' 'dl'
>> 15:51:48.274179 git.c:344               trace: built-in: git 'config=
' 'submodule.dl.url'
>> 15:51:48.275445 git.c:344               trace: built-in: git 'config=
' '-f' '.gitmodules' 'submodule.dl.update'
>> 15:51:48.276779 git.c:344               trace: built-in: git 'submod=
ule--helper' 'list' '--prefix' ''
>> 15:51:48.278362 git.c:344               trace: built-in: git 'submod=
ule--helper' 'name' 'buildroot'
>> 15:51:48.279819 git.c:344               trace: built-in: git 'config=
' 'submodule.buildroot.url'
>> 15:51:48.281192 git.c:344               trace: built-in: git 'config=
' 'submodule.buildroot.branch'
>> 15:51:48.282473 git.c:344               trace: built-in: git 'config=
' '-f' '.gitmodules' 'submodule.buildroot.branch'
>> 15:51:48.283788 git.c:344               trace: built-in: git 'config=
' 'submodule.buildroot.update'
>> 15:51:48.285269 git.c:344               trace: built-in: git 'submod=
ule--helper' 'clone' '--prefix' '' '--path' 'buildroot' '--name' 'build=
root' '--url' 'git://git.busybox.net/buildroot' '' ''
>> 15:51:48.285337 run-command.c:334       trace: run_command: 'clone' =
'--no-checkout' '--separate-git-dir' '.git/modules/buildroot' 'git://gi=
t.busybox.net/buildroot' 'buildroot'
>> 15:51:48.285687 exec_cmd.c:120          trace: exec: 'git' 'clone' '=
--no-checkout' '--separate-git-dir' '.git/modules/buildroot' 'git://git=
=2Ebusybox.net/buildroot' 'buildroot'
>> 15:51:48.286453 git.c:344               trace: built-in: git 'clone'=
 '--no-checkout' '--separate-git-dir' '.git/modules/buildroot' 'git://g=
it.busybox.net/buildroot' 'buildroot'
>> Cloning into 'buildroot'...
>> 15:51:49.177856 run-command.c:334       trace: run_command: 'index-p=
ack' '--stdin' '-v' '--fix-thin' '--keep=3Dfetch-pack 15895 on bre-buil=
d-linux' '--check-self-contained-and-connected'
>> 15:51:49.178244 exec_cmd.c:120          trace: exec: 'git' 'index-pa=
ck' '--stdin' '-v' '--fix-thin' '--keep=3Dfetch-pack 15895 on bre-build=
-linux' '--check-self-contained-and-connected'
>> 15:51:49.179806 git.c:344               trace: built-in: git 'index-=
pack' '--stdin' '-v' '--fix-thin' '--keep=3Dfetch-pack 15895 on bre-bui=
ld-linux' '--check-self-contained-and-connected'
>> remote: Counting objects: 200277, done.
>> remote: Compressing objects: 100% (62420/62420), done.
>> ...
>>
>> WITH --quite:
>>
>> GIT_TRACE=3D1 git submodule update --init --recursive --quiet
>> 15:52:26.900568 git.c:561               trace: exec: 'git-submodule'=
 'update' '--init' '--recursive' '--quiet'
>> 15:52:26.900652 run-command.c:334       trace: run_command: 'git-sub=
module' 'update' '--init' '--recursive' '--quiet'
>> 15:52:26.907761 git.c:344               trace: built-in: git 'rev-pa=
rse' '--git-dir'
>> 15:52:26.909877 git.c:344               trace: built-in: git 'rev-pa=
rse' '--git-path' 'objects'
>> 15:52:26.911766 git.c:344               trace: built-in: git 'rev-pa=
rse' '-q' '--git-dir'
>> 15:52:26.914279 git.c:344               trace: built-in: git 'rev-pa=
rse' '--show-prefix'
>> 15:52:26.915488 git.c:344               trace: built-in: git 'rev-pa=
rse' '--show-toplevel'
>> 15:52:26.917983 git.c:344               trace: built-in: git 'submod=
ule--helper' 'list' '--prefix' ''
>> 15:52:26.919504 git.c:344               trace: built-in: git 'submod=
ule--helper' 'name' 'buildroot'
>> 15:52:26.921244 git.c:344               trace: built-in: git 'config=
' 'submodule.buildroot.url'
>> 15:52:26.922619 git.c:344               trace: built-in: git 'config=
' '-f' '.gitmodules' 'submodule.buildroot.update'
>> 15:52:26.923888 git.c:344               trace: built-in: git 'submod=
ule--helper' 'name' 'dl'
>> 15:52:26.925650 git.c:344               trace: built-in: git 'config=
' 'submodule.dl.url'
>> 15:52:26.926892 git.c:344               trace: built-in: git 'config=
' '-f' '.gitmodules' 'submodule.dl.update'
>> 15:52:26.928230 git.c:344               trace: built-in: git 'submod=
ule--helper' 'list' '--prefix' ''
>> 15:52:26.929709 git.c:344               trace: built-in: git 'submod=
ule--helper' 'name' 'buildroot'
>> 15:52:26.931220 git.c:344               trace: built-in: git 'config=
' 'submodule.buildroot.url'
>> 15:52:26.932597 git.c:344               trace: built-in: git 'config=
' 'submodule.buildroot.branch'
>> 15:52:26.933867 git.c:344               trace: built-in: git 'config=
' '-f' '.gitmodules' 'submodule.buildroot.branch'
>> 15:52:26.935170 git.c:344               trace: built-in: git 'config=
' 'submodule.buildroot.update'
>> 15:52:26.936660 git.c:344               trace: built-in: git 'submod=
ule--helper' 'clone' '--quiet' '--prefix' '' '--path' 'buildroot' '--na=
me' 'buildroot' '--url' 'git://git.busybox.net/buildroot' '' ''
>> 15:52:26.936732 run-command.c:334       trace: run_command: 'clone' =
'--no-checkout' '--quiet' '--separate-git-dir' '.git/modules/buildroot'=
 'git://git.busybox.net/buildroot' 'buildroot'
>> 15:52:26.936965 exec_cmd.c:120          trace: exec: 'git' 'clone' '=
--no-checkout' '--quiet' '--separate-git-dir' '.git/modules/buildroot' =
'git://git.busybox.net/buildroot' 'buildroot'
>> 15:52:26.937803 git.c:344               trace: built-in: git 'clone'=
 '--no-checkout' '--quiet' '--separate-git-dir' '.git/modules/buildroot=
' 'git://git.busybox.net/buildroot' 'buildroot'
>> 15:52:27.958503 run-command.c:334       trace: run_command: 'index-p=
ack' '--stdin' '--fix-thin' '--keep=3Dfetch-pack 15936 on bre-build-lin=
ux' '--check-self-contained-and-connected'
>> 15:52:27.958870 exec_cmd.c:120          trace: exec: 'git' 'index-pa=
ck' '--stdin' '--fix-thin' '--keep=3Dfetch-pack 15936 on bre-build-linu=
x' '--check-self-contained-and-connected'
>> 15:52:27.960447 git.c:344               trace: built-in: git 'index-=
pack' '--stdin' '--fix-thin' '--keep=3Dfetch-pack 15936 on bre-build-li=
nux' '--check-self-contained-and-connected'
>> fatal: The remote end hung up unexpectedly
>> fatal: early EOF
>> fatal: index-pack failed
>> fatal: clone of 'git://git.busybox.net/buildroot' into submodule pat=
h 'buildroot' failed
>>
>> ---------
>> git --version
>> git version 2.7.4
>>
>> Any help in tracking down the reason for this would be greatly appre=
ciated.
>>
>> Thanks,
>> Marcus
>>
>
