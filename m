From: Stephen Hemminger <shemminger@vyatta.com>
Subject: Re: Submodules and rewind
Date: Tue, 19 Feb 2008 16:15:17 -0800
Organization: Vyatta
Message-ID: <20080219161517.34fd5878@extreme>
References: <20080219140604.04afc91f@extreme>
	<20080219223201.GE4703MdfPADPa@greensroom.kotnet.org>
	<20080219152357.5ab397cf@extreme>
	<alpine.LSU.1.00.0802200033530.8333@wbgn129.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: skimo@liacs.nl, skimo@kotnet.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 20 01:16:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRcdK-0003sq-Mq
	for gcvg-git-2@gmane.org; Wed, 20 Feb 2008 01:16:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763498AbYBTAPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 19:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763749AbYBTAP3
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 19:15:29 -0500
Received: from mail.vyatta.com ([216.93.170.194]:45922 "EHLO mail.vyatta.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763662AbYBTAPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 19:15:25 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.vyatta.com (Postfix) with ESMTP id 1FCDE4F8054;
	Tue, 19 Feb 2008 16:15:25 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.329
X-Spam-Level: 
X-Spam-Status: No, score=-2.329 tagged_above=-10 required=5 tests=[AWL=0.170,
	BAYES_00=-2.599, RDNS_DYNAMIC=0.1]
Received: from mail.vyatta.com ([127.0.0.1])
	by localhost (mail.vyatta.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RFSAtMC844Jm; Tue, 19 Feb 2008 16:15:21 -0800 (PST)
Received: from extreme (75-175-36-117.ptld.qwest.net [75.175.36.117])
	by mail.vyatta.com (Postfix) with ESMTP id 58C1C4F8051;
	Tue, 19 Feb 2008 16:15:20 -0800 (PST)
In-Reply-To: <alpine.LSU.1.00.0802200033530.8333@wbgn129.biozentrum.uni-wuerzburg.de>
X-Mailer: Claws Mail 3.3.0 (GTK+ 2.12.8; x86_64-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74484>

On Wed, 20 Feb 2008 00:35:33 +0100 (CET)
Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Tue, 19 Feb 2008, Stephen Hemminger wrote:
> 
> > On Tue, 19 Feb 2008 23:32:01 +0100
> > Sven Verdoolaege <skimo@kotnet.org> wrote:
> > 
> > > On Tue, Feb 19, 2008 at 02:06:04PM -0800, Stephen Hemminger wrote:
> > > > Because of a bone headed merge, I had to rewind one project back
> > > > to a known good state, but the sub module stuff is now wedged and
> > > > brain stuck on the old commit id.
> > > > 
> > > > Isn't there some simple way to do 'git sub-module remove' followed
> > > > by 'git sub-module add' to reset the internal index?
> > > 
> > > Why doesn't "git submodule update" work for you?
> > > 
> > 
> > It didn't fix it, but recloning did.
> 
> That does not make sense.  But with your reluctance with regards to 
> revealing details, it is really impossible to tell what is going on.
> 
> For example, you did not even once give us the output of "git submodule", 
> let alone "git diff <submodule>".
> 
> Helpless,
> Dscho
> 

Don't be stupid, I am not trying be obstreperous, just fix the problem.
Git still seems to be confused.


In old repository
$ git-submodule update
...
Getting pack list for http://git.vyatta.com/home/shemminger/vyatta-iproute/.git/
error: The requested URL returned error: 403
error: Unable to find 8d971aff46015fc156d5b74254d21831d275963c under http://git.vyatta.com/vyatta-iproute.git
Cannot obtain needed object 8d971aff46015fc156d5b74254d21831d275963c
Unable to checkout '79b4dbe51b84fdf37fdc9cb8b17819526508a60c' in submodule path 'pkgs/vyatta-iproute'

$ git-submodule status
 534f70f14ff2883cb6af5f099dd07aa98ee7d49c pkgs/linux-image-2.6.23-1-486-vyatta (debian/2.6.23-1-vyatta-1-328-g534f70f)
 11a4d8b96c3e0d9a01f1da744b5cd5590d89a08b pkgs/ppp (debian/2.4.4rel-8-vyatta-2-5-g11a4d8b)
 fb69c50e9cd04d7d9c591dd21430fef3c27087ec pkgs/vyatta-bash (debian/3.1dfsg-8-vyatta-1-3-gfb69c50)
 5e3f42d5aaba08a096744dbf9a24f7ab60d91b8f pkgs/vyatta-cfg (debian/0.1-44-g5e3f42d)
 c4a3e7239c8265b6dba6ef0b4f6a9d22abf6bc30 pkgs/vyatta-cfg-dhcp-relay (undefined)
 4416f58963a81e141b579615b7a0a6d5b6872504 pkgs/vyatta-cfg-dhcp-server (undefined)
 a7ffca8e534152373b3edde31ab8b40e54e0c198 pkgs/vyatta-cfg-firewall (debian/0.1-11-ga7ffca8)
 cc8f0c344c353b8d283b0c85b02d83d89e0ab84c pkgs/vyatta-cfg-op-pppoe (debian/0.1-14-gcc8f0c3)
 93ef17574ac5fa8f41561d081914faa698e904b6 pkgs/vyatta-cfg-qos (undefined)
 c45db01927f0d3e41f8f90f3c136f9c49a9aa680 pkgs/vyatta-cfg-quagga (debian/0.1-15-gc45db01)
 e80b62c1a078cad0324074f23560c5126b5bc980 pkgs/vyatta-cfg-system (debian/0.1-21-ge80b62c)
 45b1f46e45a26af4154766be9c472dcf77845057 pkgs/vyatta-cfg-vpn (debian/0.1-3-g45b1f46)
 e4105d088ddda49c4d5c2b88ee81daa793e24204 pkgs/vyatta-cluster (undefined)
 aa324edcfbfba16e22e548758c50e1e827d76030 pkgs/vyatta-config-migrate (debian/0.1-1-gaa324ed)
 a77cbb06f22523b30e822b63e559d53ffbe74af3 pkgs/vyatta-dhcp3-client (undefined)
error: missing object referenced by '79b4dbe51b84fdf37fdc9cb8b17819526508a60c'
Could not get commit for 79b4dbe51b84fdf37fdc9cb8b17819526508a60c. Skipping.
+dbc430424431b1cac560bb3d55e3e7c665e7cd2f pkgs/vyatta-iproute (ss-060323-193-gdbc4304)
error: missing object referenced by 'ec188eedeb370b4433a0bdb5b958f72588894fc7'
Could not get commit for ec188eedeb370b4433a0bdb5b958f72588894fc7. Skipping.
+21b09233076a75bed7cd31177a5f52af40f572f9 pkgs/vyatta-nat (undefined)
error: missing object referenced by 'a3821ddc43821483a9205efa0308f74f9c05a9aa'
Could not get commit for a3821ddc43821483a9205efa0308f74f9c05a9aa. Skipping.
+4647ef1a3a84880cc7a52d2bf74163d7e470b150 pkgs/vyatta-op (undefined)
 e75f61815dccefd242b91e36fea998cc118f3545 pkgs/vyatta-op-dhcp-server (undefined)
error: missing object referenced by 'e51bc73ce7b196e0bf02c41faa33237dc2dd138e'
Could not get commit for e51bc73ce7b196e0bf02c41faa33237dc2dd138e. Skipping.
+17fd3bf4548804e1442eb0f1d12932d1dfd37cb9 pkgs/vyatta-op-firewall (undefined)
 602e5b01035bbad2257377581c314e4005e42bb9 pkgs/vyatta-op-qos (undefined)
error: missing object referenced by '4ab57750932087042d8dfb63ddd7fc427e323373'
Could not get commit for 4ab57750932087042d8dfb63ddd7fc427e323373. Skipping.
+79c17af437631e32421a8ad2e417470a80bd22fc pkgs/vyatta-op-quagga (undefined)
error: missing object referenced by '84fe6d4b1e8fe5c8b9530f13bfcf2167ada322d1'
Could not get commit for 84fe6d4b1e8fe5c8b9530f13bfcf2167ada322d1. Skipping.
+97181aa77c9a37607947373e3c426d70fcbc8abb pkgs/vyatta-op-vpn (undefined)
 4e7b642aedc56da1a777860f7e7440f8ad7db790 pkgs/vyatta-op-xml (undefined)
error: missing object referenced by 'eedab9a7b0e17f70e5cbe1fe6d67bc8aea6efcb7'
Could not get commit for eedab9a7b0e17f70e5cbe1fe6d67bc8aea6efcb7. Skipping.
+3886503c112d89cca1b530435b12012358f1a94f pkgs/vyatta-quagga (debian/0.99.9-69-g3886503)
 77183228077879e38470710874be280c020d2900 pkgs/vyatta-ravpn (undefined)
error: missing object referenced by '54feb46fdaa2011d69549548d4518035e6b82d6e'
Could not get commit for 54feb46fdaa2011d69549548d4518035e6b82d6e. Skipping.
+49bc33a55760bb31b768d0c182d9e8a81d9403f0 pkgs/vyatta-serial (undefined)
-12ed87465010a4faea1a037053379ded7f006640 pkgs/vyatta-wanloadbalance
 d998b4c64db221606353dc852166a02c7aeb35a6 pkgs/wanpipe (vyatta-wanpipe_beta13d-2.3.4-96-gd998b4c)

------------------
new repository

$ git clone http://git.vyatta.com/build-iso.git
...

$ git branch --track glendale origin/glendale
Branch glendale set up to track remote branch refs/remotes/origin/glendale.
$ git checkout glendale
Switched to branch "glendale"
 
$ git-submodule init
Submodule 'pkgs/linux-image-2.6.23-1-486-vyatta' (http://git.vyatta.com/linux-vyatta.git) registered for path 'pkgs/linux-image-2.6.23-1-486-vyatta'
Submodule 'pkgs/ppp' (http://git.vyatta.com/ppp.git) registered for path 'pkgs/ppp'
Submodule 'pkgs/vyatta-bash' (http://git.vyatta.com/vyatta-bash.git) registered for path 'pkgs/vyatta-bash'
Submodule 'pkgs/vyatta-cfg' (http://git.vyatta.com/vyatta-cfg.git) registered for path 'pkgs/vyatta-cfg'
Submodule 'pkgs/vyatta-cfg-dhcp-relay' (http://git.vyatta.com/vyatta-cfg-dhcp-relay.git) registered for path 'pkgs/vyatta-cfg-dhcp-relay'
Submodule 'pkgs/vyatta-cfg-dhcp-server' (http://git.vyatta.com/vyatta-cfg-dhcp-server.git) registered for path 'pkgs/vyatta-cfg-dhcp-server'
Submodule 'pkgs/vyatta-cfg-firewall' (http://git.vyatta.com/vyatta-cfg-firewall.git) registered for path 'pkgs/vyatta-cfg-firewall'
Submodule 'pkgs/vyatta-cfg-op-pppoe' (http://git.vyatta.com/vyatta-cfg-op-pppoe.git) registered for path 'pkgs/vyatta-cfg-op-pppoe'
Submodule 'pkgs/vyatta-cfg-qos' (http://git.vyatta.com/vyatta-cfg-qos.git) registered for path 'pkgs/vyatta-cfg-qos'
Submodule 'pkgs/vyatta-cfg-quagga' (http://git.vyatta.com/vyatta-cfg-quagga.git) registered for path 'pkgs/vyatta-cfg-quagga'
Submodule 'pkgs/vyatta-cfg-system' (http://git.vyatta.com/vyatta-cfg-system.git) registered for path 'pkgs/vyatta-cfg-system'
Submodule 'pkgs/vyatta-cfg-vpn' (http://git.vyatta.com/vyatta-cfg-vpn.git) registered for path 'pkgs/vyatta-cfg-vpn'
Submodule 'pkgs/vyatta-cluster' (http://git.vyatta.com/vyatta-cluster.git) registered for path 'pkgs/vyatta-cluster'
Submodule 'pkgs/vyatta-config-migrate' (http://git.vyatta.com/vyatta-config-migrate.git) registered for path 'pkgs/vyatta-config-migrate'
Submodule 'pkgs/vyatta-dhcp3-client' (http://git.vyatta.com/vyatta-dhcp3.git) registered for path 'pkgs/vyatta-dhcp3-client'
Submodule 'pkgs/vyatta-iproute' (http://git.vyatta.com/vyatta-iproute.git) registered for path 'pkgs/vyatta-iproute'
Submodule 'pkgs/vyatta-nat' (http://git.vyatta.com/vyatta-nat.git) registered for path 'pkgs/vyatta-nat'
Submodule 'pkgs/vyatta-op' (http://git.vyatta.com/vyatta-op.git) registered for path 'pkgs/vyatta-op'
Submodule 'pkgs/vyatta-op-dhcp-server' (http://git.vyatta.com/vyatta-op-dhcp-server.git) registered for path 'pkgs/vyatta-op-dhcp-server'
Submodule 'pkgs/vyatta-op-firewall' (http://git.vyatta.com/vyatta-op-firewall.git) registered for path 'pkgs/vyatta-op-firewall'
Submodule 'pkgs/vyatta-op-qos' (http://git.vyatta.com/vyatta-op-qos.git) registered for path 'pkgs/vyatta-op-qos'
Submodule 'pkgs/vyatta-op-quagga' (http://git.vyatta.com/vyatta-op-quagga.git) registered for path 'pkgs/vyatta-op-quagga'
Submodule 'pkgs/vyatta-op-vpn' (http://git.vyatta.com/vyatta-op-vpn.git) registered for path 'pkgs/vyatta-op-vpn'
Submodule 'pkgs/vyatta-op-xml' (http://git.vyatta.com/vyatta-op-xml.git) registered for path 'pkgs/vyatta-op-xml'
Submodule 'pkgs/vyatta-quagga' (http://git.vyatta.com/vyatta-quagga.git) registered for path 'pkgs/vyatta-quagga'
Submodule 'pkgs/vyatta-ravpn' (http://git.vyatta.com/vyatta-ravpn.git) registered for path 'pkgs/vyatta-ravpn'
Submodule 'pkgs/vyatta-serial' (http://git.vyatta.com/vyatta-serial.git) registered for path 'pkgs/vyatta-serial'
Submodule 'pkgs/vyatta-wanloadbalance' (http://git.vyatta.com/vyatta-wanloadbalance.git) registered for path 'pkgs/vyatta-wanloadbalance'
Submodule 'pkgs/wanpipe' (http://git.vyatta.com/wanpipe.git) registered for path 'pkgs/wanpipe'

$ git-submodule update
Initialized empty Git repository in /home/shemminger/vyatta/build-iso/pkgs/linux-image-2.6.23-1-486-vyatta/.git/
got 28633ef6895b371eab2c9149c85f0d7cf60315e1
walk 28633ef6895b371eab2c9149c85f0d7cf60315e1
got aa5dc401acc9c3cb20b78c34a3e5551f489b2b39
Getting alternates list for http://git.vyatta.com/linux-vyatta.git
Getting pack list for http://git.vyatta.com/linux-vyatta.git
Getting index for pack 2654a63e45bdc6324faa5b532e707a996e73615f
got 64d5441768fa1fced38e02713a84d539c86b0779
Getting pack 2654a63e45bdc6324faa5b532e707a996e73615f
 which contains 534f70f14ff2883cb6af5f099dd07aa98ee7d49c
...
walk e13559d7b6a386f8d7e1afaff4fe5b64da7297a8
walk 77f0136069ca2c4040fe7782ee87089dc11f086b
walk 9918f96c8aa7da45f27594f372c28d7f6e720e73
walk bf65dc7681eb22bbf52a413d2c694e3c0bf5b06c
walk e32e0645b5fe0a3c6427f8cddc75318e9acc9e36
walk 947f442fc870aeb2c31f016c002d2d48ea1f2552
walk a35625b08aa22b0fd9cbd92d72af6d9d7dc49b56
walk 8406bb6bd1c288ad30f4e67cff106b34b2c4d578
walk 82d29738bd169b47611aa0247516e2f7569f6471
walk 8e96d1f6674c3649aa2c8266352f9909ed011b81
walk 86fc4e7801919a1da123f34500218a69a30c2059
Fetching refs/heads/glendale from http://git.vyatta.com/vyatta-cfg-qos.git using http
Fetching refs/heads/master from http://git.vyatta.com/vyatta-cfg-qos.git using http
Submodule path 'pkgs/vyatta-cfg-qos': checked out '93ef17574ac5fa8f41561d081914faa698e904b6'
Initialized empty Git repository in /home/shemminger/vyatta/build-iso/pkgs/vyatta-cfg-quagga/.git/
got 0c60d4dada93f768bf32723daf9acb8814d51e32
walk 0c60d4dada93f768bf32723daf9acb8814d51e32
got 775333cef345fb27b425c568eebcd9a1ac170702
got c45db01927f0d3e41f8f90f3c136f9c49a9aa680
Getting alternates list for http://git.vyatta.com/vyatta-cfg-quagga.git
walk c45db01927f0d3e41f8f90f3c136f9c49a9aa680
Getting pack list for http://git.vyatta.com/vyatta-cfg-quagga.git
Getting index for pack 98a007c890953954ec64999b87d188ac159600ce
got e368bf6b32a6cb49152465072d2b249c8d05919b
got 954f38082e21c7a2f1ff84f366360e36e9e11682
Getting pack 98a007c890953954ec64999b87d188ac159600ce
 which contains 2093aa57209177af47e489ed6b5148be99f1641c
walk 10d43bf594c7619a9e6ba02db2906b2e87644a00
got b6ece88469efbe532022ed82499b1181cf3c17f0
got 897577e2414a7812a62f5a9eaf949ac4329faa4c
walk c77f48254bb13fb6aa6bf38f2f4462626c779c84
got 4726737c905cc76e98838c3066d0e3cd921df371
got d6881c2c53ba4a8274db502939eede57a0505955
got 3d1f90a4baee16034a572d258dcd236d5d56ec42
walk 82335ed71c664d4b6225d1e81e7b6f17fb701663
got deee40826e0ba3e42bf2495bee9c9da2947fb2c6
got f05c5c454bfaec10a7b4f2cb2bf2f3441ab1ff56
walk b0c1f8565931400f9fa3f67bb23bef93576901cd
got e0d5cb6a6e69a96fa0683cacfc99bf6532adb113
got d58f35244aa87e46f5d19e956ea1358ee91ab52e
walk f5f8f70341e08a3c972c90cd52a1f1ef8fdd0495
got 3df399a4c01a0297bc5b8bdd1413711ae9982be9
got 9a39a6feca68de6185c144cf2e76fed396b1ac4f
walk 026280d9c1dd53425fc43b8945700d92c6fc2f0c
got c519b5ce42d4630f2300810949941102c9139e6c
walk bfc47df97acb41cd4c7acbd7a4b1c46f258acd36
got b91bfff7e43735375ed65eb2fd928bcb82d90c02
walk be79857b1dbf5bd9a66e685b6aff8aa1bf778b04
walk a566e4c18da64a05ef79e9b044ac3b1c5a1ba959
walk 454891904e38dedca6e2c5f8a6fdf95809e46c21
walk 53057a160296792e2c0f1151f42aac5fcba0c760
walk cd50a751d1480424cdf103fd748b514330029c24
walk c51dae6826ea505169fca5b0cb0a580bf99c18cf
walk 59d1a583a01f6edce471bb0781d386b370f13b41
walk 1b52729976a4520c2beb6db7ffc622dd57d5fe68
walk 48ee3c96852c6697259919da82e3eabfd6becb6e
walk 399b6c33726392e9cc7272812e0c61e59a310314
walk bb07b74caf1d98e51ec4a6bff130fbd48ad5f0db
walk 257510b24684243bf1358e455c067a2e824b97f9
walk ce32d73e40ef3d1c4820d4b898daf3e432d7b692
walk fca1739f1985c2ba8d6316b1882365f5e26245cd
walk 78124a9754efe0bda1d9c827c593c5e0635fec3c
walk 74acf758d9059cf9832403da644c4f8eb088563e
walk 3add3da42dd4a84329f424d8d0f80f3e76108114
walk b45e64b20f356afb629ff78aecedb00e417a18e1
walk a0fc98e8243c7ccaf2019f0cc5697041e6c6133b
walk 588281bbc1767c6ace1a48a9ae449b37962d8f29
walk 3b6103110dec56f276449a166be22bd9d1891ca8
walk b1994cca7ed2d9db8b6006a7d9ae26f7fcbf44d5
walk 696c9d7eac6609a469f1cac41d0c653c69a6dff7
walk 9c9ffc11c9d1c1d3e87ee83a3e9e50e1c70f6ae6
walk 8f25989caeeb6b916363091756a626e05d4edbc5
walk ccc86da96be587935f616ce5ce8715c67f6d2f87
walk 51e5d904b6a51ed07a0eaeda12c1d15c1f6a8c0a
walk 6a58c1175a40d3afcb3ca7164852465011cfd544
walk 8eb36ff99677255cc337c55f2a4ba061d09edf49
walk 065bbf6b587c41127373734f1aa1e2673445044c
walk 0f0f08bfc0c9e309f737840a566ab2e0e6e53248
walk b9300368b92c8b946894d66beef89fedd0e8720d
walk 8fee61a7f316d9ad82f03627b85ce3a016170a32
walk 1c10060b35829629ecedc1a1e653f4538db5574f
walk 92ba301596308ba21ed9ea1e7dcc78cd2a6509c1
walk 2446b9e66e42bc75d11e0e4502ff7edf34525a8b
walk 67a64a925231ac24036bdad5916e175bf1bb5dbf
walk bf8fe41f2d976e8cd10f258110fe7ec98e39fee4
walk 24c52ea6739354409a493fefef2b01f068b3073c
walk 1ebc228032b2306518da7a07ca07ef39544eaea2
walk a20d25171360ec0252880fb6a1f02e970dec4d07
walk 8306b478bee23055c5b0c47991ca5f35225e885d
walk 5318fb1b6189e564dd533ffc4857c8743b19deee
walk 5fdd1cec7022a6106ef2c4381c426c85b3aa2db2
walk 875780782d29fafc2841ec284d25faa435e0f8d1
walk 40b35c571d3ddb98f8bfcc734c286ffd41a113a4
walk 17a7c7d56e1ec21821a3527f1f14953bd3ed02a5
walk 0529c54dd6ceef4ca301344407653c00883835ff
walk b9a25a8aec69e8f0cead72a7cff81dcbffebeb76
walk 1a9535e68042f67087cd400523dc42103292c2fe
walk 04a2f81e5559f7a0d2f1cb22e1b72196e19b3d0b
walk 34441a9917ce16db0e48fc8d44ecd0ee4debaa34
walk 89ab190688344f11968f2809d4a9278b99eb99c3
walk 7efa91641403204640a43d115167b7fea4058e27
walk b83bab57ebbe9f295d517301ebd96402c836f25e
walk a1b390197920264609b903062156a22782ffff8e
walk 02e778de3dac1672bde54294472e8122a0668735
walk 6c4f2ec235c8c6b4ad821cbf2878bf5f9d9586b5
walk a70d37854d9b81fe30f7d6798cdaec2fce310691
walk 937ce3b04b0b8295ab5b86f4349bdd7abdbdb1c3
walk 5e155025dd0480a65cf354b9883ac659ea538e50
walk e8b2cd03166a150c8326ab3c6585e9552d797cfe
walk 0584c5da0f995e0bbbaac1e80f1dc39c108c965a
walk df9e4971d68a6791e3fd498a5d4ae1c57661f80e
walk 4c2116c9cd2b52e1a29c88f62376a450a0e3a231
walk 206873af79606eb170fbff26137634bab475fec0
walk 657890aac205c39b63a462cb5b84ac5d47faf379
walk 27db7410d11a020a409704203f1476a5843fc766
walk 42dfee070aaa757ff9b8230fa2879b89883ab205
walk d2de5c5263822a0c3bfa625f8d7cb3a2baa9377c
walk 56c73bf4dee6082a5a6277b237038b0a68131c8c
walk f6d78b37ef2c22f273484ccf68aa50e00facf4bf
walk 99378be23aeb463c5c405c279bd474ab54c0669e
walk ee92745ae3d00f24583a058a1222659de50a8468
walk 9e664b053f5537e124a00b6023a69dea5b712fcc
walk 83975de19b14b90210a2de22cb3e581e757c83b5
walk 12c3f0bab9e81b09828c7bd1cd99cfe0ae7d6dab
walk eb27e2fffae49b0d8fa636bee611d9ad3c1e0999
walk 70ad82f7cd762ddfd34534197ca1a4c1d7ee5b6c
walk 281fcfb8dad9b66f027c39476a05aa5eff89fce1
walk 83331a0a334130cc438805c124fd05d93eddd5d0
walk 0c23fb8b146cab3fbc48d4f8d45aae501e599a8a
walk cda784ae0d8e3d4c08daa3b4225156f34122b4c2
walk cfa368bbc1d4c55c42c60838e04fc523625932b7
Fetching refs/heads/glendale from http://git.vyatta.com/vyatta-cfg-quagga.git using http
Fetching refs/heads/master from http://git.vyatta.com/vyatta-cfg-quagga.git using http
Fetching refs/heads/upstream from http://git.vyatta.com/vyatta-cfg-quagga.git using http
Submodule path 'pkgs/vyatta-cfg-quagga': checked out 'c45db01927f0d3e41f8f90f3c136f9c49a9aa680'
Initialized empty Git repository in /home/shemminger/vyatta/build-iso/pkgs/vyatta-cfg-system/.git/
got e80b62c1a078cad0324074f23560c5126b5bc980
walk e80b62c1a078cad0324074f23560c5126b5bc980
got 588bd253c6a2548c1360e64f660817d87c1730bd
Getting alternates list for http://git.vyatta.com/vyatta-cfg-system.git
Getting pack list for http://git.vyatta.com/vyatta-cfg-system.git
Getting index for pack 4960ab05eaff67e47120d8090abcf6cb3a87d65b
got 42942ad8952548225f61fe1534ae7538db5e47ef
Getting pack 4960ab05eaff67e47120d8090abcf6cb3a87d65b
 which contains 66a99a4ac48dcd5dd117b48ad37ff9226933978c
walk 66a99a4ac48dcd5dd117b48ad37ff9226933978c
walk 82b50b961a42d52ea6945e54e0e0dfc88ff4a5e3
got bcbc93e8fe80126fcbc7c9962f142523be3fed5f
walk 7082f5c70f29502de722dcbfe06d4a13e2954795
got 2a64e8fcaa165ef8c9813241afcfaebeebfeba2f
walk d4b5bf85f32965a0260ea907456bdc842c97ba51
got ff0bedc51ee98fe388b334ee2ab5a69f9ace6aeb
walk 2603531f2778ebf544b694d6f0aa356aa91753ff
got df0c4e6fe8fc50037bbcfbf054f807f4abacf487
walk 8990d88c2a0e1a4559ab5eb7f0f794ecaed65033
walk 12f269b74d05a2a11be7f0aaf993faeb56321f2f
walk 1bfb6d05e36905581abdc000d9f5801d3541b1be
walk f0a8d0c3bbcd410b65648fd6971d8d03fdf91d0c
walk d8416c79e6bd75f357bea392ed88c53b67313fa2
walk 2ebfcaf09728070b305f41d67a30de45d34413d7
walk 492ebed32cf9c08626a4f45fc2aa5e1d90dbad1a
walk da7bc447e57c30325596e84d2a02ec5a64cf06d1
walk 92564549a9cfa031583cb9cf6becfca29a7caf12
walk 7c31900bc1956b14ba77283c8db27a4aca35b238
walk 52c8ddb98f3a3b8b9bc20b3417678bc4111969f5
walk 622bbf801bd435a3848c669ff2c0e9090cd2bb4e
walk c2c002021eab0adff7e4d268535170658a1b0c6c
walk 8697b0750e77cb1b128847ea424acc4ed7457fbc
walk d230a91de2ed494c1d9e5e04a0e70f8521f61747
walk 15ab3a8e8beb74f909411b741f392cf957c905b6
walk 63701b09b34dfedfe2e7e0515e200a27802cf762
walk 411ea581185a36888b1f4dd2b027541b4e029443
walk 6b6b806ff3ec38d5ec7fbe2ea9c42e9692340bb0
walk 909f09598d60863634a36972823d19d5ec5a6d1e
walk b46b6fb018c7c40a395de5a2523d86d834392b62
walk 16031470e620e2310935795cd110eceec7995712
walk c3f28ce3332dfa5ccc3ac658df876d7cd444eea5
walk b45bba4286e83f8babcd70eef908f2ea2f8fff3c
walk 45366fefe00d4e9c5d91d6906a7623bfd5daa39b
walk fdde1f1d7ce42ba4355abe879e859933cc2087b6
walk fd9a338fd30aa6d0a4618d938c7143f9986b13eb
walk 4c31892eb4adc926a4301a2831ded92daa75c991
walk ef9307c050109e974a4994d3b644873401904005
walk 2a4e2baf7a31929c14cdf6cbf1ce2e01a186e905
walk d96ba6cb41ca96daa620751e92ed98518fc2a7da
walk 0313fc7f352887f6404eb55225f5f819ad56dc0d
walk ad7513053936b4712677ee547a13f2b07b49fbef
walk 54a57f5ffc98df1097d4d3b7b3e4e0cffe27eb12
walk ea4c396e33bf34cb8272daa2e1b2177a962cffb1
walk 793d580050edada4b4468b0d8044615ff5fc15aa
walk fa71dcd232351c123ac34dcd6622449f9193b0c5
walk 77f192de9e7652c4fe43b3a2f92bcc5ee0314b9a
walk cf3cabae0a7b8b4900687f2bcad927180abace4d
walk a1d251d60a96aacc7e2523ea0bd8d599279dbdc8
walk 7dac33b3bfebabb3a9b95dfe6a0578b9f1c31453
walk f5825957351be211801d03ad0f0786c6adc4cac6
walk c30fc4752c878c12255101aa928c64f7a3511020
walk 3db5608b709d365b37a7df590862bbec4e845042
walk 527ebe536c85691d79e5d81cd4f1fae4746db8c8
walk a27a8f7b5501ef9fa1c8e3be0fed4430d0515271
walk 1802eb010fb9b382dde4d3e1574fd578027c7dc0
walk 44a2449730a5c379c96a486a8161daa8ebe2504f
walk eefd3f1d5836f383f4d627f02c794d870f23bb94
walk 36af5914de982f2770fba137c4beea9077cc6adb
walk a9cd192305b779cb62aecd858ad9a4e5a1fbcad4
walk 7a4610e0fb11946ba40ac1fe1eafbddd39a15e48
walk cd2a6a06133ed9c7d7a5e8fb64d0f1e0c1ea7edf
walk 35a2193ed8baa7af1c4c01f239b0363a9d5a5d19
walk 94fbe9b07d0f556fcd2d9bcb3b7e00a1fb2df16b
walk 731a80bf6e92611cff0acbd6e9b7bf3b2b18a174
walk 8be2a717500cbbfecf285bdb6fc3c148bfa74381
walk e21cc4704648b85f8eae737b1ca6194413231f72
walk 8b00422b60deb69fa9abbfe584e69b5853c5e8af
walk 5ba8cf8393030d75c03a15551a57831f3f0908a4
walk 8f9c81cd448ece7199aa6f97fc27338839cabfd1
walk e68b9e536f618582774313c04fc53ad4f6eb4ab1
walk a42b9776af35929a1de00940fdf24337b028230e
walk 1041db879c6bdfa86f6a8b19e1542475db6dffc9
walk b484ad3193f65a790e6f534902252c98b7217884
walk 6043afabb34aa2a63c862363679e91b2696468f3
walk 15cb4da9ef894715d0118e6e5d70f70c7b94dbba
walk 431aad88a4f51ff07148f9768c4e85f9bec32a34
walk be1a6170451eaf42f525783ff9bc8156bade7150
walk bfaa4cb6f05b86f7d4d18e0ccab6e49c02d3d52d
walk 5705741d4b523d0869d694ed320a333d3b87937d
walk 9ddd0d9ed6eb972ea985be386eb91b85fc029c93
walk 3b95ed69d8e9a82430877bed94698a11ea94b94a
walk 4555c3ed0f6a6256d60ad6a0337984da54cffa00
walk 6ea2c7979320d032c2213d271309d6026d57775b
walk b1fd90f10917c28e25cca0eba1ec7d6200679bdc
walk 7e0cd1281925ab017eeb08877be528d46ae23257
walk 619cfac2cf37a21297dd1fb51116dc4ec30d4112
walk 21581023b1fefa1b29c6ffa34235273ec739f318
walk e6ed55f7593a0f4bc2700bc7b90903bb012e27f6
walk 7f5f7bedf4f47a42fcb7e32538ccf2d78c75234b
walk c095fa715a6fae2f6b36a8a27ad24e9f24788f5b
walk 5d09a07e0fa9567559f2929f026cdf970a8015df
walk 8fedbc2a708d630b5a97c3b02e20fcf2a8d334dc
walk c4551bb0a5e3ae1780831b5037a118e3971b5c95
walk a34ee5f28146d6d272e56b10f028b7a4c9b4e265
walk f50d376954e29731a1577b94f52193a13059d047
walk d85b9132e5817f7a10eb93b52c2696711bc5d18d
walk 43f2852dd74d9dd60d955478d8d7035ebacef46b
walk 0d6807dac3d72fdfb98f42cac17dc1431a7fbdff
walk 30cc647675e017e7fd602bf841d1eee87346deee
walk 41dce94fe7ce2518a2a83387d3c88384c42ed203
walk 23e89e2b78d9dcc29cad21cbe7e15e75f01f7061
walk dd8813677e1864d8fe45db79c9fa6392dfe3f245
walk 79ee9229cc8ad833c4bb4e0eaf89cfe3645ed094
walk 76b12db507c0381b9b93db73a4cacab89dcd8c13
walk d742d5e53b5ed8f58714038a2275808fcaeb1dcc
walk ae49927598cb7e5d18776b277181670f0207d4ad
walk daa2a8f7742c29d72c9237177d8a8649004ed3ac
walk d8ed99c5bb309294a7139d3a140686d28cd18eb0
walk 1953e95aec55ddfa9697a7ae9fa9f3a733f27986
walk 84af1d1e7ba996a5bdccb409d5146ebf250288df
walk da563fa3127254122f6c4c6e86b852fdb3ca5180
walk 3894a62d87d3813a4bf1a5d76510939222ee5549
walk 96d531ad3a5ebcb3719924af73dd529b6bc9a571
walk 604a1aaeee3cd3386febf5099936359b3647d56d
walk 0c0e1b04823e9faa479e4462c6eb958df0871b42
walk c0c53152dc9cf08fdae421d9fd8441d129561ada
walk cc0b5376c6342f629290e9637e258037a56c0aa6
walk f90d67a966db732f7ae89b361a0f34b351997f87
walk d80c63081165d2088a8015b0b9933fc8af61b2da
walk 0e4fea93eaf510e18b10d0bba288c90002955e81
walk e992ddd83ab2002ea6aeb9a4cacf89f9a888c17b
walk 61f301fce041eb658d62579879ae6fb355b0cde7
walk 290a17f504293f80b54bb8960293e6bc0cfacb19
walk f0920480f03cd60681061a6bbb19fc70beb235dd
walk 0851ef8fac2aa301f4bbea8b2155cc274846398c
walk abeb97f81d4cbeac43f03963bf4e222b0ee02500
walk 1229e8c6f130c62c42900f424a772d4e9c5e8ef5
walk b1fcb904eab1425d349fd7ab8d65b39c1bfb2e3f
walk c07bfa52d381abfa0177dc5940e142bc4252b7b8
walk cb287eb4589e46b72001d8e84de1eb5bae26d543
walk d34592273240b6ea91b82c479362bd88352b7f65
walk d4e70f30421c5c48b256e0e272c91c7b6db2aa86
walk 92ee6e6c49cacad059478ad1a50ffa7a50ecd90e
walk 65f1eec84304afcde1935808519bd2cf51677a8a
walk 07183520f3f4d2f89e526055db418046d0d2450f
walk 66b621cf7759c3448ae8bfe7d7479fb13ea04b65
walk 758f31ccdf9e6da2d7dd1752ddb6fdefa13590e6
walk 9c04f3d77a812f648842c72e70f17acfdd08c6b6
walk c38f1d8ace7ba12d05954ab3374f3bbea6c13d46
Fetching refs/heads/glendale from http://git.vyatta.com/vyatta-cfg-system.git using http
Fetching refs/heads/master from http://git.vyatta.com/vyatta-cfg-system.git using http
Fetching refs/heads/upstream from http://git.vyatta.com/vyatta-cfg-system.git using http
Submodule path 'pkgs/vyatta-cfg-system': checked out 'e80b62c1a078cad0324074f23560c5126b5bc980'
Initialized empty Git repository in /home/shemminger/vyatta/build-iso/pkgs/vyatta-cfg-vpn/.git/
Getting alternates list for http://git.vyatta.com/vyatta-cfg-vpn.git
Getting pack list for http://git.vyatta.com/vyatta-cfg-vpn.git
Getting index for pack 81955c2631bfd6cfb8d76b8851f40e0dd207ad59
Getting pack 81955c2631bfd6cfb8d76b8851f40e0dd207ad59
 which contains 45b1f46e45a26af4154766be9c472dcf77845057
walk 45b1f46e45a26af4154766be9c472dcf77845057
walk 1fbac2a0fa2ff7a8593590ba2c80b1aa29a5f386
walk a6a936db1296ba09e0267cc169d588fe061b53f7
walk 375bf795e22c12149dcf5d3ec2b45f213fd39a19
walk e188c1505c9bd4c4f125882bef0f2205974897d0
walk 6f32c7aeea3834d58f903209ab3e3908a37e9dd5
walk 4ddf2e3407577987dd2f0ce408e7a6949c22c417
walk d3d62b3c5be34576d339f5a7e7a4b3a304dfd4c6
walk 18e07e875f1802324fd1ce23716936d45029106c
walk b210486cd5fdf0a1397e80939e50bd25a9ea3dc9
walk 9f2e2dea5f8d84872ed92b4a974ff588f2f71c91
walk 2b188e0c9ca392a7c54f4169378e523c355873c1
Fetching refs/heads/glendale from http://git.vyatta.com/vyatta-cfg-vpn.git using http
Fetching refs/heads/master from http://git.vyatta.com/vyatta-cfg-vpn.git using http
Submodule path 'pkgs/vyatta-cfg-vpn': checked out '45b1f46e45a26af4154766be9c472dcf77845057'
Initialized empty Git repository in /home/shemminger/vyatta/build-iso/pkgs/vyatta-cluster/.git/
Getting alternates list for http://git.vyatta.com/vyatta-cluster.git
Getting pack list for http://git.vyatta.com/vyatta-cluster.git
Getting index for pack 5873f964e00de3e234b0a211cd22e42aa7e229c5
Getting pack 5873f964e00de3e234b0a211cd22e42aa7e229c5
 which contains e4105d088ddda49c4d5c2b88ee81daa793e24204
walk e4105d088ddda49c4d5c2b88ee81daa793e24204
walk ba4e3496cad40c2b288893dfe693a35487316dff
walk f2b473bf4b904635b48489203540a644082aada5
walk ea71d73edf181b5f7c9e645cf7e5bc3f0c6a3788
walk 260d88ab1aacd85bf406ed7b06d00c617fcaa19d
walk 41aac6942e89fa24b938ec188a0933e52acff623
Fetching refs/heads/glendale from http://git.vyatta.com/vyatta-cluster.git using http
Fetching refs/heads/master from http://git.vyatta.com/vyatta-cluster.git using http
Fetching refs/heads/upstream from http://git.vyatta.com/vyatta-cluster.git using http
Submodule path 'pkgs/vyatta-cluster': checked out 'e4105d088ddda49c4d5c2b88ee81daa793e24204'
Initialized empty Git repository in /home/shemminger/vyatta/build-iso/pkgs/vyatta-config-migrate/.git/
Getting alternates list for http://git.vyatta.com/vyatta-config-migrate.git
Getting pack list for http://git.vyatta.com/vyatta-config-migrate.git
Getting index for pack 95e56725bc502554559b4209124b569e03357a39
Getting pack 95e56725bc502554559b4209124b569e03357a39
 which contains aa324edcfbfba16e22e548758c50e1e827d76030
walk aa324edcfbfba16e22e548758c50e1e827d76030
walk d47734acf74410d6f2f223854ad56337373f08f1
walk 5affcf8f05c28aa1ca1ae7164e6776f60dc40272
walk 28206a8e8ba2696befb12009a5002253ee8f4850
walk b8e31555bf31474fa912aae1c8bee0a57ac435e5
walk e6ae5511834d7daa22a08f2d102ae8011b5b50e1
walk 1381213589b505471d67f11bbe024f5d076f826a
walk e68419fa911fe311f9fa007714c76b33ea49c6fb
walk 1064639a07e45c0d65a7dddf69f265099eaab40a
Fetching refs/heads/glendale from http://git.vyatta.com/vyatta-config-migrate.git using http
Fetching refs/heads/master from http://git.vyatta.com/vyatta-config-migrate.git using http
Fetching refs/heads/upstream from http://git.vyatta.com/vyatta-config-migrate.git using http
Submodule path 'pkgs/vyatta-config-migrate': checked out 'aa324edcfbfba16e22e548758c50e1e827d76030'
Initialized empty Git repository in /home/shemminger/vyatta/build-iso/pkgs/vyatta-dhcp3-client/.git/
Getting alternates list for http://git.vyatta.com/vyatta-dhcp3.git
Getting pack list for http://git.vyatta.com/vyatta-dhcp3.git
Getting index for pack e68126c4538efef11cd68ff29dd5cd8defbfea86
Getting pack e68126c4538efef11cd68ff29dd5cd8defbfea86
 which contains a77cbb06f22523b30e822b63e559d53ffbe74af3
walk a77cbb06f22523b30e822b63e559d53ffbe74af3
walk 18dedce4280160b28a79e7e34609f0c5b4b945eb
walk 68b595f7004d36c599a83bad9b149a242bb57af0
walk 8b4e8dcc63fa33fa0b39474f06b6d22a19ae9bb3
walk 0d9d6ebea3eb749ad46610ec1d962caa50b88a24
walk 10c2fca15189b1b10a74dec05fb24703ee636572
walk 975be5635708b2f6088af0716d63753b9315145b
walk be2550b5886728273c467e120aaa683a7f7425d7
walk c3a7ab0317e26178e5c50cc565f0198332628cda
walk dd85293c24a314e49555e23b1dc9ae7b397d7310
walk e7a16763da7aac5fc75a82fe5ded3f5bd15b0af2
Fetching refs/heads/glendale from http://git.vyatta.com/vyatta-dhcp3.git using http
Fetching refs/heads/master from http://git.vyatta.com/vyatta-dhcp3.git using http
Submodule path 'pkgs/vyatta-dhcp3-client': checked out 'a77cbb06f22523b30e822b63e559d53ffbe74af3'
Initialized empty Git repository in /home/shemminger/vyatta/build-iso/pkgs/vyatta-iproute/.git/
Getting alternates list for http://git.vyatta.com/vyatta-iproute.git
Also look at http://git.vyatta.com/home/shemminger/vyatta-iproute/.git/
error: The requested URL returned error: 403 (curl_result = 22, http_code = 403, sha1 = 2ee394c2cd25793cbbdeba54e75310f2f4d6348a)
Getting pack list for http://git.vyatta.com/vyatta-iproute.git
Getting index for pack b6e3bc750b97f7f39516bbd1355ac4aee6e0f351
Getting pack b6e3bc750b97f7f39516bbd1355ac4aee6e0f351
 which contains 2ee394c2cd25793cbbdeba54e75310f2f4d6348a
walk 2ee394c2cd25793cbbdeba54e75310f2f4d6348a
walk 15e7ad69b910490e0c63b50c3bc38d666c36efd0
error: The requested URL returned error: 403 (curl_result = 22, http_code = 403, sha1 = 7d54bd2d4d7c81ed20f968c4b81391fd85574450)
Getting pack list for http://git.vyatta.com/home/shemminger/vyatta-iproute/.git/
error: The requested URL returned error: 403
error: Unable to find 2b7b643ff4e66ebf325e18753e8ff59042d3e953 under http://git.vyatta.com/vyatta-iproute.git
Cannot obtain needed blob 2b7b643ff4e66ebf325e18753e8ff59042d3e953
while processing commit 15e7ad69b910490e0c63b50c3bc38d666c36efd0.
Waiting for http://git.vyatta.com/home/shemminger/vyatta-iproute/.git//objects/fe/78fb4ab818ae932cf65f2af1b3ba0f9b3e4b41
Waiting for http://git.vyatta.com/vyatta-iproute.git/objects/17/f00111cf3d0a1c55b2ba2f551fe14dd70a1937
Waiting for http://git.vyatta.com/home/shemminger/vyatta-iproute/.git//objects/ed/d79c0ec1e696ed8f3a8e175ad17c337f428d47
Waiting for http://git.vyatta.com/vyatta-iproute.git/objects/ac/f2a99af9ddc0ecfc038583800c982a7cfa731a
Waiting for http://git.vyatta.com/vyatta-iproute.git/objects/52/6dd5002c9a19585be28577e02d7e268545a0e4
Clone of 'http://git.vyatta.com/vyatta-iproute.git' into submodule path 'pkgs/vyatta-iproute' failed
$ 
