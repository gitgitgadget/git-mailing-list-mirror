From: Ingo Molnar <mingo@elte.hu>
Subject: Re: [irq/urgent]: created 3786fc7: "irq: make variable static"
Date: Wed, 22 Oct 2008 09:56:39 +0200
Message-ID: <20081022075639.GA1284@elte.hu>
References: <20081022061730.GA5749@elte.hu> <adf1fd3d0810220039g51d61e92l5ba254b57723d3b6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Santi =?iso-8859-1?Q?B=E9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Wed Oct 22 09:58:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KsYbe-0002ON-Uj
	for gcvg-git-2@gmane.org; Wed, 22 Oct 2008 09:58:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751771AbYJVH4u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Oct 2008 03:56:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752062AbYJVH4t
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Oct 2008 03:56:49 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:40675 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751529AbYJVH4r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Oct 2008 03:56:47 -0400
Received: from elvis.elte.hu ([157.181.1.14])
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1KsYaA-0006q8-Tq
	from <mingo@elte.hu>; Wed, 22 Oct 2008 09:56:45 +0200
Received: by elvis.elte.hu (Postfix, from userid 1004)
	id 335E43E21A3; Wed, 22 Oct 2008 09:56:38 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <adf1fd3d0810220039g51d61e92l5ba254b57723d3b6@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Received-SPF: neutral (mx3: 157.181.1.14 is neither permitted nor denied by domain of elte.hu) client-ip=157.181.1.14; envelope-from=mingo@elte.hu; helo=elvis.elte.hu;
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=BAYES_00,DNS_FROM_SECURITYSAGE autolearn=no SpamAssassin version=3.2.3
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
	0.0 DNS_FROM_SECURITYSAGE  RBL: Envelope sender in
	blackholes.securitysage.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98838>


* Santi B=E9jar <santi@agolina.net> wrote:

> > It would be a nice tool that makes it easy to check the proper=20
> > structure of topical branches, after the fact. Weird, incorrectly=20
> > queued up commits would stick out _immediately_:
> >
> >  34b3ede: [x86/xen]      sched: remove redundant code in cpu_cgroup=
_create()
> >
>=20
> If you still have the tip of the branches you want to know, you can
> get a similar output with:
>=20
> $ git log --pretty=3Doneline builtin-checkout.c | git name-rev --stdi=
n
> 828e32b82e3e2bb10d6d730d3abe505063b481f6 (remotes/origin/HEAD~17) Fix
> mismerge at cdb22c4 in builtin-checkout.c
> f285a2d7ed6548666989406de8f0e7233eb84368 (remotes/spearce/master~2)
> Replace calls to strbuf_init(&foo, 0) with STRBUF_INIT initializer
> 048f2762007d022defceb6850a44bc1bd5ccebf7 (remotes/spearce/master~24)
> do not segfault if make_cache_entry failed
>=20
> (sorry if it is refilled)

i didnt know about git name-rev, nice tool!

below is sample output from tip/master. Would there be a way to reforma=
t=20
it into a compact form, like:

d80f55f6: (master)          Merge branch 'tracing/urgent'
17d80fd0: (tracing/urgent)  tracing: create tracers menu

The most useful angle would be if git log --format had a way to print=20
the reverse name. Then i could do a git-log-line script like:

  git log --pretty=3Dformat:"%h: %20N %s" $@

where %N prints the reverse name.

While at it: it would be nice if git log had a way to crop string=20
output. For example i'd love to use:

  git log --pretty=3Dformat:"%h: %60s" $@

which would print out at most 60 characters from the first commit line.

That way i can see it properly on an 80 width terminal and can paste it=
=20
into email without linewraps, etc. But --pretty=3Dformat does not seem =
to=20
know width restrictions.

	Ingo

d80f55f6711ab57ac5f4e147f9782a7351847ec1 (master) Merge branch 'tracing=
/urgent'
17d80fd07d35ae1d231b3378ee4f00ace54f9d31 (tracing/urgent) tracing: crea=
te tracers menu
debfcaf93ed500a051489db6646d71f29fe86a68 (tracing/urgent~1) Merge branc=
h 'tracing/ftrace' into tracing/urgent
722fb95f2f57cdd4c6910675a7f342066ff131f7 (master~1) Merge branch 'traci=
ng/core'
d24fdbbb398764fccaec317d6e354a5111493940 (tracing/core) Merge branch 'l=
inus' into tracing/core
3e66b5d4a4c2265832d5e6fc0e36488fb1f06d84 (master~2) Merge branch 'kmemc=
heck'
22993cab5b465ad75fc17056141cf94ff57b4767 (master~3) Merge branch 'x86/u=
v'
b0f209898f1a177bd503d49215b8c6628797a81c (x86/uv) x86, uv: use consiste=
nt names for region size and conherence id on x86 and ia64
e811da01227ab5cf84aa616f1ce528533b6204f1 (master~4) Merge branch 'irq/u=
rgent'
e85cd2b2ced8e0643a2ca769552b6f6e0cbbb470 (master~5) Merge branch 'core/=
urgent'
a56d4858686da0c97086c93d3f50d4020405c02b (core/urgent) printk: make var=
iable static
3786fc710c32b61464c322e5cd0c3d1d34ae72d0 (irq/urgent) irq: make variabl=
e static
df4a3963c2f91586ff96f8962bccee4d14cb1100 (master~6) Merge branch 'x86/u=
rgent'
8bcad30f2e6d4c20f7e71d2e2ac77acc0f0931e5 (x86/urgent) x86: make variabl=
es static
eefa4b484d1678e11c16d17b7e2d9e10bbfc1c3e (remotes/origin/HEAD) Merge br=
anch 'out-of-tree'
50f971ad73ea9550b1d8e34006bd11c7e108b24f (out-of-tree) qa: disable jffs=
2 for now
c55c135163a1fb1869beefbce887c01fe50d31ed (remotes/origin/HEAD~1) range-=
hrtimers: merge timers/urgent
490bd253db3da535fb7e8129d8d648290d27206c (remotes/origin/HEAD~2) Merge =
branch 'timers/urgent'
aed24c813ce374751c0818be922c785ec9f83dea (remotes/origin/HEAD~3) NOHZ: =
restart tick device from irq_enter()
c4bd822e7b12a9008241d76db45b665f2fef180c (timers/urgent) NOHZ: fix thin=
ko in the timer restart code path
fca45353be469acb7f961fd3b2b244f400098a7d (kmemcheck) kmemcheck: documen=
t the shadow member of struct page
50987b4becd23c0716631602c36a1be5ed74576c (kmemcheck~1) kmemcheck: updat=
e Kconfig help text
f899dff87c5f03c8fc9145a9472b7e7f7173bbaa (kmemcheck~2) kmemcheck: updat=
e documentation
af3f8f7ec6d1a35c9a99a50e4faafdc18249412c (kmemcheck~3) kmemcheck: fix m=
is-merge in sysctl table
24a528ca7f1473368bf97c67a697227e57170a7f (remotes/origin/HEAD~4) Merge =
branch 'linus'
439bbef95d7987acb821954db8f8c858c6bf6246 (remotes/origin/HEAD~5) Merge =
branch 'tracing/urgent'
ed8491f0e2c3378e2a84ddf5bb2d60b2e7c04113 (remotes/origin/HEAD~5^2) ftra=
ce: fix section mismatch warning.
8b1c190e9605035b4efb1f3bc6684cbae9b87dda (remotes/origin/HEAD~6) Merge =
branch 'irq/urgent'
1bc1b5f7823035666d341b269dede4507b81a0bb (remotes/origin/HEAD~7) Merge =
branch 'core/urgent'
5f86515158ca86182c1dbecd546f1848121ba135 (core-fixes-for-linus) rcupdat=
e: fix bug of rcu_barrier*()
b6f3b7803a9231eddc36d0a2a6d2d8105ef89344 (auto-sparseirq-next) genirq: =
NULL struct irq_desc's member 'name' in dynamic_irq_cleanup()
e9f95e637320efe1936b647308ddf4ec5b8e0311 (auto-sparseirq-next~1) genirq=
: fix off by one and coding style
935ddf564701da409ca960bf2f54db528daa79a3 (remotes/origin/HEAD~8) Merge =
branch 'irq/urgent'
8ca7f02cdb97f1fe581768593ba2288a2d0fe32f (remotes/origin/HEAD~8^2) geni=
rq: fix off by one and coding style
be5272d9410fcbc57edbc9b2d212332ed9e76dff (remotes/origin/HEAD~9) Merge =
branch 'out-of-tree'
b6ec630b689e5f4694d8ea1f38798926a960dc2e (out-of-tree~1) net9p: work ar=
ound build breakage
11f46c9d6d27ab4d359bafa0b9df0cc5e1ba4a1d (remotes/origin/HEAD~10) Merge=
 branch 'x86/doc'
ff2904fb6daeefecb6f8c2c8c63ea41b833c1ded (remotes/origin/HEAD~10^2) Mer=
ge branch 'linus' into x86/doc
197ec4d0ce943259c11900aa0ee45cf4252d009a (remotes/origin/HEAD~11) Merge=
 branch 'out-of-tree'
ae4038719e87e6cf2f815aa735909b615abd9121 (out-of-tree~2) mm fix: Re: un=
able to handle kernel NULL pointer derefence at 00000000
a331daffa5dd61e29bbc50ef258753c325815f69 (remotes/origin/HEAD~12) Merge=
 branch 'x86/urgent'
27945ca30442e84d866735dde5cec3b0ba148d62 (remotes/origin/HEAD~13) Merge=
 branch 'x86/pci-ioapic-boot-irq-quirks'
ee2caf0cee7f09953630209d63434eadd97b3f8f (remotes/origin/HEAD~14) manua=
l merge of x86/doc
e523b1fdc81ba1aed0f9800e12d99a1c0f6fcd86 (remotes/origin/HEAD~15) Merge=
 branch 'x86/cleanups'
1a6e0823a6863b9312faf6aa42f9913d25c65f66 (remotes/origin/HEAD~16) Merge=
 branch 'warnings/simple'
d9067316e80df04a850e2cc6e92f43cb149700cc (remotes/origin/HEAD~17) Merge=
 branch 'warnings/infrastructure'
a3a2394fadfc13818182ab0f8bfdbbfd01e84b57 (remotes/origin/HEAD~18) Merge=
 branch 'warnings/complex'
64cf0f977c72dbe309a089439071c1d2714f6653 (remotes/origin/HEAD~19) Merge=
 branch 'warnings/bug'
5cbb06a3ff222d3ffe6fe57f6f490bee31ae83ee (remotes/origin/HEAD~20) Merge=
 branch 'tracing/urgent'
1c667db03bee74b1b25715a192f9b297761a9e00 (remotes/origin/HEAD~21) Merge=
 branch 'tracing/markers'
1aa708f1c974d338b4bce75eec7f77ef3b748171 (remotes/origin/HEAD~22) Merge=
 branch 'tracing/ftrace'
440c31d907ecdf4f7d7d213656e08f7a67e0c18d (remotes/origin/HEAD~23) Merge=
 branch 'tracing/core'
396cc143ac608aa82cdf2d942a3d00d2ac333db2 (remotes/origin/HEAD~24) Merge=
 branch 'timers/rtc'
22022cb8b6c8fdfe3cdc12f310203a28190f24de (remotes/origin/HEAD~25) manua=
l merge of timers/range-hrtimers
f908633285b8e73cff179a52bc4f73d3d9b565f5 (remotes/origin/HEAD~26) manua=
l merge of stackprotector
00f6c5901c6ac11c63b9057639756d3e4d2dc613 (remotes/origin/HEAD~27) Merge=
 branch 'sched/urgent'
d4d79dc6ad5d9f43038ad7c717866c8fcae0173e (remotes/origin/HEAD~28) Merge=
 branch 'safe-poison-pointers'
1552b31f9c6ee9e5e5cb92dea77e084aa13ff05a (remotes/origin/HEAD~29) Merge=
 branch 'oprofile'
1ef89f7f876568c2d15731ae5ee39d384deabb05 (remotes/origin/HEAD~30) manua=
l merge of kmemcheck-v2
1f92ca40e95515ee1f7685fb7049ecfc8c797ca0 (remotes/origin/HEAD~31) Merge=
 branch 'irq/urgent'
a16fc956cb5021500a8d02547a99488c894f1413 (remotes/origin/HEAD~32) Merge=
 branch 'irq/genirq-v3'
728b75cc6dfa6178bbbf20838eda60032a78fc2c (remotes/origin/HEAD~33) manua=
l merge of irq/genirq
61b15a6bddc8625b6beda35e2d923d2844f59b95 (remotes/origin/HEAD~34) manua=
l merge of cpus4096
62dd3c84287f6b59fe2f1e40c26a0d7e5d63516c (remotes/origin/HEAD~35) Merge=
 branch 'core/urgent'
0868e883d967ac6c54e35a817c23a40a603d7551 (remotes/origin/HEAD~36) Merge=
 branch 'core/percpu'
6eb9b1d2e751f3857229e48144fdc394ffaa6fe7 (remotes/origin/HEAD~37) Merge=
 branch 'core/locking'
f89beb7bc5eba16660141122b34d99fe89fe9c65 (remotes/origin/HEAD~38) Merge=
 branch 'core/futexes'
c483bd39bfcc57c931226955d4e83b71a4e01ce9 (remotes/origin/HEAD~39) Merge=
 branch 'core/debug'
75e7035e679c462c0c9c6a1cb0dc60fbcc58d3d4 (remotes/origin/HEAD~40) Rever=
t "NOHZ: restart tick device from irq_enter()"
39fc6adb39ea36f746b6c4137dc38012878ce02e (remotes/origin/HEAD~41) Merge=
 branch 'out-of-tree'
8422ac179506d38eb3f432809e806dd012581270 (out-of-tree~3) staging: fix p=
80211wext_event_associated() build failure
d9c32f25101f22574aa861cb7f3fe58ebdf52232 (out-of-tree~4) qa: cx88: disa=
ble for now
e63003c9ec406578631c6322346ca0e326d99d46 (out-of-tree~5) qa: always-ena=
ble CONFIG_FILE_LOCKING
0be9b16320ac42f968245e55383a5dd9238b9c39 (out-of-tree~6) pci: fix: BUG:=
 unable to handle kernel NULL pointer dereference, IP: pci_create_slot+=
0x28/0x170
d4d92fcc681f2a9b788fe228df1f9da3ef0cc111 (out-of-tree~7) dvb: disable d=
m1105
b56b096cb3b258eebc63ce36ba9ee332a1427d79 (out-of-tree~8) mfd: disable a=
nother driver
892cff77716a359fc2f6e159d846893d07bf11f4 (out-of-tree~9) drivers/mfd/Kc=
onfig: turn off broken driver
93e60b49d3df9f8bab5079e9e796bce3c604e3ed (out-of-tree~10) security: ini=
tialize skb->sk_security by default
3cdfa5c3b0e1d60925497ced0cf908a2f078732c (out-of-tree~11) rtx2x00: disa=
ble for now
c8d7def4258375d88f0b6f06cc6f10c3a514a285 (out-of-tree~12) drm: fix leak=
 of uninitialized data to userspace
17bc3f7bf083e754e5c6210eab7af9ce7ed02ebc (out-of-tree~13) Revert "Rever=
t parts of "x86: update mptable""
ac2716510df12c6fa0e6b99ebb4aa68584a1a751 (out-of-tree~14) pnp: Huge num=
ber of "io resource overlap" messages
ced6e773aa88b80b0c6b519a84f1e85ff15e3416 (out-of-tree~15) acpi: don't l=
oad acpi_cpufreq if acpi=3Doff
f6d62717fa9c6572f257720abac383a7ae5fdb62 (out-of-tree~16) wd.c: work ar=
ound broken build
1327b0cc9ad75c246f6e4198cf9c1731afda4146 (out-of-tree~17) net, wd.c: fi=
x undefined reference to `NS8390p_init'
75acfc78aa1a3ac46f473e39b8b294309f8a80c9 (out-of-tree~18) misdn: work a=
round build bug
81ba9c8488248a766f7151eba1664e9d93f49701 (out-of-tree~19) hp-plus.c: wo=
rk around build failure
70027001c8e97565fad148f371505f022eb1e779 (out-of-tree~20) USB: work aro=
und crash
985d392693af6bbd6bdabcad65d24edb3b64c4ed (out-of-tree~21) work around b=
uild breakage
18eed0ffd132f50660e7c1c16c48ec2af312de00 (out-of-tree~22) i2c: work aro=
und boot crash in amd756_s4882_init()
32347630cbf94685c4eaae6d645ba720a8b31d2b (out-of-tree~23) i2c workaroun=
d: turn off I2C_NFORCE2_S4985 for now
7120b52e90e1837e09bb4621f105022f940b856a (out-of-tree~24) work around t=
his crash for now:
3966803bcaa7a7b82ac05959c66ce12ea5953111 (out-of-tree~25) ACPI: don't w=
alk tables if ACPI was disabled
3ac23f215a2b1710ae7b4ee5569ddfe303386a4f (out-of-tree~26) ACPI, x86: di=
sable the C2C3_FFH access mode if MWAIT is unsupported
1d8d02e53965633d7465e4d3881365d5f114cfd9 (out-of-tree~27) x86: enable s=
peedstep for Intel Pentium M processor 7x0 [1.6-2.26 GHz] (Sonoma) proc=
essors
899b5030558b8dc21a171e2e8129e0a93fb08860 (out-of-tree~28) init: root mo=
unt fix
6894676b3486f75d8e0c0c777fa9d8bf883eec70 (out-of-tree~29) net: use numa=
_node in net_devcice->dev instead of parent
da684332e2dc25966ac39d0c57f21715db0eb80e (out-of-tree~30) tip: add -tip=
 tag
c267f4dff573d67eb9a8645b5045d971a0a3bc7b (warnings/complex) fix warning=
 in fs/ext4/extents.c
8501db35588df4f35d67d8ba207422006a214ae7 (warnings/complex~1) work arou=
nd warning in fs/xfs/xfs_rtalloc.c
7cf87ad9e9dc30304ec862b45156e93d2c255911 (warnings/complex~2) fix warni=
ng in drivers/net/mlx4/mcg.c
6e0ffadd6edcdc2bfc8a526a4f6f7644815fd1ed (warnings/complex~3) fix warni=
ng in drivers/net/mlx4/profile.c
faad95db248fffe94b691a9c8f9cd0193584633a (warnings/complex~4) fix warni=
ng in arch/x86/kernel/setup.c
4f4e11e8dce3f4d76f7196b2af7f8c28067f902b (warnings/complex~5) fix warni=
ng in drivers/isdn/i4l/isdn_ppp.c
4b9fa1a9927b4fec31c68b2d7d20384a01363b47 (warnings/complex~6) fix warni=
ng in arch/x86/kernel/early-quirks.c
159583619a768eb78ec81bf9ca96fa0096699083 (warnings/complex~7) fix warni=
ng in drivers/base/platform.c
bfbde60a78f6d467e41c557b44ec741d92ba61f0 (warnings/complex~8) fix warni=
ng in drivers/pci/pci-driver.c
6ddae344a73fcff60c840dd4e429bf55562b41f3 (warnings/complex~9)  #ifdef c=
omplications in drivers/acpi/sleep/main.c
4b57d6ee2dc9a1062521298ad2d87b24aa5d12e4 (warnings/complex~10) fix warn=
ing in net/ax25/sysctl_net_ax25.c
b5532a323def96dda020cc19d326c2d456b3befc (warnings/complex~11) fix warn=
ings in drivers/acpi/sbs.c
ec9e8767ceacedbac9a1ed60d815e9f37ea98a31 (warnings/complex~12) fix warn=
ing in sound/pci/cs46xx/cs46xx_lib.c
76a62692c3328c2870949b07ee10dff764701faf (warnings/complex~13) fix warn=
ing in net/sunrpc/xprtrdma/verbs.c
d41b73d05e0f4c99255e18de064adeac79e32af2 (warnings/complex~14) fix warn=
ing in net/bluetooth/rfcomm/sock.c
035aca6532256d0b5a31c7dfc989c3af223aae9e (warnings/complex~15) fix warn=
ing in drivers/video/matrox/matroxfb_crtc2.c
3e67d911f11fb73d716bffc6d056730ced7b9f11 (warnings/complex~16) fix warn=
ing in drivers/char/rtc.c
8f845313ba091a6041e666c611ef9bb751d91723 (warnings/complex~17) fix warn=
ing in ipc/ipc_sysctl.c
34483bdb925851a069c8ad32801a52382f3a6d31 (warnings/complex~18) fix warn=
ing in drivers/usb/misc/vstusb.c
98fa7e0f5af226c5343b5bcdd4c5435c120acd8e (warnings/complex~19) fix warn=
ing in drivers/message/fusion/mptbase.c
956ae9e7f7535aa15a9e5f2dce1c7dc0dada2be2 (warnings/complex~20) fix warn=
ing in kernel/profile.c
e698275468fae57af762b81dbc64fac09909e1ec (warnings/complex~21) fix warn=
ing in drivers/net/wireless/ray_cs.c
830ecfa8290ba6d332bd809b330977338190abbe (warnings/complex~22) fix warn=
ing in sound/pci/hda/patch_sigmatel.c
76b04a364261b872602ce73c659534b1cde1b7ae (warnings/complex~23) fix warn=
ing in drivers/scsi/advansys.c
2020ebad843222e5e965d1a76584da5737da1e89 (warnings/complex~24) fix warn=
ing in arch/x86/kernel/cpu/intel_cacheinfo.c
aca9c3a12781b0184be4d2bf4f906206394710db (warnings/complex~25) fix warn=
ing in drivers/isdn/i4l/isdn_common.c
d489f40fdffc0432a4deffa8c6b538c5d6c76990 (warnings/complex~26) fix warn=
ing in drivers/net/wan/syncppp.c
32a1ce224a376395351d534f5a3cdbf09a1bb0a8 (warnings/complex~27) fix warn=
ing in net/netfilter/nf_conntrack_proto_sctp.c
055231c21d70848060852892d63bb0ed1db22ac5 (warnings/complex~28) fix warn=
ing in net/netfilter/ipvs/ip_vs_ctl.c
2262c8b220ab3b07ae07775b7ccb676ed24ac5f6 (warnings/complex~29) fix warn=
ing in drivers/char/rocket.c
6f9fecb3d70400c5f99c1a1d09ffcce84483f611 (warnings/complex~30) fix warn=
ing in arch/x86/kernel/scx200_32.c
1fdf3e8b2702553b5c99cd57fd7445de3b976b9c (warnings/complex~31) fix warn=
ing in drivers/net/atlx/atl2.c
fa8e55eb6d126214b56c1291b6163bb698be094f (warnings/complex~32) include/=
linux/init.h: fix warning in drivers/crypto/hifn_795x.c
5a74eb70b93ead02290817d85f0064df833d429f (warnings/complex~33) fix warn=
ing in drivers/video/aty/atyfb_base.c, #2
cc499e1b8c2a2e4b6f2bfbfaea1bf14b3d8ca9ee (warnings/complex~34) fix warn=
ing in drivers/video/aty/atyfb_base.c
dee28be5adf98095ffba0681b9d50b5193530787 (warnings/complex~35) fix warn=
ing in fs/coda/sysctl.c
6bbf3e6297bfac50ab1f26c95dded0163a7f5351 (warnings/complex~36) fix warn=
ing in net/netfilter/nf_conntrack_proto_tcp.c
47ac1136e2314d7c65d65b114a17751728f61f93 (warnings/complex~37) fix warn=
ing in drivers/media/dvb/dvb-usb/anysee.c
d569696a616ac0ca0b440d84071f83e77b00f452 (warnings/complex~38) fix warn=
ing in drivers/net/wireless/iwlwifi/iwl-scan.c
15d50b15843ccea15667f0bff5eb54d389a445f9 (warnings/complex~39) lockdep:=
 include/linux/lockdep.h - fix warning in net/bluetooth/af_bluetooth.c
5a0d58611372742163d2727812f36527321abfe3 (warnings/complex~40) fix warn=
ing in drivers/watchdog/w83697ug_wdt.c
0faf3f9d4728e23b877279f3a239d8c9c59cd5dd (warnings/complex~41) fix warn=
ing in drivers/net/wireless/libertas_tf/if_usb.c
609d5948fd3f59132f48de6360fc46d0bbecd8a7 (warnings/complex~42) fix warn=
ing in drivers/mfd/ucb1400_core.c
8858ab02a18e82675cec3a99984767ef7445084f (warnings/complex~43) fix warn=
ing in drivers/scsi/dtc.c
129e100e56a451534307b800ece2cc9ffbfa0fae (warnings/complex~44) fix warn=
ing in drivers/isdn/sc/timer.c
a70d2056f7d297e2ae39b89d72e7a3b7734cfa9e (warnings/complex~45) fix warn=
ing in drivers/isdn/sc/ioctl.c
4646ee0cad4328de4d4c30f838dc27109b54dcd3 (warnings/complex~46) fix warn=
ing in drivers/net/depca.c
ca9a950c830f529766cc422a29c4822271eb5406 (warnings/complex~47) fix warn=
ing in drivers/net/3c523.c
2e4f5630f57f155cbd07771c3a305f48b991f90c (warnings/complex~48) fix warn=
ing in drivers/scsi/g_NCR5380.c
7f941db396f1fdc0e010916b5a613b5b7d522c14 (warnings/complex~49) fix warn=
ing in drivers/isdn/sc/shmem.c
cc2efdd1b01a3caa7ce93d301d9a3e23ea0457ee (warnings/complex~50) fix warn=
ing in drivers/mca/mca-legacy.c
24842fb0217e3cf2988de77830ae1adee295a167 (warnings/complex~51) fix warn=
ing in drivers/isdn/icn/icn.c
c85193d4a954684f4269c4ed4f6f7b391d63797e (warnings/complex~52) fix warn=
ing in drivers/infiniband/hw/amso1100/c2_vq.c
299711a947ae5f818fa5f3e3d2c4fe22466a03ca (warnings/complex~53) fix warn=
ing in drivers/input/touchscreen/htcpen.c
dd4c80c5dedf66d1840fc372a9f7418f32d138df (warnings/complex~54) fix warn=
ing in drivers/isdn/sc/init.c
ec5aa2f441bacc89b2e0e9e4971c6c9aa460942a (warnings/complex~55) fix warn=
ing in drivers/watchdog/i6300esb.c
ee5aa63192e5b545c0f89c84dbfdb5cc4deea113 (warnings/complex~56) fix warn=
ing in kernel/power/main.c
e16a7ed48454125ff97a644742398022f72321dd (warnings/complex~57) fix warn=
ing in fs/compat_binfmt_elf.c
606c6806381192653211492b07592df9430c7865 (warnings/complex~58) fix warn=
ing in drivers/pci/search.c
037abd9c198336c3aa9024de149e6b640877be2f (warnings/complex~59) fix warn=
ing in drivers/isdn/hardware/eicon/message.c
f72bccd1611f4dafd875e993cff5017a4a73ec6d (warnings/complex~60) warnings=
: disable i2o on 64bit
8077af8b47a9ec1c76997a9516f0335638ee51c0 (warnings/complex~61) warnings=
: fix xfs posix acl
0b3682ba33c59a362901b478bdab965da888b350 (auto-sparseirq-next~2) genirq=
: fix set_irq_type() when recording trigger type
2515ddc6db8eb49a79f0fe5e67ff09ac7c81eab4 (kmemcheck-v2) binfmt_elf_fdpi=
c: Update for cputime changes.
a50c22eed593f474e75f693381e4d42e81762de8 (kmemcheck-v2~1) mm: remove du=
plicated #include's
e798ba57e9f423dddbf1bdeb20a62bdd0593890f (kmemcheck-v2~2) Export tiny s=
hmem_file_setup for DRM-GEM
653c03168348ac7aebb969931f87ba281749d7dd (kmemcheck-v2~3) misc: replace=
 remaining __FUNCTION__ with __func__
e8848a170fd432bdda176a2d568919d4bba90467 (kmemcheck-v2~4) fix CONFIG_HI=
GHMEM compile error in drivers/gpu/drm/i915/i915_gem.c
f6f286f33e843862c559bfea9281318c4cdec6b0 (kmemcheck-v2~5) fix WARN() fo=
r PPC
5f41b8cdc6ef33b3432cee36264d628a80398362 (kmemcheck-v2~6) kexec: fix cr=
ash_save_vmcoreinfo_init build problem
e3d2f927f788adcdabc42f8a1616f6cc56c53bbe (kmemcheck-v2~7) Merge git://g=
it.kernel.org/pub/scm/linux/kernel/git/kyle/parisc-2.6
a9b6148d25f15ddfe9d7a7f3e526fdb64e7cf7da (auto-core-next-base) USB: Fix=
 unused label warnings in drivers/usb/host/ehci-hcd.c
9b7530cc329eb036cfa589930c270e85031f554c (auto-core-next-base~1) i915: =
cleanup coding horrors in i915_gem_gtt_pwrite()
1ae87786800b5e0411847974b211797b6ada63c4 (auto-core-next-base~2) Fix sp=
rintf format warnings in drm_proc.c
2bea2e4abf2fe8bc7384103aeaad91089109cfba (auto-core-next-base~3) Merge =
branch 'bkl-removal' of git://git.lwn.net/linux-2.6
a0bfb673dca8a2b4324fe11e678ec6d6a9ad67e0 (auto-core-next-base~4) Merge =
branch 'linux-next' of git://git.kernel.org/pub/scm/linux/kernel/git/jb=
arnes/pci-2.6
92b29b86fe2e183d44eb467e5e74a5f718ef2e43 (auto-core-next-base~5) Merge =
branch 'tracing-v28-for-linus' of git://git.kernel.org/pub/scm/linux/ke=
rnel/git/tip/linux-2.6-tip
b9d7ccf56be1ac77b71a284a1c0e6337f9a7aff0 (auto-core-next-base~6) Merge =
branch 'x86-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kern=
el/git/tip/linux-2.6-tip
9301975ec251bab1ad7cfcb84a688b26187e4e4a (auto-core-next-base~7) Merge =
branch 'genirq-v28-for-linus' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/tip/linux-2.6-tip
7110879cf2afbfb7af79675f5ff109e63d631c25 (auto-core-next-base~8) Merge =
branch 'core-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/tip/linux-2.6-tip
99ebcf8285df28f32fd2d1c19a7166e70f00309c (auto-core-next-base~9) Merge =
branch 'v28-timers-for-linus' of git://git.kernel.org/pub/scm/linux/ker=
nel/git/tip/linux-2.6-tip
72558dde738b06cc01e16b3247a9659ca739e22d (auto-core-next-base~10) Merge=
 git://git.kernel.org/pub/scm/linux/kernel/git/bart/ide-2.6
b91385236c00031c64b42b44db8068ad38a5ea11 (auto-core-next-base~11) Merge=
 branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/djbw/as=
ync_tx
d67ae206ef05198824c2a306c0c0edf2d2088920 (auto-core-next-base~12) Merge=
 git://git.kernel.org/pub/scm/linux/kernel/git/wim/linux-2.6-watchdog
1d9a8a47d659f053abeca9ece45651b4d94780c8 (auto-core-next-base~13) Merge=
 branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/ms=
zeredi/fuse
f07767fd0f95c385108fa4c456a9cb216a424fec (auto-core-next-base~14) byteo=
rder: remove direct includes of linux/byteorder/swab[b].h
f4432c5caec5fa95ea7eefd00f8e6cee17e2e023 (auto-core-next-base~15) Updat=
e email addresses.
6da0b38f4433fb0f24615449d7966471b6e5eae0 (auto-core-next-base~16) fs/Kc=
onfig: move ext2, ext3, ext4, JBD, JBD2 out
54b1d646d442289d8d49e04bc2f10ba122ff6aa4 (warnings/simple) sound/soc/co=
decs/tlv320aic23.c: remove unused variable
0be735b3ff71e13e24b82420f23a1b3b0a207ffb (warnings/simple~1) net/mac802=
11/rc80211_minstrel_debugfs.c: fix return type
04271505e03535e1fd085c96085fcee41e7c415f (warnings/simple~2) [vfs] fs.h=
: fops_get()/fops_put(): use pointer comparison
f81ee5ca545020daf0ddfff3744199b87bbd8c70 (warnings/simple~3) include/li=
nux/fs.h: improve type checking of __mandatory_lock()
5baf34fc63c31ef676e0a764415b10e5cc1c7a4b (warnings/simple~4) net/netlab=
el/netlabel_addrlist.c: add type checking to audit_log_format()
d58cbf52cb25e215c0e34048bda8ec481bdce4af (warnings/simple~5) fs/afs/dir=
=2Ec: fix uninitialized variable use
19be5d76a014ce0e743848a42cbb3b579c0ad8d7 (warnings/simple~6) drivers/vi=
deo/cirrusfb.c: remove unused variables
d138e44e2f8d0f26e04b0386d328d9cc7e33d82e (warnings/simple~7) drivers/ne=
t/wireless/b43/phy_g.c: type check debug printouts
f11adf3c65aff25074d5d3a90d72cdfc40d66b50 (warnings/simple~8) drivers/id=
e/pci/hpt366.c: remove unused variable
ecd05381e26b9a61e49fa485baea1595bd3d1b40 (warnings/simple~9) x86: fix d=
efault_spin_lock_flags() prototype
0d468300dc97d6aec084799ffe39253ac366f1e4 (auto-core-next-base~17) Remov=
e empty imacfb.c file
96499871f45b9126157b1a5c512d6e30f1635225 (auto-core-next-base~4^2) PCI:=
 fix pci_ioremap_bar() on s390
db7a6d8d01b21829d28638258cbbc9553210bac1 (auto-core-next-base~18) Updat=
e .gitignore files for generated targets
270c66be9b4a6f2be53ef3aec5dc8e7b07782ec9 (auto-core-next-base~4^2~1) PC=
I: fix AER capability check
0927678f55c9a50c296f7e6dae85e87b8236e155 (auto-core-next-base~4^2~2) PC=
I: use pci_find_ext_capability everywhere
1543c90c39360df333a21bfbbdfe812ae23b8167 (auto-core-next-base~4^2~3) PC=
I: remove #ifdef DEBUG around dev_dbg call
bd1d9855be3ab8a5c2b31053d464b7fe63e6963b (auto-core-next-base~4^2~4) PC=
I hotplug: fix get_##name return value problem
e5665a45fa28d0114f61b5d534a3b2678592219d (auto-core-next-base~4^2~5) PC=
I: document the pcie_aspm kernel parameter
aa42d7c6138afdc54f74e971456a0fbfec16b77b (auto-core-next-base~4^2~6) PC=
I: introduce an pci_ioremap(pdev, barnr) function
e9f82cb75096ae30658a72d473bf170bf4d3bb2e (auto-core-next-base~4^2~7) po=
werpc/PCI: Add legacy PCI access via sysfs
f19aeb1f3638b7bb4ca21eb361f004fac2bfe259 (auto-core-next-base~4^2~8) PC=
I: Add ability to mmap legacy_io on some platforms
f393d9b130423a7a47c751b26df07ceaa5dc76a9 (auto-core-next-base~4^2~9) PC=
I: probing debug message uniformization
58c3a727cb73b75a9104d295f096cca12959a5a5 (auto-core-next-base~4^2~10) P=
CI: support PCIe ARI capability
201de56eb22f1ff3f36804bc70cbff220b50f067 (auto-core-next-base~4^2~11) P=
CI: centralize the capabilities code in probe.c
280c73d3691fb182fa55b0160737c2c0feb79471 (auto-core-next-base~4^2~12) P=
CI: centralize the capabilities code in pci-sysfs.c
e354597cce8d219d135d65e585dc4f30323486b9 (auto-core-next-base~4^2~13) P=
CI: fix 64-vbit prefetchable memory resource BARs
557848c3c03ad1d1e66cb3b5b06698e3a9ebc33c (auto-core-next-base~4^2~14) P=
CI: replace cfg space size (256/4096) by macros.
022edd86d7c864bc8fadc3c8ac4e6a464472ab05 (auto-core-next-base~4^2~15) P=
CI: use resource_size() everywhere.
c322b28a04c084a467a862766f74c40c917a721c (auto-core-next-base~4^2~16) P=
CI: use same arg names in PCI_VDEVICE comment
5d9bc1fa47f0c1561f1d7c0bdff5e24860852b42 (auto-core-next-base~4^2~17) P=
CI hotplug: rpaphp: make debug var unique
c9bbb4abb658daf6cc6f92fb4751a7796a5aab75 (auto-core-next-base~4^2~18) P=
CI: use %pF instead of print_fn_descriptor_symbol() in quirks.c
c8761fe80ed052634153438405c9048611ae7ae1 (auto-core-next-base~4^2~19) P=
CI: fix hotplug get_##name return value problem
11d587429e9cbb40ac20d7ed8126c66da0d7aba5 (auto-core-next-base~4^2~20) P=
CI: fix sparse warning in pci_remove_behind_bridge
50cbfa511a21cac1909b6b4c955fa39d1da81457 (auto-core-next-base~4^2~21) P=
CI: fix MSI-HOWTO.txt info about MSI-X MMIO space
ec84f1268fcf16c4a852fdb38b3a541748644918 (auto-core-next-base~4^2~22) P=
CI: fix -Wakpm warnings in pci_pm_init debug output
cef354db0d7a7207ea78c716753d9216a9c2b7e1 (auto-core-next-base~4^2~23) P=
CI: connect struct pci_dev to struct pci_slot
93ff68a55aa92180a765d6c51c3303f6200167a6 (auto-core-next-base~4^2~24) P=
CI: make CPU list affinity visible
5993760f7fc75b77e4701f1e56dc84c0d6cf18d5 (auto-core-next-base~4^2~25) P=
CI: utilize calculated results when detecting MSI features
7f2feec140f1f1e4f701e013a2bf8284a9ec2a3c (auto-core-next-base~4^2~26) P=
CI: pciehp: replace printk with dev_printk
83e9ad540b9ee23919961f9500ca254220b78d09 (auto-core-next-base~4^2~27) P=
CI: pciehp: change name tag of "hpdriver_portdrv" variable
37a84ec668ba251ae02cf2c2c664baf6b247ae1f (auto-core-next-base~4^2~28) x=
86/PCI: irq and pci_ids patch for Intel Ibex Peak DeviceIDs
f7a10e32a1a7ae240fa3925c5727d224eba3e31d (auto-core-next-base~4^2~29) P=
CI: pciehp: fix irq initialization
c01156061bdd5976397dfb173f8c70ae351a6cb6 (auto-core-next-base~4^2~30) P=
CI: Document that most pci options are shared between i386 and x86-64
c9ed77eeba8ec2541a40918210bcc676acacd43a (auto-core-next-base~4^2~31) P=
CI: tidy PME support messages
2fd39aa7c2f3d696814abb3e8962c759eee484f3 (auto-core-next-base~4^2~32) P=
CI: ibmphp: list_for_each to list_for_each_entry-checkpatch cleanups
a8d2dbd38481e0c35c6bdd8196dd38a42ae45d02 (auto-core-next-base~4^2~33) P=
CI: ibmphp: list_for_each to list_for_each_entry
34a2e15e95fce6d6f4d30162f53a0ceb25d5bbaf (auto-core-next-base~4^2~34) P=
CI: follow lspci device/vendor style
d768cb6929773060171eee8397a63883f60ddc07 (auto-core-next-base~4^2~35) x=
86/PCI: follow lspci device/vendor style
16dbef4a831782466b10d4ae56837c5ba17d1948 (auto-core-next-base~4^2~36) P=
CI: change MSI-x vector to 32bit
0235c4fc7fc6f621dc0dd89eba102ad5aa373390 (auto-core-next-base~4^2~37) P=
CI PM: Introduce function pci_wake_from_d3
3d137310245e4cdc3e8c8ba1bea2e145a87ae8e3 (auto-core-next-base~4^2~38) P=
CI: allow quirks to be compiled out
b41d6cf38e27a940d998d989526a9748de1bf028 (auto-core-next-base~4^2~39) P=
CI: Check dynids driver_data value for validity
edbc25caaa492a82e19baa915f1f6b0a0db6554d (auto-core-next-base~4^2~40) P=
CI: remove dynids.use_driver_data
592b7a88564a2167a144265bf68df0123c0e4e98 (tmp.master.prev~2^2) doc/x86:=
 fix doc subdirs
921974982a7aab561a1c3ff1763af7470874ba8e (auto-core-next-base~19) Merge=
 branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dr=
zeus/mmc
7d67474e506598fe26e0c262acf02132dc730517 (auto-core-next-base~20) Merge=
 git://git.infradead.org/battery-2.6
252883e512c6d8fbc03b6738f1620fda44c4d472 (auto-core-next-base~21) epca:=
 Add infinite break support
