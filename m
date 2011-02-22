From: Justin Mattock <justinmattock@gmail.com>
Subject: gitk with the latest branch makes the system unusable for some time
Date: Tue, 22 Feb 2011 15:53:08 -0800
Message-ID: <AANLkTim3MW0PmD5_tra4nmRapfgHJ9K_usJWGVK3AOUC@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: linux-kernel-owner@vger.kernel.org Wed Feb 23 00:53:22 2011
Return-path: <linux-kernel-owner@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <linux-kernel-owner@vger.kernel.org>)
	id 1Ps22i-0003xf-HF
	for glk-linux-kernel-3@lo.gmane.org; Wed, 23 Feb 2011 00:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755390Ab1BVXxN (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 22 Feb 2011 18:53:13 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:65018 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629Ab1BVXxK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2011 18:53:10 -0500
Received: by wyg36 with SMTP id 36so340494wyg.19
        for <multiple recipients>; Tue, 22 Feb 2011 15:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=WJUR8HeJpkudIcRLteFLh3wJfsP7Wb1aI8J01VEWTww=;
        b=HjcXv9M+3pI7ppVebEdKv1fzZWCYRi6xkFubabhruW8ubtgzjCK6PbA3ImT8I3zNjg
         iKf9SBsHiIzliUZlra2I462c8DsHFPqQaLnMpITDVb1sxTF9eHcXOhtvycpA43A9KVxV
         hFZuhEjflPz5latQXpU/7Q1LFwVnl0eF4aOco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=bJtpTO2GIuxUFcpx1jo9X5ENrbkpErCjCNhdypYdwMTQo28O/wQoYFYQpftAHUuGpI
         OSS9xMgBHAN3XOnvjWEvoFgt87kHCVtC6K6XD4/YNKN+qaqHxolgkQvlMV7zKZPcpR5Y
         Ug9U7sBY7yH979sb7DIxOxVDgqR/GSCC76gFk=
Received: by 10.216.183.195 with SMTP id q45mr2883982wem.94.1298418788946;
 Tue, 22 Feb 2011 15:53:08 -0800 (PST)
Received: by 10.216.9.69 with HTTP; Tue, 22 Feb 2011 15:53:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167664>

not sure if there is any reports of this or not, basically using gitk
on my macbookpro2,2 makes the system extremely slow and unusable
(after a while can finally use the system)

in dmesg I am seeing this:

[ 6089.363045] NetworkManager invoked oom-killer: gfp_mask=0x84d0,
order=0, oom_adj=0, oom_score_adj=0
[ 6089.363050] Pid: 2107, comm: NetworkManager Not tainted
2.6.38-rc5-00101-gebad2c2 #2
[ 6089.363052] Call Trace:
[ 6089.363062]  [<ffffffff810c563c>] ? T.547+0x6a/0x180
[ 6089.363066]  [<ffffffff810c5799>] ? T.544+0x47/0x24c
[ 6089.363070]  [<ffffffff810c5beb>] ? out_of_memory+0x24d/0x2f8
[ 6089.363074]  [<ffffffff810c9142>] ? __alloc_pages_nodemask+0x55c/0x696
[ 6089.363079]  [<ffffffff810dc985>] ? handle_pte_fault+0x2cd/0x73f
[ 6089.363084]  [<ffffffff8104e522>] ? pte_alloc_one+0x1e/0x3c
[ 6089.363088]  [<ffffffff810c8406>] ? __free_pages+0x1b/0x24
[ 6089.363091]  [<ffffffff810ddfc1>] ? __pte_alloc+0x1d/0xcd
[ 6089.363094]  [<ffffffff810de185>] ? handle_mm_fault+0x114/0x164
[ 6089.363099]  [<ffffffff8144973d>] ? do_page_fault+0x3dc/0x401
[ 6089.363104]  [<ffffffff81112eef>] ? mntput_no_expire+0x8d/0x13f
[ 6089.363108]  [<ffffffff81112fc2>] ? mntput+0x21/0x23
[ 6089.363112]  [<ffffffff810fb8dc>] ? fput+0x20e/0x21d
[ 6089.363116]  [<ffffffff81446a25>] ? page_fault+0x25/0x30
[ 6089.363118] Mem-Info:
[ 6089.363120] DMA per-cpu:
[ 6089.363123] CPU    0: hi:    0, btch:   1 usd:   0
[ 6089.363125] CPU    1: hi:    0, btch:   1 usd:   0
[ 6089.363127] DMA32 per-cpu:
[ 6089.363129] CPU    0: hi:  186, btch:  31 usd:  61
[ 6089.363131] CPU    1: hi:  186, btch:  31 usd: 184
[ 6089.363137] active_anon:109412 inactive_anon:109516 isolated_anon:0
[ 6089.363138]  active_file:305 inactive_file:345 isolated_file:0
[ 6089.363139]  unevictable:5 dirty:0 writeback:0 unstable:0
[ 6089.363140]  free:1985 slab_reclaimable:2193 slab_unreclaimable:22201
[ 6089.363141]  mapped:451 shmem:130 pagetables:2902 bounce:0
[ 6089.363148] DMA free:3980kB min:60kB low:72kB high:88kB
active_anon:5728kB inactive_anon:5892kB active_file:64kB
inactive_file:156kB unevictable:0kB isolated(anon):0kB
isolated(file):0kB present:15684kB mlocked:0kB dirty:0kB writeback:0kB
mapped:88kB shmem:0kB slab_reclaimable:16kB slab_unreclaimable:40kB
kernel_stack:8kB pagetables:24kB unstable:0kB bounce:0kB
writeback_tmp:0kB pages_scanned:331 all_unreclaimable? yes
[ 6089.363154] lowmem_reserve[]: 0 978 978 978
[ 6089.363164] DMA32 free:3960kB min:3972kB low:4964kB high:5956kB
active_anon:431920kB inactive_anon:432172kB active_file:1156kB
inactive_file:1224kB unevictable:20kB isolated(anon):0kB
isolated(file):0kB present:1002436kB mlocked:20kB dirty:0kB
writeback:0kB mapped:1716kB shmem:520kB slab_reclaimable:8756kB
slab_unreclaimable:88764kB kernel_stack:1704kB pagetables:11584kB
unstable:0kB bounce:0kB writeback_tmp:0kB pages_scanned:3694
all_unreclaimable? yes
[ 6089.363169] lowmem_reserve[]: 0 0 0 0
[ 6089.363174] DMA: 3*4kB 2*8kB 3*16kB 2*32kB 2*64kB 1*128kB 2*256kB
0*512kB 1*1024kB 1*2048kB 0*4096kB = 3980kB
[ 6089.363184] DMA32: 593*4kB 5*8kB 2*16kB 1*32kB 0*64kB 0*128kB
0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 4012kB
[ 6089.363193] 4369 total pagecache pages
[ 6089.363195] 3566 pages in swap cache
[ 6089.363198] Swap cache stats: add 107816, delete 104250, find 2345/3361
[ 6089.363200] Free swap  = 0kB
[ 6089.363201] Total swap = 390620kB
[ 6089.367161] 258163 pages RAM
[ 6089.367164] 6164 pages reserved
[ 6089.367165] 2023 pages shared
[ 6089.367167] 248975 pages non-shared
[ 6089.367169] [ pid ]   uid  tgid total_vm      rss cpu oom_adj
oom_score_adj name
[ 6089.367181] [ 1111]     0  1111     4188        0   1     -17
  -1000 udevd
[ 6089.367186] [ 1944]     0  1944    60148        1   1       0
      0 gdm-binary
[ 6089.367190] [ 1963]     0  1963    37584        9   0       0
      0 nscd
[ 6089.367195] [ 1979]     0  1979    30571       90   0       0
      0 rsyslogd
[ 6089.367199] [ 1991]     0  1991     1015        0   1       0
      0 acpid
[ 6089.367203] [ 2030]     0  2030    68036        1   0       0
      0 gdm-binary
[ 6089.367208] [ 2034]     0  2034    60586      953   1       0             0 X
[ 6089.367212] [ 2052]  1000  2052     8162      213   1       0
      0 dbus-daemon
[ 6089.367216] [ 2061]     0  2061     5129        1   1       0
      0 bluetoothd
[ 6089.367221] [ 2081]     0  2081     8289       96   0       0
      0 pommed
[ 6089.367225] [ 2094]     0  2094     4758        0   1       0
      0 saslauthd
[ 6089.367230] [ 2096]     0  2096     4758        0   1       0
      0 saslauthd
[ 6089.367234] [ 2097]     0  2097     4758        0   1       0
      0 saslauthd
[ 6089.367238] [ 2098]     0  2098     4758        0   1       0
      0 saslauthd
[ 6089.367242] [ 2099]     0  2099     4758        0   1       0
      0 saslauthd
[ 6089.367246] [ 2107]     0  2107    36073      227   0       0
      0 NetworkManager
[ 6089.367251] [ 2117]     0  2117    29681        1   1       0
      0 polkitd
[ 6089.367255] [ 2282]     0  2282     4881        5   0       0
      0 fcron
[ 6089.367259] [ 2284]     0  2284     1016        1   1       0
      0 agetty
[ 6089.367263] [ 2285]     0  2285     1016        1   1       0
      0 agetty
[ 6089.367267] [ 2286]     0  2286     1016        1   0       0
      0 agetty
[ 6089.367271] [ 2287]     0  2287     1016        1   1       0
      0 agetty
[ 6089.367275] [ 2288]     0  2288     1016        1   0       0
      0 agetty
[ 6089.367279] [ 2289]     0  2289     1016        1   0       0
      0 agetty
[ 6089.367284] [ 2302]     0  2302     4752       81   0       0
      0 wpa_supplicant
[ 6089.367288] [ 2311]     0  2311     4187        1   1     -17
  -1000 udevd
[ 6089.367292] [ 2312]     0  2312     4187        1   1     -17
  -1000 udevd
[ 6089.367297] [ 2331]  1000  2331    15192        3   1       0
      0 gnome-keyring-d
[ 6089.367302] [ 2335]     0  2335    30630      111   0       0
      0 console-kit-dae
[ 6089.367306] [ 2400]  1000  2400     5587        1   1       0
      0 ck-launch-sessi
[ 6089.367310] [ 2421]  1000  2421     6620        0   1       0
      0 dbus-launch
[ 6089.367315] [ 2422]  1000  2422     8130      127   1       0
      0 dbus-daemon
[ 6089.367319] [ 2428]  1000  2428     5143       10   0       0
      0 ssh-agent
[ 6089.367323] [ 2433]  1000  2433    39977      126   0       0
      0 fluxbox
[ 6089.367327] [ 2435]  1000  2435    26496        0   0       0
      0 sh
[ 6089.367332] [ 2436]  1000  2436    88159      332   0       0
      0 gnome-power-man
[ 6089.367336] [ 2438]  1000  2438    87739      489   1       0
      0 nm-applet
[ 6089.367340] [ 2439]  1000  2439    62885        1   1       0
      0 bluetooth-apple
[ 6089.367344] [ 2440]  1000  2440    60223        1   0       0
      0 volumeicon
[ 6089.367349] [ 2441]  1000  2441   102547      228   0       0
      0 nautilus
[ 6089.367353] [ 2443]  1000  2443    37483        1   0       0
      0 bonobo-activati
[ 6089.367358] [ 2444]  1000  2444    64510        1   1       0
      0 gdu-notificatio
[ 6089.367362] [ 2445]  1000  2445    58787        1   1       0
      0 gpomme
[ 6089.367366] [ 2452]  1000  2452    34508      184   0       0
      0 gconfd-2
[ 6089.367370] [ 2485]  1000  2485    57853      176   0       0
      0 tint2
[ 6089.367374] [ 2487]     0  2487    29193       39   0       0
      0 udisks-daemon
[ 6089.367379] [ 2491]     0  2491    10659       41   0       0
      0 udisks-daemon
[ 6089.367383] [ 2495]  1000  2495    67536       72   0       0
      0 notify-osd
[ 6089.367387] [ 2498]     0  2498    30367      221   0       0
      0 upowerd
[ 6089.367391] [ 2501]  1000  2501    80849      113   0       0
      0 gnome-screensav
[ 6089.367396] [ 2515]  1000  2515    35044        1   1       0
      0 gnome-keyring-d
[ 6089.367400] [ 2549]  1000  2549    37880       74   0       0
      0 xterm
[ 6089.367404] [ 2550]  1000  2550    26617        1   1       0
      0 bash
[ 6089.367408] [ 2576]     0  2576     3140        1   0       0
      0 dhclient
[ 6089.367412] [ 2584]  1000  2584    70265      420   0       0
      0 mplayer
[ 6089.367417] [ 2589]  1000  2589    70068      130   1       0
      0 mplayer
[ 6089.367421] [ 2590]  1000  2590   103253      723   0       0
      0 pidgin
[ 6089.367426] [ 2592]  1000  2592    39233       46   0       0
      0 xterm
[ 6089.367430] [ 2593]  1000  2593    26616        1   1       0
      0 bash
[ 6089.367435] [ 2717]  1000  2717   326078   204267   0       0
      0 wish
[ 6089.367439] [ 2729]  1000  2729   141207     7349   0       0
      0 git
[ 6089.367444] Out of memory: Kill process 2717 (wish) score 802 or
sacrifice child

maybe I need to get a more updated system with more memory or something...
full dmesg is here:
http://fpaste.org/6yDn/

-- 
Justin P. Mattock
