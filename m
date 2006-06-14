From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: oprofile on svn import
Date: Tue, 13 Jun 2006 22:32:53 -0400
Message-ID: <9e4733910606131932w362c6ddcx5bf36ea5591feba1@mail.gmail.com>
References: <9e4733910606131810ya6aa585m5d2349f651b01492@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Wed Jun 14 04:33:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FqLBi-0000YK-LZ
	for gcvg-git@gmane.org; Wed, 14 Jun 2006 04:32:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964941AbWFNCcz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Jun 2006 22:32:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbWFNCcz
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jun 2006 22:32:55 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:10113 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S964941AbWFNCcy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jun 2006 22:32:54 -0400
Received: by nz-out-0102.google.com with SMTP id s18so38373nze
        for <git@vger.kernel.org>; Tue, 13 Jun 2006 19:32:54 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=eGfns/Ed7mnYHAJlJ3aLNZR9MUCkKbHQMHkDKtUDz7rjU2UIvi6GNYAR0lBnXr+LEKOIHxjTsGS0eOrUe3yPciJy9/kzCSVxBuH+vjFMMTf12ekoC9XY57nr6crFKZ5gLHipdNRBGakOzvsiI5WChcE8aXykEGXgpU7vDdAOVX8=
Received: by 10.37.15.20 with SMTP id s20mr218385nzi;
        Tue, 13 Jun 2006 19:32:53 -0700 (PDT)
Received: by 10.36.36.7 with HTTP; Tue, 13 Jun 2006 19:32:53 -0700 (PDT)
To: git <git@vger.kernel.org>
In-Reply-To: <9e4733910606131810ya6aa585m5d2349f651b01492@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21823>

>From the previous data it is obvious that I had slab debugging
enabled. I usally never notice having it turned on but in this case it
make a lot of difference.

New numbers without slab debug. Could forking off the git tasks be
causing all of this vm load?

[root@jonsmirl jonsmirl]# vmstat 10
procs -----------memory---------- ---swap-- -----io---- --system--
-----cpu------
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us
sy id wa st
 2  0      0  13504  91220 563280    0    0   299   232  244   426 23
18 53  6  0
 2  0      0  10900  91344 565128    0    0   169   464  481   737 26
23 48  2  0
 2  0      0  10804  91436 564832    0    0   196   650  478   780 25
24 49  3  0
 4  0      0  13516  91512 561696    0    0   166   612  474   790 26
23 49  2  0
 1  0      0  10928  91632 563548    0    0   124   471  464   789 24
25 48  2  0
 1  0      0  12312  91684 562000    0    0   179   688  472   783 26
23 48  3  0
 1  0      0  13232  91748 560712    0    0    51   198  445   794 25
26 48  1  0

  9951967 44.5102 /home/good/vmlinux
  3192131 14.2768 /lib/libcrypto.so.0.9.8a
  2207857  9.8747 /lib/libc-2.4.so
  1587518  7.1002 /usr/lib/libz.so.1.2.3
   663114  2.9658 /usr/lib/perl5/5.8.8/i386-linux-thread-multi/CORE/libperl.so
   517463  2.3144 /lib/ld-2.4.so
   435100  1.9460 /usr/lib/libapr-1.so.0.2.2
   430292  1.9245 /usr/local/bin/git-update-index
   285157  1.2754 /usr/local/bin/git-read-tree

2331728  22.8834  copy_page_range
1076769  10.5673  unmap_vmas
667975    6.5555  page_remove_rmap
663844    6.5149  page_fault
654668    6.4249  release_pages
440547    4.3235  get_page_from_freelist
245142    2.4058  do_wp_page
174656    1.7141  vm_normal_page
155185    1.5230  __handle_mm_fault
133584    1.3110  do_page_fault
131456    1.2901  __d_lookup
94194     0.9244  __link_path_walk
92927     0.9120  flush_tlb_page
91775     0.9007  find_get_page
85927     0.8433  copy_process


-- 
Jon Smirl
jonsmirl@gmail.com
