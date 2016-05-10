From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: [PATCH v9 00/19] index-helper/watchman
Date: Tue, 10 May 2016 19:28:24 +0200
Message-ID: <1462901304.11954.5.camel@kaarsemaker.net>
References: <1462826929-7567-1-git-send-email-dturner@twopensource.com>
	 <xmqqa8jyuczj.fsf@gitster.mtv.corp.google.com>
	 <1462832134.24478.49.camel@twopensource.com>
	 <xmqqy47iswhj.fsf@gitster.mtv.corp.google.com>
	 <xmqqtwi6svzx.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>,
	David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Tue May 10 19:28:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0BSV-0000HO-R3
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 19:28:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751277AbcEJR2b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 May 2016 13:28:31 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35748 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751245AbcEJR22 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 13:28:28 -0400
Received: by mail-wm0-f43.google.com with SMTP id e201so187602746wme.0
        for <git@vger.kernel.org>; Tue, 10 May 2016 10:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kaarsemaker-net.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u62QFMZfd27sp87rhxR9QOrOXKDXUoSPibEThM5cf3Q=;
        b=osfcHpoKadoT5WBiOUkCJI+vRftDQrGjTB7s1Y74gMmc/k438AT9QrvtdxJwvC5BgK
         COijaNU8CjeuLAqTxyjgNEH0rDupOrxS25jxMcX8nWHMpjT/s+CHzyDvFatFhlo9ReDx
         3EGgsLucUgUCWSGqbwJJ8PyJLvpY9y0Ksn8puF04lmYr6QFI45Qeav4c9S+3KR3fv8+2
         KWrICODWe3VW2MvelCmzmNvAjPTObPlutVKDB3hqvJpLzhpFf1BilEqHdIqWjnQj9uSx
         KwoUkD5aawjvsT+3XfnEGNDe7MY3bPpEMwTPd2NKW+LcTKVNnpsLiD96ONQ7xTJvJ0KC
         XVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u62QFMZfd27sp87rhxR9QOrOXKDXUoSPibEThM5cf3Q=;
        b=HyosHpvyDzShpPN8eiRVaWUg4XFRk2PhpkcGANwFbdIbKW2Exk/sUSvZjCqBrWoBCJ
         k7sJRfApY97idtP4dogDXR79jrCDluDOwnT5vjfeXxeiD5Q8JKbbdYHBgu0AQ4d9ReLd
         8Fq6YhG9wUw1ZUpdKydLssPqRM+qYx0Q4jKAppVPnaibR/C8i/5f6/j/HptJ1mqyoLEQ
         9G0LKCWwXf/HEDanHv/BlyKcjCiLJQKk/qlrXsQ7bxzF7B6w+mb2I/Rxn3CjGFTRL+qN
         MFor7CfLnuIpUs1YnLL3PHvK0WEh0xGpMRqV3X34E5k9LPlnf/KUJikwpT3sUKq+BNeN
         bDhQ==
X-Gm-Message-State: AOPr4FUR1fW57oi2RP6R4GJ7gEB5F8iApkPlsTyl1OYN39q6h+cqdKMAlkEeSBJeps2uxw==
X-Received: by 10.28.150.142 with SMTP id y136mr18535462wmd.28.1462901306310;
        Tue, 10 May 2016 10:28:26 -0700 (PDT)
Received: from [10.42.1.4] ([145.132.209.114])
        by smtp.gmail.com with ESMTPSA id k62sm17986705wmb.7.2016.05.10.10.28.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 May 2016 10:28:25 -0700 (PDT)
In-Reply-To: <xmqqtwi6svzx.fsf@gitster.mtv.corp.google.com>
X-Mailer: Evolution 3.18.5.2-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294159>

On ma, 2016-05-09 at 15:32 -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> >=20
> > David Turner <dturner@twopensource.com> writes:
> >=20
> > >=20
> > > On Mon, 2016-05-09 at 14:40 -0700, Junio C Hamano wrote:
> > > >=20
> > > > Hmmm, I seem to be getting
> > > >=20
> > > > =C2=A0=C2=A0=C2=A0=C2=A0$ cat t/trash*7900*/err
> > > > =C2=A0=C2=A0=C2=A0=C2=A0fatal: Already running
> > > >=20
> > > > after running t7900 and it fails at #5, after applying
> > > > "index-helper: optionally automatically run"
> The symptom looks pretty similar to $gmane/293461 reported earlier.
> Here is how "t7900-index-helper.sh -i -v -x -d" ends.
>=20
>=20
> expecting success:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_when_finished "g=
it index-helper --kill" &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rm -f .git/index-help=
er.sock &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git status &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_path_is_missing =
=2Egit/index-helper.sock &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_config indexhelp=
er.autorun true &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git status &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test -S .git/index-he=
lper.sock &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git status 2>err &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test -S .git/index-he=
lper.sock &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_must_be_empty er=
r &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git index-helper --ki=
ll &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_config indexhelp=
er.autorun false &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git status &&
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0test_path_is_missing =
=2Egit/index-helper.sock
>=20
> + test_when_finished git index-helper --kill
> + test 0 =3D 0
> + test_cleanup=3D{ git index-helper --kill
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0} && (exit "$eval_ret"); eval_ret=3D$?; :
> + rm -f .git/index-helper.sock
> + git status
> On branch master
> Untracked files:
> =C2=A0 (use "git add <file>..." to include in what will be committed)
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0err
>=20
> nothing added to commit but untracked files present (use "git add" to
> track)
> + test_path_is_missing .git/index-helper.sock
> + test -e .git/index-helper.sock
> + test_config indexhelper.autorun true
> + config_dir=3D
> + test indexhelper.autorun =3D -C
> + test_when_finished test_unconfig=C2=A0=C2=A0'indexhelper.autorun'
> + test 0 =3D 0
> + test_cleanup=3D{ test_unconfig=C2=A0=C2=A0'indexhelper.autorun'
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0} && (exit "$eval_ret"); eval_ret=3D$?; { gi=
t index-
> helper --kill
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0} && (exit "$eval_ret"); eval_ret=3D$?; :
> + git config indexhelper.autorun true
> + git status
> error: last command exited with $?=3D141
> not ok 5 - index-helper autorun works
> #
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0test_when_finished "git index-helper --kill" &&
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0rm -f .git/index-helper.sock &&
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0git status &&
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0test_path_is_missing .git/index-helper.sock &&
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0test_config indexhelper.autorun true &&
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0git status &&
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0test -S .git/index-helper.sock &&
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0git status 2>err &&
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0test -S .git/index-helper.sock &&
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0test_must_be_empty err &&
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0git index-helper --kill &&
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0test_config indexhelper.autorun false &&
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0git status &&
> #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0test_path_is_missing .git/index-helper.sock
> #

Here are the relevant bits of a strace, pid 22200 is the second git
status, 222197 is the index helper. 22122 is the test script

22200 socket(PF_LOCAL, SOCK_STREAM, 0)=C2=A0=C2=A0=3D 7
22200 connect(7, {sa_family=3DAF_LOCAL, sun_path=3D".git/index-helper.s=
ock"}, 110 <unfinished ...>
22197 <... poll resumed> )=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 1
22197 accept(7, 0, NULL)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 8
22197 fcntl(8, F_GETFL)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 0x2 (flags O_=
RDWR)
22197 fcntl(8, F_SETFL, O_RDWR)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=3D 0
22197 read(8,=C2=A0=C2=A0<unfinished ...>
22200 <... connect resumed> )=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=3D 0
22200 rt_sigaction(SIGPIPE, {SIG_IGN, [PIPE], SA_RESTORER|SA_RESTART, 0=
x7fcc463fdd40}, {SIG_DFL, [PIPE], SA_RESTORER|SA_RESTART, 0x7fcc463fdd4=
0}, 8) =3D 0
22200 write(7, "000fpoke 22200 ", 15 <unfinished ...>
22197 <... read resumed> 0x7ffc4e4b9b20, 4) =3D 4
22197 read(8, 0x7ffc4e4b9c70, 11)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=3D 11
22197 write(8, 0x18b08b0, 6)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 6
22197 close(8)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 0
22197 poll([?] 0x7ffc4e4b9b80, 1, 600000 <unfinished ...>
22200 <... write resumed> )=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 15
22200 write(7, "0000", 4)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D -1 EPIPE (Broken pipe)
22200 --- SIGPIPE {si_signo=3DSIGPIPE, si_code=3DSI_USER, si_pid=3D2220=
0, si_uid=3D1000} ---
22200 rt_sigaction(SIGPIPE, {SIG_DFL, [PIPE], SA_RESTORER|SA_RESTART, 0=
x7fcc463fdd40}, {SIG_IGN, [PIPE], SA_RESTORER|SA_RESTART, 0x7fcc463fdd4=
0}, 8) =3D 0
22200 tgkill(22200, 22200, SIGPIPE)=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=3D 0=C2=
=A0=C2=A0=C2=A0
22200 --- SIGPIPE {si_signo=3DSIGPIPE, si_code=3DSI_TKILL, si_pid=3D222=
00, si_uid=3D1000} ---
22200 +++ killed by SIGPIPE +++
22122 <... wait4 resumed> [{WIFSIGNALED(s) && WTERMSIG(s) =3D=3D SIGPIP=
E}], 0, NULL) =3D 22200=C2=A0
22122 --- SIGCHLD {si_signo=3DSIGCHLD, si_code=3DCLD_KILLED, si_pid=3D2=
2200, si_status=3DSIGPIPE, si_utime=3D0, si_stime=3D0} ---

Looks like the index helper closes the socket, but git status still
wants to write to it. The index-helper also doesn't seem to read all
data from the socket.

--=20
Dennis Kaarsemaker
www.kaarsemaker.net
