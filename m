From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v9 00/19] index-helper/watchman
Date: Tue, 10 May 2016 19:44:01 +0200
Message-ID: <1462902241.11954.10.camel@kaarsemaker.net>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
	 <xmqqa8jyuczj.fsf@gitster.mtv.corp.google.com>
	 <1462832134.24478.49.camel@twopensource.com>
	 <xmqqy47iswhj.fsf@gitster.mtv.corp.google.com>
	 <xmqqtwi6svzx.fsf@gitster.mtv.corp.google.com>
	 <1462901304.11954.5.camel@kaarsemaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 10 19:44:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0Bhj-0001aO-PP
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 19:44:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751532AbcEJRoI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 13:44:08 -0400
Received: from mail-wm0-f52.google.com ([74.125.82.52]:38157 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750983AbcEJRoF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 13:44:05 -0400
Received: by mail-wm0-f52.google.com with SMTP id g17so41063860wme.1
        for <git@vger.kernel.org>; Tue, 10 May 2016 10:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rOpMajUodFNhDSUfbzv10das/LKqXrucYJ5/Ba3xkHI=;
        b=TThRGZO1i7zjacAdqzRP/BMo1Szy6ZTrzV9GjfMNTx92W31G+cM/WoCHT7O7DHJ7hb
         fUAnQHqlbHpu2114En0gJ1Zp3SFZZCGE8DP6R+NFxOqUiXX6sfsASkZlZjBh+6vFyp0e
         Zs42PnP3o8UW95qJilymV1/cv2UjzJwjEtyalddplh10yF1NLpLFMUZfF9fEKZSdFWBc
         fIKiXAOnNajta/qEZF/lvkaNHL4/QUxgcCwnJ4KcJJmDcpTlXixs/n7BzE0lSq4r3pyM
         LgNrtVLB2fHroeC0NoHq699I/stlM2tcWhGKF9UghdCOO1sXkn3J7CF2PqvqLeDRvE9V
         8Vfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rOpMajUodFNhDSUfbzv10das/LKqXrucYJ5/Ba3xkHI=;
        b=QraB2z+Uoyticz+maK0ACNARBKEEhmT6LBsKgjpxdxpDEoULXzB8ZrA3fd6whnq9os
         1DXOFHwLPACqPYTuS4bbw4lCNwFLX8jwSV1gh0HpEe9zuQAeiBNG8DPss75tWngi37k2
         jkvhpcmuAxbYzsZHR9oDHkXXu03JYZ+Cw3zRP6rbduy1kTU98qjxaVl/BV3vn82vXPiE
         DqEelxDKk2Hx/rNRc27dMDH29VrEpOpVUFrnT/xbv/A6ASEBm21Ad2esU2VfvDEBmNUU
         ffLlulX05QmkZZElagTZXZSaN8m24UO+io0uWxgT5TTFDzKzl6JYtb7vRPV4HDPEzLPo
         SBgQ==
X-Gm-Message-State: AOPr4FVg0p/mdh1HPg8k0ZH6Ef3/TymU4zxfM1kf5OPGUEaBsnJcfDF1f/C1JYWCZNUvwQ==
X-Received: by 10.194.153.65 with SMTP id ve1mr35813074wjb.106.1462902243212;
        Tue, 10 May 2016 10:44:03 -0700 (PDT)
Received: from [10.42.1.4] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id lm1sm3687248wjc.25.2016.05.10.10.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 10:44:02 -0700 (PDT)
In-Reply-To: <1462901304.11954.5.camel@kaarsemaker.net>
X-Mailer: Evolution 3.18.5.2-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294165>

On di, 2016-05-10 at 19:28 +0200, Dennis Kaarsemaker wrote:
> On ma, 2016-05-09 at 15:32 -0700, Junio C Hamano wrote:
> >=20
> > Junio C Hamano <gitster@pobox.com> writes:
> >=20
> > >=20
> > >=20
> > > David Turner <dturner@twopensource.com> writes:
> > >=20
> > > >=20
> > > >=20
> > > > On Mon, 2016-05-09 at 14:40 -0700, Junio C Hamano wrote:
> > > > >=20
> > > > >=20
> > > > > Hmmm, I seem to be getting
> > > > >=20
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0$ cat t/trash*7900*/err
> > > > > =C2=A0=C2=A0=C2=A0=C2=A0fatal: Already running
> > > > >=20
> > > > > after running t7900 and it fails at #5, after applying
> > > > > "index-helper: optionally automatically run"
> > The symptom looks pretty similar to $gmane/293461 reported earlier.
> > Here is how "t7900-index-helper.sh -i -v -x -d" ends.
> >=20
> >=20
> > expecting success:
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_when_finished =
"git index-helper --kill" &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -f .git/index-he=
lper.sock &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git status &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_path_is_missin=
g .git/index-helper.sock &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_config indexhe=
lper.autorun true &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git status &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test -S .git/index-=
helper.sock &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git status 2>err &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test -S .git/index-=
helper.sock &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_must_be_empty =
err &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git index-helper --=
kill &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_config indexhe=
lper.autorun false &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git status &&
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_path_is_missin=
g .git/index-helper.sock
> >=20
> > + test_when_finished git index-helper --kill
> > + test 0 =3D 0
> > + test_cleanup=3D{ git index-helper --kill
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0} && (exit "$eval_ret"); eval_ret=3D$?; :
> > + rm -f .git/index-helper.sock
> > + git status
> > On branch master
> > Untracked files:
> > =C2=A0 (use "git add <file>..." to include in what will be committe=
d)
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err
> >=20
> > nothing added to commit but untracked files present (use "git add"
> > to
> > track)
> > + test_path_is_missing .git/index-helper.sock
> > + test -e .git/index-helper.sock
> > + test_config indexhelper.autorun true
> > + config_dir=3D
> > + test indexhelper.autorun =3D -C
> > + test_when_finished test_unconfig=C2=A0=C2=A0'indexhelper.autorun'
> > + test 0 =3D 0
> > + test_cleanup=3D{ test_unconfig=C2=A0=C2=A0'indexhelper.autorun'
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0} && (exit "$eval_ret"); eval_ret=3D$?; { gi=
t index-
> > helper --kill
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0} && (exit "$eval_ret"); eval_ret=3D$?; :
> > + git config indexhelper.autorun true
> > + git status
> > error: last command exited with $?=3D141
> > not ok 5 - index-helper autorun works
> > #
> > #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0test_when_finished "git index-helper --kill" &&
> > #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0rm -f .git/index-helper.sock &&
> > #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0git status &&
> > #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0test_path_is_missing .git/index-helper.sock &&
> > #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0test_config indexhelper.autorun true &&
> > #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0git status &&
> > #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0test -S .git/index-helper.sock &&
> > #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0git status 2>err &&
> > #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0test -S .git/index-helper.sock &&
> > #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0test_must_be_empty err &&
> > #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0git index-helper --kill &&
> > #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0test_config indexhelper.autorun false &&
> > #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0git status &&
> > #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0test_path_is_missing .git/index-helper.sock
> > #
> Here are the relevant bits of a strace, pid 22200 is the second git
> status, 222197 is the index helper. 22122 is the test script
>=20
> 22200 socket(PF_LOCAL, SOCK_STREAM, 0)=C2=A0=C2=A0=3D 7
> 22200 connect(7, {sa_family=3DAF_LOCAL, sun_path=3D".git/index-
> helper.sock"}, 110 <unfinished ...>
> 22197 <... poll resumed> )=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 1
> 22197 accept(7, 0, NULL)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 8
> 22197 fcntl(8, F_GETFL)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 0x2 (flags O_=
RDWR)
> 22197 fcntl(8, F_SETFL, O_RDWR)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=3D 0
> 22197 read(8,=C2=A0=C2=A0<unfinished ...>
> 22200 <... connect resumed> )=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=3D 0
> 22200 rt_sigaction(SIGPIPE, {SIG_IGN, [PIPE], SA_RESTORER|SA_RESTART,
> 0x7fcc463fdd40}, {SIG_DFL, [PIPE], SA_RESTORER|SA_RESTART,
> 0x7fcc463fdd40}, 8) =3D 0
> 22200 write(7, "000fpoke 22200 ", 15 <unfinished ...>
> 22197 <... read resumed> 0x7ffc4e4b9b20, 4) =3D 4
> 22197 read(8, 0x7ffc4e4b9c70, 11)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=3D 11
> 22197 write(8, 0x18b08b0, 6)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 6
> 22197 close(8)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 0
> 22197 poll([?] 0x7ffc4e4b9b80, 1, 600000 <unfinished ...>
> 22200 <... write resumed> )=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 15
> 22200 write(7, "0000", 4)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D -1 EPIPE (Broken pipe)
> 22200 --- SIGPIPE {si_signo=3DSIGPIPE, si_code=3DSI_USER, si_pid=3D22=
200,
> si_uid=3D1000} ---
> 22200 rt_sigaction(SIGPIPE, {SIG_DFL, [PIPE], SA_RESTORER|SA_RESTART,
> 0x7fcc463fdd40}, {SIG_IGN, [PIPE], SA_RESTORER|SA_RESTART,
> 0x7fcc463fdd40}, 8) =3D 0
> 22200 tgkill(22200, 22200, SIGPIPE)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D =
0=C2=A0=C2=A0=C2=A0
> 22200 --- SIGPIPE {si_signo=3DSIGPIPE, si_code=3DSI_TKILL, si_pid=3D2=
2200,
> si_uid=3D1000} ---
> 22200 +++ killed by SIGPIPE +++
> 22122 <... wait4 resumed> [{WIFSIGNALED(s) && WTERMSIG(s) =3D=3D
> SIGPIPE}], 0, NULL) =3D 22200=C2=A0
> 22122 --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_KILLED,
> si_pid=3D22200, si_status=3DSIGPIPE, si_utime=3D0, si_stime=3D0} ---
>=20
> Looks like the index helper closes the socket, but git status still
> wants to write to it. The index-helper also doesn't seem to read all
> data from the socket.

This dodgy hack to make the index helper read that empty pkt-line
before closing the socket seems to work around the issue enough to make
the test pass

diff --git a/index-helper.c b/index-helper.c
index 9743481..fa072de 100644
--- a/index-helper.c
+++ b/index-helper.c
@@ -385,6 +385,8 @@ static void loop(int fd, int idle_in_seconds)
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0* close up.
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0*/
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0}
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0bytes_read =3D packet_read(client_fd, NULL, NULL, buf=
,
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0sizeof(buf), flags);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0close(client_fd);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
=C2=A0
And this even dodgier hack breaks the race on a physical machine, so
the test reliably fails everywher:

diff --git a/read-cache.c b/read-cache.c
index e8593bc..848a1fe 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1836,6 +1836,7 @@ static int poke_and_wait_for_reply(int fd)
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0strbuf_addf(&buf, "poke=
 %d %s", getpid(), requested_capabilities);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0packet_write(fd, buf.bu=
f, buf.len);
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0sleep(5);
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0packet_flush(fd);
=C2=A0
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/* Now wait for a reply=
 */

But at this point I'll have to claim ignorance on whether reading the
empty pkt-line is a fix or just hiding the problem.

--=20
Dennis Kaarsemaker
www.kaarsemaker.net
