Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D474D1F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 19:18:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbfKLTSW (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 14:18:22 -0500
Received: from mout.gmx.net ([212.227.17.22]:54777 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfKLTSW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 14:18:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573586292;
        bh=htca9va7OJO9NzYkMp2a12ZIGGeArAsAsJmO1nJ2xsE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=EhSWphxOYWU4fVs8ZYfyr8s4Tkfb2EA9M0fu7Lc8ibkkHGNIL2w+gKJIILoRxmqRp
         IJGBFWTVLJF4kEXHwV6u416II3OnNvBZleBpywL4uWt6uH+R1qvB+oZotc6IfEojdJ
         C8h+RNOZKSfjRhiA1HoM0by8HBELsiuG4dQm+MDA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MStCY-1iKGaY2l7G-00UFhi; Tue, 12
 Nov 2019 20:18:12 +0100
Date:   Tue, 12 Nov 2019 20:17:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
        git@vger.kernel.org, Sebastiaan Dammann <triadsebas@gmail.com>
Subject: Re: [PATCH v2 00/13] name-rev: eliminate recursion
In-Reply-To: <20191112103821.30265-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1911122012050.46@tvgsbejvaqbjf.bet>
References: <20190919214712.7348-1-szeder.dev@gmail.com> <20191112103821.30265-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-673742579-1573585953=:46"
Content-ID: <nycvar.QRO.7.76.6.1911122013200.46@tvgsbejvaqbjf.bet>
X-Provags-ID: V03:K1:j3k47mKXQBDEin26NpOv5Vo2C3ZtvICMHCZ8x/Ix4JMDuAcBAWL
 kcuCFoT5l7OKozaKnjT7rXEWfqTBXI82UpzrMGJ+mYvTK87qVHsVJllElJxmAbk37jjsvO8
 ppdNzDyE19K5sta7DCqRlMeSZWlV+tlEHydIhck8jmqPCmyeXhGU4OFmgR8LQskWm041MBM
 4ZEP+qoXlr+JOP/K/cmtA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oSXB1z+vPyI=:I2vRoU3JZ1FVrDypJt5eFG
 eFVZckHMsMHsjHq81SWq9Y0wpOAJWz7kdpFAEf+QGx/pG4tLqgGSaVIrVKpIhcrYbaKeroTk4
 77zhUGvpIe/D2PK61dhIECG+Jg8HeQU4FczmRp1iWfqQaT/UsPE37O7gQKs3oRTwnxb6yR2TM
 bwFtWr6P7htRLkJxv2KEH57cKjb0ZkmrrBbqhHoGme58iQta2SbhGDWQi6st9RtYBiUu4BrwY
 jj1Aw8Dl8Q96QX0irxI52M+jagLIKw/1NTgLnSgl2f3mOKkoZqoaT6L/WBX/kWENXYFPGHW+b
 gMThJ9qv23RbH4ixUAKiXs7w6TAmsM+/WBcDiVUNG3HwoSm9l2AvJrg3tKRLGJhZyCunlTDlS
 4K9d6sZZt4zzjPVuaUrYzbx99JgT+xw53WDmFyvmZkO8XU9aSFZHd26ky2NACfXy3aC4YHzQj
 PPMMXsGoqLKhgRDZlu35KvO2UFYf5P1ZF7CYwd2aE7/TC4LQD4vmU3B7SGk8TJGMe38E5h0S3
 XYAQ/O/BM/7RbZr8mfj6DtZN3oJKTO1xikCcrunULstv8cYDXYY+50tlopTCnsIJtnAnQQxwr
 oXFFEK0qNKpLWzN5WdEDXMsiEulBcDWxt/dQe+HURw62DVjJrZNqBQDW4nIS8kRtIEpH3lx3Y
 xBZ/AcxPdk/8eIOOlSVR58Yiijh15K6Iq4WuaiXgRrGM6kilbO8VNlZ0C6XyQU744ybqz6vNs
 mxVTcg0M2qUOn6vUnjSyOBQfePWCGshzd5PQzhur7bW/ZHqXEYvDqxI4vnOR4z7Zo8s1eIFvn
 Ww0VX7+AVVj8FdyEd4X5gnkRZGC8OBvQzm4tUdOkUAEEu0klex+B0du3u4fdXtGHfQWSCcHBW
 SeP4+kdh4vDMkgEH82gmYh5VPMnJTlipijRbFhTJIZDO8aeaZzxgbCBcVqd/Vc15SZoZQy66a
 1ZTPCbq2SsMCi6JSjYH/SCalNli+tMWl4YCFT/jdi+ycIk5JD9RLxT52Tj4SmMv1b8PDcq7O6
 wU1PvU+3geN8jcPJmBuf4ebC0Olyi/tQMkQ5gs63IuBnws8WyWuYWNNISDJyFVO7Fcn5EJmRx
 S0nESogf1MsVg2T/N+ItfcPk93V7x30A/zwHFfGp8S0UDaDOjRTGDXipTn2soRoLukKc7+Qvt
 4zv4VBhm7BqS2z5ozSfPItQnLU5giHrPm8FjMFdRfQC7/0VbFooCLWcWb2g8x24qTXyS8zAcI
 WVRF2Ooon72iV9Nac7rBVBOtVen/CWUecy8PmYu9bbNBCz66NPNLWRoOkNmk=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-673742579-1573585953=:46
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-ID: <nycvar.QRO.7.76.6.1911122013201.46@tvgsbejvaqbjf.bet>

Hi,

[Cc:ing Sebastian, as they indicated in
https://public-inbox.org/git/CAE7Eq9hEiVf1rMNdWx55_nQsz2gVv0N%2Bs1KckK1evt=
mruqcHyA@mail.gmail.com/t/#u
that they would be interested in testing this]

Sebastian, could you test this patch series? Since you are on Windows,
you should be able to do so by

- installing Git for Windows' SDK
  (https://gitforwindows.org/#download-sdk)
- `sdk cd git` (possibly `sdk init git`, although that should be
  implied)
- `sdk init build-extra` followed by
  `/usr/src/build-extra/apply-from-public-inbox.sh
  https://public-inbox.org/git/20191112103821.30265-1-szeder.dev@gmail.com=
/`
- `sdk build`

The result should include a `git.exe` in `/usr/src/git/` that you can
copy to your server and test via `/path/to/git.exe name-rev ...`.

Ciao,
Johannes

On Tue, 12 Nov 2019, SZEDER G=C3=A1bor wrote:

> 'git name-rev' is implemented using a recursive algorithm, and,
> consequently, it can segfault in deep histories (e.g. WebKit), and
> thanks to a test case demonstrating this limitation every test run
> results in a dmesg entry logging the segfaulting git process.
>
> This patch series eliminates the recursion.
>
> Patches 1-5 are while-at-it cleanups I noticed on the way, and patch 6
> improves test coverage.  Patches 7-11 are preparatory refactorings
> that are supposed to make this series easier to follow, and make patch
> 12, the one finally eliminating the recursion, somewhat shorter, and
> even much shorter when viewed with '--ignore-all-space'.  Patch 13
> cleans up after those preparatory steps.
>
> Changes since v1:
>
>   - Patch 12 now eliminates the recursion using a LIFO 'prio_queue'
>     instead of a 'commit_list' to avoid any performance penalty.
>
>   - Commit message updates, clarifications, typofixes, missing
>     signoffs, etc., most notably in patches 6 and 12.
>
>   - Updated ASCII art history graphs.
>
>   - Replaced the strbuf_suffix() cleanup in patch 3 with Ren=C3=A9's
>     suggestion; now that patch needs his signoff.
>
>   - Dropped the last two patches plugging memory leaks; Ren=C3=A9's plan
>     to clean up memory ownership looked more promising, and that
>     would make these two dropped patches moot anyway.
>
> v1: https://public-inbox.org/git/20190919214712.7348-1-szeder.dev@gmail.=
com/T/#u
>
> Ren=C3=A9 Scharfe (1):
>   name-rev: use strbuf_strip_suffix() in get_rev_name()
>
> SZEDER G=C3=A1bor (12):
>   t6120-describe: correct test repo history graph in comment
>   t6120-describe: modernize the 'check_describe' helper
>   name-rev: avoid unnecessary cast in name_ref()
>   name-rev: use sizeof(*ptr) instead of sizeof(type) in allocation
>   t6120: add a test to cover inner conditions in 'git name-rev's
>     name_rev()
>   name-rev: extract creating/updating a 'struct name_rev' into a helper
>   name-rev: pull out deref handling from the recursion
>   name-rev: restructure parsing commits and applying date cutoff
>   name-rev: restructure creating/updating 'struct rev_name' instances
>   name-rev: drop name_rev()'s 'generation' and 'distance' parameters
>   name-rev: eliminate recursion in name_rev()
>   name-rev: cleanup name_ref()
>
>  builtin/name-rev.c  | 147 +++++++++++++++++++++++++++++---------------
>  t/t6120-describe.sh |  72 +++++++++++++++++-----
>  2 files changed, 153 insertions(+), 66 deletions(-)
>
> Range-diff:
>  1:  673da20e3d !  1:  8d70ed050d t6120-describe: correct test repo hist=
ory graph in comment
>     @@ t/t6120-describe.sh
>      -test_description=3D'test describe
>      +test_description=3D'test describe'
>      +
>     -+#       ,---o----o----o-----.
>     -+#      /   D,R   e           \
>     -+#  o--o-----o-------------o---o----x
>     -+#      \    B            /
>     -+#       `---o----o----o-'
>     -+#                A    c
>     ++#  o---o-----o----o----o-------o----x
>     ++#       \   D,R   e           /
>     ++#        \---o-------------o-'
>     ++#         \  B            /
>     ++#          `-o----o----o-'
>     ++#                 A    c
>     ++#
>     ++# First parent of a merge commit is on the same line, second paren=
t below.
>
>      -                       B
>      -        .--------------o----o----o----x
>  2:  05df899693 =3D  2:  3720b6859d t6120-describe: modernize the 'check=
_describe' helper
>  3:  7b0227cfea !  3:  ad2f2eee68 name-rev: use strip_suffix() in get_re=
v_name()
>     @@
>       ## Metadata ##
>     -Author: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>     +Author: Ren=C3=A9 Scharfe <l.s.r@web.de>
>
>       ## Commit message ##
>     -    name-rev: use strip_suffix() in get_rev_name()
>     +    name-rev: use strbuf_strip_suffix() in get_rev_name()
>
>     -    Use strip_suffix() instead of open-coding it, making the code m=
ore
>     -    idiomatic.
>     +    get_name_rev() basically open-codes strip_suffix() before addin=
g a
>     +    string to a strbuf.
>
>     +    Let's use the strbuf right from the beginning, i.e. add the who=
le
>     +    string to the strbuf and then use strbuf_strip_suffix(), making=
 the
>     +    code more idiomatic.
>     +
>     +    [TODO: Ren=C3=A9's signoff!]
>          Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>
>       ## builtin/name-rev.c ##
>     @@ builtin/name-rev.c: static const char *get_rev_name(const struct =
object *o, stru
>      -		int len =3D strlen(n->tip_name);
>      -		if (len > 2 && !strcmp(n->tip_name + len - 2, "^0"))
>      -			len -=3D 2;
>     -+		size_t len;
>     -+		strip_suffix(n->tip_name, "^0", &len);
>       		strbuf_reset(buf);
>      -		strbuf_addf(buf, "%.*s~%d", len, n->tip_name, n->generation);
>     -+		strbuf_addf(buf, "%.*s~%d", (int) len, n->tip_name,
>     -+			    n->generation);
>     ++		strbuf_addstr(buf, n->tip_name);
>     ++		strbuf_strip_suffix(buf, "^0");
>     ++		strbuf_addf(buf, "~%d", n->generation);
>       		return buf->buf;
>       	}
>       }
>  4:  40faecdc2a =3D  4:  c86a2ae2d0 name-rev: avoid unnecessary cast in =
name_ref()
>  5:  c71df3dadf =3D  5:  4fc960cc05 name-rev: use sizeof(*ptr) instead o=
f sizeof(type) in allocation
>  6:  1dcb76072f !  6:  1493cb4484 t6120: add a test to cover inner condi=
tions in 'git name-rev's name_rev()
>     @@ Commit message
>          looks like this:
>
>            if (parent_number > 1) {
>     -        if (generation > 0)
>     -          // do stuff #1
>     -        else
>     -          // do stuff #2
>     +          if (generation > 0)
>     +              // branch #1
>     +              new_name =3D ...
>     +          else
>     +              // branch #2
>     +              new_name =3D ...
>     +          name_rev(parent, new_name, ...);
>            } else {
>     -         // do stuff #3
>     +          // branch #3
>     +          name_rev(...);
>            }
>
>          These conditions are not covered properly in the test suite.  A=
s far
>     @@ Commit message
>          command's output, because the repository used in that test scri=
pt
>          contains several branches and tags pointing somewhere into the =
middle
>          of the commit DAG, and thus result in a better name for the
>     -    to-be-named commit.  In an early version of this patch series I
>     -    managed to mess up those conditions (every single one of them a=
t
>     -    once!), but the whole test suite still passed successfully.
>     +    to-be-named commit.  This can hide bugs: e.g. by replacing the
>     +    'new_name' parameter of the first recursive name_rev() call wit=
h
>     +    'tip_name' (effectively making both branch #1 and #2 a noop) 'g=
it
>     +    name-rev --all' shows thousands of bogus names in the Git repos=
itory,
>     +    but the whole test suite still passes successfully.  In an earl=
y
>     +    version of a later patch in this series I managed to mess up al=
l three
>     +    branches (at once!), but the test suite still passed.
>
>          So add a new test case that operates on the following history:
>
>     -        -----------master
>     -       /          /
>     -      A----------M2
>     -       \        /
>     -        \---M1-C
>     -         \ /
>     -          B
>     +      A--------------master
>     +       \            /
>     +        \----------M2
>     +         \        /
>     +          \---M1-C
>     +           \ /
>     +            B
>
>     -    and names the commit 'B', where:
>     +    and names the commit 'B' to make sure that all three branches a=
re
>     +    crucial to determine 'B's name:
>
>     -      - The merge commit at master makes sure that the 'do stuff #3=
'
>     -        affects the final name.
>     +      - There is only a single ref, so all names are based on 'mast=
er',
>     +        without any undesired interference from other refs.
>
>     -      - The merge commit M2 make sure that the 'do stuff #1' part
>     -        affects the final name.
>     +      - Each time name_rev() follows the second parent of a merge c=
ommit,
>     +        it appends "^2" to the name.  Following 'master's second pa=
rent
>     +        right at the start ensures that all commits on the ancestry=
 path
>     +        from 'master' to 'B' have a different base name from the or=
iginal
>     +        'tip_name' of the very first name_rev() invocation.  Curren=
tly,
>     +        while name_rev() is recursive, it doesn't matter, but it wi=
ll be
>     +        necessary to properly cover all three branches after the re=
cursion
>     +        is eliminated later in this series.
>
>     -      - And M1 makes sure that the 'do stuff #2' part affects the f=
inal
>     -        name.
>     +      - Following 'M2's second parent makes sure that branch #2 (i.=
e. when
>     +        'generation =3D 0') affects 'B's name.
>     +
>     +      - Following the only parent of the non-merge commit 'C' ensur=
es that
>     +        branch #3 affects 'B's name, and that it increments 'genera=
tion'.
>     +
>     +      - Coming from 'C' 'generation' is 1, thus following 'M1's sec=
ond
>     +        parent makes sure that branch #1 affects 'B's name.
>
>          Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>
>       ## t/t6120-describe.sh ##
>     -@@ t/t6120-describe.sh: test_expect_success 'describe complains abo=
ut missing object' '
>     - 	test_must_fail git describe $ZERO_OID
>     +@@ t/t6120-describe.sh: test_expect_success 'name-rev a rev shortly=
 after epoch' '
>     + 	test_cmp expect actual
>       '
>
>     -+#   -----------master
>     -+#  /          /
>     -+# A----------M2
>     -+#  \        /
>     -+#   \---M1-C
>     -+#    \ /
>     -+#     B
>     -+test_expect_success 'test' '
>     ++# A--------------master
>     ++#  \            /
>     ++#   \----------M2
>     ++#    \        /
>     ++#     \---M1-C
>     ++#      \ /
>     ++#       B
>     ++test_expect_success 'name-rev covers all conditions while looking =
at parents' '
>      +	git init repo &&
>      +	(
>      +		cd repo &&
>     @@ t/t6120-describe.sh: test_expect_success 'describe complains abou=
t missing objec
>      +		git checkout master &&
>      +		git merge --no-ff HEAD@{1} &&
>      +
>     -+		git log --graph --oneline &&
>     -+
>      +		echo "$B master^2^2~1^2" >expect &&
>      +		git name-rev $B >actual &&
>      +
>  7:  bdd8378b06 =3D  7:  fc842e578b name-rev: extract creating/updating =
a 'struct name_rev' into a helper
>  8:  ce21c351f9 !  8:  7f182503e2 name-rev: pull out deref handling from=
 the recursion
>     @@ Commit message
>          Extract this condition from the recursion into name_rev()'s cal=
ler and
>          drop the function's 'deref' parameter.  This makes eliminating =
the
>          recursion a bit easier to follow, and it will be moved back int=
o
>     -    name_rev() after the recursion is elminated.
>     +    name_rev() after the recursion is eliminated.
>
>          Furthermore, drop the condition that die()s when both 'deref' a=
nd
>          'generation' are non-null (which should have been a BUG() to be=
gin
>     @@ Commit message
>
>          Note that this change reintroduces the memory leak that was plu=
gged in
>          in commit 5308224633 (name-rev: avoid leaking memory in the `de=
ref`
>     -    case, 2017-05-04), but a later patch in this series will plug i=
t in
>     -    again.
>     +    case, 2017-05-04), but a later patch (name-rev: restructure
>     +    creating/updating 'struct rev_name' instances) in this series w=
ill
>     +    plug it in again.
>
>          Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>
>  9:  c8acc6b597 !  9:  0cdd40b75b name-rev: restructure parsing commits =
and applying date cutoff
>     @@ Commit message
>          name_rev() and name_rev() itself as it iterates over the parent
>          commits.
>
>     -    This makes eliminating the recursion a bit easier to follow, an=
d it
>     -    will be moved back to name_rev() after the recursion is elimina=
ted.
>     +    This makes eliminating the recursion a bit easier to follow, an=
d the
>     +    condition moved to name_ref() will be moved back to name_rev() =
after
>     +    the recursion is eliminated.
>
>          Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>
> 10:  c731f27158 ! 10:  e1733e3c56 name-rev: restructure creating/updatin=
g 'struct rev_name' instances
>     @@ Commit message
>          At the beginning of the recursive name_rev() function it create=
s a new
>          'struct rev_name' instance for each previously unvisited commit=
 or, if
>          this visit results in better name for an already visited commit=
, then
>     -    updates the 'struct rev_name' instance attached to to the commi=
t, or
>     +    updates the 'struct rev_name' instance attached to the commit, =
or
>          returns early.
>
>          Restructure this so it's caller creates or updates the 'struct
>     @@ Commit message
>          parameter, i.e. both name_ref() before calling name_rev() and
>          name_rev() itself as it iterates over the parent commits.
>
>     -    This makes eliminating the recursion a bit easier to follow, an=
d it
>     -    will be moved back to name_rev() after the recursion is elimina=
ted.
>     +    This makes eliminating the recursion a bit easier to follow, an=
d the
>     +    condition moved to name_ref() will be moved back to name_rev() =
after
>     +    the recursion is eliminated.
>
>          This change also plugs the memory leak that was temporarily unp=
lugged
>          in the earlier "name-rev: pull out deref handling from the recu=
rsion"
> 11:  ba14bde230 ! 11:  bd6e2e6d87 name-rev: drop name_rev()'s 'generatio=
n' and 'distance' parameters
>     @@ Commit message
>          'taggerdate' and 'from_tag' parameters as well, but those param=
eters
>          will be necessary later, after the recursion is eliminated.
>
>     -    Drop name_rev()'s 'generation' and 'distance' parameters.
>     +    Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>
>       ## builtin/name-rev.c ##
>      @@ builtin/name-rev.c: static struct rev_name *create_or_update_nam=
e(struct commit *commit,
> 12:  2d03ac11f3 ! 12:  0cf63c6d64 name-rev: eliminate recursion in name_=
rev()
>     @@ Commit message
>          segfault when processing a deep history if it exhausts the avai=
lable
>          stack space.  E.g. running 'git name-rev --all' and 'git name-r=
ev
>          HEAD~100000' in the gcc, gecko-dev, llvm, and WebKit repositori=
es
>     -    results in segfaults on my machine.
>     +    results in segfaults on my machine ('ulimit -s' reports 8192kB =
of
>     +    stack size limit), and nowadays the former segfaults in the Lin=
ux repo
>     +    as well (it reached the necessasry depth sometime between v5.3-=
rc4 and
>     +    -rc5).
>
>          Eliminate the recursion by inserting the interesting parents in=
to a
>     -    'commit_list' and iteratating until the list becomes empty.
>     +    LIFO 'prio_queue' [1] and iterating until the queue becomes emp=
ty.
>
>     -    Note that the order in which the parent commits are added to th=
at list
>     -    is important: they must be inserted at the beginning of the lis=
t, and
>     -    their relative order must be kept as well, because otherwise
>     -    performance suffers.
>     +    Note that the parent commits must be added in reverse order to =
the
>     +    LIFO 'prio_queue', so their relative order is preserved during
>     +    processing, i.e. the first parent should come out first from th=
e
>     +    queue, because otherwise performance greatly suffers on mergy
>     +    histories [2].
>
>          The stacksize-limited test 'name-rev works in a deep repo' in
>          't6120-describe.sh' demonstrated this issue and expected failur=
e.  Now
>     -    the recursion is gone, so flip it to expect success.
>     -
>     -    Also gone are the dmesg entries logging the segfault of the git
>     -    process on every execution of the test suite.
>     -
>     -    Unfortunately, eliminating the recursion comes with a performan=
ce
>     -    penaly: 'git name-rev --all' tends to be between 15-20% slower =
than
>     -    before.
>     +    the recursion is gone, so flip it to expect success.  Also gone=
 are
>     +    the dmesg entries logging the segfault of that segfaulting 'git
>     +    name-rev' process on every execution of the test suite.
>
>          Note that this slightly changes the order of lines in the outpu=
t of
>          'git name-rev --all', usually swapping two lines every 35 lines=
 in
>     @@ Commit message
>
>          This patch is best viewed with '--ignore-all-space'.
>
>     +    [1] Early versions of this patch used a 'commit_list', resultin=
g in
>     +        ~15% performance penalty for 'git name-rev --all' in 'linux=
.git',
>     +        presumably because of the memory allocation and release for=
 each
>     +        insertion and removal. Using a LIFO 'prio_queue' has basica=
lly no
>     +        effect on performance.
>     +
>     +    [2] We prefer shorter names, i.e. 'v0.1~234' is preferred over
>     +        'v0.1^2~5', meaning that usually following the first parent=
 of a
>     +        merge results in the best name for its ancestors.  So when =
later
>     +        we follow the remaining parent(s) of a merge, and reach an =
already
>     +        named commit, then we usually find that we can't give that =
commit
>     +        a better name, and thus we don't have to visit any of its
>     +        ancestors again.
>     +
>     +        OTOH, if we were to follow the Nth parent of the merge firs=
t, then
>     +        the name of all its ancestors would include a corresponding=
 '^N'.
>     +        Those are not the best names for those commits, so when lat=
er we
>     +        reach an already named commit following the first parent of=
 that
>     +        merge, then we would have to update the name of that commit=
 and
>     +        the names of all of its ancestors as well.  Consequently, w=
e would
>     +        have to visit many commits several times, resulting in a
>     +        significant slowdown.
>     +
>          Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
>
>       ## builtin/name-rev.c ##
>     +@@
>     + #include "tag.h"
>     + #include "refs.h"
>     + #include "parse-options.h"
>     ++#include "prio-queue.h"
>     + #include "sha1-lookup.h"
>     + #include "commit-slab.h"
>     +
>      @@ builtin/name-rev.c: static struct rev_name *create_or_update_nam=
e(struct commit *commit,
>       		return NULL;
>       }
>     @@ builtin/name-rev.c: static struct rev_name *create_or_update_name=
(struct commit
>      -		parse_commit(parent);
>      -		if (parent->date < cutoff)
>      -			continue;
>     -+	struct commit_list *list =3D NULL;
>     ++	struct prio_queue queue;
>     ++	struct commit *commit;
>     ++	struct commit **parents_to_queue =3D NULL;
>     ++	size_t parents_to_queue_nr, parents_to_queue_alloc =3D 0;
>      +
>     -+	commit_list_insert(start_commit, &list);
>     ++	memset(&queue, 0, sizeof(queue)); /* Use the prio_queue as LIFO *=
/
>     ++	prio_queue_put(&queue, start_commit);
>      +
>     -+	while (list) {
>     -+		struct commit *commit =3D pop_commit(&list);
>     ++	while ((commit =3D prio_queue_get(&queue))) {
>      +		struct rev_name *name =3D get_commit_rev_name(commit);
>     -+		struct commit_list *parents, *new_parents =3D NULL;
>     -+		struct commit_list **last_new_parent =3D &new_parents;
>     ++		struct commit_list *parents;
>      +		int parent_number =3D 1;
>      +
>     ++		parents_to_queue_nr =3D 0;
>     ++
>      +		for (parents =3D commit->parents;
>      +				parents;
>      +				parents =3D parents->next, parent_number++) {
>     @@ builtin/name-rev.c: static struct rev_name *create_or_update_name=
(struct commit
>      -			distance =3D name->distance + 1;
>      +			if (create_or_update_name(parent, new_name, taggerdate,
>      +						  generation, distance,
>     -+						  from_tag))
>     -+				last_new_parent =3D commit_list_append(parent,
>     -+						  last_new_parent);
>     ++						  from_tag)) {
>     ++				ALLOC_GROW(parents_to_queue,
>     ++					   parents_to_queue_nr + 1,
>     ++					   parents_to_queue_alloc);
>     ++				parents_to_queue[parents_to_queue_nr] =3D parent;
>     ++				parents_to_queue_nr++;
>     ++			}
>       		}
>
>      -		if (create_or_update_name(parent, new_name, taggerdate,
>      -					  generation, distance,
>      -					  from_tag))
>      -			name_rev(parent, new_name, taggerdate, from_tag);
>     -+		*last_new_parent =3D list;
>     -+		list =3D new_parents;
>     ++		/* The first parent must come out first from the prio_queue */
>     ++		while (parents_to_queue_nr)
>     ++			prio_queue_put(&queue,
>     ++				       parents_to_queue[--parents_to_queue_nr]);
>       	}
>     ++
>     ++	clear_prio_queue(&queue);
>     ++	free(parents_to_queue);
>       }
>
>     + static int subpath_matches(const char *path, const char *filter)
>
>       ## t/t6120-describe.sh ##
>      @@ t/t6120-describe.sh: test_expect_success 'describe tag object' '
> 13:  1ef69550ca ! 13:  316f7af43c name-rev: cleanup name_ref()
>     @@ builtin/name-rev.c: static struct rev_name *create_or_update_name=
(struct commit
>      -		int from_tag)
>      +		int from_tag, int deref)
>       {
>     - 	struct commit_list *list =3D NULL;
>     + 	struct prio_queue queue;
>     + 	struct commit *commit;
>     + 	struct commit **parents_to_queue =3D NULL;
>     + 	size_t parents_to_queue_nr, parents_to_queue_alloc =3D 0;
>      +	char *to_free =3D NULL;
>      +
>      +	parse_commit(start_commit);
>     @@ builtin/name-rev.c: static struct rev_name *create_or_update_name=
(struct commit
>      +		return;
>      +	}
>
>     - 	commit_list_insert(start_commit, &list);
>     -
>     + 	memset(&queue, 0, sizeof(queue)); /* Use the prio_queue as LIFO *=
/
>     + 	prio_queue_put(&queue, start_commit);
>      @@ builtin/name-rev.c: static int name_ref(const char *path, const =
struct object_id *oid, int flags, vo
>       		if (taggerdate =3D=3D TIME_MAX)
>       			taggerdate =3D commit->date;
> 14:  9d513b3092 <  -:  ---------- name-rev: plug a memory leak in name_r=
ev()
> 15:  8489abb62e <  -:  ---------- name-rev: plug a memory leak in name_r=
ev() in the deref case
> --
> 2.24.0.388.gde53c094ea
>
>

--8323328-673742579-1573585953=:46--
